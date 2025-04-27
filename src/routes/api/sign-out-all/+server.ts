import { deleteSessionTokenCookie, invalidateAllSessions } from '$lib/db/session';
import { json } from '@sveltejs/kit';
import type { RequestEvent } from './$types';

// Sign out every session
export async function GET(event: RequestEvent) {
  invalidateAllSessions(event.locals.user);
  deleteSessionTokenCookie(event);
  return json({});
}