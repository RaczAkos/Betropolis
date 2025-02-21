<script lang="ts">
	import '$lib/app.css';
	import Navbar from '$lib/components/HomeNavbar.svelte';
	import Footer from '$lib/components/Footer.svelte';
	let { children, data } = $props();
</script>

<Navbar logged={data.logged}/>

{@render children()}

<Footer logged={data.logged}/>