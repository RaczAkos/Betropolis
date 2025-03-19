<script>
  let { text, type = "button", href = "", click = $bindable(), notification = null, count = null } = $props();
</script>

<li class="text-center hover:bg-yellow-600 rounded-md duration-300 max-sm:bg-yellow-600 borgens">
  {#if type == "button"}
  <button type="button" 
          class="w-full flex justify-center"
          onclick={() => { click = !click }}>
    {#if notification || count}
      <div class="w-6 h-6 rounded-full">
        {#if notification}
          {notification}
        {:else}
          {count}
        {/if}
      </div>
    {/if}
    <div>
      {text}
    </div>
  </button>
  {:else}
  <a {href}>
    <div class="w-full select-none">
      {text}
    </div>
  </a>
  {/if}
</li>