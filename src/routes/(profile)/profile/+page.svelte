
<script lang="ts">
    import userpng from "$lib/media/images/profile/user.png";
    import flymoney from "$lib/media/images/profile/flying-money.png";
    import income from "$lib/media/images/profile/income.png";
    import joystick from "$lib/media/images/profile/joystick.png";
    import useredit from "$lib/media/images/profile/user-edit.png";
    import chip from "$lib/media/images/chip.png";
    import LanguageModal from "$lib/components/LanguageModal.svelte";
    import { fade, scale } from 'svelte/transition';
    import { browser } from "$app/environment";
    import avatarsAll from "$lib/exports/avatars";
    import { profileChange } from '$lib/exports/profile';
    import { _ } from "svelte-i18n";

    let { data } = $props();

    let username = $state(""),
        email = $state(""),
        langClicked:boolean = $state(false),
        currentEmail = $state(data.user[0].email),
        currentName = $state(data.user[0].username),
        currentAvatar = $state(data.user[0].avatar+".png"),
        currentLang = $state(browser ? window.navigator.language : "en"),
        lang= $state(currentLang),
        showModal = $state(false),
        selectedAvatarIndex = $state(-1),
        temporarySelectedAvatar = $state(data.user[0].avatar+".png"),
        emailIsValid = $state(false),
        passwordIsValid = $state(false),
        password = $state("")



    function pictureHover() {
        let picture = document.getElementById('picChangebtn');
        picture?.classList.add('opacity-100');
    }

    function pictureLeave() {
        let picture = document.getElementById('picChangebtn');
        picture?.classList.remove('opacity-100');
    }
    
    let selectedGame:any = $state(null);

    if (data.lastPlayed.length != 0) {
        selectedGame = data.lastPlayed[0].gameid;
    }

    function selectGame(game:any) {
        selectedGame = game;
    }

    let chipsSpent = $state(0);
    for (let index = 0; index < data.transaction.length; index++) {
        if (data.transaction[index].gain < 0) {
            chipsSpent += data.transaction[index].gain;
        }
    }

    let chipsEarned = $state(0);
    for (let index = 0; index < data.transaction.length; index++) {
        if (data.transaction[index].gain > 0) {
            chipsEarned += data.transaction[index].gain;
        }
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
        modal?.children[0].classList.remove('scale-100');
        setTimeout(() => {
            modal?.classList.add('hidden');
            temporarySelectedAvatar = data.user[0].avatar+".png";
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

</script>

<!--For the reload button-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />


<div class="w-screen h-screen bg-[#141a22] flex justify-center items-center changeHeight">
    <button class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 border-b-4 border-red-700 hover:border-red-500 shadow-lg hover:shadow-red-500 rounded btnPos left-2 fixed transition-all duration-300">
        {$_(`page.profile.delete`)}
    </button>    
    <div class="w-[85vw] h-[75vh] bg-[#040d17] flex mx-auto rounded-lg shadow-2xl shadow-[#040d17] flex-col">
        <!-- Greeting and Profile Data -->
        <div class="ps-4 pe-4 pt-4 flex flex-col items-start xl:h-auto xl:overflow-visible overflow-y-auto max-h-[85vh]">
            <div class="flex items-start">
                <img src={userpng} class="w-[20px] h-auto" alt="">
                <p class="text-gray-500 ms-2 relative top-[1px]">{$_(`page.profile.greeting`)}<span class="text-white">{currentName}</span></p>
            </div>
            <!-- Scrollable Wrapper under xl -->
            <div class="mt-4 w-full h-[90%] bg-[#141a22] rounded-lg p-8 flex flex-col gap-8 overflow-y-auto scrollDesign">
                
                <!-- Avatar & Profile Stats Section -->
                <div class="flex flex-wrap xl:flex-nowrap items-start gap-8">
                    
                    <!-- Avatar Section -->
                    <div class="flex flex-col md:flex-row items-center gap-8 w-full">
                        <div class="relative w-[100px] sm:w-[120px] md:w-[150px] lg:w-[170px] flex-shrink-0">
                            <img src={currentAvatar} 
                                 alt="User Avatar" 
                                 class="w-full h-auto rounded-full border-4 border-white shadow-xl shadow-gray-500/50 hover:shadow-2xl hover:shadow-gray-500 transition-all duration-300"
                                 onmouseover="{pictureHover}"
                                 onmouseout="{pictureLeave}">

                            <button class="absolute top-[40%] left-1/2 -translate-x-1/2 -translate-y-1/2 opacity-0 hover:opacity-100 transition-opacity duration-300 bg-transparent border-0 w-10 h-10 rounded-full" id="picChangebtn"
                                    onclick={openModal}>
                                <img src="{useredit}" alt="">
                            </button>

                            <div class="mt-4 text-center">
                                <p class="text-yellow-600 text-xl max-sm:text-lg inline">
                                    <img src="{chip}" alt="Chip Icon" class="w-[20px] inline pb-1">{data.user[0].balance}
                                </p>
                            </div>
                        </div>

                        <!-- Scrollable Profile Stats Section -->
                        <div class="flex-1 w-full">
                            <div class="grid grid-cols-1 lg:grid-cols-2 xl:grid-cols-3 gap-4">
                                <div class="bg-[#040d17] drop-shadow-lg p-4 text-center rounded-lg">
                                    <img src="{flymoney}" alt="Chips Spent" class="w-[80px] mx-auto md:w-[100px]">
                                    <p class="text-gray-500 py-3 text-lg text-nowrap">{$_(`page.profile.spent`)}</p>
                                    <p class="inline text-yellow-600 text-lg text-nowrap">
                                        <img src="{chip}" alt="Chip Icon" class="w-[20px] inline pb-1">
                                        {chipsSpent*-1}
                                    </p>
                                </div>

                                <div class="bg-[#040d17] drop-shadow-lg p-4 text-center rounded-lg">
                                    <img src="{income}" alt="Chips Earned" class="w-[80px] mx-auto md:w-[100px]">
                                    <p class="text-gray-500 py-3 text-lg text-nowrap">{$_(`page.profile.gained`)}</p>
                                    <p class="inline text-yellow-600 text-lg text-nowrap">
                                        <img src="{chip}" alt="Chip Icon" class="w-[20px] inline pb-1">
                                        {chipsEarned}
                                    </p>
                                </div>

                                <div class="bg-[#040d17] drop-shadow-lg p-4 text-center rounded-lg">
                                    <img src="{joystick}" alt="Last Game Played" class="w-[80px] mx-auto md:w-[100px]">
                                    <p class="text-gray-500 py-3 text-lg text-nowrap">{$_(`page.profile.played`)}</p>
                                    <p class="text-pink-600 text-lg text-nowrap">
                                        {#if data.lastPlayed.length == 0}
                                            None
                                            {:else}
                                            {data.lastPlayed[0].name}
                                        {/if}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Table and Buttons Section -->
                <div class="w-full text-gray-500">
                    <div class="flex">
                        {#each data.games as game}
                            <button class="p-3 border border-gray-500 border-b-0 rounded-t-lg hover:bg-[#040d17]"
                                    onclick={() => selectGame(game.gameid)}>
                                {game.name}
                            </button>
                        {/each}
                    </div>

                    <!-- Table Wrapper -->
                    <div class="w-full overflow-auto scrollDesign
                                max-h-[30vh] sm:max-h-[40vh] md:max-h-[50vh] lg:max-h-[300px]">
                        {#if selectedGame}
                            <div class="w-full">
                                <table class="w-full border border-gray-700">
                                    <thead>
                                        <tr class="bg-[#040d17] text-white">
                                            {#each Object.keys(data.transaction[0]) as key}
                                                {#if key != "gameid"}
                                                    <th class="p-2 border border-gray-600">{$_(`page.profile.table.${key}`)}</th>
                                                {/if}
                                            {/each}
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {#each data.transaction as row}
                                            {#if row.gameid == selectedGame}                                             
                                                <tr class="text-center">
                                                    {#each Object.entries(row) as [key, value]}
                                                        {#if key != "gameid"}
                                                            <td class="p-2 border border-gray-600">{value}</td>
                                                        {/if}
                                                    {/each}
                                                </tr>
                                            {/if}
                                        {/each}
                                    </tbody>
                                </table>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>                                    
        </div>
    </div>
</div>

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
               bind:clicked={langClicked}/> 



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
        {#each avatarsAll[data.user[0].gender] as avatar, index}
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
          bind:value={avatarsAll[data.user[0].gender][selectedAvatarIndex]}
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





<style>
    @media (max-width: 768px) { /* md breakpoint in Tailwind */
        .changeHeight {
            height: calc(100vh - 96px) !important;
        }
        .btnPos{
            top: calc(104px) !important;
        }
    }
    @media (min-width: 768px) { /* md breakpoint in Tailwind */
        .changeHeight {
            height: calc(100vh - 88px) !important;
        }
        .btnPos{
            top: calc(96px) !important;
        }
    }

    .scrollDesign::-webkit-scrollbar{
      width: 0.5rem;
    }

    .scrollDesign::-webkit-scrollbar-track{
      background: #040d17;
      border-radius: 5px;
    }

    .scrollDesign::-webkit-scrollbar-thumb{
      border-radius: 5px;
    }
    .scrollDesign::-webkit-scrollbar-thumb{
      background-color: #6b7280;
    }
</style>