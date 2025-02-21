<script>
  let { click = $bindable(), img, alt, text} = $props();
</script>

<button class="basis-1/3 p-3 flex justify-center items-center hover:bg-gray-600/70 duration-300"
          onclick={() => { click = !click }}>
    <img src={img} {alt} class="h-8 me-1">
    {text}
</button>