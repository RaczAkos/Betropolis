<script>
  let { text, type = "button", href = "", click = $bindable(), notification = null } = $props();
</script>

<li class="text-center hover:bg-yellow-600 rounded-md duration-300 max-sm:bg-yellow-600">
  {#if type == "button"}
  <button type="button" 
          class="w-full flex justify-center items-center gap-1"
          onclick={() => { click = !click }}>
    {#if notification}
      <div class="min-w-4 h-4 max-sm:text-sm sm:min-w-6 sm:h-6 rounded-full font-bold flex items-center justify-center pb-[2px]" 
           class:bg-red-600={notification}>
        <span class="sm:pr-[2px]">{notification}</span>
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