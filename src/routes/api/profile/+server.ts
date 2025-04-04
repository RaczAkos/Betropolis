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
            `UPDATE users SET avatar = ?, username = ?, email = ?, lang = ? WHERE id = ?`,
            [avatarToPost, nameToPost, emailToPost, languageToPost, event.locals.user.id]
        );

        return json({succesful: "Succesful!"});

    } catch (error) {
        console.error("Error updating balance:", error);
        return json({ error: "Internal Server Error" }, { status: 500 });
    }
};
