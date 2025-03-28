import type { LayoutServerLoad } from "./$types";

// Check if user is logged in
export const load: LayoutServerLoad = async ({locals, url}) => {
  let data = {
    logged: false,
    home: false,
    lang: null
  }
	if (locals.user){
    data.logged = true;
    data.lang = locals.user.lang;
  } 
  if (url.pathname == '/') data.home = true;
  return {data};
};