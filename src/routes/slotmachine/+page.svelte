<script lang="ts">
    import icons from "$lib/classicfruits";
    import { onMount } from "svelte";

    let balance = $state(1000);
    let slot1:string = icons[giveRandom()],
        slot2:string = icons[giveRandom()],
        slot3:string = icons[giveRandom()],
        bet:number = $state(1),
        autorun:boolean = $state(false),
        spinning:boolean = $state(false),
        history:HTMLElement;
    
    function giveRandom() {
        return Math.floor(Math.random() * icons.length);
    }

    function spin() {
        balance -= bet;

        spinning = true;

        let index1: number = giveRandom(),
            spin1:any = document.getElementById("spin1"),
            index2: number = giveRandom(),
            spin2:any = document.getElementById("spin2"),
            index3: number = giveRandom(),
            spin3:any = document.getElementById("spin3"),
            i1 = 47, i2 = 47, i3 = 47,
            fruits:string[] = [];

        console.log(icons[index1], icons[index2], icons[index3])
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
            special:string = "none",
            gain:number = 0;

        fruit1 = fruit1.replace(fruit1.substring(fruit1.length-4), "");
        fruit2 = fruit2.replace(fruit2.substring(fruit2.length-4), "");
        fruit3 = fruit3.replace(fruit3.substring(fruit3.length-4), "");
        
        

        if (fruit1 == fruit2 && fruit1 == fruit3) {
            special = "Tripple Fruit!!!";
            gain = 100 * bet;
        }
        else if (fruit1 == fruit2 || fruit1 == fruit3 || fruit2 == fruit3) {
            special = "Double Fruit!!";
            gain = 3 * bet;
        }

        balance += gain;

        
        /*document.querySelector("table")?.classList.remove("hidden");

        history.innerHTML += `<tr class="border-y-2 m-1 table-row w-full">`+
                            `<td><img class="h-12 mx-auto" src="`+fruits[0]+`" alt="`+capitalize(fruit1)+`"></td>`+
                            `<td><img class="h-12 mx-auto" src="`+fruits[1]+`" alt="`+capitalize(fruit2)+`"></td>`+
                            `<td><img class="h-12 mx-auto" src="`+fruits[2]+`" alt="`+capitalize(fruit3)+`"></td>`+
                            `<td class="text-wrap">`+special+`</td>`+
                            `<td>`+bet+`</td>`+
                            `<td>`+gain+`</td>`+`</tr>`;*/

        setTimeout(() => {if (autorun){spin()} else spinning = false;}, 500)
    }
</script>

<div class="h-screen flex justify-center items-center text-white select-none background overflow-hidden">
    <div class="border p-2 bg-red-600 rounded-tr-3xl rounded-tl-3xl">
        <div>
            <h1 class="text-2xl text-center">Fruit Frenzy</h1>
        </div>
        <div class="border flex flex-row items-center mb-2">
            {#each [slot1, slot2, slot3] as item,i}
            <div id={"spin"+(i+1)} class="border bg-gradient-to-b from-slate-300 from-10% via-white via-50% to-slate-300 to-90% overflow-clip max-sm:h-[108px] max-sm:w-[108px] sm:w-[150px] sm:h-[150px] md:h-[200px] md:w-[200px] lg:h-[250px] relative lg:w-[250px]">
                <img src={item} alt={"Reel "+i} class="absolute">
            </div>
            {/each}
        </div>
        <div class="flex flex-col gap-2">
            <div class="flex flex-row gap-2">
                <button type="button" class="border basis-1/6 p-2 rounded-2xl" disabled={spinning || !bet || bet < 0} onclick={spin}>{#if spinning}Spinning{:else}Spin{/if}</button>
                <input type="text" class="basis-4/6 p-2 rounded-2xl">
                <button type="button" class=" border basis-1/6 p-2 rounded-2xl hover:animate-pulse animation" onclick={() => {autorun = !autorun; if (!spinning) spin();}}>{#if autorun}Stop Autorun{:else}Autorun{/if}</button>
            </div>
            <div class="flex flex-row gap-1">
                <div class="flex basis-1/2">
                    <span class="inline-flex items-center p-2 text-sm text-gray-900 bg-gray-200 basis-1/6 border rounded-e-0 border-gray-300 border-e-0 rounded-s-2xl justify-center">BET:</span>
                    <input type="number" min="1" disabled={spinning} bind:value={bet} class="rounded-none basis-5/6 rounded-e-2xl bg-gray-50 border text-gray-900 p-2 text-center" placeholder="Place your bet!">
                </div>
                <div class="basis-1/2">
                    <div class="flex">
                        <span class="inline-flex items-center p-2 text-sm text-gray-900 bg-gray-200 border rounded-e-0 border-gray-300 border-e-0 rounded-s-2xl basis-1/4 text-center">BALANCE:</span>
                        <input type="text" min="1" disabled bind:value={balance} class="rounded-none rounded-e-2xl bg-gray-50 border text-gray-900 p-2 text-center basis-3/4" placeholder="Place your bet!">
                    </div>
                </div>
            </div>
        </div>
<!--
    <table class="w-full text-center hidden">
        <caption class="text-center caption-top font-bold italic text-lg">Previous spin</caption>
        <thead>
            <tr>
                <th class="border-r-2">Reel 1</th>
                <th class="border-r-2">Reel 2</th>
                <th class="border-r-2">Reel 3</th>
                <th class="border-r-2">Special</th>
                <th class="border-r-2">Bet</th>
                <th class="">Gain</th>
            </tr>
        </thead>
        <tbody bind:this={history}></tbody>
        <tfoot><tr><td colspan="6" class="max-sm:text-[12px] sm:text-md md:text-lg text-wrap">Note: You can view your wins and losses in user statistics.</td></tr></tfoot>
    </table>
    -->
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