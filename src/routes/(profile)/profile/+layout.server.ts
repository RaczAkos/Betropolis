import type { LayoutServerLoad } from "./$types";
import { dbConnect } from "$lib/db/db";

// Check if user is logged in
export const load: LayoutServerLoad = async (event) => {
  let db = await dbConnect();

  let userData = await db.query(`SELECT email, username, gender, birthdate, balance, avatar 
                                 FROM users 
                                 WHERE id = ${event.locals.user?.id}`);

  let userEvent = {
        logged: event.locals.user !== null,
        home: event.url.pathname === '/',
        user: userData[0]
      };
                                 
  return {user: userData[0], userEvent}
};