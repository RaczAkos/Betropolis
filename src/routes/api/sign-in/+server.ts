import { goto } from "$app/navigation";
import { dbConnect } from "$lib/db/db";
import { json, redirect } from '@sveltejs/kit';

export async function POST ({ request }: { request: Request }) {
    let req = await request.json(),
        db = await dbConnect();

    try {
        let user = await db.query(`SELECT password FROM users WHERE email = '${req.id}' OR username = '${req.id}';`).then((row:any) => { return row; });
        db = null;
        if (user[0].length == 0) {
            return json({"message":"User not found!"}, {"status": 200});
        } else if (user[0][0].password === req.password) {
            throw redirect(308, '/hub');
        }
        return json({"message":"Incorrect password!"});
    }
    catch(e:any){
        return json({"ea":e.message})
    }
}