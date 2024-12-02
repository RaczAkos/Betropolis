<script lang="ts">
    import icons from "$lib/classicfruits";
    import chip from "$lib/media//images/chip.png";
    import { onMount } from "svelte";

    let balance = $state(10000);
    let slot1:string = icons[giveRandom(icons)],
        slot2:string = icons[giveRandom(icons)],
        slot3:string = icons[giveRandom(icons)],
        feedback:string = $state(""), 
        bet:number = $state(1),
        autorun:boolean = $state(false),
        spinning:boolean = $state(false);

    onMount(() => {
        feedback = "Start spinning!";
        check();
    })

    function giveRandom(array:string[]) {
        return Math.floor(Math.random() * array.length);
    }

    function spin() {
        
        balance -= bet;
        feedback = "Spinning!";
        spinning = true;

        let index1: number = giveRandom(icons),
            spin1:any = document.getElementById("spin1"),
            index2: number = giveRandom(icons),
            spin2:any = document.getElementById("spin2"),
            index3: number = giveRandom(icons),
            spin3:any = document.getElementById("spin3"),
            i1 = 47, i2 = 47, i3 = 47,
            fruits:string[] = [];

        // First reel spin
        let int1 = setInterval(() => {
            if (index1 == 7) index1 = 0;
            else index1++;

            let img: HTMLImageElement = document.createElement("img");
            img.id = String(index1);
            img.src = icons[index1];

            spin1.innerHTML = '';
            spin1.append(img);
            img.classList.add("absolute", "anim");

            if (i1 == 0){
                clearInterval(int1)
                img.classList.remove("anim");
                fruits.push(icons[index1]);
            } 
            else i1--;
        }, 50)

        // Second reel spin
        setTimeout(() => {
            let int2 = setInterval(() => {
                if (index2 == 7) index2 = 0;
                else index2++;

                let img: HTMLImageElement = document.createElement("img");
                img.id = String(index2);
                img.src = icons[index2];

                spin2.innerHTML = '';
                spin2.append(img);
                img.classList.add("absolute", "anim");

                if (i2 == 0){
                    clearInterval(int2)
                    img.classList.remove("anim");
                    fruits.push(icons[index2]);
                } 
                else i2--;
            }, 50)
        },400)

        // Third reel spin
        setTimeout(() => {
            let int3 = setInterval(() => {
                if (index3 == 7) index3 = 0;
                else index3++;

                let img: HTMLImageElement = document.createElement("img");
                img.id = String(index3);
                img.src = icons[index3];

                spin3.innerHTML = '';
                spin3.append(img);
                img.classList.add("absolute", "anim");

                if (i3 == 0){
                    clearInterval(int3)
                    img.classList.remove("anim");
                    fruits.push(icons[index3]);
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
        if (fruit1.indexOf("golden") != -1 && fruit2.indexOf("golden") != -1 && fruit3.indexOf("golden") != -1) {
            if (!autorun) output("GOLDEN FRUIT FRENZY!!!", 4);
            else feedback = "GOLDEN FRUIT FRENZY!!!";
            gain = 501 * bet;
        }
        else if (fruit1.indexOf("golden") != -1 && fruit2.indexOf("golden") != -1) {
            if (!autorun) output("Double Golden Fruit!!!", 3);
            else feedback = "Double Golden Fruit!!!";
            gain = 11 * bet;
        }
        else if (fruit1.indexOf("golden") != -1 && fruit3.indexOf("golden") != -1) {
            if (!autorun) output("Double Golden Fruit!!!", 3);
            else feedback = "Double Golden Fruit!!!";
            gain = 11 * bet;
        }
        else if (fruit2.indexOf("golden") != -1 && fruit3.indexOf("golden") != -1) {
            if (!autorun) output("Double Golden Fruit!!!", 3);
            else feedback = "Double Golden Fruit!!!";            
            gain = 11 * bet;
        }
        else if (fruit1 == fruit2 && fruit1 == fruit3) {
            if (!autorun) output("FRUIT FRENZY!!!", 3);
            else feedback = "FRUIT FRENZY!!!";
            gain = 101 * bet;
        }
        else if (fruit1 == fruit2 || fruit1 == fruit3 || fruit2 == fruit3) {
            if (!autorun) output("Double Fruit!!", 1);
            else feedback = "Double Fruit!!";
            gain = 4 * bet;
        }
        else feedback = quips[giveRandom(quips)];

        // transaction

        balance += gain;

        setTimeout(() => {if (autorun && balance !> 1){spin()} else {spinning = false; if (autorun) autorun = false}}, 500)
    }

    function output(feed:string, type:number) {
        switch (type) {
            case 4:
                let int4 = setInterval(() => {
                    feedback = feed;
                    setTimeout(() => {
                        feedback = "";
                    }, 50);
                    
                    setTimeout(() => {
                        clearInterval(int4);
                        feedback = feed;
                        check();
                    }, 1000)
                }, 100);
                break;
            case 3:
            case 2:
                let int3 = setInterval(() => {
                    feedback = feed;
                    setTimeout(() => {
                        feedback = "";
                    }, 100);
                    
                    setTimeout(() => {
                        clearInterval(int3);
                        feedback = feed;
                        check();
                    }, 1000)
                }, 200);
                break;
            case 1:
                let int2 = setInterval(() => {
                    feedback = feed;
                    setTimeout(() => {
                        feedback = "";
                    }, 250);

                    setTimeout(() => {
                        clearInterval(int2);
                        feedback = feed;
                        check();
                    }, 1000)
                }, 500);
                break;
            default:
                break;
        }
    }

    function check() {
        if (balance < bet) feedback = "Too much bet!";
        else if (balance == 0) "Not enough chips to spin!"
    }
</script>

<div class="h-screen flex justify-center items-center text-white select-none background overflow-hidden">
    <div class="border p-2 bg-red-600 sm:rounded-3xl">
        <div>
            <h1 class="text-5xl text-center orangek font-bold">Fruit Frenzy</h1>
        </div>
        <div class="border flex flex-row items-center mb-2 select-none">
            {#each [slot1, slot2, slot3] as item,i}
            <div id={"spin"+(i+1)} class="border bg-gradient-to-b from-slate-300 from-10% via-white via-50% to-slate-300 to-90% overflow-clip max-sm:h-[120px] max-sm:w-[120px] sm:w-[150px] sm:h-[150px] md:h-[200px] md:w-[200px] lg:h-[250px] relative lg:w-[250px]">
                <img src={item} alt={"Reel "+i} class="absolute">
            </div>
            {/each}
        </div>
        <div class="flex flex-col gap-2">
            <input type="text" disabled class="basis-2/4 text-3xl rounded-2xl sm:hidden text-center orangek pointer-events-none border" bind:value={feedback} class:animate-pulse={spinning}>
            <div class="flex flex-row gap-2 orangek select-none">
                <button type="button" class="border basis-1/4 text-3xl rounded-2xl max-sm:basis-1/2 disabled:bg-black hover:scale-[1.05] disabled:hover:scale-100 duration-300" class:animate-pulse={spinning} disabled={spinning || !bet || bet < 0 || balance < bet} onclick={spin}>Spin</button>
                <input type="text" disabled class="basis-2/4 text-3xl rounded-2xl max-sm:hidden text-center pointer-events-none border" bind:value={feedback} class:animate-pulse={spinning}>
                <button type="button" class=" border basis-1/4 text-3xl rounded-2xl animation max-sm:basis-1/2 hover:scale-[1.05] duration-300" class:animate-pulse={autorun} disabled={!bet || bet < 0 || balance < bet} onclick={() => {autorun = !autorun; if (!spinning) spin();}}>{#if autorun}Autorun On{:else}Autorun{/if}</button>
            </div>
            <div class="flex flex-row max-lg:flex-col gap-1">
                <div class="flex basis-1/2">
                    <span class="inline-flex items-center text-2xl  bg-red-300 basis-1/4 border rounded-e-0  border-e-0 rounded-s-2xl justify-center orangek">BET:</span>
                    <input type="number" min="1" max={balance} disabled={spinning} bind:value={bet} class="rounded-none basis-3/4 rounded-e-2xl bg-red-50 border text-gray-900 py-2 pe-1 text-center" placeholder="Place your bet!">
                </div>
                <div class="basis-1/2">
                    <div class="flex">
                        <span class="inline-flex items-center text-2xl px-1 bg-red-300 border rounded-e-0 border-e-0 rounded-s-2xl basis-3/12 justify-center orangek">BALANCE:</span>
                        <input type="text" min="1" disabled bind:value={balance} class="rounded-none bg-red-50 border border-e-0 text-gray-900 py-2 text-center basis-[63%]" placeholder="Place your bet!">
                        <span class="inline-flex items-center text-2xl px-1 bg-red-50 border border-s-0 rounded-e-2xl basis-[12%] justify-end orangek"><img src={chip} alt="chip" class="h-8"></span>
                    </div>
                </div>
            </div>
            
        <span class="block text-sm text-center border-t text-wrap">Betropolis Casino</span>
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