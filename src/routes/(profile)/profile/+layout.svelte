<script lang="ts">
	import '$lib/app.css';
	import HomeNavbar from '$lib/components/home/HomeNavbar.svelte';
	let { children, data } = $props();
</script>

<HomeNavbar logged={data.userEvent.logged} home={data.userEvent.home}/>

<div class="fixed">
	{@render children()}
</div>


