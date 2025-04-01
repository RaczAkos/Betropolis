import type { PageServerLoad } from "./$types";
import { dbConnect } from "$lib/db/db";

export const load: PageServerLoad = async ({locals}) => {
  let db = await dbConnect();

  let gamesData = await db.query(`SELECT name, route, image, font 
                                  FROM game;`), 

      friendRequestsNumber = await db.query(`SELECT COUNT(id) AS 'notification' 
                                          FROM friend_requests  
                                          WHERE sentToId = ${locals.user.id} 
                                          AND status = 'active';`)


  return {
    user: {
      "balance": locals.user.balance,
      "username": locals.user.username
    }, 
    games: gamesData[0], 
    friendRequests: friendRequestsNumber[0]
  };
}