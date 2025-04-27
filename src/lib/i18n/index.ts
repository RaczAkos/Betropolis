import { browser } from '$app/environment';
import { init, register } from 'svelte-i18n';

// Locales/Languages
register('en', () => import('./locales/en.json'));
register('hu', () => import('./locales/hu.json'));
register('hu-HU', () => import('./locales/hu.json'));
register('en-GB', () => import('./locales/en.json'));
register('en-US', () => import('./locales/en.json'));

// Setting locale
init({
	fallbackLocale: 'hu',
	initialLocale: browser ? window.navigator.language : 'hu',
});