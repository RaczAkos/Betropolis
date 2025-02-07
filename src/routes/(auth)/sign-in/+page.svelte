<svelte:head>
    <title>Sign In - Betropolis</title>
    <meta name="description" content="Welcome to Betropolis — your ultimate online destination for thrilling casino games and endless entertainment! Step into a world where the excitement never stops, and every spin, card flip, and roll of the dice brings you closer to unforgettable winnings. At Betropolis, we combine top-tier games, cutting-edge security, and seamless gameplay to create a premium online casino experience." />
</svelte:head>

<script lang="ts">
  import Input from "$lib/components/Input.svelte";

  let type:string = $state("password"),
      disabling:boolean = $state(false),
      error:string = $state(""),
      user = $state({
        id: "",
        password: ""
      });
  
  async function signIn() {
    disabling = true;
    let res = await fetch('/api/sign-in', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(user)
    })
    .then(res => res.json());
    error = res["message"];
    disabling = false;
  }
</script>

  
<!-- Username / E-mail -->
<div class="my-4">
  <Input bind:value={user.id} 
         disabled={disabling} 
         id="identifier"
         label="Username or e-mail address"/>
</div>
<div class="mb-2">
  <Input bind:value={user.password} 
         disabled={disabling} 
         id="password" 
         {type} 
         label="Password"/>
  
  <!-- Show password -->
  <div class="flex justify-center">
    <label class="text-sm font-bold mb-2 text-yellow-600 cursor-pointer block">
      <input type="checkbox" 
      class="accent-yellow-600" 
      onchange={() => { 
        if (type == "password") type = "text";
        else type = "password";
      }}>
       Show password
    </label>
  </div>
  
  <!-- Reset password -->
  <div class="flex justify-center">
    <a class="text-center align-baseline font-bold text-sm text-yellow-600 hover:underline italic" href="/reset-password">
      Forgot Password?
    </a>
  </div>
</div>

<!-- Sign in -->
<div class="flex justify-center items-center mb-1">
  <button class="disabled:opacity-35 hover:animate-pulse disabled:hover:animate-none disabled:hover:bg-yellow-600 bg-yellow-600 hover:bg-black border-yellow-600 border-2 hover:border-opacity-100 text-black hover:text-yellow-600 disabled:hover:text-black font-bold py-2 px-3 rounded focus:outline-none focus:shadow-outline duration-300" 
          type="button" 
          onclick={() => signIn()} disabled={(user.password.length < 8 || user.id.length < 4) || disabling}>
    Sign In
  </button>
</div>

<!-- Go to Sign Up -->
<div class="flex justify-center">
  <a class="hover:underline text-yellow-600 italic" href="/sign-up">Don't have an account?</a>
</div>
{#if error != ""}
  <div class="bg-red-600 text-white text-center mt-2 rounded-md p-1">
    {error}
  </div>
{/if}