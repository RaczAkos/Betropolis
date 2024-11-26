<script lang="ts">
	import '../../app.css';
	let { children } = $props();
</script>


<div class="h-screen bg-center bg-no-repeat bg-cover bg-scroll">
	{@render children()}
</div>

<style>
	div{
		background-image: url("$lib/media/images/fortunewheel/wheelbg.png");
	}
</style>