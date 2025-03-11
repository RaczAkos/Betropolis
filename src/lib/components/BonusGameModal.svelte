<script lang="ts">
  import Input from "$lib/components/Input.svelte";

  let { show = $bindable() } = $props(),
      email:string = $state(""),
      goodEmail = $state(true),
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
        message: res.message
      }

      returnedBonus = true;
      goodEmail = true;
      email = "";
  }
  $effect(() => {
    if (/^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$/.test(email)) goodEmail = true;
    else goodEmail = false;
  })
</script>


<!-- Bonus Game Modal -->
{#if show}
<div class={`relative z-10 transition-opacity duration-500`} aria-labelledby="modal-title" role="dialog" aria-modal="true">
  <div class="fixed inset-0 bg-black/90 modalbg" aria-hidden="true"></div>
  <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
    <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">
      <div class="!w-[400px] relative transform overflow-hidden bg-black text-left border border-yellow-600 transition-all sm:my-8 sm:w-full sm:max-w-2xl mx-2 rounded-3xl">
        {#if !returnedBonus}
        <div class="px-4 pt-4">
          <h3 class="font-semibold text-center text-yellow-600 text-4xl borgens">Claim your extra starting bonus!</h3>
          <div class="mt-3 text-center sm:mt-0 sm:text-left">
            <div class="my-2">
              <p class="text-md text-yellow-600 text-justify">
                  Please enter the e-mail you want your bonus to be connected to. You will automaticly get that bonus when you sign up with that e-mail.
              </p>
            </div>
            <Input id="bonusemail" 
                   bind:value={email} 
                   type="email" 
                   placeholder="example@example.com"/>
          </div>
        </div>
        <div class="border-t-yellow-600 border-t my-1 px-4 py-2 sm:flex sm:flex-row-reverse sm:px-6 justify-center">
          <button onclick={bonusGame} 
                  type="button" 
                  class="max-sm:mb-2 sm:ms-2 inline-flex w-full justify-center rounded-md bg-black p-2 text-md font-semibold text-yellow-600 border border-yellow-600 hover:bg-yellow-600 hover:text-black duration-300 sm:w-auto">
            Claim
          </button>
          <button onclick={() =>{ show = !show; email = ""; goodEmail = true; }} 
                  type="button" 
                  class="inline-flex w-full justify-center rounded-md bg-black p-2 text-md font-semibold text-yellow-600 border border-yellow-600 hover:bg-yellow-600 hover:text-black duration-300 sm:w-auto">
            Close
          </button>
        </div>
        {:else}
        <div class="p-4">
          <h3 class="font-semibold text-center text-yellow-600 text-4xl borgens">{bonus.title}</h3>
          <div class="mt-3 text-center sm:mt-0 sm:text-left w-full">
            <div class="my-2">
              <p class="text-lg text-yellow-600 text-center">
                {bonus.message}
              </p>
            </div>
          </div>
        </div>
        <div class="border-t-yellow-600 border-t my-1 px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6 justify-center">
          <button onclick={() =>{ show = !show; bonus = {}; returnedBonus = false; goodEmail = true }} 
                  type="button" 
                  class="inline-flex w-full justify-center rounded-md bg-black p-2 text-md font-semibold text-yellow-600 border border-yellow-600 hover:bg-yellow-600 hover:text-black duration-300 sm:w-auto">
            Close
          </button>
        </div>
        {/if}
      </div>
    </div>
  </div>
</div>
{/if}