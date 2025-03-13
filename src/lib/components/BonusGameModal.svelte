<script lang="ts">
  import Input from "$lib/components/Input.svelte";

  let { show = $bindable() } = $props(),
      email:string = $state(""),
      goodEmail = $state(false),
      returnedBonus = $state(false),
      bonus:any = $state({title:"", message:""});

  async function bonusGame() {
      const res = await fetch('/api/bonus', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email })
      })
      .then (res => res.json());
      
      bonus = {
        title: res.title,
        message: res.message,
        extra: res.extra
      }

      returnedBonus = true;
      email = "";
  }
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
      <div class="relative transform overflow-hidden bg-black text-left border border-yellow-600 transition-all sm:my-8 sm:w-full sm:max-w-2xl mx-2 rounded-3xl">
        
        <div class="px-4 pt-4">
          <h3 class="text-center text-4xl borgens">
            {#if !returnedBonus}
              Claim your extra starting bonus!
            {:else}
              {bonus.title}
            {/if}
          </h3>
          <div class="mt-3 text-center sm:mt-0 sm:text-left">
            <div class="my-2">
              <p class="text-center">
                {#if !returnedBonus}
                  Please enter the e-mail you want your bonus to be connected to. You will automaticly get that bonus when you sign up with that e-mail.
                {:else}
                  {bonus.message}
                {/if}
              </p>
              {#if bonus.extra}
                <p class="text-center">{bonus.extra}</p>
              {/if}
            </div>
            {#if !returnedBonus}
            <Input id="bonusemail" 
                   bind:value={email} 
                   type="email" 
                   placeholder="example@example.com"/>
            {/if}
          </div>
        </div>
        
        <div class="border-t-yellow-600 border-t my-1 mt-2 px-4 py-2 sm:flex sm:flex-row-reverse sm:px-6 justify-center">
          {#if !returnedBonus}
          <button onclick={bonusGame} 
                  disabled={!goodEmail}
                  type="button" 
                  class="max-sm:mb-2 sm:ms-2 inline-flex w-full justify-center rounded bg-black p-2 text-md font-semibold border-2 border-yellow-600 enabled:hover:bg-yellow-600 enabled:hover:text-black disabled:text-yellow-600/50 disabled:border-yellow-600/50 duration-300 sm:w-auto">
            Claim
          </button>
          {/if}
          <button onclick={() =>{ show = !show; email = ""; goodEmail = false; if (returnedBonus) {bonus = {}; returnedBonus = false;}}} 
                  type="button" 
                  class="w-full justify-center rounded bg-black p-2 text-md font-semibold border-2 border-yellow-600 hover:bg-yellow-600 hover:text-black duration-300 sm:w-auto">
            Close
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