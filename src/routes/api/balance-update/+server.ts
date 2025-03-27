import type { RequestHandler } from "./$types";
import { json } from "@sveltejs/kit";
import { dbConnect } from "$lib/db/db";


export const POST: RequestHandler = async (event) => {
    let req = await event.request.json(),
        db = await dbConnect();
    console.log(req);

    try {
        const userId = event.locals.user.id; // Replace with session or request-based ID

        // Fetch current balance
        const [rows]: any = await db.query("SELECT balance FROM users WHERE id = ?", [userId]);

        const oldBalance = rows[0].balance;
        const newBalance = oldBalance + req;

        // Update balance
        await db.execute("UPDATE users SET balance = ? WHERE id = ?", [newBalance, userId]);

        return json({ new_balance: newBalance });
    } catch (error) {
        console.error("Error updating balance:", error);
        return json({ error: "Internal Server Error" }, { status: 500 });
    }
};
