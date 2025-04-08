<script lang="ts">
  import { _ } from "svelte-i18n";
  import { page } from "$app/state";
	let { children, data } = $props(),
      links: Array<{text: string, href: string}> = $state([
        { text: "home", href: "/" },
        { text: "page.hub.title", href: "/hub" },
      ]);

  $effect(() => {
    if (!page.params.friend && page.route.id !== "/profile/settings") links[2] = { text: "page.settings.title", href: "/profile/settings" };
    else links[2] = { text: "page.profile.my", href: "/profile" };
  })
</script>

<div class="h-screen p-4">
  <div class="border-2 h-full border-yellow-600/30 bg-[#040d17] rounded-lg shadow-2xl shadow-[#040d17]">
    <div class="p-4 flex flex-col items-start h-full xl:overflow-visible overflow-y-auto">
      <div class="text-yellow-600 flex flex-col sm:flex-row justify-between w-full">
        <div class="flex items-center max-sm:justify-center">
          <img src="/src/lib/media/images/hub/user.png" 
               class="w-5 h-auto" 
               alt="user">
          <p class="ms-2 relative top-[1px]">
            {$_(`page.profile.title`)}:
            <span class="text-white">
              {#if page.params.friend}
                {page.params.friend}
              {:else}
                {data.data}
              {/if}
            </span>
          </p>
        </div>
        <div class="flex max-sm:justify-between max-sm:mt-2 sm:gap-5">
          {#each links as link}
          <a href={link.href} 
             class="border-2 rounded p-1 border-yellow-600 hover:scale-110 duration-300">
              {$_(link.text)}
            </a>
          {/each}
        </div>
      </div>
      {@render children()}                             
    </div>
  </div>
</div>
