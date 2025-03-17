<script>
  let { text, type = "button", href = "", click = $bindable() } = $props();
</script>

<li class="text-center hover:bg-yellow-600 rounded-md duration-300 max-sm:bg-yellow-600 borgens">
  {#if type == "button"}
  <button type="button" 
          class="w-full"
          onclick={() => { click = !click }}>
    {text}
  </button>
  {:else}
  <a {href}>
    <div class="w-full select-none">
      {text}
    </div>
  </a>
  {/if}
</li>