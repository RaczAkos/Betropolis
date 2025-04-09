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


    let username = $state(""),
        email = $state(""),
        langClicked:boolean = $state(false),
        lang= $state(browser ? window.navigator.language : "en"),
        showModal = $state(false),
        selectedAvatarIndex = $state(-1);

    function pictureHover() {
        let picture = document.getElementById('picChangebtn');
        picture?.classList.add('opacity-100');
    }

    function pictureLeave() {
        let picture = document.getElementById('picChangebtn');
        picture?.classList.remove('opacity-100');
    }
    
    let selectedGame:any = $state(null);

    function selectGame(game:any) {
        selectedGame = game;
    }


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
        setTimeout(() => {
            modal?.classList.add('hidden');
        }, 300);
    }

    function saveProfile() {
        closeModal();
    }

    function localeCheck(locale:string){
        if (locale == "en-GB" || locale == "en-US" || locale == "en-CA") return "en";
        return locale;
    }

    function selectAvatar(index:any) {
        selectedAvatarIndex = index;
    }



</script>

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
        <div class="w-[80vw] max-w-[500px] bg-[#040d17] rounded-lg shadow-2xl p-6 text-white relative transform scale-0 transition-transform duration-300">
            
            <!-- Close Button -->
            <button class="absolute top-3 right-3 text-gray-400 hover:text-white" onclick={closeModal}>
                &times;
            </button>

            <h2 class="text-xl font-bold text-center mb-4">{$_(`page.profile.modal.title`)}</h2>
            
            <!-- Avatar Upload -->
            <div class="flex flex-col items-center mb-4">
                <div class="relative w-[120px] h-[120px]">
                    <img id="avatarPreview" src="{data.result[0].avatar+'.png'}" class="w-full h-auto rounded-full border-4 border-white shadow-xl" 
                        onclick={() => showModal = true}>
                    <label for="avatarUpload" class="absolute inset-0 flex items-center justify-center bg-black bg-opacity-50 rounded-full cursor-pointer hover:bg-opacity-70">
                        <span class="text-sm text-white" 
                              onclick={() => showModal = true}><i class="fas fa-sync-alt text-white text-xl"></i></span>
                    </label>
                </div>
            </div>

            <!-- Username Input -->
            <div class="mb-4">
                <label class="text-gray-400 block mb-1">{$_(`page.profile.modal.name`)}</label>
                <input bind:value={username} type="text" id="username" placeholder="{data.result[0].username}" class="w-full bg-[#141a22] text-white p-2 rounded border border-gray-600 focus:outline-none focus:border-yellow-500 shadow-lg focus:shadow-yellow-600">
            </div>

            <!-- Email Input -->
            <div class="mb-4">
                <label class="text-gray-400 block mb-1">{$_(`page.profile.modal.email`)}</label>
                <input bind:value={email} type="email" id="email" placeholder="{data.result[0].email}" class="w-full bg-[#141a22] text-white p-2 rounded border border-gray-600 focus:outline-none focus:border-yellow-500 shadow-lg focus:shadow-yellow-600">
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
                <button class="bg-yellow-600 hover:bg-yellow-700 text-white font-bold py-2 px-6 rounded-lg transition-all duration-300" onclick={saveProfile}>
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
          class="bg-white p-6 rounded-xl shadow-xl w-full max-w-3xl"
          transition:scale={{ duration: 250 }}
        >
          <h2 class="text-xl font-bold mb-4">Choose Your Avatar</h2>

          <div class="flex gap-4 w-max px-4 py-2">
            {#each avatarsAll[data.result[0].gender] as avatar, index}
              <button onclick={() => selectAvatar(index)} type="button">
                <img  
                  src={avatar}
                  alt="Avatar {index}"
                  class="w-20 h-20 rounded-full border-4 cursor-pointer transition-all
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
