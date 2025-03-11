<script lang="ts">
	import '$lib/app.css';
	let { children } = $props();
</script>


<div class="h-screen">
	{@render children()}
</div>
