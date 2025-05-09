import { dbConnect } from "$lib/db/db";
import type { EntryGenerator, RequestEvent } from "./$types";

// Check if user is logged in
export const load = async (event: RequestEvent) => {
  let db = await dbConnect();

  // Check friend existence
  let friend = await db.query(`SELECT id 
                               FROM users 
                               WHERE username = '${event.params.friend}'`);

  if (!friend[0][0]) return {error: "noUser"};

  // Check friendship existence
  let friendship = await db.query(`SELECT id 
                                   FROM friends 
                                   WHERE status = 1 
                                   AND (friend1 = ${event.locals.user.id} AND friend2 = ${friend[0][0].id})
                                   OR (friend2 = ${event.locals.user.id} AND friend1 = ${friend[0][0].id});`)

  if (!friendship[0][0]) return {error: "notFriend"};

  // Friend data
  let userData = await db.query(`SELECT email, username, gender, birthdate, balance, avatar
                                 FROM users 
                                 WHERE id = ${friend[0][0].id}`);
  // Friend statistics                 
  let transactionData = await db.query(`SELECT gameid, gain, oldbalance, newbalance, date
                                        FROM statistics 
                                        WHERE user_id = ${friend[0][0].id}`);

  // Friend's played games
  let gamedist = await db.query(`SELECT DISTINCT game.gameid, game.name
                                 FROM statistics
                                 INNER JOIN game ON game.gameid = statistics.gameid 
                                 WHERE user_id = ${friend[0][0].id}
                                 ORDER BY game.gameid`);
  
  // Friend's last played game
  let lastplayedselect = await db.query(`SELECT game.name, game.gameid
                                         FROM statistics
                                         INNER JOIN game ON game.gameid = statistics.gameid 
                                         WHERE user_id = ${friend[0][0].id}
                                         ORDER BY id DESC
                                         LIMIT 1`);
                         
  return {user: userData[0], transaction: transactionData[0], games: gamedist[0], lastPlayed: lastplayedselect[0]}
};