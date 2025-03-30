<svelte:head>
    <title>{$_(`page.${page.params.doc}.title`)} - Betropolis</title>
    <meta name="description" content="The {$_(`page.${page.params.doc}.title`)} of Betropolis Casino." />
</svelte:head>

<script lang="ts">
  import { _ } from "svelte-i18n";
  import { page } from "$app/state";
  import Paragraph from "$lib/components/Paragraph.svelte";
</script>

<main class="flex justify-center select-text w-full text-wrap">
  <div class="border m-1 text-white md:w-3/4 lg:w-1/2 mt-5 px-5 pb-4">
    <div>
      <h1 class="text-5xl p-3 border-b text-center mb-2">
        {$_(`page.${page.params.doc}.title`)}
      </h1>

      <h2>
        {$_("authTitle")}
      </h2>

      <h3 class="text-xl text-justify">
        {$_(`page.${page.params.doc}.intro`)}
      </h3>

      <!-- Content -->
      {#each Array(7) as _, i}
        <Paragraph param={page.params.doc} index={i+1}/>
      {/each}
    </div>

    <h2>{$_("contact.information")}</h2>
    <p>{$_("contact.dev1")}: szabo.tamas-2020@keri.mako.hu</p>
    <p>{$_("contact.dev2")}: racz.akoscsaba-2020@keri.mako.hu</p>
  </div>
</main>

<style>
  @reference "$lib/app.css";

  h2{ @apply border-b italic text-2xl mt-5; }

  h1, h2, h3 { font-family: "Borgens Burlesque"; }
</style>