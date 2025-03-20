
<script lang="ts">

  let { show = $bindable(), requestsData = [[], []] } = $props(),
      gotRequests = $state(requestsData[0]),
      sentRequests = $state(requestsData[1]),
      feedback:any = $state({}),
      windowWidth:number = $state(0),
      colspan:number = $state(3);

  async function deleteOrAcceptFriendRequest(type:string, data:any, index:number) {
    feedback = {};
    
    let res:any = fetch(`/api/${(type == "accept")? "accept-friend":"delete-friend-request"}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    })

    res = (await res).json();
    res.then((res:any) => {
      if (res.success) {
        if (index) sentRequests = requestsData[1].filter((item:any) => item.id != data.requestId);
        else gotRequests = requestsData[0].filter((item:any) => item.id != data.requestId);
        feedback["success"] = res.success;
      } 
      else feedback['error'] = res.error;
    })  
  }

  $effect(() => {
    if (windowWidth > 639) colspan = 3;
    else colspan = 2;
  })
</script>

<svelte:window bind:innerWidth={windowWidth} />

<div class:hidden={!show} class="relative z-10" aria-labelledby="modal-title" role="dialog" aria-modal="true">

  <div class="fixed inset-0 bg-black/90 transition-opacity modalbg" aria-hidden="true"></div>
  
  <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
    <div class="flex min-h-full justify-center text-center items-center sm:p-0">
      <div class="relative transform overflow-hidden border-yellow-600 bg-black text-left border transition-all sm:my-8 max-w-2xl m-1 p-2 sm:p-4 rounded-3xl text-yellow-600">
        <h1 class="text-center text-5xl borgens">
          Friend Requests
        </h1>
        
        {#if gotRequests.length || sentRequests.length}
          <div class="m-2">

          <!-- Requests got -->
          {#if gotRequests.length}
            <table class="table-fixed w-full text-center border border-yellow-600 my-1">
              <thead>
                <tr>
                  <th colspan={colspan+2}>Friend Requests</th>
                </tr>
              </thead>
              <tbody>
                {#each gotRequests as request}
                  <tr class="[&_td]:border-yellow-600 [&_td]:border max-sm:text-sm">
                    <td {colspan}>
                      From: 
                      <span class="italic">{request.username}</span>
                    </td>
                    <td class="sm:px-2 p-1">
                      <button type="button"
                              class="bg-green-600 rounded p-1 w-full text-white hover:scale-110 duration-300 border"
                              onclick={() => deleteOrAcceptFriendRequest("accept", {"requestId":request.id, "senderId": request.senderId}, 0)}>
                        Accept
                      </button>
                    </td>
                    <td class="sm:px-2 p-1">
                      <button type="button"
                              class="bg-red-600 rounded p-1 w-full text-white hover:scale-110 duration-300 border"
                              onclick={() => deleteOrAcceptFriendRequest("delete", {"requestId":request.id}, 0)}>
                        Delete
                      </button>
                    </td>
                  </tr>
                {/each}
              </tbody>
            </table>
          {/if}

          <!-- Requests sent -->
          {#if sentRequests.length}
            <table class="w-full text-center table-fixed border border-yellow-600 my-1">
              <thead>
                <tr>
                  <th colspan={colspan+2} class="border border-yellow-600">Sent Requests</th>
                </tr>
              </thead>
              <tbody>
                {#each sentRequests as request}
                  <tr class="[&_td]:border-yellow-600 [&_td]:border max-sm:text-sm">
                    <td colspan={colspan+1}>
                      To: 
                      <span class="italic">{request.username}</span>
                    </td>
                    <td class="sm:px-2 p-1">
                      <button type="button"
                              class="bg-red-600 rounded p-1 w-full text-white hover:scale-110 duration-300 border"
                              onclick={() => deleteOrAcceptFriendRequest("delete", {"requestId":request.id}, 1)}>
                        Delete
                      </button>
                    </td>
                  </tr>
                {/each}
              </tbody>
            </table>
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

        <div class="mt-2 border-t pt-2 border-yellow-600 px-2 max-sm:flex-col-reverse gap-2 flex justify-center font-bold">
          <button class="hover:scale-110 border-2 p-1 rounded bg-black text-yellow-600 border-yellow-600 duration-300" 
                  onclick={() => { show = false; feedback = {}}}>
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