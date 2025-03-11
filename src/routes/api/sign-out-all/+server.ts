import { deleteSessionTokenCookie, invalidateAllSessions } from '$lib/db/session';
import { json } from '@sveltejs/kit';

// Sign out every session
export async function GET(event) {
  invalidateAllSessions(event.locals.user);
  deleteSessionTokenCookie(event);
  return json({});
}