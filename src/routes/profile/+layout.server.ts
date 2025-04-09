import type { LayoutServerLoad } from "./$types";
import { redirect } from "@sveltejs/kit";
import { dbConnect } from "$lib/db/db";

// Check if user is logged in
export const load: LayoutServerLoad = async ({locals}) => {
	if (locals.user === null) {
		return redirect(307, "/sign-in");
	}
	let db = await dbConnect();
	
	let userDatas = await db.query(`SELECT email, username, gender, birthdate, balance, avatar, lang
		FROM users 
		WHERE id = ${locals.user.id};`);

  return { lang: locals.user.lang, user: locals.user.username, userData: userDatas[0] }
};