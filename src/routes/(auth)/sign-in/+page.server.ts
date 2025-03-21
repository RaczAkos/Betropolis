import { redirect } from "@sveltejs/kit";
import type { Actions } from "./$types";
import { dbConnect } from "$lib/db/db";
import { createSession, generateSessionToken, setSessionTokenCookie } from "$lib/db/session";

export const actions = {
  // Sign in
  default: async (event) => {

    let data = await event.request.formData(),
        id = data.get('id'),
        password = data.get('password'),
        db = await dbConnect();
    
    let user = await db.query(`SELECT id, password 
                               FROM users 
                               WHERE email = ? OR username = ?;`, [id,id]);
    
    if (user[0][0]) {
      if(user[0][0].password === password) {

        const token = generateSessionToken();
        const session = await createSession(token, user[0][0].id);
        setSessionTokenCookie(event, token, session.expiresAt);
        
        return redirect(308, "/hub");
      }
      return {error: "Wrong password!"};
    }
    return {error: "User doesn't exist!"};
  }
} satisfies Actions;