<script lang="ts">
  import { _ } from "svelte-i18n";
  import type { Input } from "$lib/interfaces";
  // Props
  let { 
        value = $bindable(""), 
        disabled = false, 
        type = "text", 
        id = "", 
        placeholder = "", 
        label = null, 
        name="", 
        required = false,
        onpaste = null
      }: Input = $props();
</script>

<!-- Custom input (with optional label) -->
{#if label}
  <label class="block text-yellow-600 text-md font-bold mb-1" for={id}>
    {label}
  </label>
{/if}
<input bind:value={value} 
       {disabled} 
       {id} 
       {type} 
       placeholder={$_(placeholder)} 
       {name} 
       {required} 
       {onpaste}>

<style>
  @reference "../../app.css";

  input { @apply shadow appearance-none border-2 border-yellow-600 placeholder:opacity-50 rounded w-full py-1 px-3 placeholder:text-yellow-600 text-yellow-600 leading-tight focus:outline-none bg-black; }
  
  ::selection {
    background-color: rgb(66, 45, 0);
    color: #ca8a04;
  }
</style>