
<script lang="ts">

  let { show = $bindable(), requestsData = [[], []] } = $props(),
      gotRequests = $state(requestsData[0]),
      sentRequests = $state(requestsData[1]),
      feedback:any = $state({});

  async function deleteOrAcceptFriendRequest(type:string, data:any, index:number) {
    feedback = {};
    
    let res:any = fetch(`/api/${(type == "accept")? "accept-friend":"delete-friend-request"}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    });

    res = (await res).json();
    res.then((res:any) => {
      if (res.success) {
        if (index) sentRequests = sentRequests.filter((item:any) => item.id != data.requestId);
        else gotRequests = gotRequests.filter((item:any) => item.id != data.requestId);
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
      <div class="relative transform overflow-hidden border-yellow-600 bg-black text-left border-2 transition-all sm:my-8 max-w-2xl m-1 p-2 sm:p-4 rounded-3xl text-yellow-600">
        <h1 class="text-center text-5xl borgens">
          Friend Requests
        </h1>
        
        {#if gotRequests.length || sentRequests.length}
          <div class="m-2 p-2">

          <!-- Requests got -->
          {#if gotRequests.length}
            <div class="border-2 border-yellow-600 rounded-2xl p-2 shadow-md shadow-yellow-600">
              <h2 class="text-center borgens text-3xl">Friend requests</h2>
              {#each gotRequests as request}
              <div class="max-sm:text-sm flex border-t border-yellow-600 m-2 pt-1">
                <div class="basis-3/5 flex gap-1 items-center justify-center italic">
                  {request.username}
                </div>
                <div class=" p-1 basis-1/5">
                  <button type="button"
                          class="bg-green-600 text-black rounded p-1 w-full hover:scale-110 hover:bg-black hover:text-green-600 duration-300 border-2 border-green-600"
                          onclick={() => deleteOrAcceptFriendRequest("accept", {"requestId":request.id, "senderId": request.senderId}, 0)}>
                    Accept
                  </button>
                </div>
                <div class=" p-1 basis-1/5">
                  <button type="button"
                          class="bg-red-600 rounded p-1 w-full text-black hover:text-red-600 hover:bg-black hover:scale-110 duration-300 border-2 border-red-600"
                          onclick={() => deleteOrAcceptFriendRequest("delete", {"requestId":request.id}, 0)}>
                    Delete
                  </button>
                </div>
              </div>
              {/each}
            </div>
          {/if}

          <!-- Requests sent -->
          {#if sentRequests.length}
            <div class="border-2 border-yellow-600 rounded-2xl p-2 mt-2 shadow-md shadow-yellow-600">
              <h2 class="text-center borgens text-3xl">Sent requests</h2>
              {#each sentRequests as request}
              <div class="max-sm:text-sm flex border-t border-yellow-600 m-2">
                <div class="basis-4/5 flex gap-1 items-center justify-center italic">
                  {request.username}
                </div>
                <div class="sm:px-2 p-1 basis-1/5">
                  <button type="button"
                          class="bg-red-600 rounded p-1 w-full text-black hover:text-red-600 hover:bg-black hover:scale-110 duration-300 border-2 border-red-600"
                          onclick={() => deleteOrAcceptFriendRequest("delete", {"requestId":request.id}, 1)}>
                    Delete
                  </button>
                </div>
              </div>
              {/each}
            </div>
          {/if}
        </div>
        
        {:else}
          <div class="p-2 text-center">
            No requests right now!
          </div>
        {/if}

        {#if feedback.success || feedback.error}
          <div class:bg-green-600={feedback.success}
               class:bg-red-600={feedback.error} 
               class="m-2 rounded text-white text-center p-1 text-md">
            {feedback.success}
            {feedback.error}
          </div>
        {/if}

        <div class="mt-2 border-t-2 pt-2 border-yellow-600 px-2 max-sm:flex-col-reverse gap-2 flex justify-center font-bold">
          <button class="hover:scale-110 border-2 p-1 rounded bg-black text-yellow-600 border-yellow-600 duration-300" 
                  onclick={() => { show = false; feedback = {}; }}>
            Close
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