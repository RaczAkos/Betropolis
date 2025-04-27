<script lang="ts">
  import type { HubNavButton } from "$lib/interfaces";
  let { 
        click = $bindable(), 
        img, 
        alt, 
        text, 
        notification = null
      }: HubNavButton = $props();
</script>

<!-- Button for Hub navbar -->
<button class="basis-1/3 p-3 flex justify-center items-center gap-1 hover:bg-yellow-600 duration-300 text-2xl"
        onclick={() => { click = !click }}>
    
    <!-- Notification (for friends) -->
    {#if notification}
      <span class="bg-red-600 leading-[120%] w-8 h-8 rounded-full font-bold pr-[1px]">
        {notification}
      </span>
    {/if}

    <!-- Image and text -->
    <img src={img} 
         {alt} 
         class="h-8">
    <span class="max-sm:hidden borgens">
      {text}
    </span>
</button>