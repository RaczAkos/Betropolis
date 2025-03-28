<script>
  import logo from "$lib/media/images/logo.png";
  import { _ } from "svelte-i18n";
  let { logged, home } = $props();
  let links = [ "terms&conditions", "privacy-policy" ];
</script>

<footer>
  <div class="sm:flex sm:items-center sm:justify-between md:ps-9">
    <a href="/" class="flex items-center max-lg:flex-col mb-0 space-x-3 rtl:space-x-reverse">
      <img src={logo} class="h-24" alt="Casino logo"/>
    </a>
    <ul class="">
      {#if !logged}
        <li>
          <a href="/sign-in">
            {$_("page.sign-in.title")}
          </a>
        </li>
      {/if}
      {#if !home}
        <li>
          <a href="/">
            {$_("backToHome")}
          </a>
        </li>
      {/if}
      {#each links as link}
        <li>
          <a href={"/"+link}>
            {$_(`page.${link}.title`)}
          </a>
        </li>
      {/each}
    </ul>
  </div>
  <hr class="sm:mx-auto border-yellow-600 my-2"/>
  <span class="block text-md text-center">{$_("copyright")}</span>
</footer>

<style>
  @reference "$lib/app.css";

  footer { 
    @apply bg-transparent select-none w-full mx-auto md:py-2 pt-3 px-3 text-yellow-600;
    font-family: "Borgens Burlesque";
  }

  ul { @apply flex flex-wrap max-lg:flex-col items-center max-lg:text-xl text-2xl font-medium max-sm:mt-3; }

  a { @apply hover:underline sm:me-6 max-sm:underline }
</style>