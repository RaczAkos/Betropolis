<script lang="ts">
  import { _ } from "svelte-i18n";
  import { page } from "$app/state";
  import type { Navbar } from "$lib/interfaces";
  
  let { logged, home }: Navbar = $props(), 
      links: string[] = [ "terms&conditions", "privacy-policy" ];
</script>

<footer>
  <div class="sm:flex sm:items-center sm:justify-between md:ps-9">
    <div class="flex items-center max-lg:flex-col mb-0 space-x-3 rtl:space-x-reverse">
      <img src="/src/lib/media/images/logo.png" 
           class="h-24" 
           alt="Casino logo"/>
    </div>
    <ul>
      <li>
        <a href="/sign-in">
          {$_(`page.${logged ? "hub" : "sign-in"}.title`)}
        </a>
      </li>
      {#if !home}
        <li>
          <a href="/">
            {$_("backToHome")}
          </a>
        </li>
      {/if}
      {#each links as link}
        {#if page.params.doc !== link}
          <li>
            <a href={"/"+link}>
              {$_(`page.${link}.title`)}
            </a>
          </li>
        {/if}
      {/each}
    </ul>
  </div>
  <hr class="sm:mx-auto border-yellow-600 my-2"/>
  <span class="block text-md text-center">
    {$_("copyright")}
  </span>
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