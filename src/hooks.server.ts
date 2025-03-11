import {
	validateSessionToken,
	setSessionTokenCookie,
	deleteSessionTokenCookie
} from "$lib/db/session";

import type { Handle } from "@sveltejs/kit";

export const handle: Handle = async ({ event, resolve }) => {
  // Getting token from cookie
	const token = event.cookies.get("session") ?? null;

  // Checking if token exists
	if (token === null) {
		event.locals.user = null;
		event.locals.session = null;
		return resolve(event);
	}

  // Validating user
	let { session, user } = await validateSessionToken(token);
	if (session !== null) {
		setSessionTokenCookie(event, token, session.expiresAt);
	} else {
		deleteSessionTokenCookie(event);
	}

  // Setting locals
	event.locals.session = session;
	event.locals.user = user;
	return resolve(event);
};
