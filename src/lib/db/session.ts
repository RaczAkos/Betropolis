import { encodeBase32LowerCaseNoPadding, encodeHexLowerCase } from "@oslojs/encoding";
import { sha256 } from "@oslojs/crypto/sha2";
import { dbConnect } from "./db";
import type { RequestEvent } from "@sveltejs/kit";

// Generating session token
export function generateSessionToken(): string {
	const bytes = new Uint8Array(20);
	crypto.getRandomValues(bytes);
	const token = encodeBase32LowerCaseNoPadding(bytes);
	return token;
}

// Creating session
export async function createSession(token: string, userId: number): Promise<Session> {
	const sessionId = encodeHexLowerCase(sha256(new TextEncoder().encode(token)));
    let db = await dbConnect();
	const session: Session = {
		id: sessionId,
		userId,
		expiresAt: new Date(Date.now() + 1000 * 60 * 60 * 24 * 30)
	};

  // Storing session in database
	await db.query(
		"INSERT INTO user_session (id, user_id, expires_at) VALUES (?, ?, ?)",
		[session.id,
		 session.userId,
		 session.expiresAt]
	);

	return session;
}

// Validating session
export async function validateSessionToken(token: string): Promise<SessionValidationResult> {
	let sessionId = encodeHexLowerCase(sha256(new TextEncoder().encode(token))), 
      db = await dbConnect();
  
  // Getting session
	let sessionData = await db.query(`SELECT id, user_id, expires_at 
                                    FROM user_session 
                                    WHERE id = "${sessionId}"`);

  // Checking if session exists
	if (sessionData === undefined || !sessionData) return { session: null, user: null };

  // Getting user
  let userData = await db.query(`SELECT id, username, lang, balance 
                                 FROM users 
                                 WHERE id = ${sessionData[0][0].user_id}`);
  
	let session: Session = {
		    id: sessionData[0][0].id,
		    userId: sessionData[0][0].user_id,
		    expiresAt: sessionData[0][0].expires_at
	    },  
      user: User = {
        id: userData[0][0].id,
        username: userData[0][0].username,
        lang: userData[0][0].lang,
        balance: userData[0][0].balance
	    };

  // Checking if session expired, or extending it
	if (Date.now() >= session.expiresAt.getTime()) {
    await db.query("DELETE FROM user_session WHERE id = ?", [session.id]);
		return { session: null, user: null };
	}
	if (Date.now() >= session.expiresAt.getTime() - 1000 * 60 * 60 * 24 * 15) {
    session.expiresAt = new Date(Date.now() + 1000 * 60 * 60 * 24 * 30);
		await db.query(
      "UPDATE user_session SET expires_at = ? WHERE id = ?",
			[session.expiresAt,
       session.id]
      );
    }
	return { session, user };
}

// Invalidating a specific session
export async function invalidateSession(sessionId: string): Promise<void> {
  let db = await dbConnect();
	await db.query("DELETE FROM user_session WHERE id = ?", [sessionId]);
}

// Invalidating all sessions from a user
export async function invalidateAllSessions(user:any): Promise<void> {
  let db = await dbConnect();
	await db.query("DELETE FROM user_session WHERE user_id = ?", [user.id]);
}

// Setting session cookie
export function setSessionTokenCookie(event: RequestEvent, token: string, expiresAt: Date): void {
	event.cookies.set("session", token, {
		httpOnly: true,
		sameSite: "lax",
		expires: expiresAt,
		path: "/"
	});
}

// Deleting session cookie
export function deleteSessionTokenCookie(event: RequestEvent): void {
	event.cookies.set("session", "", {
		httpOnly: true,
		sameSite: "lax",
		maxAge: 0,
		path: "/"
	});
}

// Type checking for session and user
export type SessionValidationResult =
	| { session: Session; user: User }
	| { session: null; user: null };

export interface Session {
	id: string;
	userId: number;
	expiresAt: Date;
}

export interface User {
	id: number;
  lang: string;
  username: string;
  balance: number;
}
