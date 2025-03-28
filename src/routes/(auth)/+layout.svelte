<script lang="ts">
  import { _ } from "svelte-i18n";
	import '$lib/app.css';
  import logo from "$lib/media/images/logo.png";
	let { children } = $props();
</script>

<main class="min-h-screen grid place-items-center bg-fixed bg-center bg-cover bg-no-repeat select-none text-yellow-600"
      style="background-image: url(src/lib/media/images/backgrounds/login_bg.jfif);">
  <div class="bg-black shadow-md rounded px-8 py-6 border-double border-yellow-600 border-4">
    <a href="/" 
       class="text-md italic hover:underline max-sm:underline">
      {$_("backToHome")}
    </a>

    <div class="flex justify-center items-center px-3">
      <a href="/">
        <img src={logo} 
             alt="Casino Logo"  
             class="self-center w-52">
      </a>
    </div>
    <div class="w-full text-center text-xl font-bold my-2 italic">
      {$_("authTitle")}
    </div>
    
    {@render children()}
  </div>
</main>
