import { dbConnect } from '$lib/db/db';
import { json } from '@sveltejs/kit';

export async function POST(event) {
  let data = await event.request.json(),
      db = await dbConnect();
  
  try {
    await db.query(`UPDATE friend_requests 
                    SET status = "accepted" 
                    WHERE id = ${data.requestId};`);

    await db.query("INSERT INTO friends (friend1, friend2) VALUES (?,?);", 
                   [event.locals.user.id, data.senderId]);

    return json({"success":"Friend request accepted"});
  }
  catch (e:any) {
    return json({error: e.message});
  }
}