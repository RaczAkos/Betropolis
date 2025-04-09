<script lang="ts">
  import { _ } from "svelte-i18n";
  import type { Language, Modal } from "$lib/interfaces";

  let { 
        show = $bindable(), 
        selectedLang = $bindable(), 
        defaultLang
      }: Modal = $props(),
      
      // Languages
      langs: Array<Language> = [
        {
          id: "en", 
          name: $_("lang.name.en"), 
          defaultName: "English", 
          img: "/src/lib/media/images/lang/en.png"
        },
        {
          id: "hu-HU",
          name: $_("lang.name.hu"), 
          defaultName: "Hungarian", 
          img: "/src/lib/media/images/lang/hu-HU.png"
        }
      ];
</script>

<!-- Language change modal -->
<div class:hidden={!show} 
     class="relative z-10 transition-opacity duration-500 text-yellow-600 text-lg">
  <div class="fixed inset-0 bg-black/90 modalbg"></div>
  <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
    <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">
      <div class="relative transform overflow-hidden bg-black text-left border-2 border-yellow-600 
                  transition-all sm:my-8 sm:w-full sm:max-w-2xl mx-2 rounded-3xl">
        <div class="p-4">
          <h1 class="text-center text-5xl borgens">
            {$_("lang.title")}
          </h1>

          <div class="flex flex-row justify-center gap-4 my-5 text-white borgens text-3xl">
            {#each langs as lang}
              <!-- Language -->
              <button class="rounded-2xl hover:bg-yellow-600/50 p-4 outline-none hover:scale-110 duration-500" 
                      class:outline-yellow-600={selectedLang === lang.id}
                      onclick={() => selectedLang = lang.id}>
                <img src={lang.img} alt={lang.id} class="w-40">
                <h2>{lang.name}</h2>
                {#if !defaultLang}
                  <p>({lang.defaultName})</p>
                {/if}
              </button>
            {/each}
          </div>
          <div class="mt-2 border-t-2 pt-2 border-yellow-600 px-2 max-sm:flex-col-reverse gap-2 flex justify-center font-bold">
            <button class="hover:scale-110 hover:bg-yellow-600 hover:text-black border-2 p-1 rounded 
                           bg-black text-yellow-600 border-yellow-600 duration-300" 
                    onclick={() =>  show = false }>
              {$_("accept")}
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  ::selection {
    background-color: rgb(66, 45, 0);
    color: #ca8a04;
  }
</style>