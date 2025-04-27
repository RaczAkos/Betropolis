import { dbConnect } from '$lib/db/db';
import { json } from '@sveltejs/kit';
import { generateSessionToken, setSessionTokenCookie, createSession } from '$lib/db/session';

// Sign in
export async function POST(event) {
  let user = await event.request.json(),
      db = await dbConnect();
  
  try {
    // Checking if user exists
    let userCheck = await db.query(`SELECT id, password 
                                   FROM users 
                                   WHERE email = ? OR username = ?;`, [user.id,user.id]);
    if (userCheck[0][0]) {

      // Checking if password is correct
      if(userCheck[0][0].password === user.password) {
        
        // Creating session
        const token = generateSessionToken();
        const session = await createSession(token, userCheck[0][0].id);
        setSessionTokenCookie(event, token, session.expiresAt);
            
        return json({success: "success"})
      }

      return json({error: "wrongPassword"});
    }
    return json({error: "wrongId"});
  }
  catch (e:any) {
    console.log(e)
    return json({error: e.message});
  }
}