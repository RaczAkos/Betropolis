
<script lang="ts">

  import Input from "../Input.svelte";

  let { show = $bindable() } = $props(),
      friendUsername = $state(""),
      disabled = $state(true),
      feedback:any = $state({});

  async function addFriend() {
    feedback = {};

    let res:any = fetch("/api/add-friend", {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ friendUsername })
    })

    res = (await res).json();
    res.then((res:any) => {
      if (res.success) feedback["success"] = res.success;
      else feedback['error'] = res.error;
    })

    friendUsername = "";
  }

  $effect(() => {
    disabled = /^[a-zA-Z0-9]{5,20}$/.test(friendUsername);
  })

</script>

<div class:hidden={!show} class="relative z-10" aria-labelledby="modal-title" role="dialog" aria-modal="true">

  <div class="fixed inset-0 bg-black/90 transition-opacity modalbg" aria-hidden="true"></div>
  
  <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
    <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">
      <div class="relative transform overflow-hidden border-yellow-600 bg-black text-left border transition-all sm:my-8 max-w-3xl mx-2 p-4 rounded-3xl text-yellow-600">
        <h1 class="text-center text-5xl borgens">
          Friend Requests
        </h1>
        
        

        <div class="mt-2 border-t pt-2 border-yellow-600 px-2 max-sm:flex-col-reverse gap-2 flex justify-center font-bold">
          <button class="hover:scale-110 border-2 p-1 rounded bg-black text-yellow-600 border-yellow-600 duration-300" 
                  onclick={() => { show = false; friendUsername = "", feedback = {}}}>
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