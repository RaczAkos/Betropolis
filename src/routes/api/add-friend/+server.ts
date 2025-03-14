import { dbConnect } from '$lib/db/db';
import { json } from '@sveltejs/kit';


export async function POST(event) {
  let data = await event.request.json(),
      db = await dbConnect();
  
  let friend = await db.query(`SELECT id FROM users WHERE username LIKE '${data.friendUsername}';`)
  console.log(friend)
  return json("");
}