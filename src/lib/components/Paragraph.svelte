<script lang="ts">
  import { _ } from "svelte-i18n";
  import type { Paragraph } from "$lib/interfaces";
  
  let { param, index }: Paragraph = $props();
</script>

<div>
  <h2>{index}. {$_(`page.${param}.titles.${index}`)}</h2>
  <p>{$_(`page.${param}.paragraphs.${index}`)}</p>
</div>

<style>
  @reference "../app.css";
  
  h2 { 
    @apply border-b italic text-3xl mt-5;  
    font-family: "Borgens Burlesque"; 
  }

  p { @apply text-justify mb-3 mt-1 text-xl; }
</style>