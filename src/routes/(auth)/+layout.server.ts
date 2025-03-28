import type { LayoutServerLoad } from "./$types";
import { redirect } from "@sveltejs/kit";

// Check if user is logged in
export const load: LayoutServerLoad = async ({locals}) => {
	if (locals.user !== null) {
		return redirect(307, "/hub");
	}
};