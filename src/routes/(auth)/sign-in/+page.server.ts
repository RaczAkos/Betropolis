import { redirect } from "@sveltejs/kit";
import type { Actions } from "./$types";
import { dbConnect } from "$lib/db/db";
import { createSession, generateSessionToken, setSessionTokenCookie } from "$lib/db/lucia";

// Sign in
export const actions = {
  default: async (event) => {
    // Get form data and database connection
    let data = await event.request.formData();
    let id = data.get('id'),
        password = data.get('password');
    let db = await dbConnect();
    
    // Get user from database
    let checkuser = await db.query(`SELECT id, password FROM users WHERE email = ? OR username = ?;`, [id,id]).then((rows:any) => { return rows[0][0]; });
    
    // Close database connection
    db = null;

    // Check if user exists
    if (checkuser) {
      // Check if password is correct
      if(checkuser.password === password) {
        // Create user session
        const token = generateSessionToken();
        const session = await createSession(token, checkuser.id);
        // Set session cookie
        setSessionTokenCookie(event, token, session.expiresAt);
        return redirect(308, "/hub");
      }
      return {error: "Wrong password!"};
    }
    return {error: "User doesn't exist!"};
  }
} satisfies Actions;