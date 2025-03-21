
<script lang="ts">
  import chip from "$lib/media/images/chip.png"
  import SignOutModal from "../SignOutModal.svelte";
  import HubNavLi from "./HubNavLi.svelte";

  let { show = $bindable(), data = {} } = $props(),
      signOutClicked:boolean  = $state(false),
      links = [
        {text: "Statistics", href: "/statistics"},
        {text: "Profile", href: "/profile"},
        {text: "Terms & Conditions", href: "/terms&conditions"},
        {text: "Privacy Policy", href: "/privacy-policy"},
      ];
</script>

<div class:hidden={!show}
     class="w-1/2 sm:w-1/3 border-4 bg-black border-yellow-600 rounded-tl-xl float-right">

  <div class="p-2 flex max-lg:flex-col max-lg:text-center border-yellow-600 place-content-between border-b-4">
    <div class="borgens">
      Profile: 
      <span class="italic text-yellow-600">
        {data.user[0].username}
      </span>
    </div>
    <div class="flex flex-row justify-center">
      <div class="flex place-items-center">
        <div class="text-lg me-1 font-extrabold">
          {data.user[0].balance}
        </div>
        <img src={chip} 
             alt="chips" 
             class="h-6">
      </div>
    </div>
  </div>

  <ul>
    {#each links as link}
      <HubNavLi text={link.text} 
                type="link" 
                href={link.href}/>
    {/each}
    <HubNavLi text="Sign Out" 
              bind:click={signOutClicked}/>
  </ul>
</div>

<SignOutModal bind:clicked={signOutClicked}/>