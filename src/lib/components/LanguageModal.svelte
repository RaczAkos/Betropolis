<script lang="ts">
  import { _ } from "svelte-i18n";
  let { clicked = $bindable() } = $props();
</script>

<!-- Language change modal -->
{#if clicked}
<div class="relative z-10 transition-opacity duration-500 text-yellow-600 text-lg" aria-labelledby="modal-title" role="dialog" aria-modal="true">
  <div class="fixed inset-0 bg-black/90 modalbg" aria-hidden="true"></div>
  <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
    <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">
      <div class="relative transform overflow-hidden bg-black text-left border-2 border-yellow-600 transition-all sm:my-8 sm:w-full sm:max-w-2xl mx-2 rounded-3xl">
        <div class="px-4 pt-4">
          
        </div>
      </div>
    </div>
  </div>
</div>
{/if}

<style>
  ::selection {
    background-color: rgb(66, 45, 0);
    color: #ca8a04;
  }
</style>