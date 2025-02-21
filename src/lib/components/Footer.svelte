<script>
  import logo from "$lib/media/images/logo.png";
    import { text } from "@sveltejs/kit";
  let { logged } = $props();
  let links = [
    { text: "About", href: "/about" },
    { text: "Terms & Conditions", href: "/terms&conditions" },
    { text: "Privacy Policy", href: "/privacy-policy" },
  ];
</script>

<footer class="bg-transparent select-none borgens">
  <div class="w-full mx-auto md:py-4 p-3 text-yellow-600">
    <div class="sm:flex sm:items-center sm:justify-between md:ps-9">
      <a href="/" class="flex items-center max-md:flex-col mb-0 space-x-3 rtl:space-x-reverse">
        <img src={logo} class="max-md:h-32 h-24" alt="Casino logo" />
      </a>
      <ul class="flex flex-wrap max-md:flex-col items-center max-lg:text-xl text-2xl font-medium mt-5">
        {#if !logged}
          <li>
            <a href="/sign-in" class="hover:underline sm:me-6">Sign in</a>
          </li>
        {/if}
        {#each links as item}
          <li>
            <a href={item.href} class="hover:underline sm:me-6">{item.text}</a>
          </li>
        {/each}
      </ul>
    </div>
    <hr class="sm:mx-auto border-yellow-600 my-4"/>
    <span class="block text-md text-center">© 2025 - Tamás Szabó, Rácz Ákos Csaba - All Rights Reserved.</span>
  </div>
</footer>