import { dbConnect } from '$lib/db/db';
import { json } from '@sveltejs/kit';

export async function POST(event) {
  let data = await event.request.json(),
      db = await dbConnect();
  
  try {
    await db.query(`UPDATE friend_requests 
                    SET status = "deleted" 
                    WHERE id = ${data.requestId};`);

    return json({"success":"Request deleted!"});
  }
  catch (e:any) {
    return json({error: e.message});
  }
}