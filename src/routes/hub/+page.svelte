<svelte:head>
    <title>Hub - Betropolis</title>
    <meta name="description" content="Game Hub of the Casino." />
</svelte:head>

<script lang="ts">
  import HubNavButton from "$lib/components/HubNavButton.svelte";
  import HubNavLi from "$lib/components/HubNavLi.svelte";

  import user from "$lib/media/images/hub/user.png";
  import group from "$lib/media/images/hub/group.png";
  import add from "$lib/media/images/hub/add.png";
  let profile:boolean = $state(false),
      friends:boolean = $state(false),
      profileClicked = $state(false),
      addFundsClicked = $state(false),
      friendsClicked = $state(false),
      signOutTrigger = $state(false),
      signOutAllTrigger = $state(false);

  function signOut() {
    fetch("/api/sign-out").then(() => window.location.reload());
  }

  function signOutAll() {
    fetch("/api/sign-out-all").then(() => window.location.reload());
  }

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



<div class="bottom-14 absolute w-full [&_li]:text-center [&_li]:m-2 font-bold text-xl [&_li]:onhover:">
  <div class:hidden={!friends} 
       class="w-1/3 text-white border-4 border-gray-600/70 bg-black rounded-xl h-fit float-start">
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
       class="w-1/3 text-white border-4 border-gray-600/70 bg-black rounded-xl float-right">
    <ul>
      <li>
        Statistics
      </li>
      <li>
        Profile
      </li>
      <li>
        Statistics
      </li>
      <li>
        <button onclick={signOut}>
          Sign out
        </button>
      </li>
      <li>
        <button onclick={signOutAll}>
          Sign out everywhere
        </button>
      </li>
      <HubNavLi text="Sign out everywhere"/>
    </ul>
  </div>
</div>

<!-- Hub navbar -->
<nav class="flex bg-black bottom-0 w-full text-white fixed text-center border-t border-gray-600/70 font-bold [&>*:nth-child(even)]:border-x [&>*:nth-child(even)]:border-gray-600/70">
  <HubNavButton text="Friends" img={group} alt="Friends icon" bind:click={friendsClicked}/>
  <HubNavButton text="Add funds" img={add} alt="Add icon" bind:click={addFundsClicked}/>
  <HubNavButton text="Profile" img={user} alt="User icon" bind:click={profileClicked}/>
</nav>