<script>
  let { text, click = $bindable() } = $props();
</script>

<li class="text-center hover:bg-slate-600 rounded-md duration-300">
  <button type="button" 
          class="w-full"
          onclick={() => { click = !click }}>
    {text}
  </button>
</li>