
<script lang="ts">
  import { _ } from "svelte-i18n";
  import chip from "$lib/media/images/chip.png";
  import SignOutModal from "../SignOutModal.svelte";
  import HubNavLi from "./HubNavLi.svelte";
  import type { Modal } from "$lib/interfaces";

  let { 
        show = $bindable(), 
        user = {
          balance: 0, 
          username: "error"
        } 
      }: Modal = $props(),
      signOutClicked: boolean  = $state(false),
      links: string[] = [ "profile", "terms&conditions", "privacy-policy" ];
</script>

<div class:hidden={!show}
     class="w-1/2 sm:w-1/3 border-4 bg-black border-yellow-600 rounded-tl-xl float-right">

  <div class="p-2 flex max-lg:flex-col max-lg:text-center border-yellow-600 place-content-between border-b-4">
    <div class="borgens">
      {$_("page.profile.title")}: 
      <span class="italic text-yellow-600">
        {user.username}
      </span>
    </div>
    <div class="flex flex-row justify-center">
      <div class="flex place-items-center">
        <div class="text-lg me-1 font-extrabold">
          {user.balance}
        </div>
        <img src={chip} 
             alt="chips" 
             class="h-6">
      </div>
    </div>
  </div>

  <ul>
    {#each links as link}
      <HubNavLi text={$_(`page.${link}.title`)} 
                type="link" 
                href={"/"+link}/>
    {/each}
    <HubNavLi text={$_("sign-out")} 
              bind:show={signOutClicked}/>
  </ul>
</div>

<SignOutModal bind:show={signOutClicked}/>