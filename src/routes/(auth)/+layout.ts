import { browser } from '$app/environment';
import '$lib/i18n';
import { locale, waitLocale } from 'svelte-i18n';
import type { LayoutLoad } from '../(home)/$types';

export const load: LayoutLoad = async () => {
	await waitLocale();
}