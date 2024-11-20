<script lang="ts">
    import icons from "$lib/classicfruits";
    import { onMount } from "svelte";

    let slot1:string = $state(""),
        slot2:string = $state(""),
        slot3:string = $state(""),
        spinned:number = $state(0),
        autorun:boolean = $state(false),
        icons1:string[] = shuffle(icons),
        icons2:string[] = shuffle(icons),
        icons3:string[] = shuffle(icons),
        history:HTMLElement;


    onMount(() => {
        slot1 = icons1[giveRandom()];
        slot2 = icons2[giveRandom()];
        slot3 = icons3[giveRandom()];
    })

    function giveRandom() {
        return Math.floor(Math.random() * icons.length);
    }

    function spin() {
        spinned++;

        let index1: number = giveRandom(),
            spin1:any = document.getElementById("spin1"),
            index2: number = giveRandom(),
            spin2:any = document.getElementById("spin2"),
            index3: number = giveRandom(),
            spin3:any = document.getElementById("spin3"),
            i1 = 50, i2 = 50, i3 = 50,
            fruits:string[] = [];

        // First reel spin
        let int1 = setInterval(() => {
            if (index1 == 7) index1 = 0;
            else index1++;

            let img: HTMLImageElement = document.createElement("img");
            img.id = String(index1);
            img.src = icons1[index1];

            spin1.innerHTML = '';
            spin1.append(img);
            img.classList.add("absolute", "anim");

            if (i1 == 0){
                clearInterval(int1)
                img.classList.remove("anim");
                fruits.push(icons1[index1]);
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
                img.src = icons1[index2];

                spin2.innerHTML = '';
                spin2.append(img);
                img.classList.add("absolute", "anim");

                if (i2 == 0){
                    clearInterval(int2)
                    img.classList.remove("anim");
                    fruits.push(icons2[index2]);
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
                img.src = icons1[index3];

                spin3.innerHTML = '';
                spin3.append(img);
                img.classList.add("absolute", "anim");

                if (i3 == 0){
                    clearInterval(int3)
                    img.classList.remove("anim");
                    fruits.push(icons3[index3]);
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
            special:string = "none";

        fruit1 = fruit1.replace(fruit1.substring(fruit1.length-4), "");
        fruit2 = fruit2.replace(fruit2.substring(fruit2.length-4), "");
        fruit3 = fruit3.replace(fruit3.substring(fruit3.length-4), "");
        
        if (fruit1 == fruit2 && fruit1 == fruit3) {
            special = "Tripple";
        }
        else if (fruit1 == fruit2 || fruit1 == fruit3 || fruit2 == fruit3) {
            special = "Double";
        }

        


        history.innerHTML += `<tr class="bg-yellow-600 border m-1">`+
                             `<td>`+capitalize(fruit1)+`</td>`+
                             `<td>`+capitalize(fruit2)+`</td>`+
                             `<td>`+capitalize(fruit3)+`</td>`+
                             `<td>`+special+`</td>`+
                             `<td>`+capitalize(fruit1)+`</td>`+
                             `<td>`+capitalize(fruit1)+`</td>`+`</tr>`;

        setTimeout(() => {if (autorun){spin()};}, 1000)
    }

    function capitalize(val:string) {
        return String(val).charAt(0).toUpperCase() + String(val).slice(1);
    }

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

<div class="h-screen flex justify-center items-center text-white select-none">
    <div class="border p-2">
        <div class="border flex flex-row items-center mb-2">
            {#each [slot1, slot2, slot3] as item,i}
            <div id={"spin"+(i+1)} class="border bg-gradient-to-b from-slate-300 from-10% via-white via-50% to-slate-300 to-90% overflow-clip h-[256px] relative w-[256px]">
                <img src={item} alt="slot icon" class="absolute">
            </div>
            {/each}
        </div>
        <button type="button" class="border" onclick={spin}>Spin</button>
        <div>Spinned: {spinned}</div>
        <button type="button" onclick={() => autorun = !autorun}>{#if autorun}Stop Autorun{:else}Autorun{/if}</button>

        <table class="w-full">
            <caption class="text-center caption-top">Previous spins</caption>
            <thead>
                <tr>
                    <th>Reel 1</th>
                    <th>Reel 2</th>
                    <th>Reel 3</th>
                    <th>Special</th>
                    <th>Bet</th>
                    <th>Gain</th>
                </tr>
            </thead>
            <tbody bind:this={history}>

            </tbody>
        </table>
    </div>
</div>