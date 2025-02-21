import type { LayoutServerLoad } from "./$types";

// Check if user is logged in
export const load: LayoutServerLoad = async (event) => {
	if (event.locals.user !== null) {
		return {logged: true};
	}
};