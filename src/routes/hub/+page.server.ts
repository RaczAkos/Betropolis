import type { PageServerLoad } from "./$types";
import { dbConnect } from "$lib/db/db";

export const load: PageServerLoad = async (event) => {
  let db = await dbConnect();

  let userData = await db.query("SELECT username, balance FROM users WHERE id = ?", [event.locals.user.id]).then((rows:any) => { return rows[0] }),
      gamesData = await db.query("SELECT name, route, image, font FROM game;").then((rows:any) => { return rows[0] });

  return {user: userData, games: gamesData};
}