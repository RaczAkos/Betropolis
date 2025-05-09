import { dbConnect } from "$lib/db/db";
import type { LayoutServerLoad } from "./$types";

export const load: LayoutServerLoad = async ({locals, url}) => {
  let db = await dbConnect();
  
  let data = {
    logged: false,
    home: false,
    lang: null,
    claimedBonus: false
  }
  
  // Check if user is logged in
	if (locals.user){
    data.logged = true;
    data.lang = locals.user.lang;

    // Checking users bonus
    let email = await db.query("SELECT email FROM users WHERE id = ?", locals.user.id),
        bonus = await db.query("SELECT id FROM bonus WHERE status = 1 AND email = ?", email[0][0].email);

    if (bonus[0][0]) data.claimedBonus = true;
  } 
  data.home = url.pathname == '/';
  return data;
};