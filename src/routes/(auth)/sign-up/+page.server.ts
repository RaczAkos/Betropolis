import { redirect } from "@sveltejs/kit";
import type { Actions } from "@sveltejs/kit";
import { dbConnect } from "$lib/db/db";
import { createSession, generateSessionToken, setSessionTokenCookie } from "$lib/db/session";

// Sign up
export const actions = {
  default: async (event) => {
    let data = await event.request.formData(),
        user = {
          name: data.get('name'),
          username: data.get('username'),
          birthdate: data.get('birthdate'),
          gender: data.get('gender'),
          email: data.get('email'),
          password: data.get('password')
        },
        db = await dbConnect();
    
    // Check username in database
    let nameCheck = await db.query("SELECT balance FROM users WHERE username LIKE ?;", [user.username]);
    if (nameCheck[0][0]) return {error: "Username already taken."};

    // Check email in database
    let emailCheck = await db.query("SELECT balance FROM users WHERE email LIKE ?;", [user.email]);
    if (emailCheck[0][0]) return {error: "E-mail already used by someone."};

    // Upload user to db and get back the id
    let uploadUser = await db.query("INSERT INTO users (email, username, password, name, gender, birthdate, balance) VALUES (?,?,?,?,?,?,500)", 
                                    [user.email, user.username, user.password, user.name, user.gender, user.birthdate]);

    // Add bonus to balance if claimed
    let bonus = await db.query("SELECT starting_bonus FROM bonus WHERE email LIKE ? AND status LIKE 0;", [user.email]);
    if (bonus[0][0]) await db.query("UPDATE users SET balance = 500 + ? WHERE id = ?; UPDATE bonus SET status = 1 WHERE email = ?;", 
                              [bonus.starting_bonus, uploadUser[0].insertId, user.email]);

    // Create session
    const token = generateSessionToken();
    const session = await createSession(token, uploadUser[0].insertId);
    setSessionTokenCookie(event, token, session.expiresAt);
    
    return redirect(308, "/hub");
  }
} satisfies Actions;