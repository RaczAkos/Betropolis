
<script lang=ts>

  import AddFriendModal from "./AddFriendModal.svelte";
  import FriendRequestsModal from "./FriendRequestsModal.svelte";
  import FriendsModal from "./FriendsModal.svelte";
  import HubNavLi from "./HubNavLi.svelte";

  let { show = $bindable(), requests = [], friends = [] } = $props(),
      addFriendClicked:boolean= $state(false),
      friendRequestClicked:boolean = $state(false),
      friendsButtonClicked:boolean = $state(false);
  
</script>

<!-- Menu -->
<div class:hidden={!show} 
     class="w-1/2 sm:w-1/3 border-4 bg-black border-yellow-600 rounded-tr-xl h-fit float-start">
  <ul>
    <HubNavLi text="Friends" 
              bind:click={friendsButtonClicked} />
    <HubNavLi text="Friend Requests" 
              bind:click={friendRequestClicked} 
              notification={requests[0].length}/>
    <HubNavLi text="Add Friend" 
              bind:click={addFriendClicked}/>
  </ul>
</div>

<!-- Modals -->
<FriendsModal bind:show={friendsButtonClicked}
              friendData={friends}/>
<FriendRequestsModal bind:show={friendRequestClicked} 
                     requestsData={requests}/>
<AddFriendModal bind:show={addFriendClicked}/>