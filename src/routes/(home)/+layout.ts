import { browser } from '$app/environment';
import '$lib/i18n';
import { locale, waitLocale } from 'svelte-i18n';
import type { LayoutLoad } from './$types';

// Set language
export const load: LayoutLoad = async ({data}) => {
  if (browser) {
    if (data.lang) locale.set(data.lang)
    else locale.set(window.navigator.language);
  }
	await waitLocale();
  return data;
}