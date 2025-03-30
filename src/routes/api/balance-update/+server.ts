import type { RequestHandler } from "./$types";
import { json } from "@sveltejs/kit";
import { dbConnect } from "$lib/db/db";


export const POST: RequestHandler = async (event) => {
    let req = await event.request.json(),
        db = await dbConnect();
    console.log(req);

    try {
        const oldBalance = event.locals.user.balance,
              newBalance = oldBalance + req.number,
              gameid = req.gameid,
              userId = event.locals.user.id,
              gain = req.number

        // Update balance
        await db.execute("UPDATE users SET balance = ? WHERE id = ?", [newBalance, event.locals.user.id]);


        // Insert statistics
        await db.execute(`INSERT INTO statistics(user_id, gameid, gain, oldbalance, newbalance) 
                          VALUES (?,?,?,?,?)`, 
                          [userId, gameid, gain, oldBalance, newBalance]);

        return json({id: userId, gameid: gameid, gain: gain, oldBalance: oldBalance, newBalance: newBalance});

    } catch (error) {
        console.error("Error updating balance:", error);
        return json({ error: "Internal Server Error" }, { status: 500 });
    }
};

export const GET: RequestHandler = async (event) => {
    let db = await dbConnect();
    try {
        return json({ balance: event.locals.user.balance });
    } catch (error) {
        console.error("Error updating balance:", error);
        return json({ error: "Internal Server Error" }, { status: 500 });
    }
};
