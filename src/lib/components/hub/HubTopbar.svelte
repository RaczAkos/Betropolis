
<script lang="ts">
  import { _ } from "svelte-i18n";
  import Input from "$lib/components/Input.svelte";
  import homeImg from "$lib/media/images/hub/home.png";
  import searchImg from "$lib/media/images/hub/search.png";
  import closeImg from "$lib/media/images/hub/close.png";

  let { search = $bindable(), searchBar = $bindable() } = $props();
</script>

<div class="fixed top-0 bg-black border-b border-yellow-600 w-full p-2 borgens flex justify-between text-center select-none h-[65px]">
  {#if searchBar}

  <!-- Mobile searchbar -->
  <div class="w-full flex text-2xl">
    <Input bind:value={search} 
           type="search" 
           placeholder={$_("page.hub.search")}
           id="search"
           name="search"/>
    <button type="button"
            class="bg-red-600 rounded p-2 !min-w-12 ms-2"
            onclick={() => {searchBar = false; search = ""}}>
      <img src={closeImg} 
           alt={$_("close")}>
    </button>
  </div>
  {:else}

  <!-- Back to Home -->
  <div class="basis-1/3 flex items-center justify-start">
    <a href="/">
      <div class="hover:bg-black hover:text-yellow-600 sm:hover:scale-110 border-2 border-yellow-600 inline-block p-2 rounded bg-yellow-600 text-xl duration-300">
        <div class="flex justify-center items-center gap-1">
          <img src={homeImg} 
               alt={$_("home")} 
               class="sm:hidden">
          <div class="max-sm:hidden">
            {$_("home")}
          </div>
        </div>
      </div>
    </a>
  </div>

  <div class="basis-1/3 flex items-center justify-center">
    <h1 class="text-6xl text-yellow-600">
      {$_("page.hub.games")}
    </h1>
  </div>

  <!-- Searchbar -->
  <div class="basis-1/3 flex items-center justify-end">
    
    <div class="max-sm:hidden text-xl flex">
      <Input bind:value={search} 
             type="search" 
             placeholder={$_("page.hub.search")}
             id="search"
             name="search"/>
      <button type="button" 
              onclick={() => {search = ""}}
              disabled={search.length < 1}
              class:!bg-red-600={search}
              class="bg-yellow-600 rounded ms-1 p-2 min-w-12 enabled:hover:scale-110 duration-200">
        {#if search}
          <img src={closeImg} alt={$_("close")}>
        {:else}
          <img src={searchImg} alt={$_("page.hub.search")}>
        {/if}
      </button>
    </div>
  
    <button type="button" 
            onclick={() => searchBar = true}
            class="ms-1 bg-yellow-600 rounded p-2 sm:hidden border-2 border-yellow-600">
      <img src={searchImg} 
           alt={$_("page.hub.search")}>
    </button>
  </div>
  {/if}
</div>

<style>
  @reference "$lib/app.css";

  img { @apply h-8; }
</style>