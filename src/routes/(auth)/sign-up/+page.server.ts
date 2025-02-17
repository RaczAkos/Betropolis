import { redirect } from "@sveltejs/kit";
import type { Actions } from "@sveltejs/kit";
import { dbConnect } from "$lib/db/db";
import { createSession, generateSessionToken, setSessionTokenCookie } from "$lib/db/lucia";

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
    
    let nameCheck = await db.query("SELECT balance FROM users WHERE username LIKE ?;", [user.username]).then((row:any) => {return row[0][0]});
    if (nameCheck) {
      console.log(nameCheck)
    }
    
  }
} satisfies Actions;