import { dbConnect } from "$lib/db/db";
import { json } from '@sveltejs/kit';

function generateBonus() {
  return Math.round(Math.floor((Math.random() * 3000) + 2000)/100)*100;
}

export async function POST ({ request }: { request: Request }) {
  let req = await request.json(),
      db = await dbConnect(),
      title = "", message = "", extra = null,
      bonus =  generateBonus();
  
  try {
    // Check if user reqistered
    let userCheck = await db.query(`SELECT id FROM users WHERE email = '${req.email}';`);
    if (!userCheck[0].length) {
      
      // Check if bonus exists
      let emailCheck = await db.query(`SELECT id 
                                       FROM bonus 
                                       WHERE email = '${req.email}';`);
      if (!emailCheck[0].length){
        
        await db.query(`INSERT INTO bonus (email, starting_bonus, status) 
                        VALUES (?,?,?)`, 
                        [req.email, bonus, 0]);

        title = "Succesfully claimed bonus!";
        message = `Sign up to claim your starting bonus: ${bonus} chips`;
        extra = `(Other cards contained: ${generateBonus()}, ${generateBonus()}, ${generateBonus()})`;
      }

      // If email is already registered
      else {
        title = "Bonus already registered with e-mail!";
        message = "This email has been already registered for a bonus. Sign up with this e-mail to claim the bonus.";
      }
      db = null;
      return json({title, message, extra});
    
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
      "message": error.message
    });
  }
}