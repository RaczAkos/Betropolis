import { redirect } from "@sveltejs/kit";
import type { Actions } from "@sveltejs/kit";
import { dbConnect } from "$lib/db/db";
import { createSession, generateSessionToken, setSessionTokenCookie } from "$lib/db/session";

// Sign up
export const actions = {
  default: async (event) => {
    // Get form data and database connection
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
    let nameCheck = await db.query("SELECT balance FROM users WHERE username LIKE ?;", [user.username]).then((row:any) => {return row[0][0]});
    if (nameCheck) return {error: "Username already taken."};

    // Check email in database
    let emailCheck = await db.query("SELECT balance FROM users WHERE email LIKE ?;", [user.email]).then((row:any) => {return row[0][0]});
    if (emailCheck) return {error: "E-mail already used by someone."};

    // Upload user to db and get back the id
    await db.query("INSERT INTO users (email, username, password, name, gender, birthdate, balance) VALUES (?,?,?,?,?,?,500)", [user.email, user.username, user.password, user.name, user.gender, user.birthdate]);
    let id = await db.query("SELECT id FROM users WHERE email = ?", [user.email]).then((row:any) =>  {return row[0][0]});

    // Add bonus to balance if claimed
    let bonus = await db.query("SELECT starting_bonus FROM bonus WHERE email LIKE ? AND status LIKE 0;", [user.email]).then((row:any) =>  {return row[0][0]});
    if (bonus) await db.query("UPDATE users SET balance = 500 + ? WHERE id = ?; UPDATE bonus SET status = 1 WHERE email = ?;", [bonus.starting_bonus, id.id, user.email]);

    // Create session
    const token = generateSessionToken();
    const session = await createSession(token, id);
    
    // Set session cookie
    setSessionTokenCookie(event, token, session.expiresAt);
    return redirect(308, "/hub");
  }
} satisfies Actions;