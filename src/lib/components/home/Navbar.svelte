<script lang="ts">
  import { _ } from "svelte-i18n";
  import SignOutModal from '../SignOutModal.svelte';
  import type { Navbar } from "$lib/interfaces";
  
  let { logged, home }: Navbar = $props(), 
      signOutClicked: boolean = $state(false),
      mobileViewOpen: boolean = $state(false);
</script>

<!-- Homepage Navbar -->
<nav class="font-bold">
  <div class="w-screen flex justify-between max-md:hidden text-lg lg:text-2xl">

    <!-- Homepage link -->
    <div class="w-1/3 place-content-center pl-3">
      {#if !home}
      <a href="/">
        <div class="md:hover:scale-110 border-2 w-12 lg:w-[52px] border-yellow-600 hover-1 p-2 rounded bg-yellow-600 duration-300">
          <div class="flex justify-center items-center">
            <img src={"/src/lib/media/images/hub/home.png"} 
                 alt={$_("home")}
                 class="h-[28px] lg:h-8">
          </div>
        </div>
      </a>
      {/if}
    </div>

    <!-- Casino Logo -->
    <div class="w-1/3 place-items-center place-content-center grid p-1 nav">
      <img src={"/src/lib/media/images/logo.png"} alt="Casino Logo" class="h-[80px]">
    </div>

    <div class="place-content-center w-1/3">
      <!-- Hub or Sign up link -->
      <a href={logged ? "/hub" : "/sign-up"}>
        <div class="button2 mr-5 ml-2 hover-1 float-right">
          {$_(logged ? "page.hub.title": "page.sign-up.title")}
        </div>
      </a>

      <!-- Sign out button or Sign in link-->
      {#if logged}
      <button class="button1 textShadow hover-1 float-right"
              onclick={() => {signOutClicked = true}}>
        {$_("sign-out")}
      </button>
      {:else}
      <a href="/sign-in">
        <div class="button1 textShadow hover-1 float-right">
          {$_("page.sign-in.title")}
        </div>
      </a>
      {/if}
    </div>
  </div>

  <!-- Mobile view -->
  <div class="md:hidden">
    <!-- Logo and arrow -->
    <button class="w-full p-2 goldenbg flex flex-row place-items-center" onclick={() => mobileViewOpen = !mobileViewOpen}>
      <div class="basis-1/2">
        <img src={"/src/lib/media/images/logo.png"} alt="Casino Logo" class="h-20 ms-3">
      </div>
      <div class="basis-1/2">
        <img src={"/src/lib/media/images/down.png"} alt="Navbar Arrow" class:rotate-90={!mobileViewOpen} class="h-8 float-end me-3">
      </div>
    </button>

    <!-- Dropdown menu -->
    {#if mobileViewOpen}
    <div>
      <!-- Homepage link -->
      {#if !home}
      <button onclick={() => mobileViewOpen = false} class="w-full">
        <a href="/">
          <div class="text-yellow-600 border-y border-yellow-600 text-center text-2xl p-2">
            {$_("home")}
          </div>
        </a>
      </button>
      {/if}
    
      <div class="flex flex-row-reverse w-full mb-2">
        
        <!-- Hub or Sign up link -->
        <a href={logged ? "/hub" : "/sign-up"} class="basis-1/2 p-1">
          <div class=" w-full text-center float-end button2">
            {$_(logged ? "page.hub.title": "page.sign-up.title")}
          </div>
        </a>
        
        <!-- Sign out button or Sign in link-->
        {#if logged}
        <div class="basis-1/2 p-1">
          <button class="w-full button1"
                  onclick={() => {signOutClicked = true}}>
            {$_("sign-out")}
          </button>
        </div>
        {:else}
        <a href="/sign-in" class="basis-1/2 p-1">
          <div class="w-full text-center textShadow button1">
            {$_("page.sign-in.title")}
          </div>
        </a>
        {/if}
      </div>
    </div>
    {/if}
  </div>
</nav>

<SignOutModal bind:show={signOutClicked} />

<style>
  @reference "$lib/app.css";

  .nav{
    background-image: linear-gradient(to left, #000000, #30181b, #5b2926, #843e29, 
                                         #a85a24, #a85a24, #a85a24, #a85a24, #843e29, #5b2926, #30181b, #000000);
  }
  .goldenbg{
    background-image: linear-gradient(to bottom, #000000, #30181b, #5b2926, #843e29, 
                                         #a85a24, #a85a24, #a85a24, #a85a24, #843e29, #5b2926, #30181b, #000000);
  }

  .button1 {
    @apply bg-black text-yellow-600;
  }
  .button2 {
    @apply bg-yellow-600 text-black ;
  }

  .button1, .button2 {
    @apply p-2 rounded md:duration-300 md:hover:scale-110 border-yellow-600 border-2;
  }
</style>