<!-- Title and Description of the Page -->
<svelte:head>
    <title>Welcome to Betropolis Casino!</title>
    <meta name="description" content="Welcome to Betropolis — your ultimate online destination for thrilling casino games and endless entertainment! Step into a world where the excitement never stops, and every spin, card flip, and roll of the dice brings you closer to unforgettable winnings. At Betropolis, we combine top-tier games, cutting-edge security, and seamless gameplay to create a premium online casino experience." />
</svelte:head>

<script lang=ts>
  import BonusGameModal from "$lib/components/home/BonusGameModal.svelte";
  import banner from "$lib/media/videos/banner.mp4";
  import frenchcards from "$lib/exports/frenchcards";
  import images from "$lib/exports/hubgames";
  import { onMount } from "svelte";
  let index:number = 0, 
      slides:HTMLDivElement,
      modal = $state(false);

  onMount(() => {
    setInterval(() => {
      if (slides) {
        index = (index + 1) % 3;
        slides.style.transform = `translateX(-${index * 100}%)`;
      }
    }, 3000);
  });

</script>

<header class="w-auto xl:w-screen">
  <div class="relative">
    <video poster="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" 
           src={banner} 
           autoplay muted loop 
           class=" blur-[7px] drop-shadow-none sepia-0 poster"
           preload='auto'>
    </video>
    
    <div class="borgens absolute italic inset-0 max-md:top-5 flex justify-center items-center text-center w-full">
      <div class="text-yellow-600 flex justify-center flex-col textShadow">
        <h1 class="text-4xl sm:text-6xl md:text-7xl lg:text-8xl p-1">
          Welcome to Betropolis Casino!
        </h1>
        <h2 class="text-2xl sm:text-4xl lg:text-5xl underline">
          <a href="/sign-in">
            Start betting now!
          </a>
        </h2>
      </div>        
    </div>
  </div>
</header>

<main>
  <div class="goldenbg">
    <div class="relative w-full max-w-[1400px] mx-auto flex flex-wrap md:flex-nowrap items-center py-10 text-yellow-600 md: lg:text-xl xl:text-3xl text-center max-sm:text-lg borgens">
      <div class="md:w-3/4 text-center justify-items-center flex justify-center p-5">
        <p class="border-yellow-600 border-y py-5 rounded-xl max-md:w-3/4 max-sm:px-3 textShadow text-justify px-3 max-sm:w-full">
          Your ultimate online destination for thrilling casino games and endless entertainment! Step into a world where the excitement never stops, and every spin, card flip, and roll of the dice brings you closer to unforgettable winnings. At Betropolis, we combine top-tier games, cutting-edge security, and seamless gameplay to create a premium online casino experience.
        </p>
      </div>
        
      <!-- Carousel -->
      <div class="md:w-[1000px] overflow-hidden m-1">
        <div bind:this={slides} class="flex transition-transform duration-500">
          {#each images as img}
            <div class="w-full flex-shrink-0"><img src={img} class="w-full rounded-lg" alt="Slide"/></div>
          {/each}
        </div>
      </div>
    </div>
  </div>


  <!-- Bonus Game -->
  <div class="flex justify-center mt-[100px] borgens select-none text-3xl text-yellow-600 text-center max-sm:text-2xl">
    <div class="mx-5 lg:basis-2/3">
      <h2 class="">Choose a card for a free extra starting bonus!</h2>
      <div class="ledBorder grid grid-cols-4 max-md:grid-cols-2 mx-5 my-2 gap-2 p-2 rounded-3xl">
        {#each frenchcards as img}
          <button onclick={() => modal = !modal} class="border flex items-center justify-center rounded-3xl bg-gray-300 duration-150 ease-in-out hover:scale-[1.07] hover:shadow-xl hover:shadow-black">
            <img src={img} alt="Card" class="h-1/2">
          </button>
        {/each}
      </div>
      <h2>Already claimed the bonus? <a href="/sign-up" class="hover:underline max-sm:underline italic">Sign up!</a></h2>
    </div>
  </div>
</main>

<BonusGameModal bind:show={modal}/>

<style>
  :global(body){
    overflow-x: hidden;
  }
    
  .poster {
    background-image: url("$lib/media/images/poster.png");
    background-position: cover;
    background-position: center;
  }
  .goldenbg{
    background-image: linear-gradient(to bottom, #000000, #30181b, #5b2926, #843e29, #a85a24, #a85a24, #a85a24, #a85a24, #843e29, #5b2926, #30181b, #000000);
  }
</style>
