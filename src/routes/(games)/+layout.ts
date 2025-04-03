import { locale, waitLocale } from "svelte-i18n";
import '$lib/i18n';
import type { LayoutLoad } from "../(home)/$types";
import { browser } from "$app/environment";

// Set language
export const load:LayoutLoad = async ({data}) => {
  if (browser) locale.set(data.lang);
  await waitLocale();
};