<script lang="ts">
  import { _ } from "svelte-i18n";
  import type { Feedback, FriendData, Modal } from "$lib/interfaces";
  let { show = $bindable() }: Modal = $props(),
      friends: Array<FriendData> = $state([]),
      feedback : Feedback = $state({});

  // Get friends data
  $effect(() => {
    if (show) getFriends();
  })

  async function getFriends(): Promise<void> {
    await fetch("/api/get-friends")
    .then((res: Response) => res.json())
    .then(res => friends = res)
  }

  async function deleteFriend(id: number): Promise<void> {
    await fetch("/api/delete-friend", {
      method: "PUT",
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(id)
    })
    .then((res: Response) => res.json())
    .then(res => {
      if (res.success) {
        friends = friends.filter((item: FriendData) => item.id != id);
        feedback["success"] = res.success;
      }
      else feedback['error'] = res.error;
    });
  }
</script>

<div class:hidden={!show} class="relative z-10" aria-labelledby="modal-title" role="dialog" aria-modal="true">

  <div class="fixed inset-0 bg-black/90 transition-opacity modalbg" aria-hidden="true"></div>
  
  <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
    <div class="flex min-h-full justify-center text-center items-center sm:p-0">
      <div class="relative transform overflow-hidden border-yellow-600 bg-black text-left 
                  border-2 transition-all sm:my-8 max-w-2xl m-1 p-2 sm:p-4 rounded-3xl text-yellow-600">
        <h1 class="text-center text-5xl borgens">
          {$_("friends.title")}
        </h1>

        <div class="p-2">
          {#if friends.length}
            {#each friends as friend}
            <div class="max-sm:text-sm flex border-t border-yellow-600 m-2 pt-1">
              <div class="basis-3/5 flex items-center justify-center italic p-2">
                {friend.username}
              </div>
              <div class="sm:px-2 p-1 basis-1/5">
                <a href="/profile/{friend.username}">
                  <div class="bg-blue-600 text-black rounded p-1 w-full hover:scale-110 hover:bg-black 
                              hover:text-blue-600 duration-300 border-2 border-blue-600">
                    {$_("friends.statistics")}
                  </div>
                </a>
              </div>
              <div class="sm:px-2 p-1 basis-1/5">
                <button type="button"
                        class="bg-red-600 rounded p-1 w-full text-black hover:text-red-600 hover:bg-black 
                                 hover:scale-110 duration-300 border-2 border-red-600"
                        onclick={() => deleteFriend(friend.id)}>
                  {$_("delete")}
                </button>
              </div>
            </div>
            {/each}
          {:else}
            <div class="p-2 text-center">
              {$_("friends.friends.empty")}
            </div>
          {/if}
        </div>

        {#if feedback.success || feedback.error}
          <div class:bg-green-600={feedback.success}
               class:bg-red-600={feedback.error} 
               class="m-2 rounded text-white text-center p-1 text-md">
          {#if feedback.success}
            {$_("friends.success.friends.deleted")}
          {:else}
            {$_(`${feedback.error}`)}
          {/if}
          </div>
        {/if}

        <div class="mt-2 border-t-2 pt-2 border-yellow-600 px-2 max-sm:flex-col-reverse gap-2 flex justify-center font-bold">
          <button class="hover:scale-110 border-2 p-1 rounded bg-black text-yellow-600 border-yellow-600 duration-300" 
                  onclick={() => { show = false; }}>
            {$_("close")}
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