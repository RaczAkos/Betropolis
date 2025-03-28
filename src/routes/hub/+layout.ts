import { locale, waitLocale } from "svelte-i18n";
import { browser } from "$app/environment";
import type { LayoutLoad } from "../(home)/$types";

// Check if user is logged in
export const load:LayoutLoad = async (event) => {
	if (browser) locale.set("en");
  await waitLocale();
};