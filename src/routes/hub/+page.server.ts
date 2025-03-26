import type { PageServerLoad } from "./$types";
import { dbConnect } from "$lib/db/db";

export const load: PageServerLoad = async (event) => {
  let db = await dbConnect();

  let userData = await db.query(`SELECT username, balance 
                                 FROM users 
                                 WHERE id = ${event.locals.user.id}`),

      gamesData = await db.query(`SELECT name, route, image, font 
                                  FROM game;`), 

      friendRequestData = await db.query(`SELECT friend_requests.id, senderId, username 
                                          FROM friend_requests 
                                          INNER JOIN users 
                                          ON friend_requests.senderId = users.id 
                                          WHERE sentToId = ${event.locals.user.id} 
                                          AND status = 'active'; 

                                          SELECT friend_requests.id, username 
                                          FROM friend_requests 
                                          INNER JOIN users 
                                          ON friend_requests.sentToId = users.id 
                                          WHERE senderId = ${event.locals.user.id} 
                                          AND status = 'active';`),

      friendData = await db.query(`SELECT users.username 
                                   FROM friends 
                                   INNER JOIN users 
                                   ON users.id = friends.friend2 
                                   WHERE friend1 = ${event.locals.user.id};
                                   
                                   SELECT users.username 
                                   FROM friends 
                                   INNER JOIN users 
                                   ON users.id = friends.friend1 
                                   WHERE friend2 = ${event.locals.user.id};`);

  friendData = friendData[0][0].concat(friendData[0][1]);

  return {user: userData[0], games: gamesData[0], friendRequests: friendRequestData[0], friends: friendData};
}