import { dbConnect } from '$lib/db/db';
import { json } from '@sveltejs/kit';

export async function POST(event) {
  let data = await event.request.json(),
      db = await dbConnect();
  
  try {

    let friend = await db.query(`SELECT id FROM users WHERE username LIKE '${data.friendUsername}';`);

    if (friend[0][0] == undefined) return json({error: "User doesnt exists!"});
    else if (friend.id == event.locals.user.id) return json({error: "You cant add yourself as friend!"});
    else {
      let requestQuery = "SELECT id FROM friend_requests WHERE senderId LIKE ? AND sentToId LIKE ?;";

      let sentRequest = await db.query(requestQuery, [event.locals.user.id, friend.id]);
      if (sentRequest[0][0]) return json({error: "You already sent a request!"});

      let gotRequest = await db.query(requestQuery, [friend.id, event.locals.user.id]);
      if (gotRequest[0][0]) return json({error: "You already got a request!"});

      let friends = await db.query("SELECT id FROM friends WHERE (friend1 LIKE ? OR friend1 LIKE ?) AND (friend2 LIKE ? OR friend2 LIKE ?);",
                                   [friend.id, event.locals.user.id, friend.id, event.locals.user.id]);
      if (friends[0][0]) return json({error: "You are already friends!"});
    }

    await db.query("INSERT INTO friend_requests (senderId, sentToId) VALUES (?,?)", [event.locals.user.id, friend.id]);
    
    return json({success: "Friend request sent!"});
  }
  catch (e:any) {
    return json({error: e.message});
  }
}