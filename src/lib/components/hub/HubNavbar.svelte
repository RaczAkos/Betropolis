<script lang="ts">
  import HubNavButton from "$lib/components/hub/HubNavButton.svelte";
  import HubNavLi from "$lib/components/hub/HubNavLi.svelte";
  import SignOutModal from "$lib/components/SignOutModal.svelte";
  import AddFriendModal from "$lib/components/hub/AddFriendModal.svelte";
  import chip from "$lib/media/images/chip.png";
  import user from "$lib/media/images/hub/user.png";
  import group from "$lib/media/images/hub/group.png";
  import add from "$lib/media/images/hub/add.png";

  let { data } = $props(),
      profile:boolean = $state(false),
      friends:boolean = $state(false),
      profileClicked:boolean  = $state(false),
      addFundsClicked:boolean = $state(false),
      signOutClicked:boolean  = $state(false),
      friendsClicked:boolean  = $state(false),
      addFriendClicked:boolean= $state(false),
      friendRequestClicked:boolean = $state(false),
      friendsButtonClicked:boolean = $state(false),
      links = [
        {text: "Statistics", href: "/statistics"},
        {text: "Profile", href: "/profile"},
        {text: "Terms & Conditions", href: "/terms&conditions"},
        {text: "Privacy Policy", href: "/privacy-policy"},
      ];

  $effect(() => {
    if (profileClicked) {
      profile = !profile;
      friends = false;
      profileClicked = false;
    }
    if (friendsClicked) {
      friends = !friends;
      profile = false;
      friendsClicked = false;
    }
  })
</script>

<div class="bottom-14 absolute w-full [&_li]:text-center text-white [&_li]:m-2 sm:text-xl">
  
  <!-- Friends menu -->
  <div class:hidden={!friends} 
       class="w-1/3  border-4 bg-black border-yellow-600 rounded-tr-xl h-fit float-start">
    <ul>
      <HubNavLi text="Friends" bind:click={friendsButtonClicked}/>
      <HubNavLi text="Friend Requests" bind:click={friendRequestClicked}/>
      <HubNavLi text="Add Friend" bind:click={addFriendClicked}/>
    </ul>
  </div>

  <!-- Profile menu -->
  <div class:hidden={!profile}
       class="w-1/3 border-4 bg-black border-yellow-600 rounded-tl-xl float-right">
    <div class="p-2 flex max-lg:flex-col max-lg:text-center border-yellow-600 place-content-between border-b-4 font-bold">
      <div>
        Profile: 
        <span class="italic font-bold text-yellow-600">
          {data.user[0].username}
        </span>
      </div>
      <div class="flex flex-row justify-center">
        <div class="flex place-items-center">
          <div class="text-lg me-1">
            {data.user[0].balance}
          </div>
          <img src={chip} alt="chips" class="h-6">
        </div>
      </div>
    </div>
    <ul>
      {#each links as link}
      <HubNavLi text={link.text} type="link" href={link.href}/>
      {/each}
      <HubNavLi text="Sign Out" bind:click={signOutClicked}/>
    </ul>
  </div>
</div>

<nav class="borgens flex bg-black bottom-0 w-full text-white fixed text-center border-t border-yellow-600 [&>*:nth-child(even)]:border-x [&>*:nth-child(even)]:border-yellow-600">
  <HubNavButton text="Friends" img={group} alt="Friends icon" bind:click={friendsClicked}/>
  <HubNavButton text="Manage funds" img={add} alt="Add icon" bind:click={addFundsClicked}/>
  <HubNavButton text="Profile" img={user} alt="User icon" bind:click={profileClicked}/>
</nav>

<AddFriendModal bind:show={addFriendClicked}/>
<SignOutModal bind:clicked={signOutClicked}/>