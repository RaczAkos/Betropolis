
<script lang="ts">
    import userpng from "$lib/media/images/profile/user.png";
    import flymoney from "$lib/media/images/profile/flying-money.png";
    import income from "$lib/media/images/profile/income.png";
    import joystick from "$lib/media/images/profile/joystick.png";
    import chip from "$lib/media/images/chip.png";
    import { onMount } from "svelte";

    let { data } = $props();

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
</script>
<!--For the reload button-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />


<div class="w-screen h-screen bg-[#141a22] flex justify-center items-center changeHeight">    
    <div class="w-[85vw] h-[75vh] bg-[#040d17] flex mx-auto rounded-lg shadow-2xl shadow-[#040d17] flex-col">
        <!-- Greeting and Profile Data -->
        <div class="ps-4 pe-4 pt-4 flex flex-col items-start xl:h-auto xl:overflow-visible overflow-y-auto max-h-[85vh]">
            <div class="flex items-start">
                <img src={userpng} class="w-[20px] h-auto" alt="">
                <p class="text-gray-500 ms-2 relative top-[1px]">Welcome, <span class="text-white">{data.user[0].username}</span></p>
            </div>
            <!-- Scrollable Wrapper under xl -->
            <div class="mt-4 w-full h-[90%] xl:h-[95%] bg-[#141a22] rounded-lg p-8 flex flex-col gap-8 overflow-y-auto scrollDesign">
                
                <!-- Avatar & Profile Stats Section -->
                <div class="flex flex-wrap xl:flex-nowrap items-start gap-8">
                    
                    <!-- Avatar Section -->
                    <div class="flex flex-col md:flex-row items-center gap-8 w-full">
                        <div class="relative w-[100px] sm:w-[120px] md:w-[150px] lg:w-[170px] flex-shrink-0">
                            <img src={data.user[0].avatar+".png"} 
                                 alt="User Avatar" 
                                 class="w-full h-auto rounded-full border-4 border-white shadow-xl shadow-gray-500/50 hover:shadow-2xl hover:shadow-gray-700/50 transition-all duration-300"
                                 onmouseover="{pictureHover}"
                                 onmouseout="{pictureLeave}">

                            <button class="absolute top-[45%] left-1/2 -translate-x-1/2 -translate-y-1/2 opacity-0 hover:opacity-100 transition-opacity duration-300 bg-transparent border-0 p-0 w-10 h-10 rounded-full" id="picChangebtn">
                                <i class="fas fa-sync-alt text-white text-3xl"></i>
                            </button>

                            <div class="mt-4 text-center">
                                <p class="text-yellow-600 text-xl max-sm:text-lg inline">
                                    <img src="{chip}" alt="Chip Icon" class="w-[20px] inline">{data.user[0].balance}
                                </p>
                            </div>
                        </div>

                        <!-- Scrollable Profile Stats Section -->
                        <div class="flex-1 w-full">
                            <div class="grid grid-cols-1 lg:grid-cols-2 xl:grid-cols-3 gap-4">
                                <div class="bg-[#040d17] drop-shadow-lg p-4 text-center rounded-lg">
                                    <img src="{flymoney}" alt="Chips Spent" class="w-[80px] mx-auto md:w-[100px]">
                                    <p class="text-gray-500 py-3 text-lg text-nowrap">Chips Spent</p>
                                    <p class="inline text-yellow-600 text-lg text-nowrap">
                                        <img src="{chip}" alt="Chip Icon" class="w-[20px] inline pb-1">
                                        {chipsSpent*-1}
                                    </p>
                                </div>

                                <div class="bg-[#040d17] drop-shadow-lg p-4 text-center rounded-lg">
                                    <img src="{income}" alt="Chips Earned" class="w-[80px] mx-auto md:w-[100px]">
                                    <p class="text-gray-500 py-3 text-lg text-nowrap">Chips Earned</p>
                                    <p class="inline text-yellow-600 text-lg text-nowrap">
                                        <img src="{chip}" alt="Chip Icon" class="w-[20px] inline pb-1">
                                        {chipsEarned}
                                    </p>
                                </div>

                                <div class="bg-[#040d17] drop-shadow-lg p-4 text-center rounded-lg">
                                    <img src="{joystick}" alt="Last Game Played" class="w-[80px] mx-auto md:w-[100px]">
                                    <p class="text-gray-500 py-3 text-lg text-nowrap">Last Game Played</p>
                                    <p class="text-pink-600 text-lg text-nowrap">{data.lastPlayed[0].name}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Table and Buttons Section -->
                <div class="w-full text-gray-500">
                    <div class="flex gap-4 mb-4">
                        {#each data.games as game}
                        <button class="" onclick={() => selectGame(game.gameid)}>
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
                                                <th class="p-2 border border-gray-600">{key}</th>
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






<style>
    @media (max-width: 768px) { /* md breakpoint in Tailwind */
        .changeHeight {
            height: calc(100vh - 96px) !important;
        }
    }
    @media (min-width: 768px) { /* md breakpoint in Tailwind */
        .changeHeight {
            height: calc(100vh - 88px) !important;
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