<svelte:head>
    <title>Hub - Betropolis</title>
    <meta name="description" content="Game Hub of the Casino." />
</svelte:head>

<script lang="ts">
  import HubNavButton from "$lib/components/HubNavButton.svelte";
  import HubNavLi from "$lib/components/HubNavLi.svelte";
  import SignOutModal from "$lib/components/SignOutModal.svelte";
  import chip from "$lib/media/images/chip.png";

  import user from "$lib/media/images/hub/user.png";
  import group from "$lib/media/images/hub/group.png";
  import add from "$lib/media/images/hub/add.png";
  let profile:boolean = $state(false),
      friends:boolean = $state(false),
      profileClicked  = $state(false),
      addFundsClicked = $state(false),
      friendsClicked  = $state(false),
      signOutClicked  = $state(false)

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

<!-- Temp stuff -->
<div class="text-white">
    <p>temporary hyperlinks</p>
    <a href="/fruit-frenzy-classic">Fruit Frenzy</a>
    <a href="/findcard">Findcard</a>
    <a href="/crashgame">crash</a>
    <a href="/">home</a>
</div>



<div class="bottom-14 absolute w-full [&_li]:text-center [&_li]:m-2 font-bold sm:text-xl [&_li]:onhover:">
  <div class:hidden={!friends} 
       class="w-1/3 text-white border-4 border-yellow-600 bg-black rounded-tr-xl h-fit float-start">
    <ul>
      <li>
        Friends
      </li>
      <li>
        Friend requests
      </li>
      <li>
        Add friend
      </li>
    </ul>
  </div>
  <div class:hidden={!profile}
       class="w-1/3 text-white border-4 border-yellow-600 bg-black rounded-tl-xl float-right">
    <div>
      <span>User: </span>
      <span> <img src={chip} alt="chips"></span>
    </div>
    <ul>
      <li>
        Statistics
      </li>
      
      <HubNavLi text="Profile" type="link" href="/profile"/>
      <HubNavLi text="Sign out" bind:click={signOutClicked}/>
      <HubNavLi text="Terms & Conditions" type="link" href="/terms&conditions"/>
      <HubNavLi text="Privacy Policy" type="link" href="/privacy-policy"/>
    </ul>
  </div>
</div>

<nav class="flex bg-black bottom-0 w-full text-white fixed text-center border-t border-yellow-600 font-bold [&>*:nth-child(even)]:border-x [&>*:nth-child(even)]:border-yellow-600">
  <HubNavButton text="Friends" img={group} alt="Friends icon" bind:click={friendsClicked}/>
  <HubNavButton text="Add funds" img={add} alt="Add icon" bind:click={addFundsClicked}/>
  <HubNavButton text="Profile" img={user} alt="User icon" bind:click={profileClicked}/>
</nav>

<SignOutModal bind:clicked={signOutClicked} show={signOutClicked}/>