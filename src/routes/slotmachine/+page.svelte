<script lang="ts">
    import icons from "$lib/classicfruits";
    import { onMount } from "svelte";

    let slot1:string = $state(""),
        slot2:string = $state(""),
        slot3:string = $state(""),
        spinned:number = $state(0),
        double:number = $state(0),
        triple:number = $state(0),
        icons1:string[] = shuffle(icons),
        icons2:string[] = shuffle(icons),
        icons3:string[] = shuffle(icons);

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
            i1 = 50, i2 = 50, i3 = 50;

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
            } 
            else i1--;
        }, 50)

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
                } 
                else i2--;
            }, 50)
        },400)

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
                } 
                else i3--;
            }, 50)
        },800)
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
    </div>
</div>