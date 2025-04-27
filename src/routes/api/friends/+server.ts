import { dbConnect } from '$lib/db/db';
import { json } from '@sveltejs/kit';
import type { RequestEvent } from '@sveltejs/kit';
import type { FriendData } from '$lib/interfaces';

// Accept friend request
export async function POST(event: RequestEvent) {
  let data: FriendData = await event.request.json(),
      db: any          = await dbConnect();
  
  try {
    await db.query(`UPDATE friend_requests 
                    SET status = "accepted" 
                    WHERE id = ${data.id};`);

    await db.query("INSERT INTO friends (friend1, friend2, status) VALUES (?,?,1);", 
                   [event.locals.user.id, data.senderId]);

    return json({success: "accepted"});
  }
  catch (e:any) {
    return json({error: e.message});
  }
}

// Get friends data
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

// Set friendship to inactive status
export async function DELETE(event: RequestEvent) {
  let data: number = await event.request.json(),
      db: any      = await dbConnect();

  try {
    await db.query(`UPDATE friends 
                    SET status = 0 
                    WHERE id = ${data};`);

    return json({success: "friends.deleted"});
  }
  catch (e:any) {
    return json({error: e.message});
  }
}