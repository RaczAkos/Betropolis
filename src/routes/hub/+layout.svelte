<script lang="ts">
	let { children } = $props();
</script>

<div class="bg-center bg-no-repeat bg-cover bg-fixed min-h-screen bg-[url('/src/lib/media/images/hub/hubbgblurred.png')]">
	{@render children()}
</div>