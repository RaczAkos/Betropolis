<script lang="ts">
  import Navbar from '$lib/components/Navbar.svelte';
	let { children } = $props();
</script>

<Navbar logged={true} home={false}/>

<div class="h-screen fixed">
	{@render children()}
</div>
