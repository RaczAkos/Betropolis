<script lang="ts">
  import { _ } from "svelte-i18n";
  import { page } from "$app/state";
  import { browser } from "$app/environment";
	let { children, data } = $props(),
      links: Array<{text: string, href: string}> = $state([
        { text: "/src/lib/media/images/profile/home.png", href: "/" },
        { text: "/src/lib/media/images/profile/gamble-jackpot.png", href: "/hub" },
      ]);

  $effect(() => {
    if (!page.params.friend && page.route.id !== "/profile/settings") links[2] = { text: "/src/lib/media/images/profile/gear.png", href: "/profile" };
    else links[2] = { text: "/src/lib/media/images/profile/frienduser.png", href: "/profile" };
  }) 

    import LanguageModal from "$lib/components/LanguageModal.svelte";
    import { fade, scale } from 'svelte/transition';
    import avatarsAll from "$lib/exports/avatars";
    import { deleteCharacter, profileChange } from '$lib/exports/profile';


    let username = $state(""),
        email = $state(""),
        langClicked:boolean = $state(false),
        currentEmail = $state(data.result[0].email),
        currentName = $state(data.result[0].username),
        currentAvatar = $state(data.result[0].avatar),
        currentLang = $state(browser ? window.navigator.language : "en"),
        lang= $state(currentLang),
        showModal = $state(false),
        selectedAvatarIndex = $state(-1),
        temporarySelectedAvatar = $state(data.result[0].avatar),
        emailIsValid = $state(false),
        passwordIsValid = $state(false),
        password = $state("")


    function openModal() {
        const modal = document.getElementById('profileEditModal');
        modal?.classList.remove('hidden');
        setTimeout(() => {
            modal?.classList.remove('opacity-0');
            modal?.classList.remove('bg-opacity-0');
            modal?.classList.add('bg-opacity-50');
            modal?.classList.add('opacity-100');
            modal?.children[0].classList.remove('scale-0');
            modal?.children[0].classList.add('scale-100');
        }, 10);
    }

    function closeModal() {
        const modal = document.getElementById('profileEditModal');
        modal?.classList.add('opacity-0');
        modal?.classList.remove('bg-opacity-50');
        modal?.classList.remove('opacity-100');
        modal?.classList.add('bg-opacity-0');
        modal?.children[0].classList.add('scale-0');
        modal?.children[0].classList.remove('scale-100');
        setTimeout(() => {
            modal?.classList.add('hidden');
            temporarySelectedAvatar = data.result[0].avatar;
        }, 300);
    }

    function localeCheck(locale:string){
        if (locale == "en-GB" || locale == "en-US" || locale == "en-CA") return "en";
        return locale;
    }

    function selectAvatar(index:any) {
        selectedAvatarIndex = index;
    }

    function saveChanges() {
        if (emailIsValid && passwordIsValid) {
            profileChange(temporarySelectedAvatar, username, email, passwordIsValid, lang);
            currentEmail = email,
            currentName = username,
            currentAvatar = temporarySelectedAvatar,
            currentLang = lang,
            [username, password, email] = "";
            closeModal();  
        }
    }

    $effect(() => {
       if (/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email) && 
           /^.*(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[.!#$%&?<>_ "]).*$/.test(password)) {
        emailIsValid = true;
        passwordIsValid = true;
       }else{
        emailIsValid = false;
        passwordIsValid = false;
       }
    })
    
    function deleteUser() {
        deleteCharacter();
    }



</script>
<!--For the reload button-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />

<div class="h-screen p-4">
  <div class="border-2 h-full border-yellow-600/30 bg-[#040d17] rounded-lg shadow-2xl shadow-[#040d17]">
    <div class="p-4 flex flex-col items-start h-full xl:overflow-visible overflow-y-auto">
      <div class="text-yellow-600 flex flex-col sm:flex-row justify-between w-full">
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
                {data.data}
              {/if}
            </span>
          </p>
        </div>
        <div class="flex max-sm:justify-between max-sm:mt-2 sm:gap-5">
          {#each links as link}
            <a href={link.href} 
              class="p-1 hover:scale-110 duration-300"
              onclick={openModal}>
              <img src="{$_(link.text)}" alt="">
            </a>
          {/each}
        </div>
      </div>
      {@render children()}
      <!-- Profile Edit Modal -->
      <div id="profileEditModal" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-0 opacity-0 hidden transition-opacity duration-700">
        <div class="w-[80vw] max-w-[500px] bg-[#040d17] rounded-lg shadow-2xl p-6 text-white relative transform scale-0 transition-transform duration-300  border-white shadow-2xl shadow-gray-500">
            
            <!-- Close Button -->
            <button class="absolute top-3 right-3 text-gray-400 hover:text-white" onclick={closeModal}>
                &times;
            </button>

            <h2 class="text-xl font-bold text-center mb-4">{$_(`page.profile.modal.title`)}</h2>
            
            <!-- Avatar Upload -->
            <div class="flex flex-col items-center mb-4">
                <div class="relative w-[120px] h-[120px]">
                    <img id="avatarPreview" src="{temporarySelectedAvatar}" class="w-full h-auto rounded-full border-4 border-white shadow-xl">
                    <label for="avatarUpload" class="absolute inset-0 flex items-center justify-center bg-black bg-opacity-50 rounded-full cursor-pointer hover:bg-opacity-70">
                        <span class="text-sm text-white" 
                              onclick={() => showModal = true}><i class="fas fa-sync-alt text-white text-xl"></i></span>
                    </label>
                </div>
            </div>

            <!-- Username Input -->
            <div class="mb-4">
                <label class="text-gray-400 block mb-1">{$_(`page.profile.modal.name`)}</label>
                <input bind:value={username} type="text" id="username" placeholder="{currentName}" class="w-full bg-[#141a22] text-white p-2 rounded border border-gray-600 focus:outline-none focus:border-yellow-500 shadow-lg focus:shadow-yellow-600">
            </div>

            <!-- Email Input -->
            <div class="mb-4">
                <label class="text-gray-400 block mb-1">{$_(`page.profile.modal.email`)}</label>
                <input bind:value={email} type="email" id="email" placeholder="{currentEmail}" class="w-full bg-[#141a22] text-white p-2 rounded border border-gray-600 focus:outline-none focus:border-yellow-500 shadow-lg focus:shadow-yellow-600">
            </div>

            <!-- Password Input -->
            <div class="mb-4">
                <label class="text-gray-400 block mb-1">{$_(`page.profile.modal.password`)}</label>
                <input bind:value={password} type="password" id="password" placeholder="**********" class="w-full bg-[#141a22] text-white p-2 rounded border border-gray-600 focus:outline-none focus:border-yellow-500 shadow-lg focus:shadow-yellow-600">
            </div>

            
            <div class="w-full justify-items-center">
                <button type="button"
                        onclick={() => langClicked = true}
                        class="border-2 rounded p-1 px-4 border-yellow-600 flex">
                    <div>
                        <img src={`/src/lib/media/images/lang/${localeCheck(lang)}.png`} 
                        alt={lang}
                        class="h-8">
                    </div>
                </button>
            </div> 

            <!-- Save Button -->
            <div class="flex justify-center mt-4">
                <button class="bg-yellow-600 hover:bg-yellow-700 text-white font-bold py-2 px-6 rounded-lg transition-all duration-300" onclick={saveChanges}>
                    {$_(`page.profile.modal.save`)}
                </button>
            </div>
        </div>
      </div>

      <LanguageModal bind:selectedLang={lang} 
                  bind:show={langClicked}/> 



      <!-- Modal -->
      {#if showModal}
      <div
        class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
        transition:fade
        onclick={() => showModal = false}
      >
        <!-- Modal content box -->
        <div
          class="bg-[#040d17] p-6 rounded-xl shadow-xl w-auto border-white shadow-2xl shadow-gray-500"
          transition:scale={{ duration: 250 }}
        >
          <h2 class="text-xl text-white font-bold mb-4">Choose Your Avatar</h2>

          <div class="flex gap-4 w-max px-4 py-2">
            {#each avatarsAll[data.result[0].gender] as avatar, index}
              <button onclick={() => {selectAvatar(index), temporarySelectedAvatar = avatar}} type="button">
                <img  
                  src={avatar}
                  alt="Avatar {index}"
                  class="w-20 h-20 rounded-full border-4 cursor-pointer transition-all hover:border-white shadow-xl hover:shadow-gray-500
                  {selectedAvatarIndex === index
                    ? 'border-yellow-600'
                    : 'border-transparent hover:border-gray-400'}"
                />
              </button>
            {/each}
            <input
              name="picture"
              class="hidden"
              type="text"
              bind:value={avatarsAll[data.result[0].gender][selectedAvatarIndex]}
            />
          </div>

          <button
            class="mt-4 bg-gray-800 text-white px-4 py-2 rounded"
            onclick={() => showModal = false}
          >
            Close
          </button>
        </div>
      </div>
      {/if}                            
    </div>
  </div>
</div>
