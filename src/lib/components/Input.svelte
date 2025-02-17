<script>
  // Props
    let { value = $bindable(""), 
          disabled = false, 
          type = "text", 
          id = "", 
          placeholder = "", 
          label = null, 
          name="", 
          required = false} = $props();
</script>

<!-- Custom input -->
{#if label}<label class="block text-yellow-600 text-md font-bold mb-1" for={id}>{label}</label>{/if}
<input bind:value={value} {disabled} {id} {type} {placeholder} {name} {required}
       class=" shadow appearance-none border-2 border-yellow-600 placeholder:opacity-50 rounded w-full py-1 px-3 placeholder:text-yellow-600 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black ">