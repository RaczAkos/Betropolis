<script lang="ts">
	import '$lib/app.css';
  import HomeNavbar from '$lib/components/home/HomeNavbar.svelte';
	let { children } = $props();
</script>

<HomeNavbar logged={true} home={false}/>

<div class="h-screen fixed">
	{@render children()}
</div>
