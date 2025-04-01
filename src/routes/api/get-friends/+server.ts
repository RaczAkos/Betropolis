import { dbConnect } from '$lib/db/db';
import { json } from '@sveltejs/kit';

export async function GET(event) {
  let db = await dbConnect();
  
  try {
    let friendData = await db.query(`SELECT users.username 
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

    return json(friendData);
  }
  catch (e:any) {
    return json({error: e.message});
  }
}