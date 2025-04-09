import { dbConnect } from '$lib/db/db';
import { json } from '@sveltejs/kit';
import type { RequestEvent } from './$types';

export async function PUT(event: RequestEvent) {
  let data = await event.request.json(),
      db: any      = await dbConnect();
      
  let newbalance = (data.type == "deposit")? event.locals.user.balance + data.change : event.locals.user.balance - data.change
  
  try {
    await db.query(`UPDATE users 
                    SET balance = ${newbalance} 
                    WHERE id = ${event.locals.user.id};`);

    event.locals.user.balance = newbalance;

    return json({success: "friends.deleted", balance : newbalance});
  }
  catch (e:any) {
    return json({error: e.message});
  }
}