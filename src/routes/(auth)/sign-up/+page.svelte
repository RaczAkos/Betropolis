<svelte:head>
    <title>{$_("page.sign-up.title")} - Betropolis</title>
    <meta name="description" content={$_("page.home.description")} />
</svelte:head>

<script lang="ts">
  import { _ } from "svelte-i18n";
  import Input from "$lib/components/Input.svelte";
  import { enhance } from "$app/forms";
  import avatarsAll from "$lib/exports/avatars";
  import LanguageModal from "$lib/components/LanguageModal.svelte";
  import { browser } from "$app/environment";
  import { onMount } from "svelte";
  import type { PageProps } from "../sign-in/$types";
  import type { Registration } from "$lib/interfaces";
  
  let { form }:PageProps = $props(),
      user:Registration  = $state({
        name: "",
        username: "",
        birthdate: "",
        gender: null,
        email: "",
        password: "",
        picture:"",
        lang: ""
      }),
      genders: string[]           = ["male", "female"],
      windowWidth: number         = $state(0),
      type: string                = $state("password"),
      password2: string           = $state(""),
      passwordConfirm: boolean    = $state(false),
      passwordFormat: boolean     = $state(false),
      userNameFormat: boolean     = $state(false),
      date: Date                  = new Date(),
      month: string|number        = (Number(date.getMonth()) < 9)? "0"+(Number(date.getMonth())+1):date.getMonth()+1,
      day: string|number          = (date.getDate() < 10)? "0"+date.getDate():date.getDate(),
      currentDate: string         = `${date.getFullYear()-18}-${month}-${day}`,
      conditions: boolean         = $state(false),
      defaultLang: boolean        = $state(false),
      over18: boolean             = $state(false),
      valid: boolean              = $state(false),
      langClicked: boolean        = $state(false),
      selectedAvatarIndex: number = $state(-1);

  // Setting language
  onMount(() => {
    if (browser) user.lang = localeCheck(window.navigator.language);
    else user.lang = 'en';

    if (user.lang == 'en') defaultLang = true;
  })

  // Testing password format
  $effect(() => {
    passwordFormat = /^.*(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[.!#$%&?<>_ "]).*$/.test(user.password);
    if (passwordFormat) passwordConfirm = (user.password == password2)? true : false;
  });
  
  // Testing username format
  $effect(() => {
    userNameFormat = /^[a-zA-Z0-9]{5,20}$/.test(user.username);
  });

  // Checking fields
  $effect(() => {
    if (user.name.length > 2 && user.name.indexOf(' ') &&                     // name
      userNameFormat &&                                                       // username
      user.gender !== null &&                                                 // gender
      user.birthdate != "" &&                                                 // date of birth
      /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(user.email) &&  // email
      passwordConfirm &&                                                      // confirmed password
      conditions &&                                                           // policies
      over18 &&                                                               // age
      selectedAvatarIndex != -1                                               // avatar
    ) valid = true;
    else valid = false;
  });

  function localeCheck(locale:string){
    if (locale == "en-GB" || locale == "en-US" || locale == "en-CA") return "en";
    return locale;
  }
</script>

<svelte:window bind:innerWidth={windowWidth}/>

<form method="POST" 
      use:enhance={() => { return async ({ update }) => {update({ reset: false });};}}>
  <div class="flex sm:flex-row flex-col sm:w-[500px]">
    <div class="sm:w-1/2">
      <!-- Name -->
      <Input id="name" 
             bind:value={user.name}
             name="name" 
             label="{$_("page.sign-up.fullName")} ({$_("page.sign-up.required")})"/>
      
      <!-- Username -->
      <div class="my-2">
        <Input id="name" 
               bind:value={user.username} 
               name="username" 
               label="{$_("page.sign-up.username")} ({$_("page.sign-up.required")})" 
               type="text" />
        <div class:text-green-400={userNameFormat} 
             class:opacity-100={userNameFormat} 
             class="text-gray-300 opacity-50 text-xs text-wrap !text-justify m-1">
          {$_("page.sign-up.usernameDescription")}
        </div>
      </div>
      
      <!-- Date of birth -->
      <div class="relative">
        <div class="block text-yellow-600 text-md font-bold p-1">{$_("page.sign-up.dateOfBirth")} ({$_("page.sign-up.required")})</div>
        <input bind:value={user.birthdate} 
               max={currentDate} 
               type="date"
               name="birthdate" 
               class="bg-black outline-none border-2 text-yellow-600 text-md rounded-lg focus:ring-yellow-600 border-yellow-600 block w-full p-2 text-center">
      </div>

      <div class="flex flex-row max-sm:flex-col p-1 mb-2 gap-2">
        <!-- Gender -->
        <div class="w-full mt-2">
          <p class="block text-yellow-600 font-bold text-md">{$_("page.sign-up.gender")} ({$_("page.sign-up.required")})</p>
          <div class="flex flex-row justify-center items-center h-2/3 gap-3">
            {#each genders as gender, i}
            <div class="basis-1/2">
              <input bind:group={user.gender} 
                     value={i} 
                     id="gender-{gender}" 
                     type="radio" 
                     name="gender" 
                     class="w-4 h-4 accent-yellow-600 bg-black border-yellow-600 focus:ring-yellow-600 ">
              <label for="gender-{gender}" 
                     class="ms-1 text-md font-medium text-yellow-600">
                {$_(`page.sign-up.${gender}`)}
              </label>
            </div>
            {/each}
          </div>
        </div>
      </div>
    </div>

    <div class="sm:ms-4 sm:w-1/2">
      <!-- E-mail -->
      <div class="mb-2">
        <Input bind:value={user.email}
               id="email" 
               type="email" 
               name="email"
               label="E-mail ({$_("page.sign-up.required")})"/>
      </div>
    
      <!-- Password -->
      <div class="mb-2">
        <Input bind:value={user.password} 
               id="password" 
               {type} 
               name="password"
               label="{$_("page.sign-in.password")} ({$_("page.sign-up.required")})"
               onpaste={(e:Event) => e.preventDefault()}/>
        <div class:text-green-400={passwordFormat} 
             class:opacity-100={passwordFormat} 
             class="text-gray-300 opacity-50 text-xs text-wrap !text-justify m-1">
          {$_("page.sign-up.passwordDescription")}
        </div>
    
        <!-- Show password -->
        <div class="flex justify-center">
          <label class="text-sm font-bold mb-2 text-yellow-600 cursor-pointer block">
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

      <!-- Password confirm -->
      <div class="mb-1">
        <Input bind:value={password2} 
               type="password" 
               id="passconf" 
               label="{$_("page.sign-up.confirmPassword")} ({$_("page.sign-up.required")})" 
               onpaste={(e:Event) => e.preventDefault()}/>
      </div>

      {#if passwordConfirm}
        <div class="text-green-400 text-center">{$_("page.sign-in.password")} {$_("page.sign-up.confirmed")}.</div>
      {:else}
        <div class="text-red-400 text-center opacity-70">{$_("page.sign-in.password")} {$_("page.sign-up.notConfirmed")}.</div>
      {/if}
    </div>
  </div>

  <!-- Accepting sign up conditions -->
  <div class="my-2 flex flex-col sm:w-[500px]">
    <label class="text-sm font-bold mb-2 text-yellow-600 cursor-pointer">
      <input type="checkbox" 
             class="accent-yellow-600" 
             bind:checked={conditions}>
      {$_("page.sign-up.read")} 
      <a href="/terms&conditions"
         class="sm:hover:underline italic max-sm:underline">
         {$_("page.sign-up.t&c")}
      </a>
      {$_("and")}
      <a href="/privacy-policy"
         class="sm:hover:underline italic max-sm:underline">
         {$_("page.sign-up.p-p")}
      </a>.
    </label>
    <label class="text-sm font-bold mb-2 text-yellow-600 cursor-pointer">
      <input type="checkbox" 
             class="accent-yellow-600" 
             bind:checked={over18}>
      {$_("page.sign-up.over18")}.
    </label>
  </div>

  {#if user.gender !== null}
  <div>
    <div class="text-center sm:w-[500px] mb-5" style="max-width: {windowWidth-89}px;">
      <h2 class="text-xl font-semibold mb-4">{$_("page.sign-up.avatar")}</h2>
      <!-- Scrollable container -->
      <div class="overflow-x-scroll sm:w-[500px] scrollDesign">
        <div class="flex gap-4 w-max px-4 py-2">
          {#each avatarsAll[user.gender] as avatar, index}
            <button onclick={() => selectedAvatarIndex = index} type="button">
              <img  
                src={avatar}
                alt="Avatar {index}"
                class="w-20 h-20 rounded-full border-4 cursor-pointer transition-all
                      {selectedAvatarIndex === index ? 'border-yellow-600' : 'border-transparent hover:border-gray-400'}"
              />
            </button>
          {/each}
          <input name="picture" class="hidden" type="text" bind:value={avatarsAll[user.gender][selectedAvatarIndex]}>
        </div>
      </div>
    </div>
  </div>
  {/if}

  <input name="lang" class="hidden" type="text" bind:value={user.lang}>

  <!-- Sign in -->
  <div class="flex justify-center items-center gap-2 my-1">
    <button type="button"
            onclick={() => langClicked = true}
            class="border-2 rounded p-1 px-4 border-yellow-600">
      <div>
        <img src={`/src/lib/media/images/lang/${user.lang}.png`} 
        alt={user.lang}
        class="h-8">
      </div>
    </button>
    <button class="disabled:opacity-35 disabled:hover:bg-yellow-600 bg-yellow-600 hover:bg-black border-yellow-600 border-2 hover:border-opacity-100 text-black hover:text-yellow-600 disabled:hover:text-black font-bold py-2 px-3 rounded focus:outline-none focus:shadow-outline duration-300" 
            disabled={!valid}>
      {$_("page.sign-up.title")}
    </button>
  </div>

  <!-- Go to Sign in -->
  <div class="flex justify-center">
    <a class="hover:underline text-yellow-600 italic" 
       href="/sign-in">
       {$_("page.sign-up.account")}
    </a>
  </div>
</form>

<!-- Display error/feedback -->
{#if form?.error}
  <div class="bg-red-600 text-white text-center mt-2 rounded-md p-1">
    {$_("page.sign-up." + form.error)}
  </div>
{/if}

<LanguageModal bind:selectedLang={user.lang} 
               bind:show={langClicked}
               {defaultLang}/>

<style>
    input[type="date"] {
        position: relative;
        appearance: none;
        -webkit-appearance: none;
        box-sizing: border-box;
    }

    input[type="date"]::-webkit-calendar-picker-indicator {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        width: 16px;
        height: 16px;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="goldenrod" viewBox="0 0 24 24"><path d="M7 10l5 5 5-5H7z"/></svg>') no-repeat center;
        background-size: contain;
        cursor: pointer;
        opacity: 1;
    }
    .scrollDesign::-webkit-scrollbar{
      height: 0.5rem
    }

    .scrollDesign::-webkit-scrollbar-track{
      background: #1e1e24;
    }

    .scrollDesign::-webkit-scrollbar-thumb{
      border-radius: 5px;
    }
    .scrollDesign::-webkit-scrollbar-thumb:hover{
      background-color: #ca8a04;
    }
</style>