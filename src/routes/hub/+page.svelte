<svelte:head>
    <title>Hub - Betropolis</title>
    <meta name="description" content="Game Hub of the Casino." />
</svelte:head>

<script lang="ts">
  let profile:boolean = $state(false),
      friends:boolean = $state(false)

  function signOut() {
    fetch("/api/sign-out").then(() => window.location.reload());
  }

  function signOutAll() {
    fetch("/api/sign-out-all").then(() => window.location.reload());
  }
</script>

<!-- Temp stuff -->
<div class="text-white">
    <p>temporary hyperlinks</p>
    <a href="/fruit-frenzy-classic">Fruit Frenzy</a>
    <a href="/findcard">Findcard</a>
    <a href="/crashgame">crash</a>
    <a href="/">home</a>
</div>



<div class="bottom-12 absolute w-full [&_li]:text-center [&_li]:m-2]">
  <div class:hidden={!friends} class="w-1/3 text-white border bg-slate-400 h-fit float-start">
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
  <div class:hidden={!profile} class="w-1/3 text-white border bg-slate-400 float-right">
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
      <li class="">
        <button onclick={signOut}>
          Sign out
        </button>
      </li>
      <li>
        <button onclick={signOutAll}>
          Sign out everywhere
        </button>
      </li>
    </ul>
  </div>
</div>

<!-- Hub navbar -->
<nav class="flex bg-black bottom-0 w-full text-white fixed text-center border-t border-gray-600 border-opacity-70">
  <button class="basis-1/3 p-3"
          onclick={() => {friends = !friends; profile = false}}>
    Friends
  </button>
  <button class="basis-1/3 p-3 border-x border-gray-600 border-opacity-70">
    Add funds
  </button>
  <button class="basis-1/3 p-3"
          onclick={() => {profile = !profile; friends = false}}>
    Profile
  </button>
</nav>