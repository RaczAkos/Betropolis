import type { ParamMatcher } from '@sveltejs/kit';

export const match = ((param: string): param is ('privacy-policy' | 'terms&conditions') => {
	return param === 'privacy-policy' || param === 'terms&conditions';
}) satisfies ParamMatcher;