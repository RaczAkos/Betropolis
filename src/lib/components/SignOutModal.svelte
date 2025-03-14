<script>
  let { clicked = $bindable() } = $props();

  function signOut() {
    fetch("/api/sign-out").then(() => window.location.reload());
  }

  function signOutAll() {
    fetch("/api/sign-out-all").then(() => window.location.reload());
  }
</script>

<div class:hidden={!clicked} class="relative z-10" aria-labelledby="modal-title" role="dialog" aria-modal="true">

  <div class="fixed inset-0 bg-black/90 transition-opacity modalbg" aria-hidden="true"></div>
  
  <div class="fixed inset-0 z-10 w-screen overflow-y-auto text-white">
    <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">
      <div class="relative transform overflow-hidden border-yellow-600 bg-black text-left border transition-all sm:my-8 max-w-3xl mx-2 p-4 rounded-3xl text-yellow-600">
        <h1 class="text-center text-5xl borgens">
          Signing out!
        </h1>          
        
        <div class="text-center">
          Are you sure you want to sign out?
        </div>
        
        <div class="mt-2 border-t pt-2 border-yellow-600 px-2 max-sm:flex-col-reverse gap-2 flex justify-center font-bold">
          <button class="hover:scale-105 border-2 p-1 rounded bg-black text-yellow-600 border-yellow-600 duration-300" 
                  onclick={() => clicked = false}>
            Close
          </button>
          <button class="hover:scale-105 border-2 p-1 rounded bg-yellow-600 text-black border-yellow-600 hover:bg-black hover:text-yellow-600 duration-300" 
                  onclick={signOut}>
            Sign out
          </button>
          <button class="hover:scale-105 border-2 p-1 rounded bg-yellow-600 text-black border-yellow-600 hover:bg-black hover:text-yellow-600 duration-300" 
                  onclick={signOutAll}>
            Sign out everywhere
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