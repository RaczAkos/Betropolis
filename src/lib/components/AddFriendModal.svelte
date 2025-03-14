<script>
  import Input from "./Input.svelte";
  let { show = $bindable() } = $props();
  let friendUsername = $state(""),
      disabled = $state(true);

  function addFriend() {
    fetch("/api/add-friend", {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ friendUsername })
    })
    .then(() => {
      
    });
  }

  $effect(() => {
    disabled = /^[a-zA-Z0-9]{5,20}$/.test(friendUsername);
    $inspect(disabled)
  })
  
</script>

<div class:hidden={!show} class="relative z-10" aria-labelledby="modal-title" role="dialog" aria-modal="true">

  <div class="fixed inset-0 bg-black/90 transition-opacity modalbg" aria-hidden="true"></div>
  
  <div class="fixed inset-0 z-10 w-screen overflow-y-auto text-white">
    <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">
      <div class="relative transform overflow-hidden border-yellow-600 bg-black text-left border transition-all sm:my-8 max-w-3xl mx-2 p-4 rounded-3xl text-yellow-600">
        <h1 class="text-center text-5xl borgens">Add a friend</h1>
        
        <div class="text-center mb-2">Enter your friend's username:</div>
        <Input bind:value={friendUsername}/>
        
        <div class="mt-2 border-t pt-2 border-yellow-600 px-2 max-sm:flex-col-reverse gap-2 flex justify-center font-bold">
          <button class="hover:scale-105 border-2 p-1 rounded bg-black text-yellow-600 border-yellow-600 duration-300" 
                  onclick={() => show = false}>
            Close
          </button>
          <button class="hover:scale-105 border-2 p-1 rounded bg-yellow-600 text-black border-yellow-600 enabled:hover:bg-black enabled:hover:text-yellow-600 disabled:bg-yellow-600/50 disabled:border-yellow-600/50 duration-300" 
                  disabled={!disabled}
                  onclick={addFriend}>
            Add
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