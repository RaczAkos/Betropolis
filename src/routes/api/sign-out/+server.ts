import { deleteSessionTokenCookie, invalidateSession } from '$lib/db/lucia';
import { json } from '@sveltejs/kit';

// Sign out of current session
export async function GET(event) {
  invalidateSession(event.locals.session.id);
  deleteSessionTokenCookie(event);
  return json({});
}