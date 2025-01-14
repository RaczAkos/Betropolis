<svelte:head>
    <title>Fruit Frenzy Classic! - Betropolis</title>
</svelte:head>

<script lang="ts">
    import icons from "$lib/classicfruits";
    import chip from "$lib/media/images/chip.png";
    import line from "$lib/media/images/line.png";

    let balance = $state(10000);
    let slot1:string = icons[giveRandom(icons.slice(0,6))],
        slot2:string = icons[giveRandom(icons.slice(0,6))],
        slot3:string = icons[giveRandom(icons.slice(0,6))],
        goldenicons:string[] = icons.slice(7,14),
        feedback:string = $state("Start spinning!"), 
        bet:number = $state(1),
        autorun:boolean = $state(false),
        spinning:boolean = $state(false),
        modal:boolean = $state(false);

    // Return random index
    function giveRandom(array:string[]) { return Math.floor(Math.random() * array.length); }

    function spin() {

        let gold1:string[] = [], 
            gold2:string[] = [], 
            gold3:string[] = [], 
            fruits1 = icons.slice(0,7), 
            fruits2 = icons.slice(0,7), 
            fruits3 = icons.slice(0,7);

        for (let i = 0; i < 3; i++) {
            let temp = 0, element = Math.random();
            
            if (element >= 0.5 && element < 0.8) temp = 1;
            else if (element > 0.8 && element < 0.95) temp = 2;
            else if (element >= 0.95) temp = 3;

            if (temp != 0) {
                for (let j = 0; j < temp; j++) {
                    if (i == 0) gold1.push(goldenicons[giveRandom(goldenicons)]);
                    else if (i == 1) gold2.push(goldenicons[giveRandom(goldenicons)]);
                    else gold3.push(goldenicons[giveRandom(goldenicons)]);
                }
            }
        }

        fruits1 = fruits1.concat(gold1);
        fruits2 = fruits2.concat(gold2);
        fruits3 = fruits3.concat(gold3);
        
        balance -= bet;
        feedback = "Spinning!";
        spinning = true;

        let index1: number = giveRandom(fruits1),
            spin1:any = document.getElementById("spin1"),
            index2: number = giveRandom(fruits2),
            spin2:any = document.getElementById("spin2"),
            index3: number = giveRandom(fruits3),
            spin3:any = document.getElementById("spin3"),
            i1 = 50, i2 = 50, i3 = 50,
            fruits:string[] = [];

        // First reel spin
        goldbar(gold1, 1);
        let int1 = setInterval(() => {
            if (index1 == fruits1.length-1) index1 = 0;
            else index1++;

            let img: HTMLImageElement = document.createElement("img");
            img.id = String(index1);
            img.src = fruits1[index1];

            spin1.innerHTML = '';
            spin1.append(img);
            img.classList.add("absolute", "anim");

            if (i1 == 0){
                clearInterval(int1);
                img.classList.remove("anim");
                fruits.push(fruits1[index1]);
            } 
            else i1--;
        }, 50)

        // Second reel spin
        setTimeout(() => {
            goldbar(gold2, 2);
            let int2 = setInterval(() => {
                if (index2 == fruits2.length-1) index2 = 0;
                else index2++;

                let img: HTMLImageElement = document.createElement("img");
                img.id = String(index2);
                img.src = fruits2[index2];

                spin2.innerHTML = '';
                spin2.append(img);
                img.classList.add("absolute", "anim");

                if (i2 == 0){
                    clearInterval(int2);
                    img.classList.remove("anim");
                    fruits.push(fruits2[index2]);
                } 
                else i2--;
            }, 50)
        },400)

        // Third reel spin
        setTimeout(() => {
            goldbar(gold3, 3);
            let int3 = setInterval(() => {
                if (index3 == fruits3.length-1) index3 = 0;
                else index3++;

                let img: HTMLImageElement = document.createElement("img");
                img.id = String(index3);
                img.src = fruits3[index3];

                spin3.innerHTML = '';
                spin3.append(img);
                img.classList.add("absolute", "anim");

                if (i3 == 0){
                    clearInterval(int3);
                    img.classList.remove("anim");
                    fruits.push(fruits3[index3]);
                    calculate(fruits);
                } 
                else i3--;
            }, 50)
        },800)
    }

    function calculate(fruits:string[]) {
        let fruit1:string = fruits[0].split('/')[fruits[0].split('/').length-1],
            fruit2:string = fruits[1].split('/')[fruits[1].split('/').length-1],
            fruit3:string = fruits[2].split('/')[fruits[2].split('/').length-1],
            quips:string[] = ["Not this time!", "No luck!", "Try again!", "Almost!", "Maybe next time!"],
            gain:number = 0;

        fruit1 = fruit1.replace(fruit1.substring(fruit1.length-4), "");
        fruit2 = fruit2.replace(fruit2.substring(fruit2.length-4), "");
        fruit3 = fruit3.replace(fruit3.substring(fruit3.length-4), "");
        
        feedback = "";

        // Reward logic here
        
        feedback = quips[giveRandom(quips)];

        // transaction

        balance += gain;
        console.log(`Spin: ${fruit1} + ${fruit2} + ${fruit3}`)

        setTimeout(() => {if (autorun && balance !> 1){spin()} else {spinning = false; if (autorun) autorun = false}}, 700)
    }

    // Goldbar
    function goldbar(array:string[], i:number){
        let goldreels:any = document.getElementsByClassName(`goldreel${i}`);
        
        // Goldreel 1
        goldreels[0].src = (array.length >= 1)? array[0]:line;
        goldreels[0].classList.add("goldpulse");
        setTimeout(() => {
            goldreels[0].classList.remove("goldpulse");
        }, 400)

        // Goldreel 2
        setTimeout(() => {
            goldreels[1].src = (array.length >= 2)? array[1]:line;;
            goldreels[1].classList.add("goldpulse");
        }, 100)
        setTimeout(() => {
            goldreels[1].classList.remove("goldpulse");
        }, 500)

        // Goldreel 3
        setTimeout(() => {
            goldreels[2].src = (array.length >= 3)? array[2]:line;;
            goldreels[2].classList.add("goldpulse");
        }, 200)
        setTimeout(() => {
            goldreels[2].classList.remove("goldpulse");
        }, 600)
        
    }

