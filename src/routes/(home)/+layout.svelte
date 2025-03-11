<script lang="ts">
	import '$lib/app.css';
	import HomeNavbar from '$lib/components/HomeNavbar.svelte';
	import Footer from '$lib/components/Footer.svelte';
	let { children, data } = $props();
</script>

<HomeNavbar logged={data.logged} home={data.home}/>

{@render children()}

<Footer logged={data.logged} home={data.home}/>