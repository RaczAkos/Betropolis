<!-- Title and Description of the Page -->
<svelte:head>
    <title>Welcome to Betropolis Casino!</title>
    <meta name="description" content="Welcome to Betropolis — your ultimate online destination for thrilling casino games and endless entertainment! Step into a world where the excitement never stops, and every spin, card flip, and roll of the dice brings you closer to unforgettable winnings. At Betropolis, we combine top-tier games, cutting-edge security, and seamless gameplay to create a premium online casino experience." />
</svelte:head>

<script lang=ts>
    import banner from "$lib/media/videos/banner.mp4";
    import frenchcards from "$lib/frenchcards";
    import images from "$lib/hubgames";
    import { onMount } from "svelte";
    import Input from "$lib/components/Input.svelte";

    let index = 0;
    let slides:any;

    onMount(() => {
        setInterval(() => {
        if (slides) {
            index = (index + 1) % 3;
            slides.style.transform = `translateX(-${index * 100}%)`;
        }
        }, 3000);
    });

    let cardImages = shuffle(frenchcards),
        modal = $state(false),
        goodEmail = $state(true),
        returnedBonus = $state(false),
        email = $state(""),
        bonus:any = $state({title:"", message:""});

    // Array shuffle
    function shuffle(array: string[]) {
        let currentIndex = array.length;
        while (currentIndex != 0) {
            let randomIndex = Math.floor(Math.random() * currentIndex);
            currentIndex--;
            [array[currentIndex], array[randomIndex]] = [array[randomIndex], array[currentIndex]];
        }
        return array;
    }

    // Bonus Game
    async function bonusGame() {
        // Checking email format
        if (/^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$/.test(email)) {
            const res = await fetch('/api/bonus', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ email })
            }).then (res => res.json());
            bonus = {
                title: res.title,
                message: res.message
            }
            returnedBonus = true;
            goodEmail = true;
            email = "";
        } else goodEmail = false;
    }
</script>


<header class="w-auto xl:w-screen">
    <div class="relative">
        <video poster="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" 
               src={banner} 
               autoplay muted loop 
               class=" blur-[7px] drop-shadow-none sepia-0 poster"
               preload='auto'>
        </video>
        <div class="absolute bottom-0 left-0 right-0 top-0 max-md:top-5 flex justify-center items-center text-center w-full">
            <div class="text-yellow-600 text-4xl max-sm:text-2xl flex justify-center textShadow">
                <h1 class="">
                    Welcome to Betropolis!
                </h1>
            </div>        
        </div>
    </div>
</header>
<div class="goldenbg">
    <div class="relative w-full max-w-[1400px] mx-auto flex flex-wrap md:flex-nowrap items-center py-[50px] text-yellow-600 text-xl text-center max-sm:text-sm borgens">
        <div class="md:w-3/4 text-center justify-items-center flex justify-center p-5">
            <p class="border-yellow-600 border-y pt-5 pb-5 rounded-xl max-md:w-3/4 max-sm:px-3 textShadow text-justify px-3 max-sm:w-full">
                Your ultimate online destination for thrilling casino games and endless entertainment! Step into a world where the excitement never stops, and every spin, card flip, and roll of the dice brings you closer to unforgettable winnings. At Betropolis, we combine top-tier games, cutting-edge security, and seamless gameplay to create a premium online casino experience.
            </p>
        </div>
        
        <!-- Carousel -->
        <div class="md:w-[1000px] overflow-hidden m-1">
            <div bind:this={slides} class="flex transition-transform duration-500">
                <div class="w-full flex-shrink-0"><img src="{images[0]}" class="w-full rounded-lg" alt="img"/></div>
                <div class="w-full flex-shrink-0"><img src="{images[1]}" class="w-full rounded-lg" alt="img"/></div>
                <div class="w-full flex-shrink-0"><img src="{images[2]}" class="w-full rounded-lg" alt="img"/></div>
            </div>
        </div>
    </div>
</div>


