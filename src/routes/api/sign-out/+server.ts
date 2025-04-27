import { deleteSessionTokenCookie, invalidateSession } from '$lib/db/session';
import { json } from '@sveltejs/kit';
import type { RequestEvent } from './$types';

// Sign out of current session
export async function GET(event: RequestEvent) {
  invalidateSession(event.locals.session.id);
  deleteSessionTokenCookie(event);
  return json({});
}