import type { LayoutServerLoad } from "./$types";
import { redirect } from "@sveltejs/kit";

// Check if user is logged in
export const load: LayoutServerLoad = async (event) => {
	if (event.locals.user === null) {
		return redirect(307, "/sign-in");
	}

  
};