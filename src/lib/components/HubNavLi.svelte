<script>
  let { text, type = "button", href = "", click = $bindable() } = $props();
</script>

<li class="m-2 text-center">
  {#if type == "button"}
    <button type="button" 
            onclick={() => { click = !click }}>
      {text}
    </button>
  {:else}
    <a {href}>
      {text}
    </a>
  {/if}
</li>