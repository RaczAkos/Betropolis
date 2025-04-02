<script lang="ts">
  import Input from "$lib/components/Input.svelte";
  import { _ } from "svelte-i18n";
  import chip from "$lib/media/images/chip.png";

  let { show = $bindable(), logged } = $props(),
      email:string = $state(""),
      goodEmail = $state(false),
      bonus:any = $state({});

  async function bonusGame() {
    let res:any = {}
    if (!logged) {
      res = await fetch('/api/bonus', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email })
      })
      .then (res => res.json());
    } else {
      res = await fetch('/api/bonus')
      .then (res => res.json());
    }
    email = "";
    
    bonus = {
      title: res.title,
      description: res.description,
      extra: res.extra,
      bonus: res.bonus
    }
  }

  $effect(() => {
    if (logged && show) bonusGame();
  });

  // E-mail format check
  $effect(() => {
    if (/^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$/.test(email)) goodEmail = true;
    else goodEmail = false;
  })
</script>


<!-- Bonus Game Modal -->
{#if show}
<div class="relative z-10 transition-opacity duration-500 text-yellow-600 text-lg" aria-labelledby="modal-title" role="dialog" aria-modal="true">
  <div class="fixed inset-0 bg-black/90 modalbg" aria-hidden="true"></div>
  <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
    <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">
      <div class="relative transform overflow-hidden bg-black text-left border-2 border-yellow-600 transition-all sm:my-8 sm:w-full sm:max-w-2xl mx-2 rounded-3xl">
        <div class="px-4 pt-4">
          
          <h3 class="text-center text-4xl borgens">
            {$_(!bonus.title ? "bonus.title": bonus.title)}
          </h3>
          <div class="mt-3 [&_p]:text-center sm:mt-0 sm:text-left">
            <div class="my-2">
              <p>
                {$_(!bonus.description ? "bonus.description": bonus.description)}
                {#if bonus.bonus}
                  {bonus.bonus}
                  <img src={chip} 
                       alt="chips" 
                       class="h-6 inline-block">
                {/if}
              </p>
              {#if bonus.extra}
                <p>({$_("bonus.returned.extra")} {bonus.extra[0]}, {bonus.extra[1]}, {bonus.extra[2]})</p>
              {/if}
            </div>
            {#if !bonus.title}
            <Input id="bonusemail" 
                   bind:value={email} 
                   type="email" 
                   placeholder="example@example.com"/>
            {/if}
          </div>
        </div>
        
        <div class="border-t-yellow-600 border-t-2 my-1 mt-2 px-4 py-2 sm:flex sm:flex-row-reverse sm:px-6 justify-center">
          {#if !bonus.title}
          <button onclick={bonusGame} 
                  disabled={!goodEmail}
                  type="button" 
                  class="max-sm:mb-2 sm:ms-2 inline-flex w-full justify-center rounded bg-black p-1 text-md font-semibold border-2 border-yellow-600 enabled:hover:bg-yellow-600 enabled:hover:text-black disabled:text-yellow-600/50 disabled:border-yellow-600/50 duration-300 sm:w-auto">
            {$_("bonus.claim")}
          </button>
          {/if}
          <button onclick={() =>{ 
                    show = !show; 
                    email = ""; 
                    goodEmail = false; 
                    if (bonus.title) bonus = {};
                    if (logged) window.location.reload();
                  }} 
                  type="button" 
                  class="w-full justify-center rounded bg-black p-1 text-md font-semibold border-2 border-yellow-600 hover:bg-yellow-600 hover:text-black duration-300 sm:w-auto">
            {$_("close")}
          </button>
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