import { dbConnect } from "$lib/db/db";
import { json } from '@sveltejs/kit';

export async function POST ({ request }: { request: Request }) {
    let req = await request.json(),
        db = await dbConnect(),
        title = "", message = "",
        bonus =  Math.round(Math.floor((Math.random() * 3000) + 2000)/100)*100;
    try {

        //Check if user is already signed up
        let userCheck = await db.query("SELECT * FROM users WHERE email='"+req.email+"';").then((rows:any) => { return rows; });
        if (!userCheck[0].length) {
            
            // Checking email in database
            let emailCheck = await db.query("SELECT * FROM bonus WHERE email='"+req.email+"';").then((rows:any) => { return rows; });
            
            // If bonus claimed successfully
            if (!emailCheck[0].length){
                await db.query("INSERT INTO bonus VALUES (?,?,?)", [req.email, bonus, 0]);
                title = "Succesfully claimed bonus!";
                message = "Sign up to claim your starting bonus: " + bonus + " chips";
            }
            // If email is already registered
            else {
                title = "Bonus already registered with e-mail!";
                message = "This email has been already registered for a bonus. Sign up with this e-mail to claim the bonus.";
            }
            db = null;
            return json({title, message});
        } else {
            db = null;
            return json({
                "title":"Your account already exists!",
                "message":"Please log in to your account and claim your bonus in the hub if you haven't already claimed it."
            });
        }
    }
    catch (error : any) {
        return json({
            "title": "Some error happened!", 
            "message": "Please try again!"
        });
    }
}