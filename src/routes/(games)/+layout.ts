import { locale, waitLocale } from "svelte-i18n";
import { browser } from "$app/environment";
import type { LayoutLoad } from "../(home)/$types";

// Set language
export const load:LayoutLoad = async (event) => {
	if (browser) locale.set(event.data.lang);
  await waitLocale();
};