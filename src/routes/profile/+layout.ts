import { locale, waitLocale } from "svelte-i18n";
import '$lib/i18n';
import { browser } from "$app/environment";
import type { LayoutLoad } from "../(home)/$types";

// Set language
export const load:LayoutLoad = async ({data}: any) => {
	if (browser) locale.set(data.lang);
  await waitLocale();
  
  return {data: data.user, result: data.userData};
};