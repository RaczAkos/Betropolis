import type { PageServerLoad } from "./$types";
import { dbConnect } from "$lib/db/db";
import type { Game } from "$lib/interfaces";

export const load: PageServerLoad = async ({locals}: {locals: App.Locals}) => {
  let db = await dbConnect();

  let gamesData: Array<Array<Game>> = await db.query(
        `SELECT name, route, image, font 
         FROM game;`
      );

  return {
    user: {
      "balance": locals.user.balance,
      "username": locals.user.username
    }, 
    games: gamesData[0]
  };
}