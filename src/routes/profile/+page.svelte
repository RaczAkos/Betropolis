<svelte:head>
  <title>{$_("page.profile.my")} - Betropolis</title>
</svelte:head>

<script lang="ts">
    import { _ } from "svelte-i18n";

    let { data } = $props(),
        chipsSpent: number  = $state(calculateChips(0)), 
        chipsEarned: number = $state(calculateChips(1)),
        fields = [
          { // Avatar and balance
            avatar: true, 
            text: "games.balance", 
            content: data.user[0].balance, 
            chips: true 
          },
          { // Balance spent
            avatar: false, 
            text: "page.profile.spent", 
            img: "/src/lib/media/images/profile/flying-money.png", 
            content: chipsSpent * -1, 
            chips: true 
          },
          { // Balance earned
            avatar: false, 
            text: "page.profile.gained", 
            img: "/src/lib/media/images/profile/income.png", 
            content: chipsEarned, 
            chips: true 
          },
          { // Last game played
            avatar: false, 
            text: "page.profile.played", 
            img: "/src/lib/media/images/profile/joystick.png", 
            chips: false 
          },
        ],
        selectedGame: number | null = $state((data.lastPlayed.length != 0) ? data.lastPlayed[0].gameid : null);

    let fadeOutTable = $state(false);

    function handleButtonClick(gameid: any) {
      fadeOutTable = true;

      // Wait for the fade-out animation to complete before changing the selected game
      setTimeout(() => {
        selectedGame = gameid;
        fadeOutTable = false;
      }, 500);
    }

    // Calculating total earned and lost chips
    function calculateChips(type: number): number {
      let chips: number = 0;
      for (let index = 0; index < data.transaction.length; index++) {
        if (type ? data.transaction[index].gain > 0 : data.transaction[index].gain < 0) chips += data.transaction[index].gain;
      }
      return chips;
    }

    /*

    let username = $state(""),
        email = $state(""),
        langClicked:boolean = $state(false),
        currentEmail = $state(data.user[0].email),
        currentName = $state(data.user[0].username),
        currentAvatar = $state(data.user[0].avatar+".png"),
        currentLang = $state(browser ? window.navigator.language : "en"),
        //lang= $state(currentLang),
        showModal = $state(false),
        selectedAvatarIndex = $state(-1),
        temporarySelectedAvatar = $state(data.user[0].avatar+".png"),
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

    
    function pictureHover() {
        let picture = document.getElementById('picChangebtn');
        picture?.classList.add('opacity-100');
    }

    function pictureLeave() {
        let picture = document.getElementById('picChangebtn');
        picture?.classList.remove('opacity-100');
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
    
    function deleteUser() {
        deleteCharacter();
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
  */
</script>

