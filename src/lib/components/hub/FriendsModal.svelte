
<script lang="ts">
  let { show = $bindable(), friendData = [] } = $props(),
      friends = $state(friendData);

  async function deleteFriend() {
    let response = fetch("/api/delete-friend", {
                     method: "POST",
                     headers: { 'Content-Type': 'application/json' },
                     body: JSON.stringify("data")
                   })
                   .then(res => res.json());
  }
</script>

<div class:hidden={!show} class="relative z-10" aria-labelledby="modal-title" role="dialog" aria-modal="true">

  <div class="fixed inset-0 bg-black/90 transition-opacity modalbg" aria-hidden="true"></div>
  
  <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
    <div class="flex min-h-full justify-center text-center items-center sm:p-0">
      <div class="relative transform overflow-hidden border-yellow-600 bg-black text-left border-2 transition-all sm:my-8 max-w-2xl m-1 p-2 sm:p-4 rounded-3xl text-yellow-600">
        <h1 class="text-center text-5xl borgens">
          Friends
        </h1>

        <div class="p-2">
          {#if friends.length}
            {#each friends as friend}
            <div class="p-1 border-t">
              <div>
                {friend.username}
              </div>
            </div>
            {/each}
          {:else}
            <div class="p-2 text-center">
              No friends yet!
            </div>
          {/if}
        </div>

        <!-- 
        {#if feedback.success || feedback.error}
          <div class:bg-green-600={feedback.success}
               class:bg-red-600={feedback.error} 
               class="m-2 rounded text-white text-center p-1 text-md">
            {feedback.success}
            {feedback.error}
          </div>
        {/if}-->

        <div class="mt-2 border-t-2 pt-2 border-yellow-600 px-2 max-sm:flex-col-reverse gap-2 flex justify-center font-bold">
          <button class="hover:scale-110 border-2 p-1 rounded bg-black text-yellow-600 border-yellow-600 duration-300" 
                  onclick={() => { show = false; }}>
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