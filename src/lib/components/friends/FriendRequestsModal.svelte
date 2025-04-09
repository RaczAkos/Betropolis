<script lang="ts">
  import { _ } from "svelte-i18n";
  import { onMount } from "svelte";
  import type { Feedback, FriendData, Modal } from "$lib/interfaces";

  let { 
        show = $bindable(), 
        notification = $bindable() 
      }: Modal = $props(),
      gotRequests: Array<FriendData>  = $state([]),
      sentRequests: Array<FriendData> = $state([]),
      feedback: Feedback = $state({});

  // Get Requests
  onMount(getRequests);

  $effect(() => {
    if (show) getRequests();
  });

  async function getRequests(): Promise<void> {
    await fetch("/api/get-friend-requests")
    .then((res:Response) => res.json())
    .then(res => {
      gotRequests = res.data[0];
      sentRequests = res.data[1];
      notification = gotRequests.length;
    })
  }

  // Delete or accept requests
  async function deleteOrAcceptFriendRequest(type: string, data: FriendData, index: number): Promise<void> {
    feedback = {};
    
    await fetch(`/api/${(type == "accept")? "accept-friend":"delete-friend-request"}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    })
    .then((res:Response)=> res.json())
    .then(res => {
      if (res.success) {
        if (index) sentRequests = sentRequests.filter((item: FriendData) => item.id != data.id);
        else gotRequests = gotRequests.filter((item: FriendData) => item.id != data.id);

        feedback["success"] = res.success;
        notification = gotRequests.length;
      }
      else feedback['error'] = res.error;
    });
  }
</script>

<div class:hidden={!show} 
     class="relative z-10">

  <div class="fixed inset-0 bg-black/90 transition-opacity modalbg"></div>
  
  <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
    <div class="flex min-h-full justify-center text-center items-center sm:p-0">
      <div class="relative transform overflow-hidden border-yellow-600 bg-black 
                  text-left border-2 transition-all max-w-3xl m-1 p-3 sm:p-4 rounded-3xl text-yellow-600">
        <h1 class="text-center text-5xl borgens">
          {$_("friends.requests")}
        </h1>

        {#if gotRequests.length || sentRequests.length}
          <div class="m-2 p-2">

          <!-- Requests for user -->
          {#if gotRequests.length}
            <div class="border-2 border-yellow-600 rounded-2xl px-2 pt-2 shadow-md shadow-yellow-600">
              
              <h2 class="text-center borgens text-3xl">
                {$_("friends.requests.incoming")}
              </h2>
              
              {#each gotRequests as request}
              <div class="max-sm:text-sm flex border-t border-yellow-600 m-2 pt-1">
                <div class="p-2 basis-3/5 flex gap-1 items-center justify-center italic">
                  {request.username}
                </div>
                <div class="sm:py-2 p-1 basis-1/5">
                  <button type="button"
                          class="bg-green-600 text-black rounded p-1 w-full hover:scale-110 hover:bg-black 
                                 hover:text-green-600 duration-300 border-2 border-green-600"
                          onclick={() => deleteOrAcceptFriendRequest("accept", {"id": request.id, "senderId": request.senderId}, 0)}>
                    {$_("accept")}
                  </button>
                </div>
                <div class="sm:py-2 p-1 basis-1/5">
                  <button type="button"
                          class="bg-red-600 rounded p-1 w-full text-black hover:text-red-600 hover:bg-black 
                                   hover:scale-110 duration-300 border-2 border-red-600"
                          onclick={() => deleteOrAcceptFriendRequest("delete", {"id": request.id}, 0)}>
                    {$_("delete")}
                  </button>
                </div>
              </div>
              {/each}
            </div>
          {/if}

          <!-- Requests sent by user -->
          {#if sentRequests.length}
            <div class="border-2 border-yellow-600 rounded-2xl px-2 pt-2 mt-2 shadow-md shadow-yellow-600">

              <h2 class="text-center borgens text-3xl">
                {$_("friends.requests.outgoing")}
              </h2>
              
              {#each sentRequests as request}
              <div class="max-sm:text-sm flex border-t border-yellow-600 m-2">
                <div class="basis-4/5 flex gap-1 items-center justify-center italic">
                  {request.username}
                </div>
                <div class="sm:px-2 p-1 basis-1/5">
                  <button type="button"
                          class="bg-red-600 rounded p-1 w-full text-black hover:text-red-600 hover:bg-black 
                                   hover:scale-110 duration-300 border-2 border-red-600"
                          onclick={() => deleteOrAcceptFriendRequest("delete", {"id": request.id}, 1)}>
                    {$_("delete")}
                  </button>
                </div>
              </div>
              {/each}
            </div>
          {/if}
        </div>
        
        {:else}
          <div class="p-2 text-center">
            {$_("friends.requests.empty")}
          </div>
        {/if}

        {#if feedback.success || feedback.error}
          <div class:bg-green-600={feedback.success}
               class:bg-red-600={feedback.error} 
               class="m-2 rounded text-white text-center p-1 text-md">
          {#if feedback.success}
            {$_("friends.success.requests." + feedback.success)}
          {:else}
            {$_(`${feedback.error}`)}
          {/if}
          </div>
        {/if}

        <div class="mt-2 border-t-2 pt-2 border-yellow-600 px-2 max-sm:flex-col-reverse gap-2 flex justify-center font-bold">
          <button class="hover:scale-110 border-2 p-1 rounded bg-black text-yellow-600 border-yellow-600 duration-300" 
                  onclick={() => { 
                    show = false; 
                    feedback = {}; 
                  }}>
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