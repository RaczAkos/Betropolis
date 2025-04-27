import type { RequestHandler } from "./$types";
import { json } from "@sveltejs/kit";
import { dbConnect } from "$lib/db/db";

// Update balance and statistics
export const POST: RequestHandler = async (event) => {
  let req = await event.request.json(),
      db = await dbConnect();
      
  try {
    const oldBalance = event.locals.user.balance,
          newBalance = oldBalance + req.number,
          gameid = req.gameid,
          userId = event.locals.user.id,
          gain = req.number,
          date : Date = new Date();
    let formattedDate = `${date.getFullYear()}. ${String(date.getMonth() + 1).padStart(2, '0')}. ${String(date.getDate()).padStart(2, '0')}. ${String(date.getHours()).padStart(2, '0')}:${String(date.getMinutes()).padStart(2, '0')}:${String(date.getSeconds()).padStart(2, '0')}`;
    
    // Update balance
    await db.query("UPDATE users SET balance = ? WHERE id = ?", [newBalance, event.locals.user.id]);
    
    // Insert statistics
    await db.query(`INSERT INTO statistics(user_id, gameid, gain, oldbalance, newbalance, date) 
                    VALUES (?,?,?,?,?,?)`, 
                    [userId, gameid, gain, oldBalance, newBalance, formattedDate]);
   
    return json({id: userId, gameid: gameid, gain: gain, oldBalance: oldBalance, newBalance: newBalance});
  } catch (error) {
    console.error("Error updating balance:", error);
    return json({ error: "Internal Server Error" }, { status: 500 });
  }
};

// Get balance
export const GET: RequestHandler = async ({locals}) => {
  return json({ balance: locals.user.balance });
};
