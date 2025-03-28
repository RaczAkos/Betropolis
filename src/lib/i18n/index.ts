// src/lib/i18n/index.ts
import { browser } from '$app/environment'
import { init, register } from 'svelte-i18n'

register('en', () => import('./locales/en.json'))
register('hu-HU', () => import('./locales/hu.json'))

init({
	fallbackLocale: 'en',
	initialLocale: browser ? window.navigator.language : 'en',
})