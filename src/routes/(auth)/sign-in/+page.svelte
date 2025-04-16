<svelte:head>
    <title>{$_("page.sign-in.title")} - Betropolis</title>
    <meta name="description" content={$_("page.home.description")} />
</svelte:head>

<script lang="ts">
  import { _ } from "svelte-i18n";
  import Input from "$lib/components/Input.svelte";
  import type { PageProps } from "./$types";
  import { enhance } from '$app/forms';
    import { goto } from "$app/navigation";

  interface SignIn {
    id:string,
    password:string
  }
  
  let type: string  = $state("password"),
      user: SignIn  = $state({
        id: "",
        password: ""
      }),
      error: string = $state("");

  function signIn() {
    fetch("/api/sign-in", {
      method: "POST",
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify(user)
    })
    .then((res: Response) => res.json())
    .then(res => {
      if (res.success) goto("/hub");
      else error = res.error;
    })
  }
</script>

<form class="text-yellow-600">

  <!-- Username / E-mail -->
  <div class="my-3">
    <Input bind:value={user.id} 
           name="id" 
           id="identifier" 
           required={true} 
           label={$_("page.sign-in.id")}/>
  </div>

  <!-- Password -->
  <div class="mb-2">
    <Input bind:value={user.password}
           id="password" 
           name="password" 
           {type} 
           required={true} 
           label={$_("page.sign-in.password")}/>
  
    <!-- Show password -->
    <div class="flex justify-center mt-1">
      <label class="text-sm font-bold mb-2 cursor-pointer block">
        <input type="checkbox" 
               class="accent-yellow-600" 
               onchange={() => { 
                 if (type == "password") type = "text";
                 else type = "password";
               }}>
        {$_("page.sign-in.showPassword")}
      </label>
    </div>
  </div>

  <!-- Sign in -->
  <div class="flex justify-center items-center mb-1">
    <button class="disabled:opacity-35 bg-yellow-600 enabled:hover:bg-black border-yellow-600 border-2 text-black enabled:hover:text-yellow-600 font-bold p-2 rounded duration-300" 
            disabled={user.password.length < 8 || user.id.length < 5}
            type="button"
            onclick={signIn}>
      {$_("page.sign-in.title")}
    </button>
  </div>

  <!-- Go to Sign Up -->
  <div class="flex justify-center">
    <a class="hover:underline italic" 
       href="/sign-up">{$_("page.sign-in.toSignUp")}</a>
  </div>

  <!-- Display error -->
  {#if error}
    <div class="bg-red-600 text-white text-center mt-2 rounded-md p-1">
      {$_("page.sign-in." + error)}
    </div>
  {/if}
</form>