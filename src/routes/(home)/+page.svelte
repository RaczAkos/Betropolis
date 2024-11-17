<svelte:head>
    <title>Welcome to Betropolis Casino!</title>
    <meta name="description" content="Welcome to Betropolis — your ultimate online destination for thrilling casino games and endless entertainment! Step into a world where the excitement never stops, and every spin, card flip, and roll of the dice brings you closer to unforgettable winnings. At Betropolis, we combine top-tier games, cutting-edge security, and seamless gameplay to create a premium online casino experience." />
</svelte:head>

<script lang=ts>
    import banner from "$lib/media/videos/banner.mp4";
    import frenchcards from "$lib/frenchcards";

    let cardImages = shuffle(frenchcards),
        modal = $state(false),
        goodEmail = $state(false);

    function shuffle(array: string[]) {
        let currentIndex = array.length;
        while (currentIndex != 0) {
            let randomIndex = Math.floor(Math.random() * currentIndex);
            currentIndex--;
            [array[currentIndex], array[randomIndex]] = [array[randomIndex], array[currentIndex]];
        }
        return array;
    }
    
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

<div class="flex justify-center mt-3">
    <div class="mx-5 lg:basis-2/3">
        <h2 class="text-yellow-600 text-center text-xl">Choose a card for a free extra starting bonus!</h2>
        <div class="ledBorder grid grid-cols-4 max-md:grid-cols-2 mx-5 gap-2 p-2 rounded-3xl">
            {#each cardImages as img}
            <button onclick={() => modal = !modal} class="border flex items-center justify-center rounded-3xl bg-gray-300 hover:duration-[150ms] ease-in-out hover:scale-[1.07] hover:shadow-xl hover:shadow-black">
                <img src={img} alt="" class="h-1/2">
            </button>
            {/each}
        </div>
        <h2 class="text-yellow-600 text-center text-xl">Already claimed the bonus? <a href="/signup" class="hover:underline">Sign up!</a></h2>
    </div>
</div>

<div class:hidden={!modal} class="relative z-10" aria-labelledby="modal-title" role="dialog" aria-modal="true">

    <div class="fixed inset-0 bg-black/90 transition-opacity" aria-hidden="true"></div>
    
    <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
        <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">

            <form method="POST" class:hidden={goodEmail} class="relative transform overflow-hidden bg-black text-left border border-yellow-600 transition-all sm:my-8 sm:w-full sm:max-w-2xl mx-2 rounded-3xl">
                <div class="px-4 pb-4 pt-5 sm:p-6 sm:pb-4">
                    <div class="sm:flex sm:items-start">
                        <h3 class="font-semibold text-center text-yellow-600 text-4xl border-b" id="modal-title">Claim your extra starting bonus!</h3>
                        <div class="mt-3 text-center sm:ml-4 sm:mt-0 sm:text-left w-full">
                            <div class="my-2">
                                <p class="text-md text-yellow-600 text-justify px-4">
                                    Please enter the e-mail you want your bonus to be connected to. You will automaticly get that bonus when you sign up with that e-mail.
                                </p>
                            </div>
                            <input required id="bonusemail" type="email" placeholder="example@example.com" class="shadow appearance-none border-2 border-yellow-600 rounded w-full py-2 px-3 placeholder:text-yellow-600/50 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black">
                        </div>
                    </div>
                </div>
                <div class="border-t-yellow-600 border-t my-1 px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6 justify-center">
                    <button type="submit" onsubmit={(e) => {e.preventDefault();goodEmail = true}} class="inline-flex w-full justify-center rounded-md bg-yellow-600 disabled:bg-yellow-600/70 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-red-500 sm:ml-3 sm:w-auto">Claim!</button>
                    <button onclick={() => modal = !modal} type="button" class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto">Close</button>
                </div>
            </form>

            <div class:hidden={!goodEmail} class="relative transform overflow-hidden rounded-lg bg-black text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-2xl mx-2">
                <div class="px-4 pb-4 pt-5 sm:p-6 sm:pb-4">
                    <div class="sm:flex sm:items-start">
                        <div class="mt-3 text-center sm:ml-4 sm:mt-0 sm:text-left w-full">
                            <h3 class="font-semibold text-center text-yellow-600 text-4xl" id="modal-title">Claim your extra starting bonus!</h3>
                            <div class="my-2">
                                <p class="text-md text-yellow-600 text-justify px-4">
                                    Please enter the e-mail you want your bonus to be connected to. You will automaticly get that bonus when you sign up with that e-mail.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="border-t-yellow-600 border-t px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6 justify-center">
                    <button onclick={() => {modal = !modal; goodEmail = true;}} type="button" class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto">Close</button>
                </div>
            </div>
        </div>
    </div>

    
</div>

<style>
    :global(body){
        overflow-x: hidden;
    }
</style>
