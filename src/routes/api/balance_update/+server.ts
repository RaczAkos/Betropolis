import type { RequestHandler } from "./$types";
import { json } from "@sveltejs/kit";
import { dbConnect } from "$lib/db/db";


export const POST: RequestHandler = async (event) => {
    let req = await event.request.json(),
        db = await dbConnect(),
        userId = event.locals.user.id;
    console.log(req);

    try {
        const userId = 1; // Replace with session or request-based ID

        // Fetch current balance
        const [rows]: any = await db.query("SELECT balance FROM users WHERE id = ?", [userId]);

        const oldBalance = rows[0].balance;
        const newBalance = oldBalance + data;

        // Update balance
        await db.execute("UPDATE users SET balance = ? WHERE id = ?", [newBalance, userId]);

        return json({ new_balance: newBalance });
    } catch (error) {
        console.error("Error updating balance:", error);
        return json({ error: "Internal Server Error" }, { status: 500 });
    }
};
