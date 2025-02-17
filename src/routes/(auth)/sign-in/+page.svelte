<svelte:head>
    <title>Sign In - Betropolis</title>
    <meta name="description" content="Welcome to Betropolis — your ultimate online destination for thrilling casino games and endless entertainment! Step into a world where the excitement never stops, and every spin, card flip, and roll of the dice brings you closer to unforgettable winnings. At Betropolis, we combine top-tier games, cutting-edge security, and seamless gameplay to create a premium online casino experience." />
</svelte:head>

<script lang="ts">
  import Input from "$lib/components/Input.svelte";
  import type { PageProps } from "./$types";
  import { enhance } from '$app/forms';

  let { form }:PageProps = $props();

  interface Login {
    id:string,
    password:string
  }

  let type:string = $state("password"),
      disabling:boolean = $state(false),
      error:string = $state("error"),
      user:Login = $state({
        id: "johndoe",
        password: "password123"
      });
</script>

<form method="POST" use:enhance={() => { return async ({ update }) => {update({ reset: false });};}}>

  <!-- Username / E-mail -->
  <div class="my-3">
    <Input bind:value={user.id} 
           disabled={disabling} 
           name="id"
           id="identifier"
           required={true}
           label="Username or e-mail address"/>
  </div>

  <!-- Password -->
  <div class="mb-2">
    <Input bind:value={user.password} 
           disabled={disabling} 
           id="password" 
           name="password"
           {type} 
           required={true}
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
      <a class="text-center align-baseline font-bold text-sm text-yellow-600 hover:underline italic" 
         href="/reset-password">
        Forgot Password?
      </a>
    </div>
  </div>

  <!-- Sign in -->
  <div class="flex justify-center items-center mb-1">
    <button class="disabled:opacity-35 disabled:hover:bg-yellow-600 bg-yellow-600 hover:bg-black border-yellow-600 border-2 hover:border-opacity-100 text-black hover:text-yellow-600 disabled:hover:text-black font-bold py-2 px-3 rounded focus:outline-none focus:shadow-outline duration-300" 
    disabled={(user.password.length < 8 || user.id.length < 4) || disabling}>
      Sign In
    </button>
  </div>

  <!-- Go to Sign Up -->
  <div class="flex justify-center">
    <a class="hover:underline text-yellow-600 italic" href="/sign-up">Don't have an account?</a>
  </div>

  <!-- Display error/feedback -->
  <div class="bg-red-600 text-white text-center mt-2 rounded-md p-1"
       class:invisible={!form?.error}>
    {#if form?.error}
      {form.error}
    {:else}
      hidden
    {/if}
  </div>
</form>