import { locale, waitLocale } from "svelte-i18n";
import { browser } from "$app/environment";
import '$lib/i18n';
import type { LayoutLoad } from "../(home)/$types";

// Set language
export const load:LayoutLoad = async ({data}) => {
	if (browser) locale.set(data.lang); 
  await waitLocale();
};