<script lang="ts">
	import Navbar from '$lib/components/Navbar.svelte';
	import Footer from '$lib/components/home/Footer.svelte';
	let { children, data } = $props();
</script>

<Navbar logged={data.logged} 
            home={data.home}/>

{@render children()}

<Footer logged={data.logged} 
        home={data.home}/>