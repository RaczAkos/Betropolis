import { dbConnect } from '$lib/db/db';
import { json } from '@sveltejs/kit';
import { generateSessionToken, setSessionTokenCookie, createSession } from '$lib/db/session';

// Sign up
export async function POST(event) {
  let user = await event.request.json(),
      db = await dbConnect();

  try {
    // Check username in database
    let nameCheck = await db.query("SELECT balance FROM users WHERE username = ?;", user.username);
    if (nameCheck[0][0]) return json({error: "error.username"});

    // Check email in database
    let emailCheck = await db.query("SELECT balance FROM users WHERE email = ?;", user.email);
    if (emailCheck[0][0]) return json({error: "error.email"});
    
    // Upload user to db and get back the id
    let uploadUser = await db.query("INSERT INTO users (email, username, password, name, gender, birthdate, avatar, balance, lang) VALUES (?,?,?,?,?,?,?,0,?)", 
                                    [user.email, user.username, user.password, user.name, user.gender, user.birthdate, user.picture, user.lang]);

    // Add bonus to balance if claimed
    let bonus = await db.query("SELECT starting_bonus FROM bonus WHERE email = ? AND status = 0;", [user.email]);
    if (bonus[0][0]) await db.query("UPDATE users SET balance = 500 + ? WHERE id = ?; UPDATE bonus SET status = 1 WHERE email = ?;", 
                              [bonus.starting_bonus, uploadUser[0].insertId, user.email]);

    // Create session
    const token = generateSessionToken();
    const session = await createSession(token, uploadUser[0].insertId);
    setSessionTokenCookie(event, token, session.expiresAt);

    return json({success: "success"})
  }
  catch (e:any) {
    return json({error: e.message});
  }
}