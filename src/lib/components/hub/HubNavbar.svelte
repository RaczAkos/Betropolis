<script lang="ts">
  import HubNavButton from "$lib/components/hub/HubNavButton.svelte";
  import HubNavLi from "$lib/components/hub/HubNavLi.svelte";
  import SignOutModal from "$lib/components/SignOutModal.svelte";
  import AddFriendModal from "$lib/components/hub/AddFriendModal.svelte";
  import chip from "$lib/media/images/chip.png";
  import user from "$lib/media/images/hub/user.png";
  import group from "$lib/media/images/hub/group.png";
  import add from "$lib/media/images/hub/add.png";
    import HubFriendsMenu from "./HubFriendsMenu.svelte";
    import HubProfileMenu from "./HubProfileMenu.svelte";

  let { data } = $props(),
      profile:boolean = $state(false),
      friends:boolean = $state(false),
      profileClicked:boolean  = $state(false),
      addFundsClicked:boolean = $state(false),
      friendsClicked:boolean  = $state(false)
      

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

<nav class=" bg-black bottom-0 w-full text-white fixed text-center border-t border-yellow-600">
  <div class="bottom-14 absolute w-full [&_li]:text-center [&_li]:m-2 sm:text-xl">
    <HubFriendsMenu show={friends}/>
    <HubProfileMenu show={profile} {data} />
  </div>

  <div class="flex [&>*:nth-child(even)]:border-x [&>*:nth-child(even)]:border-yellow-600 borgens">
    <HubNavButton text="Friends" img={group} alt="Friends icon" bind:click={friendsClicked}/>
    <HubNavButton text="Manage funds" img={add} alt="Add icon" bind:click={addFundsClicked}/>
    <HubNavButton text="Profile" img={user} alt="User icon" bind:click={profileClicked}/>
  </div>
</nav>
