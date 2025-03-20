import type { PageServerLoad } from "./$types";
import { dbConnect } from "$lib/db/db";

export const load: PageServerLoad = async (event) => {
  let db = await dbConnect();

  let userData = await db.query("SELECT username, balance FROM users WHERE id = ?", [event.locals.user.id]),
      gamesData = await db.query("SELECT name, route, image, font FROM game;"), 
      friendRequestdata = await db.query("SELECT friend_requests.id, senderId, username FROM friend_requests INNER JOIN users ON friend_requests.senderId = users.id WHERE sentToId = ?; SELECT friend_requests.id, username FROM friend_requests INNER JOIN users ON friend_requests.sentToId = users.id WHERE senderId = ?;", [event.locals.user.id, event.locals.user.id]);

  return {user: userData[0], games: gamesData[0], friendRequests: friendRequestdata[0]};
}