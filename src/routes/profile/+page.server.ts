import { dbConnect } from "$lib/db/db";
import type { RequestEvent } from "./$types";

// Check if user is logged in
export const load = async (event: RequestEvent) => {
  let db = await dbConnect();

  // User data
  let userData = await db.query(`SELECT email, username, gender, birthdate, balance, avatar
                                 FROM users 
                                 WHERE id = ${event.locals.user.id};`);
  // Statistics                           
  let transactionData = await db.query(`SELECT gameid, gain, oldbalance, newbalance, date
                                        FROM statistics 
                                        WHERE user_id = ${event.locals.user.id};`);
  // Played games
  let gamedist = await db.query(`SELECT DISTINCT game.gameid, game.name
                                 FROM statistics
                                 INNER JOIN game ON game.gameid = statistics.gameid 
                                 WHERE user_id = ${event.locals.user.id}
                                 ORDER BY game.gameid;`);
  
  // Last played game
  let lastplayedselect = await db.query(`SELECT game.name, game.gameid
                                         FROM statistics
                                         INNER JOIN game ON game.gameid = statistics.gameid 
                                         WHERE user_id = ${event.locals.user.id}
                                         ORDER BY id DESC
                                         LIMIT 1;`);
  
  // Returning Profile data
  return {user: userData[0], transaction: transactionData[0], games: gamedist[0], lastPlayed: lastplayedselect[0]}
};