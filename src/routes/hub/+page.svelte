<svelte:head>
    <title>Hub - Betropolis</title>
    <meta name="description" content="Game Hub of the Casino." />
</svelte:head>

<script lang="ts">
    import HubNavbar from "$lib/components/hub/HubNavbar.svelte";
    import Input from "$lib/components/Input.svelte";
    import homeImg from "$lib/media/images/hub/home.png";
    import searchImg from "$lib/media/images/hub/search.png";
    import closeImg from "$lib/media/images/hub/close.png";

    let { data } = $props(),
        windowWidth = $state(0),
        gameList = $state(data.games),
        search:string = $state(""),
        searchBar:boolean = $state(false);

    $effect(() => {
      if (search) gameList = data.games.filter((game:any) => game.name.toLowerCase().search(search.toLowerCase()) != -1);
      else gameList = data.games;

      if (windowWidth > 639) searchBar = false;
      else if (windowWidth < 640 && search) searchBar = true;
    })
</script>

<svelte:window bind:innerWidth={windowWidth} />

<!-- Top bar -->
<div class="p-2 borgens flex justify-between text-center select-none">
  {#if searchBar}

  <!-- Mobile searchbar -->
  <div class="w-full flex text-2xl">
    <Input bind:value={search} 
           type="search" 
           placeholder="search"
           id="search"
           name="search"/>
    <button type="button"
            class="bg-red-600 rounded p-2 !min-w-12 ms-2"
            onclick={() => {searchBar = false; search = ""}}>
      <img src={closeImg} 
           alt="Home" 
           class="h-8">
    </button>
  </div>
  {:else}
  <div class="basis-1/3">
    <a href="/" class="float-left">
      <div class="inline-block p-2 rounded bg-yellow-600 text-2xl">
        <div class="flex justify-center items-center gap-1">
          <img src={homeImg} 
               alt="Home" 
               class="h-8 sm:hidden">
          <div class="max-sm:hidden">
            Home
          </div>
        </div>
      </div>
    </a>
  </div>

  <div class="basis-1/3">
    <h1 class="text-5xl text-yellow-600">Games</h1>
  </div>

  <div class="basis-1/3 flex items-center justify-end">
    
    <div class="max-sm:hidden text-xl flex">
      <Input bind:value={search} 
             type="search" 
             placeholder="search"
             id="search"
             name="search"/>
      <button type="button" 
              onclick={() => {search = ""}}
              disabled={search.length < 1}
              class:!bg-red-600={search}
              class="bg-yellow-600 rounded ms-1 p-2 min-w-10 enabled:hover:scale-110 duration-200">
        {#if search}
          <img src={closeImg} alt="close" class="h-6">
        {:else}
          <img src={searchImg} alt="search" class="h-6">
        {/if}
      </button>
    </div>
  
    <button type="button" 
            onclick={() => searchBar = true}
            class="ms-1 bg-yellow-600 rounded p-2 sm:hidden">
      <img src={searchImg} 
           alt="search"
           class="h-8">
    </button>
  </div>
  {/if}
</div>

<!-- Games -->
<div class="w-full grid max-sm:grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-2 text-white p-2">
  {#each gameList as game}
  <div class="border rounded-2xl flex justify-center items-center h-60 bg-cover bg-center duration-200" 
       style="background-image: url(/src/lib/media/images/hub/{game.image}.png);">
    <div>
      <a href={game.route}>
        {game.name}
      </a>
    </div>
  </div>
  {/each}
</div>

<div class="h-14"></div>

<HubNavbar {data} />