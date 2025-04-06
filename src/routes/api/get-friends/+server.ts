import { dbConnect } from '$lib/db/db';
import type { FriendData } from '$lib/interfaces';
import { json } from '@sveltejs/kit';

export async function GET({locals}: {locals: App.Locals}) {
  let db: any = await dbConnect();
  
  try {
    let friendDataQuery: Array<Array<Array<FriendData>>> = await db.query(
          `SELECT friends.id, users.username 
           FROM friends 
           INNER JOIN users 
           ON users.id = friends.friend2 
           WHERE friend1 = ${locals.user.id} 
           AND status = 1;

           SELECT friends.id, users.username 
           FROM friends 
           INNER JOIN users 
           ON users.id = friends.friend1 
           WHERE friend2 = ${locals.user.id}
           AND status = 1;`
        ),
        friendData: Array<FriendData> = friendDataQuery[0][0].concat(friendDataQuery[0][1]);

    return json(friendData);
  }
  catch (e:any) {
    return json({error: e.message});
  }
}