<script lang="ts">
	import '$lib/app.css';
	let { children } = $props();
</script>


<div class="h-screen bg-center bg-no-repeat bg-cover bg-scroll ">
	{@render children()}
</div>

<style>
	div{
		background-image: url("$lib/media/images/findcardgame/findcardbg.jfif");
		opacity: 0;
		animation: fadeIn 1s forwards;
	}

	@keyframes fadeIn {
		to {
			opacity: 1;
		}
	}
</style>