<!-- Bonus Game -->
<div class="flex justify-center mt-9 borgens text-3xl text-yellow-600 text-center max-sm:text-2xl">
    <div class="mx-5 lg:basis-2/3">
        <h2 class="select-none">Choose a card for a free extra starting bonus!</h2>
        <div class="ledBorder grid grid-cols-4 max-md:grid-cols-2 mx-5 my-2 gap-2 p-2 rounded-3xl">
            {#each cardImages as img}
            <button onclick={() => modal = !modal} class="border flex items-center justify-center rounded-3xl bg-gray-300 hover:duration-[150ms] ease-in-out hover:scale-[1.07] hover:shadow-xl hover:shadow-black">
                <img src={img} alt="Card" class="h-1/2">
            </button>
            {/each}
        </div>
        <h2 class="select-none">Already claimed the bonus? <a href="/sign-up" class="hover:underline">Sign up!</a></h2>
    </div>
</div>

<!-- Bonus Game Modal -->
<div class={`relative z-10 transition-opacity duration-500 ${modal ? 'opacity-100' : 'opacity-0 pointer-events-none'}`} aria-labelledby="modal-title" role="dialog" aria-modal="true">
    <div class="fixed inset-0 bg-black/90 modalbg" aria-hidden="true"></div>
    <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
        <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">
            <div class="!w-[400px] relative transform overflow-hidden bg-black text-left border border-yellow-600 transition-all sm:my-8 sm:w-full sm:max-w-2xl mx-2 rounded-3xl">
                {#if !returnedBonus}
                <div class="px-4 pt-4">
                    <h3 class="font-semibold text-center text-yellow-600 text-4xl borgens">Claim your extra starting bonus!</h3>
                    <div class="mt-3 text-center sm:mt-0 sm:text-left">
                        <div class="my-2">
                            <p class="text-md text-yellow-600 text-justify">
                                Please enter the e-mail you want your bonus to be connected to. You will automaticly get that bonus when you sign up with that e-mail.
                            </p>
                        </div>
                        <Input id="bonusemail" 
                               bind:value={email} 
                               type="email" 
                               placeholder="example@example.com"/>
                        <p class:invisible={goodEmail} class="text-red-600 text-center m-1">Please enter a valid e-mail address.</p>
                    </div>
                </div>
                <div class="border-t-yellow-600 border-t my-1 px-4 py-2 sm:flex sm:flex-row-reverse sm:px-6 justify-center">
                    <button onclick={bonusGame} 
                            type="button" 
                            class="max-sm:mb-2 sm:ms-2 inline-flex w-full justify-center rounded-md bg-black p-2 text-md font-semibold text-yellow-600 border border-yellow-600 hover:bg-yellow-600 hover:text-black duration-300 sm:w-auto">
                        Claim
                    </button>
                    <button onclick={() =>{ modal = !modal; email = ""; goodEmail = true; }} 
                            type="button" 
                            class="inline-flex w-full justify-center rounded-md bg-black p-2 text-md font-semibold text-yellow-600 border border-yellow-600 hover:bg-yellow-600 hover:text-black duration-300 sm:w-auto">
                        Close
                    </button>
                </div>
                {:else}
                <div class="p-4">
                    <h3 class="font-semibold text-center text-yellow-600 text-4xl borgens">{bonus.title}</h3>
                    <div class="mt-3 text-center sm:mt-0 sm:text-left w-full">
                        <div class="my-2">
                            <p class="text-lg text-yellow-600 text-center">
                                {bonus.message}
                            </p>
                        </div>
                    </div>
                </div>
                <div class="border-t-yellow-600 border-t my-1 px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6 justify-center">
                    <button onclick={() =>{ modal = !modal; bonus = {}; returnedBonus = false; goodEmail = true }} 
                        type="button" 
                        class="inline-flex w-full justify-center rounded-md bg-black p-2 text-md font-semibold text-yellow-600 border border-yellow-600 hover:bg-yellow-600 hover:text-black duration-300 sm:w-auto">
                        Close
                    </button>
                </div>
                {/if}
            </div>
        </div>
    </div>

    
</div>

<style>
    :global(body){
        overflow-x: hidden;
    }
    
    .poster {
        background-image: url("$lib/media/images/poster.png");
        background-position: cover;
        background-position: center;
    }
    .goldenbg{
        background-image: linear-gradient(to bottom, #000000, #30181b, #5b2926, #843e29, #a85a24, #a85a24, #a85a24, #a85a24, #843e29, #5b2926, #30181b, #000000);
    }
</style>
