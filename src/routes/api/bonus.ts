import { dbConnect } from "$lib/db/db";
import { json, type RequestHandler } from '@sveltejs/kit';

export async function POST:RequestHandler ({ request }: { request: Request }) {
    const data = await request.json();
    // Handle your data here (e.g., save to database)
    return json({data}, {status: 200});
}
