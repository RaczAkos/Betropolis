import type { RequestHandler } from "../balance-update/$types";
import { json } from "@sveltejs/kit";
import { dbConnect } from "$lib/db/db";
import { deleteSessionTokenCookie, invalidateAllSessions } from "$lib/db/session";

// Update user profile
export const POST: RequestHandler = async (event) => {
    let req = await event.request.json(),
        db = await dbConnect();
        
    try {
        const avatarToPost = req.newPicture,
              nameToPost = req.newName,
              emailToPost = req.newEmail,
              passwordToPost = req.newPassword,
              languageToPost = req.newLanguage

        await db.query(
            `UPDATE users SET avatar = ?, username = ?, email = ?, lang = ?, password = ? WHERE id = ?`,
            [avatarToPost, nameToPost, emailToPost, languageToPost, passwordToPost, event.locals.user.id]
        );

        return json({successful: "Successful!"});

    } catch (error) {
        console.error("Error updating profile:", error);
        return json({ error: "Internal Server Error" }, { status: 500 });
    }
};

// Delete Account
export const DELETE: RequestHandler = async (event) => {
  let db = await dbConnect();
    
  try {
    await db.query(`
      DELETE FROM friends WHERE friend1 = ${event.locals.user.id} OR friend2 = ${event.locals.user.id};
      DELETE FROM friend_requests WHERE senderId = ${event.locals.user.id} OR sentToId = ${event.locals.user.id};
      DELETE FROM statistics WHERE user_id = ${event.locals.user.id};
      DELETE FROM users WHERE id = ${event.locals.user.id};
    `);
    
    await invalidateAllSessions(event.locals.user);
    deleteSessionTokenCookie(event);
    return json({successful: "Successful!"})
  } catch (error) {
    return json(error);
  }
};

// Get user data
export const GET: RequestHandler = async (event) => {
  let db = await dbConnect();
    
  try {
    let userData = await db.query(`SELECT email, username, gender, birthdate, balance, avatar, lang
                                   FROM users 
                                   WHERE id = ${event.locals.user.id};`);
    return json({user: userData[0]})
  } catch (error) {
    return json("");
  }
};
