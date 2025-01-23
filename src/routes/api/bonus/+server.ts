import { dbConnect } from "$lib/db/db";
import { json } from '@sveltejs/kit';

export async function POST ({ request }: { request: Request }) {
    let req = await request.json(),
        db = await dbConnect(),
        method = 0,
        bonus =  Math.round(Math.floor((Math.random() * 3000) + 2000)/100)*100;
    
    //Check if user is already registered
    let userCheck = await db.query("SELECT * FROM users WHERE email='"+req.email+"';").then((rows:any) => { return rows; });
    if (!userCheck[0].length) {

        // Checking email in database
        let emailCheck = await db.query("SELECT * FROM bonus WHERE email='"+req.email+"';").then((rows:any) => { return rows; });
        
        if (!emailCheck[0].length) db.query("INSERT INTO bonus VALUES (?,?,?)", [req.email, bonus, 0]);
        else {
            if (emailCheck[0].status) method = 1;
            else method = 2;
        }
        db = null;
        return json({method, bonus}, {status: 200})
    } else {
        db = null;
        return json({"method":3})
    }
}
