<script lang="ts">
	import '../../../app.css';
	let { children } = $props();
</script>

<div class="h-screen grid place-items-center overflow-scroll bg-scroll bg-center bg-cover bg-no-repeat">
    {@render children()}
</div>

<style>
    div {
        background-image: url("$lib/media/images/login_bg.jfif");
    }
</style>