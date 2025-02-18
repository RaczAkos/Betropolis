<svelte:head>
    <title>Hub - Betropolis</title>
    <meta name="description" content="Game Hub of the Casino." />
</svelte:head>

<script lang="ts">
  // Sign out
  function signOut() {
    fetch("/api/sign-out").then(() => window.location.reload());
  }

  // Sign out everywhere
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



<div class="bottom-12 absolute flex w-full items-end">
  <div class:invisible={false} class="basis-1/3 text-white border bg-slate-400 h-fit">
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
  <div class="basis-1/3 invisible"></div>
  <div class:invisible={false} class="basis-1/3 text-white border bg-slate-400 text-center">
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
  <button class="basis-1/3 p-3">
    Friends
  </button>
  <button class="basis-1/3 p-3 border-x border-gray-600 border-opacity-70">
    Add funds
  </button>
  <button class="basis-1/3 p-3">
    Profile
  </button>
</nav>