import { dbConnect } from '$lib/db/db';
import { json } from '@sveltejs/kit';

export async function POST(event) {
  let data = await event.request.json(),
      db = await dbConnect();
  
  try {
    
  }
  catch (e:any) {
    return json({error: e.message});
  }
}