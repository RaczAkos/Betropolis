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
        email = $state("");

    function shuffle(array: string[]) {
        let currentIndex = array.length;
        while (currentIndex != 0) {
            let randomIndex = Math.floor(Math.random() * currentIndex);
            currentIndex--;
            [array[currentIndex], array[randomIndex]] = [array[randomIndex], array[currentIndex]];
        }
        return array;
    }

    async function bonus() {
        if (/^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$/.test(email)) {
            alert("jó");
            const res = fetch('/api/bonus', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ email })
            });
            const alma = (await res).json();
            console.log(alma)
        } else {
            goodEmail = false;
        }
    }
    
</script>


<header class="w-[1440px] xl:w-screen">
    <div class="relative text-center">
        <video poster="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" 
               src={banner} 
               autoplay muted loop 
               class=" blur-sm drop-shadow-none sepia-0 poster">
        </video>
        <!--<p>Welcome to Betropolis — your ultimate online destination for thrilling casino games and endless entertainment! Step into a world where the excitement never stops, and every spin, card flip, and roll of the dice brings you closer to unforgettable winnings. At Betropolis, we combine top-tier games, cutting-edge security, and seamless gameplay to create a premium online casino experience.</p>-->
    </div>

</header>
<!--Carousel-->
<div class="relative w-full max-w-2xl mx-auto overflow-hidden my-[50px]">
    <div bind:this={slides} class="flex transition-transform duration-500">
      <div class="w-full flex-shrink-0"><img src="{images[0]}" class="w-full rounded-lg" /></div>
      <div class="w-full flex-shrink-0"><img src="{images[0]}" class="w-full rounded-lg" /></div>
      <div class="w-full flex-shrink-0"><img src="{images[0]}" class="w-full rounded-lg" /></div>
    </div>
</div>


<!-- Bonus Game -->
<div class="flex justify-center mt-3 borgens text-3xl text-yellow-600 text-center max-sm:text-2xl">
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
<div class:hidden={!modal} class="relative z-10" aria-labelledby="modal-title" role="dialog" aria-modal="true">

    <div class="fixed inset-0 bg-black/90 transition-opacity" aria-hidden="true"></div>
    
    <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
        <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">

            <div class="relative transform overflow-hidden bg-black text-left border border-yellow-600 transition-all sm:my-8 sm:w-full sm:max-w-2xl mx-2 rounded-3xl">
                <div class="px-4 pb-4 pt-5 sm:p-6 sm:pb-4">
                    <div class="sm:flex sm:items-start">
                        <h3 class="font-semibold text-center text-yellow-600 text-4xl border-b" id="modal-title">Claim your extra starting bonus!</h3>
                        <div class="mt-3 text-center sm:ml-4 sm:mt-0 sm:text-left w-full">
                            <div class="my-2">
                                <p class="text-md text-yellow-600 text-justify px-4">
                                    Please enter the e-mail you want your bonus to be connected to. You will automaticly get that bonus when you sign up with that e-mail.
                                </p>
                            </div>
                            <input id="bonusemail" bind:value={email} type="email" placeholder="example@example.com" class="shadow appearance-none border-2 border-yellow-600 rounded w-full py-2 px-3 placeholder:text-yellow-600/50 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black">
                            <p class:hidden={goodEmail}>Please enter a valid e-mail address.</p>
                        </div>
                    </div>
                </div>
                <div class="border-t-yellow-600 border-t my-1 px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6 justify-center">
                    <button onclick={() => bonus()} type="button" class="text-white">Claim!</button>
                    <button onclick={() => modal = !modal} type="button" class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto">Close</button>
                </div>
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
</style>
