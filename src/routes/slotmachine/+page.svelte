<script lang="ts">
    import icons from "$lib/classicfruits";
    import { onMount } from "svelte";

    let slot1:string = $state(""),
        slot2:string = $state(""),
        slot3:string = $state(""),
        icons1:string[] = shuffle(icons),
        icons2:string[] = shuffle(icons),
        icons3:string[] = shuffle(icons),
        spinning1:any = "";

    onMount(() => {
        slot1 = icons1[giveRandom()];
        slot2 = icons2[giveRandom()];
        slot3 = icons3[giveRandom()];
    })

    function giveRandom() {
        return Math.floor(Math.random() * icons.length);
    }

    function spin() {
        let index1: number = giveRandom(),
            prevIndex1: number = (index1 == 0)? 7 : index1,
            spin1:any = document.getElementById("spin1");

        

        let spinning1 = setInterval(() => {
            if (index1 == 7){
                prevIndex1 = index1;
                index1 = 0;
            } 
            else{
                index1++;
                if (prevIndex1 == 7) prevIndex1 = 0;
                else prevIndex1++;
            }
            let img: HTMLImageElement = document.createElement("img");
            img.id = String(index1);
            img.src = icons1[index1];

            
            spin1.append(img);
            
            setTimeout(() => {

                spin1.innerHTML = '';
                spin1.append(img);
            }, 600)

        }, 550)

        
        /* This works!
        let index1 = giveRandom(), index2 = giveRandom(), index3 = giveRandom();

        setInterval(() => {
            if (index1 == 7) index1 = 0;
            else index1++;
            slot1 = icons[index1];
        }, 3)

        setTimeout(() => {
            setInterval(() => {
                if (index2 == 7) index2 = 0;
                else index2++;
                slot2 = icons[index2];
            }, 3)
        }, 1000);

        setTimeout(() => {
            setInterval(() => {
                if (index3 == 7) index3 = 0;
                else index3++;
                slot3 = icons[index3];
            }, 3)
        }, 2000)*/
    }

    function stop(){
        clearInterval(spinning1)
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
            <div id={"spin"+(i+1)} class="border bg-gradient-to-b from-slate-300 from-10% via-white via-50% to-slate-300 to-90% overflow-clip h-[256px]">
                <img src={item} alt="slot icon">
            </div>
            {/each}
            
        </div>
        <button type="button" class="border" onclick={spin}>Spin</button>
        <button type="button" class="border" onclick={stop}>Stop</button>
    </div>
</div>