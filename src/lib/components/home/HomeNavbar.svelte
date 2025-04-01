<script lang="ts">
  import { _ } from "svelte-i18n";
  import SignOutModal from '../SignOutModal.svelte';
	import logo from '$lib/media/images/logo.png';
  import arrow from '$lib/media/images/down.png';
  import LanguageModal from "../LanguageModal.svelte";
  
  let { logged, home } = $props(), 
      signOutClicked:boolean = $state(false),
      mobileViewOpen:boolean = $state(false),
      languageClicked:boolean = $state(false);
</script>

<nav class="font-bold">
  <div class="w-screen flex justify-between max-md:hidden text-lg lg:text-2xl">

    <div class="w-1/3 place-content-center">
      {#if !home}
      <a href="/">
        <div class="hover-1 ml-3 mr-2 float-left button2">
          {$_("home")}
        </div>
      </a>
      {/if}

      {#if !logged}
        <button class="hover-1 float-left button1 textShadow"
                class:ml-3={home}
                onclick={() => languageClicked = true}>
          {$_("lang")}
        </button>
      {/if}
    </div>

    <div class="w-1/3 place-items-center place-content-center grid p-1 nav">
      <img src={logo} alt="Casino Logo" class="h-[80px]">
    </div>

    <div class="place-content-center w-1/3">
      <a href={logged ? "/hub" : "/sign-up"}>
        <div class="button2 mr-5 ml-2 hover-1 float-right">
          {$_(logged ? "page.hub.title": "page.sign-up.title")}
        </div>
      </a>

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
    <button class="w-full p-2 goldenbg flex flex-row place-items-center" onclick={() => mobileViewOpen = !mobileViewOpen}>
      <div class="basis-1/2">
        <img src={logo} alt="Casino Logo" class="h-20 ms-3">
      </div>
      <div class="basis-1/2">
        <img src={arrow} alt="Navbar Arrow" class:rotate-90={!mobileViewOpen} class="h-8 float-end me-3">
      </div>
    </button>

    {#if mobileViewOpen}
    <div>
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
        <a href={logged ? "/hub" : "/sign-up"} class="basis-1/2 p-1">
          <div class=" w-full text-center float-end button2">
            {$_(logged ? "page.hub.title": "page.sign-up.title")}
          </div>
        </a>
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

<SignOutModal bind:clicked={signOutClicked} />
<LanguageModal bind:clicked={languageClicked} />

<style>
  @reference "$lib/app.css";

  .nav{
    background-image: linear-gradient(to left, #000000, #30181b, #5b2926, #843e29, #a85a24, #a85a24, #a85a24, #a85a24, #843e29, #5b2926, #30181b, #000000);
  }
  .goldenbg{
    background-image: linear-gradient(to bottom, #000000, #30181b, #5b2926, #843e29, #a85a24, #a85a24, #a85a24, #a85a24, #843e29, #5b2926, #30181b, #000000);
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