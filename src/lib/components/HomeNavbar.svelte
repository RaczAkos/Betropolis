<script>
	import logo from '$lib/media/images/logo.png';
  let { logged } = $props();

  function signOut() {
    fetch("/api/sign-out").then(() => window.location.reload());
  }
</script>

<nav>
    <div class="w-screen flex justify-between max-sm:hidden text-2xl">
        <div class="place-items-start w-1/3 place-content-center">
          <!-- To be implemented -->
        </div>
        <div class="w-1/3 place-items-center place-content-center grid p-1 nav">
          <a href="/">
            <img src="{logo}" alt="Casino Logo" class="h-[80px]">
          </a>
        </div>
        <div class="place-content-center w-1/3 place-items-end">
          <!-- Sign out / Hub -->
          {#if logged}
            <a href="/hub">
              <div class="inline-block font-bold float-end bg-yellow-600 hover:scale-110 border-yellow-600 border-2 text-black me-5 p-2 rounded focus:outline-none focus:shadow-outline duration-300">
                Hub
              </div>
            </a>
            <button class="inline-block font-bold float-end hover:scale-110 bg-black border-yellow-600 border-2 text-yellow-600 me-2 p-2 rounded focus:outline-none focus:shadow-outline duration-300"
                    onclick={signOut}>
              Sign out
            </button>
          {:else}
          <!-- Sign in / up -->
            <a href="/sign-up">
              <div class="inline-block font-bold float-end bg-yellow-600 hover:scale-110 border-yellow-600 border-2  text-black  me-6 p-2 rounded focus:outline-none focus:shadow-outline duration-300">
                Sign up
              </div>
            </a>
            <a href="/sign-in">
              <div class="inline-block font-bold float-end hover:scale-110 bg-black border-yellow-600 border-2 text-yellow-600 me-2 p-2 rounded focus:outline-none focus:shadow-outline duration-300">
                Sign in
              </div>
            </a>
          {/if}

        </div>
    </div>
    <div class="sm:hidden p-2">
        <img src="{logo}" alt="Casino Logo" class="h-[90px]">
    </div>
</nav>

<style>
    .nav{
      background-image: linear-gradient(to left, #000000, #30181b, #5b2926, #843e29, #a85a24, #a85a24, #a85a24, #a85a24, #843e29, #5b2926, #30181b, #000000);
    }
</style>