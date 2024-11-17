<script lang=ts>
    import banner from "$lib/media/videos/banner.mp4";
    import frenchcards from "$lib/frenchcards";

    let cardImages = shuffle(frenchcards),
        modal = $state(true);

    function shuffle(array: string[]) {
        let currentIndex = array.length;
        while (currentIndex != 0) {
            let randomIndex = Math.floor(Math.random() * currentIndex);
            currentIndex--;
            [array[currentIndex], array[randomIndex]] = [array[randomIndex], array[currentIndex]];
        }
        return array;
    }




    $effect(() => {

    })
    
</script>

<header class="w-[1440px] xl:w-screen ">
    <div class="relative text-center">
        <video  src={banner} autoplay muted loop class=" blur-sm drop-shadow-none sepia-0">
        </video>
        <div class="overlay w-screen absolute top-0 left-0 px-20 ">
            <!--<p class="text-xl text-yellow-600">Welcome to Betropolis — your ultimate online destination for thrilling casino games and endless entertainment! Step into a world where the excitement never stops, and every spin, card flip, and roll of the dice brings you closer to unforgettable winnings. At Betropolis, we combine top-tier games, cutting-edge security, and seamless gameplay to create a premium online casino experience.</p>-->
        </div>
    </div>

</header>
<div class="grid grid-cols-1">
    <table class="text-yellow-600 text-center border-separate [border-spacing:0.75rem] select-none border-spacing-2">
        <thead>
            <tr>
                <td colspan=5 class="text-xl drop-shadow-[0_1.2px_1.2px_rgba(0,0,0,0.8)]">
                    Choose a card for chance for a free starting bonus!
                </td>
            </tr>
        </thead>
        <tbody class="text-center max-sm:justify-center">
            
        </tbody>
    </table>
    <div id="prize" tabindex="-1" aria-hidden="true" class="backdrop-blur-md hidden overflow-y-auto overflow-x-hidden fixed inset-0 mx-auto justify-center items-center w-full h-[calc(100%-1rem)] max-h-full">
        <div class="relative p-4 w-full max-w-2xl max-h-full mx-auto top-1/4">
            <!-- Modal content -->
            <div class="relative bg-black rounded-lg shadow">
                <!-- Modal header -->
                <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t border-yellow-600">
                    <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
                        Nyertél!
                    </h3>
                    <button id="cancel" type="button" class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white">
                        <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                        </svg>
                        <span class="sr-only">Close modal</span>
                    </button>
                </div>
                <!-- Modal body -->
                <div class="p-4 md:p-5 space-y-4">
                    <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
                        With less than a month to go before the European Union enacts new consumer privacy laws for its citizens, companies around the world are updating their terms of service agreements to comply.
                    </p>
                    <table>
                        <tbody>
                            <tr class="">
                                <td class="modalImg"></td>
                                <td class="modalImg"></td>
                                <td class="modalImg"></td>
                                <td class="modalImg"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!-- Modal footer -->
                <div class="flex items-center justify-center p-4 md:p-5 border-t border-gray-200 rounded-b dark:border-yellow-600">
                    <a href="/signup" type="button" class="bg-yellow-600 hover:shadow-lg hover:shadow-yellow-600 hover:ring-2 hover:ring-black font-medium rounded-lg text-sm px-5 py-2.5 text-center">Claim now!</a>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="mx-5">
    <h1 class="text-yellow-600 text-center text-xl">Choose a card for a free extra starting bonus!</h1>
    <div class="ledBorder grid grid-cols-4 max-md:grid-cols-2 mx-5 gap-2 p-2 rounded-3xl">
        {#each cardImages as img}
            <button onclick={() => modal = !modal} class="border flex items-center justify-center rounded-3xl bg-white hover:duration-[150ms] ease-in-out hover:scale-[1.07] hover:shadow-xl hover:shadow-black">
                <img src={img} alt="" class="h-1/2">
            </button>
        {/each}
    </div>
</div>

<div class:hidden={modal} class="relative z-10" aria-labelledby="modal-title" role="dialog" aria-modal="true">

    <div class="fixed inset-0 bg-black/90 transition-opacity" aria-hidden="true"></div>
    
    <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
        <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">
            <div class="relative transform overflow-hidden rounded-lg bg-black text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg">
                <div class="px-4 pb-4 pt-5 sm:p-6 sm:pb-4">
                    <div class="sm:flex sm:items-start">
                        <div class="mt-3 text-center sm:ml-4 sm:mt-0 sm:text-left w-full">
                            <h3 class="font-semibold text-center text-yellow-600 text-2xl" id="modal-title">Claim your extra starting bonus!</h3>
                            <div class="mt-2">
                                <p class="text-sm text-gray-500"></p>
                            </div>
                            <div>
                                <input id="bonusemail" type="email" placeholder="example@example.com" class="shadow appearance-none border-2 border-yellow-600 rounded w-full py-2 px-3 placeholder:text-yellow-600 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="border-t-yellow-600 border-t px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6 justify-center">
                    <button type="button" class="inline-flex w-full justify-center rounded-md bg-red-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-red-500 sm:ml-3 sm:w-auto">Deactivate</button>
                    <button onclick={() => modal = !modal} type="button" class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</div>
    
    


<style>
    :global(body){
        overflow-x: hidden;
    }

    td{
        height: 60px;
    }
</style>
