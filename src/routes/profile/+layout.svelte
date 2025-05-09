<script lang="ts">
  import { _ } from "svelte-i18n";
  import { page } from "$app/state";
	let { children, data } = $props(),
      links: Array<{text: string, href: string}> = $state([
        { text: "home.png", href: "/" },
        { text: "gamble-jackpot.png", href: "/hub" },
      ]);

  $effect(() => {
    links[2] = { text: `${!page.params.friend? "gear" : "frienduser"}.png`, href: "/profile" };
  }) 

  import LanguageModal from "$lib/components/LanguageModal.svelte";
  import { fade, scale } from 'svelte/transition';
  import avatarsAll from "$lib/exports/avatars";
  import { setContext } from 'svelte';
  import { writable } from 'svelte/store';
  import { profileChange } from '$lib/exports/profile';

  let username: string                = $state(data.result[0].username),
      email: string                   = $state(data.result[0].email),
      langClicked: boolean            = $state(false),
      currentEmail: string            = $state(data.result[0].email),
      currentName: string             = $state(data.result[0].username),
      currentAvatar: number           = $state(data.result[0].avatar),
      currentLang:string              = $state(localeCheck(data.result[0].lang)),
      showModal: boolean              = $state(false),
      selectedAvatarIndex: number     = $state(data.result[0].avatar),
      password: string                = $state(data.result[0].password),
      passwordType: string            = $state("password"),
      deleteClicked: boolean          = $state(false);

  // Opening and closing profile setting modal
  function openModal() {
    const modal = document.getElementById('profileEditModal');
    modal?.classList.remove('hidden');
    modal?.classList.add('flex');
    setTimeout(() => {
      modal?.classList.remove('opacity-0','bg-opacity-0');
      modal?.classList.add('bg-opacity-50', 'opacity-100');
      modal?.children[0].classList.remove('scale-0');
      modal?.children[0].classList.add('scale-100');
    }, 10);
  }

  function closeModal() {
    const modal = document.getElementById('profileEditModal');
    modal?.classList.add('opacity-0', 'bg-opacity-0');
    modal?.classList.remove('bg-opacity-50', 'opacity-100');
    modal?.children[0].classList.add('scale-0');
    modal?.children[0].classList.remove('scale-100');
    setTimeout(() => {
      modal?.classList.add('hidden');
      modal?.classList.remove('flex');
      selectedAvatarIndex = data.result[0].avatar;
    }, 300);
  }

  function localeCheck(locale:string){
    if (locale == "en-GB" || locale == "en-US" || locale == "en-CA") return "en";
    return locale;
  }

  const sharedPic = writable(0);
  setContext('sharedPic', sharedPic);

  // Update user
  function saveChanges() {
    if (/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email) && 
        /^.*(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[.!#$%&?<>_ "]).*$/.test(password) &&
        /^[a-zA-Z0-9]{5,20}$/.test(username)) {
      profileChange(selectedAvatarIndex, username, email, password, currentLang);
      currentEmail = email;
      currentName = username;
      currentAvatar = selectedAvatarIndex;
      password = "";
      if (currentAvatar > 0) sharedPic.set(currentAvatar);
      closeModal();
    }
  }

  // Delete user
  function deleteUser() {
    fetch('/api/profile', {
      method: 'DELETE',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({}),
    })
    .then(res => window.location.reload());
  }
</script>

<div class="h-screen p-4">
  <div class="border-2 h-full border-yellow-600/30 bg-[#040d17] rounded-lg shadow-2xl shadow-[#040d17]">
    <div class="p-4 flex flex-col items-start h-full xl:overflow-visible overflow-y-auto">
      <div class="text-yellow-600 flex flex-col sm:flex-row justify-between w-full">

        <!-- Username -->
        <div class="flex items-center max-sm:justify-center">
          <img src="/src/lib/media/images/hub/user.png" 
               class="w-5 h-auto" 
               alt="user">
          <p class="ms-2 relative top-[1px]">
            {$_(`page.profile.title`)}:
            <span class="text-white">
              {#if page.params.friend}
                {page.params.friend}
              {:else}
                {currentName}
              {/if}
            </span>
          </p>
        </div>

        <!-- Navigation -->
        <div class="flex max-sm:justify-between max-sm:mt-2 sm:gap-5">
          {#each links as link}
            <a href={link.href} 
              class="p-1 hover:scale-110 duration-300"
              onclick={() => { if (link.text == "gear.png") openModal(); }}>
              <img src={`/src/lib/media/images/profile/${link.text}`} 
                   alt="link" 
                   class="h-8">
            </a>
          {/each}
        </div>
      </div>
      {@render children()}    
    </div>
  </div>
</div>


<!-- Profile Edit Modal -->
<div id="profileEditModal" 
     class="fixed inset-0 hidden items-center justify-center bg-black bg-opacity-0 opacity-0 transition-opacity duration-700 overflow-auto p-1">
  <div class="sm:w-[80vw] max-w-[500px] bg-[#040d17] rounded-lg shadow-2xl p-6 
            text-white relative transform scale-0 transition-transform duration-300  border-white shadow-gray-500">
      
    <div>
      <!-- Close Button -->
      <button class="absolute top-3 right-3 text-gray-400 hover:text-white py-2 px-4 text-3xl" onclick={closeModal}>
        &times;
      </button>

      <h2 class="text-xl font-bold text-center mb-2">
        {$_(`page.profile.modal.title`)}
      </h2>
        
      <!-- Avatar Upload -->
      <div class="flex flex-col items-center mb-2">
        <div class="relative w-[120px] h-[120px]">
          <img id="avatarPreview" 
              src={`/src/lib/media/images/avatars/${data.result[0].gender ? "female" : "male"}_avatars/avatar_${selectedAvatarIndex}.png`} 
              alt="avatar" 
              class="w-full h-auto rounded-full border-4 border-white shadow-xl">
          <button class="text-sm" 
                  onclick={() => showModal = true}
                  aria-labelledby="avatar-change">
            <label for="avatarUpload" 
                   class="absolute inset-0 flex items-center justify-center bg-black bg-opacity-50
                          rounded-full cursor-pointer hover:bg-opacity-70">
            </label>
          </button>
        </div>
      </div>

      <!-- Name, gender, date of birth -->
      <div class="flex justify-center">
        <table class="w-auto">
          <tbody class="[&_th]:text-start [&_th]:px-2">
            <tr>
              <th>
                {$_("page.sign-up.fullName")}:
              </th>
              <td>
                {data.result[0].name}
              </td>
            </tr>
            <tr>
              <th>
                {$_("page.sign-up.gender")}:
              </th>
              <td>
                {#if data.result[0].gender}
                  {$_("page.sign-up.female")}
                {:else}
                  {$_("page.sign-up.male")}
                {/if}
              </td>
            </tr>
            <tr>
              <th>
                {$_("page.sign-up.dateOfBirth")}:
              </th>
              <td>
                {data.result[0].birthdate.toString().split(' ')[3]}.
                {("JanFebMarAprMayJunJulAugSepOctNovDec".indexOf(data.result[0].birthdate.toString().split(' ')[1]) / 3 + 1).toString().padStart(2, '0')}. 
                {data.result[0].birthdate.toString().split(' ')[2]}.
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Username Input -->
      <div class="mb-2">
        <label for="username" 
              class="text-gray-400 block mb-1">
          {$_(`page.profile.modal.name`)}
        </label>
        <input bind:value={username} 
              type="text" 
              id="username" 
              placeholder={currentName} 
              class="w-full bg-[#141a22] text-white p-2 rounded border border-gray-600 
                      focus:outline-none focus:border-yellow-500 shadow-lg focus:shadow-yellow-600">
      </div>

      <!-- Email Input -->
      <div class="mb-2">
        <label for="email" class="text-gray-400 block mb-1">
          {$_(`page.profile.modal.email`)}
        </label>
        <input bind:value={email} 
              type="email" 
              id="email" 
              placeholder="{currentEmail}" 
              class="w-full bg-[#141a22] text-white p-2 rounded border border-gray-600 
                      focus:outline-none focus:border-yellow-500 shadow-lg focus:shadow-yellow-600">
      </div>

      <!-- Password Input -->
      <div class="mb-2">
        <label for="password" 
              class="text-gray-400 block mb-1">
          {$_(`page.profile.modal.password`)}
        </label>
        <input bind:value={password} 
               type={passwordType} 
               id="password" 
               placeholder="**********" 
               class="w-full bg-[#141a22] text-white p-2 rounded border border-gray-600 
                      focus:outline-none focus:border-yellow-500 shadow-lg focus:shadow-yellow-600">
        <div class="flex justify-center gap-1 py-1">
          <input type="checkbox" 
                 name="showPassword" 
                 id="showPassword" 
                 onchange={() => {
                   if (passwordType == "password") passwordType = "text";
                   else passwordType = "password";
                 }}>
          <label for="showPassword">
            {$_("page.sign-in.showPassword")}
          </label>
        </div>
      </div>
        
      <!-- Change language -->
      <div class="w-full flex justify-center">
        <button type="button"
                onclick={() => langClicked = true}
                class="border-2 rounded p-1 px-4 border-yellow-600 flex">
          <div>
            <img src={`/src/lib/media/images/lang/${localeCheck(currentLang)}.png`} 
                alt={currentLang}
                class="h-8">
          </div>
        </button>
      </div> 

      <!-- Buttons -->
      <div class="flex justify-center font-bold text-white gap-2 mt-2">
        <div class="flex justify-center">
          <button class="bg-yellow-600 py-2 px-3 rounded-lg transition-all duration-300
                          border-b-4 border-yellow-700 hover:border-yellow-500 shadow-lg hover:shadow-yellow-500" 
                  onclick={saveChanges}>
            {$_(`page.profile.modal.save`)}
          </button>
        </div>
        <div class="flex justify-center">
          <button class="bg-red-600 py-2 px-3 rounded-lg transition-all duration-300
                          border-b-4 border-red-700 hover:border-red-500 shadow-lg hover:shadow-red-500" 
                  onclick={() => deleteClicked = true}>
            {$_(`page.profile.delete`)}
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<LanguageModal bind:selectedLang={currentLang} 
               bind:show={langClicked}/> 

<!-- Avatar change Modal -->
{#if showModal}
<div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
     transition:fade>
  <!-- Modal content box -->
  <div class="bg-[#040d17] p-6 rounded-xl w-auto border-white shadow-2xl shadow-gray-500"
       transition:scale={{ duration: 250 }}>
    <h2 class="text-xl text-center text-white font-bold mb-4">
      {$_("page.sign-up.avatar")}
    </h2>

    <div class="grid grid-cols-2 sm:grid-cols-4 lg:grid-cols-8 gap-4 w-max px-4 py-2">
      {#each avatarsAll[data.result[0].gender] as avatar, index}
        <button onclick={() => selectedAvatarIndex = index+1} type="button">
          <img src={avatar}
               alt="Avatar {index}"
               class="w-20 h-20 rounded-full border-4 cursor-pointer transition-all hover:border-white shadow-xl hover:shadow-gray-500
                      {selectedAvatarIndex === index+1 ? 'border-yellow-600' : 'border-transparent hover:border-gray-400'}"/>
        </button>
      {/each}
    </div>

    <div class="flex justify-center">
      <button class="mt-4 bg-gray-800 text-white px-4 py-2 rounded"
              onclick={() => showModal = false}>
        {$_("close")}
      </button>
    </div>
  </div>
</div>
{/if}

<!-- Confirm user deletion Modal -->
{#if deleteClicked}
<div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 text-white"
     transition:fade>
  <!-- Modal content box -->
  <div class="bg-[#040d17] p-4 rounded-xl w-auto border-white shadow-2xl shadow-gray-500"
       transition:scale={{ duration: 250 }}>
    <h2 class="text-xl text-center font-bold mb-2">
      {$_("page.profile.delete")}
    </h2>

    <p class="text-center">
      {$_("page.profile.deleteConfirm")}
    </p>

    <div class="flex justify-center gap-2 mt-2">
      <button class="bg-gray-800 px-4 py-2 rounded hover:bg-gray-600 duration-300 hover:scale-105"
              onclick={() => deleteClicked = false}>
        {$_("close")}
      </button>
      <button class="bg-red-600 px-4 py-2 rounded duration-300 border-b-4 border-red-700 hover:border-red-500 shadow-lg 
                     hover:shadow-red-500 transition-all"
              onclick={deleteUser}>
        {$_("page.profile.delete")}
      </button>
    </div>
  </div>
</div>
{/if}                        