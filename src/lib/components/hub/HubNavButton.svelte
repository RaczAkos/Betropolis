<script>
  let { click = $bindable(), img, alt, text, notification = null} = $props();
</script>

<button class="basis-1/3 p-3 flex justify-center items-center gap-1 hover:bg-yellow-600 duration-300 text-2xl"
        onclick={() => { click = !click }}>
    {#if notification}
      <span class="bg-red-600 w-8 h-8 rounded-full font-bold notif pr-[1px]">
        {notification}
      </span>
    {/if}
    <img src={img} 
         {alt} 
         class="h-8">
    <span class="max-sm:hidden borgens">
      {text}
    </span>
</button>
<style>
  .notif{
    line-height: 120%;
  }
</style>