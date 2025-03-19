
<script lang=ts>
  import AddFriendModal from "./AddFriendModal.svelte";
  import FriendRequestsModal from "./FriendRequestsModal.svelte";
  import HubNavLi from "./HubNavLi.svelte";

  let { show = $bindable() } = $props(),
      addFriendClicked:boolean= $state(false),
      friendRequestClicked:boolean = $state(false),
      friendsButtonClicked:boolean = $state(false);
  
</script>

<div class:hidden={!show} 
     class="w-1/2 sm:w-1/3 border-4 bg-black border-yellow-600 rounded-tr-xl h-fit float-start">
  <ul>
    <HubNavLi text="Friends" bind:click={friendsButtonClicked}/>
    <HubNavLi text="Friend Requests" bind:click={friendRequestClicked}/>
    <HubNavLi text="Add Friend" bind:click={addFriendClicked}/>
  </ul>
</div>

<AddFriendModal bind:show={addFriendClicked}/>
<FriendRequestsModal bind:show={friendRequestClicked}/>