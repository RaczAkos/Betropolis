import { redirect } from "@sveltejs/kit";
import type { Actions } from "./$types";
import { dbConnect } from "$lib/db/db";
import { createSession, generateSessionToken, setSessionTokenCookie } from "$lib/db/lucia";

// Sign up
export const actions = {
  default: async (event) => {
    // Get form data and database connection
    let data = await event.request.formData(),
        db   = await dbConnect();
    
    
  }
} satisfies Actions;