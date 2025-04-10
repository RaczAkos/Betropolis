import { dbConnect } from '$lib/db/db';
import type { FriendData } from '$lib/interfaces';
import { json } from '@sveltejs/kit';

export async function GET({locals}: {locals: App.Locals}) {
  let db: any = await dbConnect();
  
  try {
    let friendRequestData: Array<Array<Array<FriendData>>> = await db.query(
          `SELECT friend_requests.id, senderId, username 
           FROM friend_requests 
           INNER JOIN users 
           ON friend_requests.senderId = users.id 
           WHERE sentToId = ${locals.user.id} 
           AND status = 'active'; 

           SELECT friend_requests.id, username 
           FROM friend_requests 
           INNER JOIN users 
           ON friend_requests.sentToId = users.id 
           WHERE senderId = ${locals.user.id} 
           AND status = 'active';`
        );
    return json({data: friendRequestData[0]});
  }
  catch (e:any) {
    return json({error: e.message});
  }
}