<!-- Collected content
<button class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 border-b-4 border-red-700 hover:border-red-500 shadow-lg hover:shadow-red-500 rounded btnPos left-2 fixed transition-all duration-300"
            onclick={deleteUser}>
        {$_(`page.profile.delete`)}
    </button>  

    <div class="shadow-[0_450px_2000px_30px] {!field.chips ? "!shadow-pink-600": "shadow-[#ff9011]"} {field.avatar ? "!shadow-white": "shadow-[#ff9011]"} -z-2">
-->


      


<div class="mt-2 w-full h-full bg-[#141a22] rounded-lg p-8 flex flex-col gap-8 overflow-y-auto scrollDesign">
  <div class="flex flex-wrap xl:flex-nowrap items-start gap-8">
    <div class="flex-1">
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        {#each fields as field}
          <div class="rounded-lg !shadow-3xl -z-1 {!field.chips ? "!shadow-pink-600": ""} {field.avatar ? "!shadow-white": ""} {field.chips && !field.avatar ? "!shadow-[#ff9011] ": ""}">
            <div class="bg-[#040d17] drop-shadow-lg p-4 text-center rounded-lg border-2 border-gray-600/30">
              {#if !field.avatar}
                <img src={field.img} alt={field.text} class="w-28 mx-auto md:w-32 lg:w-40">
              {:else}
                <img src={data.user[0].avatar + ".png"} alt="avatar" class="w-28 mx-auto md:w-32 lg:w-40 rounded-full border-4 border-white shadow-xl shadow-gray-300">
              {/if}
              <p class="text-gray-500 py-3 text-lg text-nowrap">{$_(field.text)}</p>
              <p class="inline { field.chips ? "text-yellow-600": "text-pink-600"} text-lg text-nowrap">
                {#if field.chips}
                  <img src="/src/lib/media/images/chip.png" alt="chip" class="w-[20px] inline pb-1">{field.content}
                {:else}
                  {#if data.lastPlayed.length == 0}
                    {$_("page.profile.noGame")}
                  {:else}
                    {data.lastPlayed[0].name}
                  {/if}
                {/if}
              </p>
            </div>
          </div>
        {/each}
      </div>
    </div>
  </div>
  <div class="w-full h-full text-[#040d17]">
    <div class="flex ps-4">
      {#each data.games as game}
        <button class="p-3 border-2 sm:min-w-24 border-[#040d17] font-bold hover:border-white hover:text-white border-b-0 rounded-t-lg hover:bg-[#040d17] mx-1 hover:-translate-y-1 hover:scale-[120%] duration-200 {selectedGame == game.gameid ? "!text-white scale-[120%] bg-[#040d17] !border-white -translate-y-1 !mx-4" : ""}"
                class:!text-white={selectedGame == game.gameid}
                onclick={() => handleButtonClick(game.gameid)}>
          {game.name}
        </button>
      {/each}
    </div>
    <div class="w-full overflow-auto scrollDesign max-h-[30vh] sm:max-h-[40vh] md:max-h-[40vh] bg-[#040d17] shadow-2xl shadow-white">
      {#if selectedGame}
        <div class="w-full">
          <table class="w-full border-2 border-gray-700 {fadeOutTable ? 'table-fade-out' : ''} table-animate" id="tableanimate">
            <thead>
              <tr class="text-white">
                {#each Object.keys(data.transaction[0]) as key}
                  {#if key != "gameid"}
                    <th class="p-2 border-2 border-white">
                      {$_(`page.profile.table.${key}`)}
                    </th>
                  {/if}
                {/each}
              </tr>
            </thead>
            <tbody>
              {#each data.transaction as row}
                {#if row.gameid == selectedGame}                                             
                  <tr class="text-center {row.gain > 0 ? "text-green-600 win" : "text-red-600 lose"}">
                    {#each Object.entries(row) as [key, value]}
                      {#if key != "gameid"}
                        <td class="p-2 border-2 border-white">
                          {value}
                        </td>
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

<style>
  @keyframes fadeIn {
    from {
      opacity: 0;
      transform: translateY(-20px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  .table-animate {
    animation: fadeIn 0.5s ease-in-out;
  }

  @keyframes fadeOut {
    from {
      opacity: 1;
      transform: translateY(0);
    }
    to {
      opacity: 0;
      transform: translateY(-20px);
    }
  }

  .table-fade-out {
    animation: fadeOut 0.5s ease-in-out;
  }

  @keyframes new-row-lose {
    from { background-color: red; }
    to { background-color: black; }
  }

  tr.lose td {
    animation: new-row-lose 0.8s;
  }

  @keyframes new-row-win {
    from { background-color: green; }
    to { background-color: black; }
  }

  tr.win td {
    animation: new-row-win 0.8s;
  }
</style>
<!-- Profile Edit Modal 
<div id="profileEditModal" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-0 opacity-0 hidden transition-opacity duration-700">
    <div class="w-[80vw] max-w-[500px] bg-[#040d17] rounded-lg shadow-2xl p-6 text-white relative transform scale-0 transition-transform duration-300  border-white shadow-2xl shadow-gray-500">
        
        <!-- Close Button 
        <button class="absolute top-3 right-3 text-gray-400 hover:text-white" onclick={closeModal}>
            &times;
        </button>

        <h2 class="text-xl font-bold text-center mb-4">{$_(`page.profile.modal.title`)}</h2>
        
        <!-- Avatar Upload 
        <div class="flex flex-col items-center mb-4">
            <div class="relative w-[120px] h-[120px]">
                <img id="avatarPreview" src="{temporarySelectedAvatar}" class="w-full h-auto rounded-full border-4 border-white shadow-xl">
                <label for="avatarUpload" class="absolute inset-0 flex items-center justify-center bg-black bg-opacity-50 rounded-full cursor-pointer hover:bg-opacity-70">
                    <span class="text-sm text-white" 
                          onclick={() => showModal = true}><i class="fas fa-sync-alt text-white text-xl"></i></span>
                </label>
            </div>
        </div>

        <!-- Username Input 
        <div class="mb-4">
            <label class="text-gray-400 block mb-1">{$_(`page.profile.modal.name`)}</label>
            <input bind:value={username} type="text" id="username" placeholder="{currentName}" class="w-full bg-[#141a22] text-white p-2 rounded border border-gray-600 focus:outline-none focus:border-yellow-500 shadow-lg focus:shadow-yellow-600">
        </div>

        <!-- Email Input 
        <div class="mb-4">
            <label class="text-gray-400 block mb-1">{$_(`page.profile.modal.email`)}</label>
            <input bind:value={email} type="email" id="email" placeholder="{currentEmail}" class="w-full bg-[#141a22] text-white p-2 rounded border border-gray-600 focus:outline-none focus:border-yellow-500 shadow-lg focus:shadow-yellow-600">
        </div>

        <!-- Password Input 
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

        <!-- Save Button 
        <div class="flex justify-center mt-4">
            <button class="bg-yellow-600 hover:bg-yellow-700 text-white font-bold py-2 px-6 rounded-lg transition-all duration-300" onclick={saveChanges}>
                {$_(`page.profile.modal.save`)}
            </button>
        </div>
    </div>
</div>-->



<!-- Modal 
{#if showModal}
  <div
    class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
    transition:fade
    onclick={() => showModal = false}
  >
    <!-- Modal content box 
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
{/if}-->
