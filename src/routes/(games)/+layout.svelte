<script lang="ts">
  let { children } = $props();
</script>

<div class="opacity-0">
  {@render children()}
</div>


<style>
  div{
		animation: fadeIn 1s forwards;
	}

	@keyframes fadeIn {
		to {
			opacity: 1;
		}
	}
</style>