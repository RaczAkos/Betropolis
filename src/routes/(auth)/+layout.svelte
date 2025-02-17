<script lang="ts">
	import '$lib/app.css';
    import logo from "$lib/media/images/logo.png";
	let { children } = $props();
</script>

<main class="h-screen grid place-items-center bg-scroll bg-center bg-cover bg-no-repeat">
    <div class=" bg-black shadow-md rounded px-8 pt-6 pb-2 border-double border-yellow-600 border-4">

        <!-- Logo, Welcome -->
        <a href="/" class="text-yellow-600 text-md italic hover:underline max-sm:underline">Back to Home</a>
        <div class="flex justify-center items-center" data-sveltekit-reload>
            <a href="/"><img src={logo} alt="Casino Logo" class="self-center"></a>
        </div>
        <div class="w-full text-center text-yellow-600 text-xl font-bold my-2 italic">Welcome to Betropolis!</div>
        
        <!-- Content -->
        {@render children()}
    </div>
</main>

<style>
    main {
        background-image: url("$lib/media/images/login_bg.jfif");
    }
</style>