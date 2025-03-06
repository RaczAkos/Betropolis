<script>
    import "$lib/app.css";
    let { children } = $props();
</script>
<div>
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