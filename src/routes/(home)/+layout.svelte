<script lang="ts">
	import '$lib/app.css';
	import Navbar from '$lib/components/HomeNavbar.svelte';
	import Footer from '$lib/components/Footer.svelte';
	let { children } = $props();
</script>

<Navbar signin="Sign in" signup="Sign up" linksignin="/sign-in" linksignup="/sign-up"></Navbar>

{@render children()}

<Footer></Footer>