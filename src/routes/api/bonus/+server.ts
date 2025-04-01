import { dbConnect } from "$lib/db/db";
import { json } from '@sveltejs/kit';

function generateBonus() {
  return Math.round(Math.floor((Math.random() * 3000) + 2000)/100)*100;
}

export async function POST ({ request }: { request: Request }) {
  let req = await request.json(),
      db = await dbConnect(),
      title = "", description = "", extra = null,
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

        title = "bonus.returned.title";
        description = "bonus.returned.description";
        extra = [generateBonus(), generateBonus(), generateBonus()];
      }

      // If email is already registered
      else {
        title = "Bonus already registered with e-mail!";
        description = "This email has been already registered for a bonus. Sign up with this e-mail to claim the bonus.";
      }
      db = null;
      return json({
        title, 
        description, 
        extra, 
        bonus
      });
    
    } else return json({
      title: "",
      description: "",
      extra: [generateBonus(), generateBonus(), generateBonus()]
    });
  }
  catch (error : any) {
    return json({
      "title": "bonus.error.title", 
      "description": error.message
    });
  }
}