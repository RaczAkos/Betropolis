import type { PageServerLoad } from "./$types";
import { dbConnect } from "$lib/db/db";

export const load: PageServerLoad = async (event) => {
  let db = await dbConnect();

  let userData = await db.query("SELECT username, balance FROM users WHERE id = ?", [event.locals.user.id]),
      gamesData = await db.query("SELECT name, route, image, font FROM game;"), 
      friendRequestdata = await db.query("SELECT id FROM friend_requests WHERE sentToId = ?", [event.locals.user.id]);

  return {user: userData[0], games: gamesData[0], friendRequests: friendRequestdata[0]};
}