</script>

<div class="h-screen flex justify-center items-center text-white select-none background overflow-hidden">
    <div class="absolute bottom-2">
        <a href="/hub" 
           class="text-2xl max-sm:underline hover:underline orangek" 
           class:hidden={spinning || !bet || bet < 0 || balance < bet}>
           Back to Hub
        </a>
    </div>
    
    <div class="pt-2 px-2 bg-red-700 sm:rounded-3xl border">
        <h1 class="text-5xl text-center orangek font-bold border-b mb-2">Fruit Frenzy</h1>
        
        <!-- Slots -->
        <div class="border flex flex-row items-center mb-2 select-none">
            {#each [slot1, slot2, slot3] as item,i}
                <div>

                    <!-- Reels -->
                    <div id={"spin"+(i+1)} 
                         class="border bg-gradient-to-b from-slate-300 from-10% via-white via-50% to-slate-300 to-90% overflow-clip max-sm:h-[120px] max-sm:w-[120px] sm:w-[150px] sm:h-[150px] md:h-[200px] md:w-[200px] lg:h-[250px] relative lg:w-[250px]">
                        <img src={item} 
                             alt={"Reel "+i} 
                             class="absolute">
                    </div>

                    <!-- Goldbar -->
                    <div class="flex flex-row lg:h-[83.33px] max-sm:h-[40px] sm:h-[50px] md:h-[66.66px]">
                        {#each Array(3) as _, index (index)}
                            <div class="lg:w-[83.33px] max-sm:w-[40px] sm:w-[50px] md:w-[66.66px] border flex w-1/3 text-center bg-gradient-to-b from-slate-300 from-10% via-white via-50% to-slate-300 to-90% text-4xl text-black justify-center items-center">
                                <img id={i+"-"+index} 
                                     src={line} 
                                     alt={i+"-"+index}
                                     class={`goldreel${i+1}`}>
                            </div>
                        {/each}
                    </div>
                </div>
            {/each}
        </div>

        <!-- Panel -->
        <div class="flex flex-col gap-2 border-y py-2">
            <input type="text" 
                   disabled class="basis-2/4 text-3xl rounded-2xl orangek sm:hidden text-center pointer-events-none border bg-red-900 border-red-900" 
                   bind:value={feedback}>

            <div class="flex flex-row gap-2 orangek select-none">
                <button class:bg-red-500={!spinning} 
                        type="button" 
                        class="border border-red-500 basis-1/4 text-3xl rounded-2xl max-sm:basis-1/2 disabled:bg-transparent hover:scale-[1.05] disabled:hover:scale-100 duration-200" 
                        class:animate-pulse={spinning} 
                        disabled={spinning || !bet || bet < 0 || balance < bet} 
                        onclick={spin}>
                        Spin</button>

                <input type="text" 
                       disabled 
                       class="basis-2/4 text-3xl rounded-2xl max-sm:hidden text-center pointer-events-none border bg-red-900 border-red-900" 
                       bind:value={feedback}>

                <button class:bg-red-500={!autorun} 
                        type="button" 
                        class="border-red-500 disabled:bg-transparent disabled:hover:scale-100 border basis-1/4 text-3xl rounded-2xl animation max-sm:basis-1/2 hover:scale-[1.05] duration-200" 
                        class:animate-pulse={autorun} 
                        disabled={!bet || bet < 0 || balance < bet} 
                        onclick={() => {autorun = !autorun; if (!spinning) spin();}}>
                        {#if autorun}Autorun On{:else}Autorun{/if}</button>
            </div>

            <!-- Bet, Balance -->
            <div class="flex flex-row max-lg:flex-col gap-2">
                <div class="flex basis-1/2">
                    <span class="inline-flex items-center text-2xl bg-red-900 border-red-900 basis-1/4 border rounded-e-0 border-e-0 rounded-s-2xl justify-center orangek">BET:</span>
                    
                    <input type="number" 
                           min="1" 
                           max={balance} 
                           disabled={spinning} 
                           bind:value={bet} 
                           class="rounded-none basis-3/4 rounded-e-2xl bg-red-50 border text-gray-900 py-2 pe-1 text-center" 
                           placeholder="Place your bet!">
                </div>

                <div class="basis-1/2">
                    <div class="flex">
                        <span class="inline-flex items-center text-2xl px-1 bg-red-900 border-red-900 border rounded-e-0 border-e-0 rounded-s-2xl basis-3/12 justify-center orangek">BALANCE:</span>
                        
                        <input type="text" 
                               min="1" 
                               disabled bind:value={balance} 
                               class="rounded-none bg-red-50 border border-e-0 text-gray-900 py-2 text-center basis-[63%]" 
                               placeholder="Place your bet!">
                        
                               <span class="inline-flex items-center text-2xl px-1 bg-red-50 border border-s-0 rounded-e-2xl basis-[12%] justify-end orangek">
                            <img src={chip} 
                                 alt="chip" 
                                 class="h-8">
                        </span>
                    </div>
                </div>
            </div>
            
        </div>

        <!-- Rules modal trigger -->
        <button class="text-center text-wrap hover:underline max-sm:underline orangek text-xl mx-auto flex px-3" 
                onclick={() => modal = true}>Rules</button>
    </div>
</div>

<!-- Rules/Description -->
<div class:hidden={!modal} class="relative z-10" aria-labelledby="modal-title" role="dialog" aria-modal="true">

    <div class="fixed inset-0 bg-black/90 transition-opacity" aria-hidden="true"></div>
    
    <div class="fixed inset-0 z-10 w-screen overflow-y-auto text-white">
        <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">
            <div  class="shadow-[0_0px_600px_-15px_rgba(0,0,0,0.3)] shadow-white relative transform overflow-hidden bg-red-700 text-left border transition-all sm:my-8 sm:w-full sm:max-w-2xl mx-2 p-2 rounded-3xl orangek">
                <h1 class="text-center text-5xl pb-2 border-b">Rules</h1>

                <!-- Description -->
                <div class="p-2">
                    <p class="text-justify text-xl sm:text-2xl leading-6">
                        The reels contain 7 fruits and a can contain up to 3 golden variants of the fruits. Golden variants boost the rewards.
                    </p>
                    <p class="text-justify text-xl sm:text-2xl leading-6">
                        Press the spin button to try your luck. You can use the autorun button to keep the machine continously running. The minimum bet is 1 chip.
                    </p>
                </div>
                <!-- Reward table -->
                <table class="mx-auto text-lg sm:text-2xl border rounded my-2 [&_th]:border [&_th]:p-2 [&_td]:border [&_td]:p-2">
                    <thead>
                        <tr class="text-center">
                            <th>2 identical fruits</th>
                            <th>Reward</th>
                            <th>3 identical fruits</th>
                            <th>Reward</th>
                        </tr>
                    </thead>
                    <tbody class="">
                        <tr>
                            <td>2 base</td>
                            <td class="text-center">2x</td>
                            <td>3 base</td>
                            <td class="text-center">100x</td>
                        </tr>
                        <tr>
                            <td>1 base, 1 gold</td>
                            <td class="text-center">3x</td>
                            <td>2 base, 1 gold</td>
                            <td class="text-center">100x</td>
                        </tr>
                        <tr>
                            <td>2 gold</td>
                            <td class="text-center">5x</td>
                            <td>1 base, 2 gold</td>
                            <td class="text-center">100x</td>
                        </tr>
                        <tr>
                            <td colspan="2"></td>
                            <td>3 golden fruits</td>
                            <td class="text-center">500x</td>
                        </tr>
                    </tbody>
                </table>
                <div class="border-t pt-2 flex justify-center">
                    <button class="border text-2xl p-1 rounded-2xl w-24 hover:scale-105" onclick={() => modal = false}>Close</button>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .background {
        background-image: url("$lib/media/images/backgrounds/fruitslotbg.jfif");
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
    }
</style>