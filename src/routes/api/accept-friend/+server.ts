import { dbConnect } from '$lib/db/db';
import { json } from '@sveltejs/kit';
import type { RequestEvent } from './$types';
import type { FriendData } from '$lib/interfaces';

export async function POST(event: RequestEvent) {
  let data: FriendData = await event.request.json(),
      db: any           = await dbConnect();
  
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