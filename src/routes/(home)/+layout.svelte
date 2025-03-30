<script lang="ts">
	import '$lib/app.css';
	import HomeNavbar from '$lib/components/home/HomeNavbar.svelte';
	import Footer from '$lib/components/home/Footer.svelte';
	let { children, data } = $props();
</script>

<HomeNavbar logged={data.logged} home={data.home}/>

{@render children()}

<Footer logged={data.logged} home={data.home}/>