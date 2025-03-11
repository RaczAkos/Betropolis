import type { LayoutServerLoad } from "./$types";

// Check if user is logged in
export const load: LayoutServerLoad = async (event) => {
  let data = {
    logged: false,
    home: false
  }
	if (event.locals.user !== null) data.logged = true;
  if (event.url.pathname == '/') data.home = true;
  return data;
};