<script lang="ts">
  import { _ } from "svelte-i18n";
  import AddFriendModal from "../friends/AddFriendModal.svelte";
  import FriendRequestsModal from "../friends/FriendRequestsModal.svelte";
  import FriendsModal from "../friends/FriendsModal.svelte";
  import HubNavLi from "./HubNavLi.svelte";
  import type { Modal } from "$lib/interfaces";

  let { 
        show = $bindable(), 
        notification = $bindable()
      }: Modal = $props();
  let addFriendClicked: boolean     = $state(false),
      friendRequestClicked: boolean = $state(false),
      friendsButtonClicked: boolean = $state(false);
</script>

<!-- Menu -->
<div class:hidden={!show} 
     class="w-1/2 sm:w-1/3 border-4 bg-black border-yellow-600 rounded-tr-xl h-fit float-start">
  <ul>
    <!-- Friends -->
    <HubNavLi text={$_("friends.title")} 
              bind:show={friendsButtonClicked} />
    
    <!-- Friend requests -->
    <HubNavLi text={$_("friends.requests")}
              bind:show={friendRequestClicked} 
              {notification}/>

    <!-- Add friend -->
    <HubNavLi text={$_("friends.add")} 
              bind:show={addFriendClicked}/>
  </ul>
</div>

<!-- Modals -->
<FriendsModal bind:show={friendsButtonClicked}/>
<FriendRequestsModal bind:show={friendRequestClicked} bind:notification={notification}/>
<AddFriendModal bind:show={addFriendClicked}/>