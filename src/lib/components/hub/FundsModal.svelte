<script lang="ts">
  import { _ } from "svelte-i18n";
  import Input from "../Input.svelte";
  import type { Feedback, Modal } from "$lib/interfaces";

  let { show = $bindable() }: Modal = $props();
  let funds: string[]   = $state(["deposit", "withdraw"]),
      type: string   = $state(""),
      balance:number = $state(0),
      change:number  = $state(0),
      feedback: Feedback = $state({});

  $effect(() => {
    if (show) fetch("/api/balance-update").then(res => res.json()).then(res => balance = res.balance);
  })

  // Depositing or withdrawing
  async function manageFunds(): Promise<void> {
    feedback = {};

    await fetch("/api/funds", {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ change, type })
    })
    .then((res: Response) => res.json())
    .then(res => {
      if (res.success){
        feedback["success"] = res.success;
        balance = res.balance;
      } 
      else feedback['error'] = res.error;
    });

    setTimeout(() => {
      feedback = {};
    }, 3000)

    change = 0;
  }
</script>

<!-- Funds Modal -->
<div class:hidden={!show} 
     class="relative z-10">

  <div class="fixed inset-0 bg-black/90 transition-opacity modalbg"></div>
  
  <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
    <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">
      <div class="relative transform overflow-hidden border-yellow-600 bg-black text-left 
                  border-2 transition-all sm:my-8 max-w-3xl mx-2 p-4 rounded-3xl text-yellow-600">
        <h1 class="text-center text-5xl borgens">
          {$_("funds.title")}
        </h1>
        
        <!-- Select withdraw or deposit -->
        <div class="text-center mb-1 p-2 flex flex-row text-lg">
          {#each funds as fundType}
            <div class="basis-1/2">
              <input bind:group={type} 
                     value={fundType} 
                     id="fund-{fundType}" 
                     type="radio" 
                     name="gender" 
                     class="w-4 h-4 accent-yellow-600 bg-black border-yellow-600 focus:ring-yellow-600 ">
              <label for="fund-{fundType}" 
                     class="ms-1 text-md font-medium text-yellow-600">
                {$_(`funds.${fundType}`)}
              </label>
            </div>
            {/each}
        </div>

        <!-- Balance -->
        <div class="text-center my-1 text-2xl flex items-center justify-center gap-1">
          {$_("games.balance")}: {balance} 
          <img src="/src/lib/media/images/chip.png" 
               alt="chip"
               class="w-6 h-6">
        </div>

        <!-- Amount -->
        <div class="px-5 text-center">
          <Input bind:value={change} 
                 type="number"/>
        </div>

        <!-- Display success or error -->
        {#if feedback.success || feedback.error}
          <div class:bg-green-600={feedback.success}
               class:bg-red-600={feedback.error} 
               class="m-2 rounded text-white text-center p-1 text-md duration-500">
            {#if feedback.success}
              {$_(`funds.${type}-success`)}
            {:else}
              {$_("" + feedback.error)}
            {/if}
          </div>
        {/if}

        <!-- Close and Add buttons -->
        <div class="mt-2 border-t-2 pt-2 border-yellow-600 px-2 max-sm:flex-col-reverse gap-2 flex justify-center font-bold text-xl">
          <button class="hover:scale-110 border-2 p-1 rounded bg-black text-yellow-600 border-yellow-600 duration-300" 
                  onclick={() => { show = false; feedback = {}}}>
            {$_("close")}
          </button>
          <button class="enabled:hover:scale-110 border-2 p-1 rounded bg-yellow-600 text-black border-yellow-600 
                       enabled:hover:bg-black enabled:hover:text-yellow-600 disabled:opacity-50 duration-300" 
                  disabled={!type || (type == "withdraw" && balance < change) || change <= 0}
                  onclick={manageFunds}>
            {#if type == "deposit"}
              {$_("funds.deposit")}
            {:else}
              {$_("funds.withdraw")}
            {/if}
          </button>
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