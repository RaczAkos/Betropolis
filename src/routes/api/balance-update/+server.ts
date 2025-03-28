import type { RequestHandler } from "./$types";
import { json } from "@sveltejs/kit";
import { dbConnect } from "$lib/db/db";


export const POST: RequestHandler = async (event) => {
    let req = await event.request.json(),
        db = await dbConnect();
    console.log(req);

    try {

        const oldBalance = event.locals.user.balance;
        const newBalance = oldBalance + req.number;

        // Update balance
        await db.execute("UPDATE users SET balance = ? WHERE id = ?", [newBalance, event.locals.user.id]);

        return json({ new_balance: newBalance });
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
