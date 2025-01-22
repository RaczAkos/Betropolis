<script lang="ts">
	import '$lib/app.css';
	import Navbar from '$lib/components/HomeNavbar.svelte';
	import Footer from '$lib/components/Footer.svelte';
	let { children } = $props();
</script>

<Navbar></Navbar>

{@render children()}

<Footer></Footer>