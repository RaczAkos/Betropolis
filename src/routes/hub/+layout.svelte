<script lang="ts">
	import '$lib/app.css';
	import HubNavbar from '$lib/components/HubNavbar.svelte';
	let { children } = $props();
</script>


<div class="h-screen bg-center bg-no-repeat bg-cover bg-scroll ">
	{@render children()}
	<HubNavbar/>
</div>

<style>
	div{
		background-image: url("$lib/media/images/hub/hubbgblurred.png");
	}
</style>