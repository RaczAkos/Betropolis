import type { RequestHandler } from "../balance-update/$types";
import { json } from "@sveltejs/kit";
import { dbConnect } from "$lib/db/db";
import { invalidateAllSessions } from "$lib/db/session";

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

        await db.execute(
            `UPDATE users SET avatar = ?, username = ?, email = ?, lang = ?, password = ? WHERE id = ?`,
            [avatarToPost, nameToPost, emailToPost, languageToPost, passwordToPost, event.locals.user.id]
        );

        return json({successful: "Successful!"});

    } catch (error) {
        console.error("Error updating profile:", error);
        return json({ error: "Internal Server Error" }, { status: 500 });
    }
};

// Delete user
export const DELETE: RequestHandler = async ({locals}) => {
  let db = await dbConnect();
    
  try {
    invalidateAllSessions(locals.user)
    await db.execute(`DELETE FROM users WHERE id = ?;
                      DELETE FROM friends WHERE friend1 = ? OR friend2 = ?;
                      DELETE FROM friend_requests WHERE senderId = ? OR sentToId = ?;
                      DELETE FROM statistics WHERE user_id = ?;`,
                     [locals.user.id, locals.user.id, locals.user.id, locals.user.id, locals.user.id, locals.user.id]);

    return json({successful: "Successful!"})
  } catch (error) {
    console.error("Error deleting profile:", error);
    return json({ error: "Internal Server Error" }, { status: 500 });
  }
};

export const GET: RequestHandler = async (event) => {
  let db = await dbConnect();
    
  try {
    let userData = await db.query(`SELECT email, username, gender, birthdate, balance, avatar, lang
                                   FROM users 
                                   WHERE id = ${event.locals.user.id};`);
    return json({user: userData[0]})
  } catch (error) {
    console.error("Error getting user data:", error);
    return json({ error: "Internal Server Error" }, { status: 500 });
  }
};
