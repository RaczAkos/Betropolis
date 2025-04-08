import { dbConnect } from '$lib/db/db';
import { json } from '@sveltejs/kit';
import type { RequestEvent } from './$types';
import type { FriendData } from '$lib/interfaces';

export async function POST(event: RequestEvent) {
  let data: FriendData = await event.request.json(),
      db: any           = await dbConnect();
  
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