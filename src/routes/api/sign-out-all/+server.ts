import { deleteSessionTokenCookie, invalidateAllSessions } from '$lib/db/session';
import { json } from '@sveltejs/kit';
import type { RequestEvent } from './$types';

export const prerender = false;

// Sign out every session
export async function GET(event: RequestEvent) {
  invalidateAllSessions(event.locals.user);
  deleteSessionTokenCookie(event);
  return json({});
}