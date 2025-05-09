<!-- Title and Description of the Page -->
<svelte:head>
    <title>{$_("page.home.title")}</title>
    <meta name="description" content={$_("page.home.description")} />
</svelte:head>

<script lang="ts">
  import { _ } from "svelte-i18n";
  import BonusGameModal from "$lib/components/home/BonusGameModal.svelte";
  import banner from "$lib/media/videos/banner.mp4";
  import frenchcards from "$lib/exports/frenchcards";
  import images from "$lib/exports/hubgames";
  import { onMount } from "svelte";

  let { data } = $props();
  let index:number = 0,
      slides:HTMLDivElement,
      modal = $state(false);

  // Carousel
  onMount(() => {
    setInterval(() => {
      if (slides) {
        index = (index + 1) % 3;
        slides.style.transform = `translateX(-${index * 100}%)`;
      }
    }, 3000);
  });
</script>

<!-- Header with banner video and title -->
<header>
  <div class="relative">
    <video poster="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" 
           src={banner} 
           autoplay muted loop 
           preload='auto'>
    </video>
    
    <div class="borgens absolute italic inset-0 max-md:top-5 flex justify-center items-center text-center w-full">
      <div class="text-yellow-600 flex justify-center flex-col textShadow">
        <h1 class="text-3xl sm:text-6xl md:text-7xl p-3">
          {$_(!data.logged ? "page.home.title" : "page.home.loggedTitle")}
        </h1>
        <h2 class="text-2xl sm:text-4xl lg:text-5xl underline">
          <a href="/hub">
            {$_(!data.logged ? "page.home.catchphrase" : "page.home.loggedCatchphrase")}
          </a>
        </h2>
      </div>        
    </div>
  </div>
</header>

<main>
  <div class="goldenbg">
    <div class="relative w-full max-w-[1400px] mx-auto flex flex-wrap md:flex-nowrap 
                items-center py-10 text-yellow-600 md: lg:text-xl xl:text-3xl 
                text-center max-sm:text-lg">
      
      <!-- Description -->
      <div class="md:w-3/4 text-center justify-items-center flex justify-center p-5">
        <p class="border-yellow-600 border-y py-5 rounded-xl max-md:w-3/4 
                    max-sm:px-3 textShadow text-justify px-3 max-sm:w-full borgens">
          {$_("page.home.description")}  
        </p>
      </div>
        
      <!-- Carousel -->
      <div class="md:w-[1000px] overflow-hidden m-1">
        <div bind:this={slides} 
             class="flex transition-transform duration-500">
          {#if data.lang == "hu-HU"}
            {#each images[1] as img}
              <div class="w-full flex-shrink-0">
                <img src={img} 
                    class="w-full rounded-lg" 
                    alt="Slide"/>
              </div>
            {/each}
          {:else}
            {#each images[0] as img}
              <div class="w-full flex-shrink-0">
                <img src={img} 
                    class="w-full rounded-lg" 
                    alt="Slide"/>
              </div>
            {/each}
          {/if}
          
        </div>
      </div>
    </div>
  </div>


  <!-- Bonus Game -->
  <div class="flex justify-center mt-12 mb-3 borgens select-none text-3xl 
              text-yellow-600 text-center max-sm:text-2xl">
    <div class="mx-5 lg:basis-2/3">
      {#if !data.claimedBonus}
        <h2>
          {$_("page.home.bonus")}
        </h2>
      {/if}

      {#if !data.claimedBonus}
        <div class="ledBorder bonus">
          <!-- Cards -->
          {#each frenchcards as img}
          <button onclick={() => modal = !modal} 
                  class="card">
            <img src={img} 
                 alt="Card" 
                 class="h-1/2">
          </button>
          {/each}
        </div>
      {:else}
        <div class="mx-5 my-2 gap-2 p-2 rounded-3xl ledBorder grid border-2 border-yellow-600">
          {$_("page.home.claimedBonus")}
        </div>
      {/if}
      {#if !data.logged}
        <h2>
          {$_("page.home.alreadyClaimed")} 
          <a href="/sign-up">
            {$_("page.sign-up.title")}!
          </a>
        </h2>
      {/if}
    </div>
  </div>
</main>

<!-- Modal -->
<BonusGameModal bind:show={modal} logged={data.logged}/>

<style>
  @reference "$lib/app.css";

  :global(body){
    overflow-x: hidden;
  }

  a { @apply hover:underline max-sm:underline italic; }

  header { @apply w-auto xl:w-screen; }

  video { @apply blur-[7px] drop-shadow-none sepia-0 bg-center bg-[url($lib/media/images/poster.png)] }

  .bonus { @apply grid grid-cols-4 max-md:grid-cols-2 mx-5 my-2 gap-2 p-2 rounded-3xl; }
  
  .card { @apply border flex items-center justify-center rounded-3xl bg-gray-300 duration-150 ease-in-out hover:scale-[1.07] hover:shadow-xl hover:shadow-black; }

  .goldenbg{
    background-image: linear-gradient(to bottom, #000000, #30181b, #5b2926, #843e29, #ff9011, #a85a24, #a85a24, #a85a24, 
                                         #843e29, #5b2926, #30181b, #000000);
  }
</style>
