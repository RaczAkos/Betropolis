<script lang="ts">
  import { _ } from "svelte-i18n";
  let { text }: { text: string } = $props();
</script>

<!-- Description (for fruit frenzy) -->
<p class="text-justify text-xl sm:text-2xl leading-6 my-2">
  {$_(text)}
</p>

<style>
  ::selection {
    background-color: white;
    color: rgb(127, 29, 29);
  }
</style>