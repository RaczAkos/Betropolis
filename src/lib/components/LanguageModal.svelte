<script lang="ts">
  import { _ } from "svelte-i18n";
  import en from "$lib/media/images/lang/en.png";
  import hu from "$lib/media/images/lang/hu-HU.png";
  let { clicked = $bindable(), selectedLang = $bindable() } = $props(),
      langs = [
        {id: "en", name: $_("lang.name.en"), defaultName: "English", img: en},
        {id: "hu-HU",name: $_("lang.name.hu"), defaultName: "Hungarian", img: hu}
      ];

</script>

<!-- Language change modal -->
{#if clicked}
<div class="relative z-10 transition-opacity duration-500 text-yellow-600 text-lg" aria-labelledby="modal-title" role="dialog" aria-modal="true">
  <div class="fixed inset-0 bg-black/90 modalbg" aria-hidden="true"></div>
  <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
    <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">
      <div class="relative transform overflow-hidden bg-black text-left border-2 border-yellow-600 transition-all sm:my-8 sm:w-full sm:max-w-2xl mx-2 rounded-3xl">
        <div class="p-4">
          <h1 class="text-center text-5xl borgens">
            {$_("lang.title")}
          </h1>

          <div class="flex flex-row justify-center gap-2 my-2 text-white borgens text-3xl">
            {#each langs as lang}
            <button class="rounded-2xl bg-slate-600 p-4 outline-none" 
                    class:outline-yellow-600={selectedLang === lang.id}
                    onclick={() => selectedLang = lang.id}>
              <img src={lang.img} alt={lang.id} class="w-40">
              <h2>{lang.name}</h2>
              <p>({lang.defaultName})</p>
            </button>
            {/each}
          </div>
          <div class="mt-2 border-t-2 pt-2 border-yellow-600 px-2 max-sm:flex-col-reverse gap-2 flex justify-center font-bold">
            <button class="hover:scale-110 border-2 p-1 rounded bg-black text-yellow-600 border-yellow-600 duration-300" 
                    onclick={() => { clicked = false; }}>
              {$_("close")}
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
{/if}

<style>
  ::selection {
    background-color: rgb(66, 45, 0);
    color: #ca8a04;
  }
</style>