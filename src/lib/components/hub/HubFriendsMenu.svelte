<script lang="ts">
  import { _ } from "svelte-i18n";
  import AddFriendModal from "../friends/AddFriendModal.svelte";
  import FriendRequestsModal from "../friends/FriendRequestsModal.svelte";
  import FriendsModal from "../friends/FriendsModal.svelte";
  import HubNavLi from "./HubNavLi.svelte";

  let { show = $bindable(), requests } = $props(),
      addFriendClicked:boolean= $state(false),
      friendRequestClicked:boolean = $state(false),
      friendsButtonClicked:boolean = $state(false);
</script>

<!-- Menu -->
<div class:hidden={!show} 
     class="w-1/2 sm:w-1/3 border-4 bg-black border-yellow-600 rounded-tr-xl h-fit float-start">
  <ul>
    <HubNavLi text={$_("friends.title")} 
              bind:click={friendsButtonClicked} />
    <HubNavLi text={$_("friends.requests")}
              bind:click={friendRequestClicked} 
              notification={requests[0].notification}/>
    <HubNavLi text={$_("friends.add")} 
              bind:click={addFriendClicked}/>
  </ul>
</div>

<!-- Modals -->
<FriendsModal bind:show={friendsButtonClicked}/>
<FriendRequestsModal bind:show={friendRequestClicked}/>
<AddFriendModal bind:show={addFriendClicked}/>