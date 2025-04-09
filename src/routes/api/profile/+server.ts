import type { RequestHandler } from "../balance-update/$types";
import { json } from "@sveltejs/kit";
import { dbConnect } from "$lib/db/db";


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

        return json({succesful: "Succesful!"});

    } catch (error) {
        console.error("Error updating profile:", error);
        return json({ error: "Internal Server Error" }, { status: 500 });
    }
};

export const DELETE: RequestHandler = async (event) => {
        let db = await dbConnect();
    try {
        await db.execute(
            `DELETE FROM users WHERE id = ?`,
            [event.locals.user.id]
        );;
    return json({successful: "Successful!"})
    } catch (error) {
        console.error("Error deleting profile:", error);
        return json({ error: "Internal Server Error" }, { status: 500 });
    }
};

export const GET: RequestHandler = async (event) => {
    let db = await dbConnect();
    try {
        let userData = await db.query(`SELECT email, username, gender, birthdate, balance, avatar
            FROM users 
            WHERE id = ${event.locals.user.id};`);
    return json({user: userData[0]})
    } catch (error) {
        console.error("Error getting user data:", error);
        return json({ error: "Internal Server Error" }, { status: 500 });
    }
    };
