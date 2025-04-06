<svelte:head>
    <title>{$_("page.hub.title")} - Betropolis</title>
    <meta name="description" content="Game Hub of the Casino." />
</svelte:head>

<script lang="ts">
  import { _ } from "svelte-i18n";
  import GameCard from "$lib/components/hub/GameCard.svelte";
  import HubNavbar from "$lib/components/hub/HubNavbar.svelte";
  import HubTopbar from "$lib/components/hub/HubTopbar.svelte";
  import type { Game } from "$lib/interfaces/index.js";

  let { data } = $props(),
      windowWidth:number    = $state(0),
      search: string        = $state(""),
      searchBar: boolean    = $state(false),
      gameList: Array<Game> = $state(data.games);

  $effect(() => {
    // Search
    if (search) gameList = data.games.filter((game:any) => game.name.toLowerCase().search(search.toLowerCase()) != -1);
    else gameList = data.games;

    if (windowWidth > 639) searchBar = false;
    else if (windowWidth < 640 && search) searchBar = true;
  })
</script>

<svelte:window bind:innerWidth={windowWidth} />

<div class="h-16"></div>

<HubTopbar bind:search={search} 
           bind:searchBar={searchBar}/>

<!-- Games -->
{#if gameList.length > 0}
  <div class="w-full grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-2 text-white p-2 py-3">
    {#each gameList as game}
      <GameCard {game} />
    {/each}
  </div>
{:else}
  <h1 class="borgens text-4xl text-center text-yellow-600 mt-5">
    {$_("page.hub.noGames")}
  </h1>
{/if}

<div class="h-14"></div>

<HubNavbar data={data.user} />