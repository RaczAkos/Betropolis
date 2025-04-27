import type { ParamMatcher } from '@sveltejs/kit';

// Matching parameters for docs page
export const match = ((param: string): param is ('privacy-policy' | 'terms&conditions') => {
	return param === 'privacy-policy' || param === 'terms&conditions';
}) satisfies ParamMatcher;