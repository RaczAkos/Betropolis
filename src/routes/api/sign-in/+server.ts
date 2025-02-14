import { dbConnect } from "$lib/db/db";
import { json, redirect } from '@sveltejs/kit';
import { generateSessionToken, createSession } from "$lib/db/lucia";


export async function POST ({ request }: { request: Request }) {
    let req = await request.json(),
        db = await dbConnect();

    try {
        let user = await db.query(`SELECT password FROM users WHERE email = '${req.id}' OR username = '${req.id}';`).then((row:any) => { return row; });
        db = null;
        if (user[0].length == 0) {
            return json({"message":"User not found!"}, {"status": 200});
        } else if (user[0][0].password === req.password) {
            return json({"message": user[0][0].id});
            const token = generateSessionToken();
            const session = createSession(token, user[0][0].id)
            throw redirect(308, '/hub');
        }
        return json({"message":"Incorrect password!"});
    }
    catch(e:any){
        return json({"message":e.message})
    }
}