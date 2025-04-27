import { dbConnect } from '$lib/db/db';
import { json } from '@sveltejs/kit';
import type { RequestEvent } from './$types';
import type { FriendData } from '$lib/interfaces';

// Get request data
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

// Set request status to deleted
export async function DELETE(event: RequestEvent) {
  let data: FriendData = await event.request.json(),
      db: any          = await dbConnect();
  
  try {
    await db.query(`UPDATE friend_requests 
                    SET status = "deleted" 
                    WHERE id = ${data.id};`);

    return json({success: "deleted"});
  }
  catch (e:any) {
    return json({error: e.message});
  }
}

// Send friend requests
export async function POST(event) {
  let data = await event.request.json(),
      db = await dbConnect();
  
  try {

    let friend = await db.query(`SELECT id 
                                 FROM users 
                                 WHERE username = '${data.friendUsername}';`);

    // Check if user exists or self
    if (friend[0][0] == undefined) return json({error: "noUser"});
    else if (friend[0][0].id == event.locals.user.id) return json({error: "self"});
    else {
      let requestQuery = `SELECT id 
                          FROM friend_requests 
                          WHERE (senderId = ? AND sentToId = ?) 
                          AND status = 'active';`,
          friendId = friend[0][0].id;

      // Check if is there is a request already sent
      let sentRequest = await db.query(requestQuery, [event.locals.user.id, friendId]);
      if (sentRequest[0][0]) return json({error: "sent"});

      let gotRequest = await db.query(requestQuery, [friendId, event.locals.user.id]);
      if (gotRequest[0][0]) return json({error: "got"});

      // Check if friendship exists
      let friends = await db.query(`SELECT id 
                                    FROM friends 
                                    WHERE (friend1 = ? OR friend1 = ?) 
                                    AND (friend2 = ? OR friend2 = ?) 
                                    AND status = 1;`,
                                   [friendId, event.locals.user.id, friendId, event.locals.user.id]);
      if (friends[0][0]) return json({error: "friends"});
    }

    await db.query(`INSERT INTO friend_requests (senderId, sentToId, status) 
                    VALUES (?,?, 'active')`, 
                    [event.locals.user.id, friend[0][0].id]);
    
    return json({success: "success"});
  }
  catch (e:any) {
    return json({error: e.message});
  }
}