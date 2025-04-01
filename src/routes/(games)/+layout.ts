import { locale, waitLocale } from "svelte-i18n";
import '$lib/i18n';
import type { LayoutLoad } from "../(home)/$types";

// Set language
export const load:LayoutLoad = async (event) => {
  await waitLocale();
};