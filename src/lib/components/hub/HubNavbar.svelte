<script lang="ts">
  import { _ } from "svelte-i18n";
  import HubNavButton from "./HubNavButton.svelte";
  import HubFriendsMenu from "./HubFriendsMenu.svelte";
  import HubProfileMenu from "./HubProfileMenu.svelte";
  import type { userData } from "$lib/interfaces";

  let { data }: { data: userData } = $props(),
      profile: boolean = $state(false),
      friends: boolean = $state(false),
      notification: number = $state(0),
      profileClicked: boolean  = $state(false),
      addFundsClicked: boolean = $state(false),
      friendsClicked: boolean  = $state(false);

  // Opening menus
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

<nav class="bg-black bottom-0 w-full text-white fixed text-center border-t border-yellow-600">
  <div class="bottom-14 absolute w-full [&_li]:text-center [&_li]:m-2 sm:text-xl">
    <HubFriendsMenu show={friends} 
                    bind:notification={notification}/>
    <HubProfileMenu show={profile} 
                    user={data}/>
  </div>

  <div class="flex [&>*:nth-child(even)]:border-x [&>*:nth-child(even)]:border-yellow-600">
    <HubNavButton text={$_("friends.title")} 
                  img="/src/lib/media/images/hub/group.png" 
                  alt="Friends icon" 
                  {notification} 
                  bind:click={friendsClicked}/>
    <HubNavButton text={$_("funds.title")} 
                  img="/src/lib/media/images/hub/add.png" 
                  alt="Add icon" 
                  bind:click={addFundsClicked}/>
    <HubNavButton text={$_("page.profile.title")} 
                  img="/src/lib/media/images/hub/user.png" 
                  alt="User icon" 
                  bind:click={profileClicked}/>
  </div>
</nav>
