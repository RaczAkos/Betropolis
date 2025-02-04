<script>
    import logo from "$lib/media/images/logo.png";
</script>

<main class="bg-black shadow-md rounded px-8 pt-6 pb-8 select-none border-double border-4 border-yellow-600">
    <div class="flex justify-center items-center" data-sveltekit-reload>
      <a href="/">
        <img src={logo} alt="Go back to home" class="self-center">
      </a>
    </div>
    
    <a class="underline text-yellow-600 flex justify-center items-center" href="/sign-in">Go back to Sign In</a>
</main>