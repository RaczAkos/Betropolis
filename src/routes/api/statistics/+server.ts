import type { RequestHandler } from "./$types";
import { json } from "@sveltejs/kit";
import { dbConnect } from "$lib/db/db";


export const POST: RequestHandler = async (event) => {
    let req = await event.request.json(),
        db = await dbConnect();
    console.log(req);

    try {
        const newBalance = event.locals.user.balance + req.number,
              oldBalance = event.locals.user.balance,
              gameid = req.id,
              id = event.locals.user.id,
              gain = req.gain


        // Update balance
        await db.execute(`INSERT INTO statistics(id, gameid, gain, oldbalance, newbalance) 
                          VALUES (?,?,?,?,?)`, 
                          [id, gameid, gain, oldBalance, newBalance]);

        return json({ new_balance: newBalance });
    } catch (error) {
        console.error("Error updating balance:", error);
        return json({ error: "Internal Server Error" }, { status: 500 });
    }
};