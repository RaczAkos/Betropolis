<script lang="ts">
	import '$lib/app.css';
	let { children } = $props();
</script>

<div class="bg-center bg-no-repeat bg-cover bg-fixed min-h-screen"
     style="background-image: url('src/lib/media/images/hub/hubbgblurred.png');">
	{@render children()}
</div>