<script lang="ts">
  import { _ } from "svelte-i18n";
  import Input from "../Input.svelte";
  import type { Feedback, Modal } from "$lib/interfaces";

  let { show = $bindable() }: Modal = $props(),
      friendUsername: string = $state(""),
      feedback: Feedback     = $state({});

  // Adding friend
  async function addFriend(): Promise<void> {
    feedback = {};

    await fetch("/api/friend-requests", {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ friendUsername })
    })
    .then((res: Response) => res.json())
    .then(res => {
      if (res.success) feedback["success"] = res.success;
      else feedback['error'] = res.error;
    })

    friendUsername = "";
  }
</script>

<div class:hidden={!show} 
     class="relative z-10">

  <div class="fixed inset-0 bg-black/90 transition-opacity modalbg"></div>
  
  <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
    <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">
      <div class="relative transform overflow-hidden border-yellow-600 bg-black text-left 
                  border-2 transition-all sm:my-8 max-w-3xl mx-2 p-4 rounded-3xl text-yellow-600">
        <h1 class="text-center text-5xl borgens">
          {$_("friends.add")}
        </h1>
        
        <div class="text-center mb-2 p-2">
          {$_("friends.add.description")}
        </div>

        <div class="px-5">
          <Input bind:value={friendUsername}/>
        </div>

        <!-- Display success or error -->
        {#if feedback.success || feedback.error}
          <div class:bg-green-600={feedback.success}
               class:bg-red-600={feedback.error} 
               class="m-2 rounded text-white text-center p-1 text-md">
            {#if feedback.success}
              {$_("friends.success.add")}
            {:else}
              {$_("friends.errors.add." + feedback.error)}
            {/if}
          </div>
        {/if}

        <!-- Close and Add buttons -->
        <div class="mt-2 border-t-2 pt-2 border-yellow-600 px-2 max-sm:flex-col-reverse gap-2 flex justify-center font-bold">
          <button class="hover:scale-110 border-2 p-1 rounded bg-black text-yellow-600 border-yellow-600 duration-300" 
                  onclick={() => { show = false; friendUsername = "", feedback = {}}}>
            {$_("close")}
          </button>
          <button class="enabled:hover:scale-110 border-2 p-1 rounded bg-yellow-600 text-black 
                       border-yellow-600 enabled:hover:bg-black enabled:hover:text-yellow-600 disabled:opacity-50 duration-300" 
                  disabled={!/^[a-zA-Z0-9]{5,20}$/.test(friendUsername)}
                  onclick={addFriend}>
            {$_("friends.add.send")}
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