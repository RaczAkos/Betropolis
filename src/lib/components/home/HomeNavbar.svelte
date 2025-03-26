<script>
  import SignOutModal from '../SignOutModal.svelte';
	import logo from '$lib/media/images/logo.png';
  import arrow from '$lib/media/images/down.png';
  let { logged, home } = $props();

  let signOutClicked = $state(false),
      mobileViewOpen = $state(false);
</script>

<nav>
  <div class="w-screen flex justify-between max-md:hidden text-2xl">

    <div class="w-1/3 place-content-center place-items-start">
      {#if !home}
      <a href="/">
        <div class="hover-1 ms-5 inline-block font-bold bg-yellow-600 hover:scale-110 border-yellow-600 border-2 text-black me-5 p-2 rounded focus:outline-none focus:shadow-outline duration-300">
          Home
        </div>
      </a>
      {/if}
    </div>

    <div class="w-1/3 place-items-center place-content-center grid p-1 nav">
      <img src={logo} alt="Casino Logo" class="h-[80px]">
    </div>

    <div class="place-content-center w-1/3">
      <!-- Sign out / Hub -->
      {#if logged}
      <a href="/hub">
        <div class="hover-1 inline-block font-bold float-end bg-yellow-600 hover:scale-110 border-yellow-600 border-2 text-black me-5 p-2 rounded focus:outline-none focus:shadow-outline duration-300">
          Hub
        </div>
      </a>
      <button class="hover-1 textShadow inline-block font-bold float-end hover:scale-110 bg-black border-yellow-600 border-2 text-yellow-600 me-2 p-2 rounded focus:outline-none focus:shadow-outline duration-300"
              onclick={() => {signOutClicked = true}}>
        Sign out
      </button>
      {:else}
      <!-- Sign in / up -->
      <a href="/sign-up">
        <div class="hover-1 inline-block font-bold float-end bg-yellow-600 hover:scale-110 border-yellow-600 border-2  text-black  me-6 p-2 rounded focus:outline-none focus:shadow-outline duration-300">
          Sign up
        </div>
      </a>
      <a href="/sign-in">
        <div class="hover-1 textShadow inline-block font-bold float-end hover:scale-110 bg-black border-yellow-600 border-2 text-yellow-600 me-2 p-2 rounded focus:outline-none focus:shadow-outline duration-300">
          Sign in
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
            Home
          </div>
        </a>
      </button>
      {/if}
    
      <div class="flex flex-row-reverse w-full mb-2">
        <!-- Sign out / Hub -->
        {#if logged}
        <a href="/hub" class="basis-1/2 p-1">
          <div class="hover-1 w-full text-center font-bold float-end bg-yellow-600 border-yellow-600 border-2 text-black p-2 rounded focus:outline-none focus:shadow-outline">
            Hub
          </div>
        </a>
        <div class="basis-1/2 p-1">
          <button class="w-full font-bold bg-black border-yellow-600 border-2 text-yellow-600 p-2 rounded focus:outline-none focus:shadow-outline"
                  onclick={() => {signOutClicked = true}}>
          Sign out
          </button>
        </div>
        {:else}
        <!-- Sign in / up -->
        <a href="/sign-up" class="basis-1/2 p-1">
          <div class="w-full text-center font-bold bg-yellow-600 border-yellow-600 border-2 text-black p-2 rounded focus:outline-none focus:shadow-outline">
            Sign-up
          </div>
        </a>
        <a href="/sign-in" class="basis-1/2 p-1">
          <div class="w-full text-center textShadow font-bold bg-black border-yellow-600 border-2 text-yellow-600 p-2 rounded focus:outline-none focus:shadow-outline">
            Sign in
          </div>
        </a>
        {/if}
      </div>
    </div>
    {/if}
  </div>
</nav>

<SignOutModal bind:clicked={signOutClicked} />

<style>
  .nav{
    background-image: linear-gradient(to left, #000000, #30181b, #5b2926, #843e29, #a85a24, #a85a24, #a85a24, #a85a24, #843e29, #5b2926, #30181b, #000000);
  }
  .goldenbg{
    background-image: linear-gradient(to bottom, #000000, #30181b, #5b2926, #843e29, #a85a24, #a85a24, #a85a24, #a85a24, #843e29, #5b2926, #30181b, #000000);
  }

</style>