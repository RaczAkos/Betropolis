import { dbConnect } from "$lib/db/db";
import { json } from '@sveltejs/kit';

export const prerender = false;

function generateBonus() {
  return Math.round(Math.floor((Math.random() * 3000) + 2000)/100)*100;
}

// Claim bonus if signed in
export async function GET ({locals}): Promise<any> {
  let db = await dbConnect(),
      bonus = generateBonus();

  let email = await db.query("SELECT email FROM users WHERE id = ?", locals.user.id);

  await db.query(`INSERT INTO bonus (email, starting_bonus, status) 
                  VALUES (?,?,?);`, 
                  [email[0][0].email, bonus, 1]);
  await db.query("UPDATE users SET balance = ? WHERE id = ?", 
                 [locals.user.balance + bonus, locals.user.id]);

  return json({
    title: "bonus.returned.title", 
    description: "bonus.returned.description", 
    extra: [generateBonus(), generateBonus(), generateBonus()], 
    bonus
  });
}

// Claim bonus with email
export async function POST ({ request }: { request: Request }) {
  let req = await request.json(),
      db = await dbConnect(),
      title = "", description = "", extra = null,
      bonus = generateBonus();
  
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
                        VALUES (?,?,?);`, 
                        [req.email, bonus, 0]);

        title = "bonus.returned.title";
        description = "bonus.returned.description";
        extra = [generateBonus(), generateBonus(), generateBonus()];
      }

      // If email is already registered
      else {
        title = "bonus.error.email.title";
        description = "bonus.error.email.description";
      }
      db = null;
      return json({
        title, 
        description, 
        extra, 
        bonus: extra ? bonus : null
      });
    
    } else return json({
      title: "bonus.logged.title",
      description: "bonus.logged.description"
    });
  }
  catch (error : any) {
    return json({
      "title": "bonus.error.title", 
      "description": error.message
    });
  }
}