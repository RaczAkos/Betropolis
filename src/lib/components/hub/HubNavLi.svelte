<script>
  let { text, type = "button", href = "", click = $bindable(), notification = null, count = null } = $props();
</script>

<li class="text-center hover:bg-yellow-600 rounded-md duration-300 max-sm:bg-yellow-600">
  {#if type == "button"}
  <button type="button" 
          class="w-full flex justify-center items-center gap-1"
          onclick={() => { click = !click }}>
    {#if notification || count}
      <div class="w-4 h-4 max-sm:text-sm sm:w-6 sm:h-6 rounded-full font-bold flex items-center justify-center" 
           class:border={count} 
           class:bg-red-600={notification}>
        {#if notification}
          {notification}
        {:else}
          {count}
        {/if}
      </div>
    {/if}
    <div class="borgens">
      {text}
    </div>
  </button>
  {:else}
  <a {href}>
    <div class="w-full select-none borgens">
      {text}
    </div>
  </a>
  {/if}
</li>