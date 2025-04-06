import { dbConnect } from '$lib/db/db';
import { json } from '@sveltejs/kit';
import type { RequestEvent } from './$types';

export async function PUT(event: RequestEvent) {
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