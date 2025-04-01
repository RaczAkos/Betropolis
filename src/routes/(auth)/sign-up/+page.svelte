<!-- Meta information -->
<svelte:head>
    <title>Sign up! - Betropolis</title>
    <meta name="description" content="Welcome to Betropolis — your ultimate online destination for thrilling casino games and endless entertainment! Step into a world where the excitement never stops, and every spin, card flip, and roll of the dice brings you closer to unforgettable winnings. At Betropolis, we combine top-tier games, cutting-edge security, and seamless gameplay to create a premium online casino experience." />
</svelte:head>

<script lang="ts">
  import Input from "$lib/components/Input.svelte";
  import { enhance } from "$app/forms";
  import avatarsAll from "$lib/exports/avatars.js";

  let { form } = $props();

  interface Registration {
    name:string,
    username:string,
    birthdate:string,
    gender:number|null,
    email:string,
    password:string,
    picture:string,
    lang:string
  }

  let user: Registration = $state({
        name: "",
        username: "",
        birthdate: "",
        gender: null,
        email: "",
        password: "",
        picture:"",
        lang: ""
      }),
      windowWidth:number     = $state(0),
      type:string            = $state("password"),
      password2:string       = $state(""),
      passConf:boolean       = $state(false),
      passwordFormat:boolean = $state(false),
      userNameFormat:boolean = $state(false),
      date:Date              = new Date(),
      month:string|number    = (Number(date.getMonth()) < 9)? "0"+(Number(date.getMonth())+1):date.getMonth()+1,
      day:string|number      = (date.getDate() < 10)? "0"+date.getDate():date.getDate(),
      currentDate:string     = `${date.getFullYear()-18}-${month}-${day}`,
      conditions:boolean     = $state(false),
      over18:boolean         = $state(false),
      valid:boolean          = $state(false);
    
  let selectedAvatarIndex = $state(-1);


  // Testing password format
  $effect(() => {
    passwordFormat = /^.*(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[.!#$%&?<>_ "]).*$/.test(user.password);
    if (passwordFormat) passConf = (user.password == password2)? true : false;
  });

  $effect(() => {
    userNameFormat = /^[a-zA-Z0-9]{5,20}$/.test(user.username);
  });

  // Checking fields
  $effect(() => {
    if (user.name.length > 3 && 
      user.name.indexOf(' ') && 
      userNameFormat &&
      user.gender && 
      user.birthdate != "" &&
      /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(user.email) &&
      passConf &&
      conditions &&
      over18 &&
      selectedAvatarIndex != -1
    ) valid = true;
    else valid = false;
  });

  function selectAvatar(index:any) {
    selectedAvatarIndex = index;
    console.log("Selected Avatar Index:", index);
  }
  
</script>

<svelte:window bind:innerWidth={windowWidth}/>

<form method="POST" use:enhance={() => { return async ({ update }) => {update({ reset: false });};}}>
  <div class="flex sm:flex-row flex-col sm:w-[500px]">
    <div class="sm:w-1/2">
      <!-- Name -->
      <Input id="name" 
             bind:value={user.name}
             name="name" 
             label="Full name (required)"/>
      
      <!-- Username -->
      <div class="my-2">
        <Input id="name" 
               bind:value={user.username}
               name="username"
               label="Username (required)"
               type="text" />
        <div class:text-green-400={userNameFormat} 
             class:opacity-100={userNameFormat} 
             class="text-gray-300 opacity-50 text-xs text-wrap !text-justify m-1">
          Username should be 5 to 20 characters and should only contain letters and numbers.
        </div>
      </div>
      
      <!-- Date of birth -->
      <div class="relative">
        <div class="block text-yellow-600 text-md font-bold p-1">Date of birth (required)</div>
        <input bind:value={user.birthdate} 
               max={currentDate} 
               type="date"
               name="birthdate" 
               class="bg-black outline-none border-2 text-yellow-600 text-md rounded-lg focus:ring-yellow-600 border-yellow-600 block w-full p-2 text-center">
      </div>

      <div class="flex flex-row max-sm:flex-col p-1 mb-2 gap-2">
        <!-- Gender -->
        <div class="w-full mt-2">
          <p class="block text-yellow-600 font-bold text-md">Gender (required)</p>
          <div class="flex flex-row justify-center items-center h-2/3 gap-3">
            <div class="basis-1/2">
              <input bind:group={user.gender} 
                     value=0 
                     id="gender-male" 
                     type="radio" 
                     name="gender" 
                     class="w-4 h-4 accent-yellow-600 bg-black border-yellow-600 focus:ring-yellow-600 ">
              <label for="gender-male" 
                     class="ms-1 text-md font-medium text-yellow-600">
                Male
              </label>
            </div>
            <div class="basis-1/2">
              <input bind:group={user.gender} 
                     value=1 
                     id="gender-female" 
                     type="radio" 
                     name="gender" 
                     class="w-4 h-4 accent-yellow-600 bg-black border-yellow-600 focus:ring-yellow-600">
              <label for="gender-female" 
                     class="ms-1 text-md font-medium text-yellow-600">
                Female
              </label>
            </div>
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
               label="E-mail (required)"/>
      </div>
    
      <!-- Password -->
      <div class="mb-2">
        <Input bind:value={user.password} 
               id="password" 
               {type} 
               name="password"
               label="Password (required)"
               onpaste={(e:Event) => e.preventDefault()}/>
        <div class:text-green-400={passwordFormat} 
             class:opacity-100={passwordFormat} 
             class="text-gray-300 opacity-50 text-xs text-wrap !text-justify m-1">
          Password must be at least 8 characters, containing at least 1 uppercase, 1 lowercase, 1 number and 1 special character.
        </div>
    
        <!-- Show password -->
        <div class="flex justify-center">
          <label class="text-sm font-bold mb-2 text-yellow-600 cursor-pointer block">
            <input type="checkbox" 
                   class="accent-yellow-600" 
                   onchange={() => { 
                      if (type == "password") type = "text";
                      else type = "password";
                   }}
            >
              Show password
          </label>
        </div>
      </div>

      <!-- Password confirm -->
      <div class="mb-1">
        <Input bind:value={password2} 
               type="password" 
               id="passconf" 
               label="Confirm password (required)" 
               onpaste={(e:Event) => e.preventDefault()}/>
      </div>

      {#if passConf}
        <div class="text-green-400 text-center">Password confirmed.</div>
      {:else}
        <div class="text-red-400 text-center opacity-70">Password not confirmed.</div>
      {/if}
    </div>
  </div>

  <!-- Accepting sign up conditions -->
  <div class="my-2">
    <label class="text-sm font-bold mb-2 text-yellow-600 cursor-pointer block">
        <input type="checkbox" 
               class="accent-yellow-600" 
               bind:checked={conditions}>
      I have read and accept the 
      <a href="/terms&conditions"
         class="sm:hover:underline italic max-sm:underline">
         Terms & Conditions
      </a>
      and 
      <a href="/privacy-policy"
         class="sm:hover:underline italic max-sm:underline">
        Privacy Policy
      </a>.
    </label>
    <label class="text-sm font-bold mb-2 text-yellow-600 cursor-pointer block">
      <input type="checkbox" 
             class="accent-yellow-600" 
             bind:checked={over18}>
      I am 18 years old or older.
    </label>
  </div>

  {#if user.gender}
  <div>
    <div class="text-center sm:w-[500px] mb-5" style="max-width: {windowWidth-89}px;">
      <h2 class="text-xl font-semibold mb-4">Choose Your Avatar!</h2>
      <!-- Scrollable container -->
      <div class="overflow-x-scroll sm:w-[500px] scrollDesign">
        <div class="flex gap-4 w-max px-4 py-2">
          {#each avatarsAll[user.gender] as avatar, index}
            <button onclick={() => selectAvatar(index)} type="button">
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

  <!-- Sign in -->
  <div class="flex justify-center items-center my-1">
    <button class="disabled:opacity-35 disabled:hover:bg-yellow-600 bg-yellow-600 hover:bg-black border-yellow-600 border-2 hover:border-opacity-100 text-black hover:text-yellow-600 disabled:hover:text-black font-bold py-2 px-3 rounded focus:outline-none focus:shadow-outline duration-300" 
            disabled={!valid}>
      Sign Up
    </button>
  </div>

  <!-- Go to Sign in -->
  <div class="flex justify-center">
    <a class="hover:underline text-yellow-600 italic" href="/sign-in">Already have an account?</a>
  </div>
</form>

<!-- Display error/feedback -->
{#if form?.error}
  <div class="bg-red-600 text-white text-center mt-2 rounded-md p-1">
    {form.error}
  </div>
{/if}

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