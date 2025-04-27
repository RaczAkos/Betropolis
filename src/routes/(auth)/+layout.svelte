<script lang="ts">
  import { _ } from "svelte-i18n";
	let { children } = $props();
</script>

<!-- Layout for auth pages -->
<main class="min-h-screen grid place-items-center bg-fixed bg-center bg-cover bg-no-repeat select-none text-yellow-600"
      style="background-image: url(src/lib/media/images/backgrounds/login_bg.jfif);">
  <div class="bg-black shadow-md rounded px-8 py-6 border-double border-yellow-600 border-4">
    
    <!-- Back to Home -->
    <a href="/" 
       class="text-md italic hover:underline max-sm:underline">
      {$_("backToHome")}
    </a>

    <!-- Casino logo -->
    <div class="flex justify-center items-center px-3 mt-1">
      <div>
        <img src="/src/lib/media/images/logo.png" 
             alt="Casino Logo"  
             class="self-center w-52">
      </div>
    </div>
    <div class="w-full text-center text-xl font-bold my-2 italic">
      {$_("authTitle")}
    </div>
    
    <!-- Content -->
    {@render children()}
  </div>
</main>
