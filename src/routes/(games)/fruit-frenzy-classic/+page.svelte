<svelte:head>
    <title>Fruit Frenzy Classic! - Betropolis</title>
</svelte:head>

<script lang="ts">
    import icons from "$lib/exports/classicfruits";
    import line from "$lib/media/images/line.png";
    import { updateBalance, getBalance } from '$lib/exports/balance';
    import { onMount } from "svelte";
    import { _ } from "svelte-i18n";
    import Description from "$lib/components/Description.svelte";

    onMount(async() => {
        balance = await getBalance();
    })

    let balance = $state(0);
    let slot1:string = icons[giveRandom(icons.slice(0,6))],
        slot2:string = icons[giveRandom(icons.slice(0,6))],
        slot3:string = icons[giveRandom(icons.slice(0,6))],
        goldenicons:string[] = icons.slice(7,14),
        feedback:string = $state("Start spinning!"), 
        bet:number = $state(10),
        autorun:boolean = $state(false),
        spinning:boolean = $state(false),
        modal:boolean = $state(false);

    // Return random index
    function giveRandom(array:string[]) { return Math.floor(Math.random() * array.length); }

    async function spin() {

        let gold1:string[] = [], 
            gold2:string[] = [], 
            gold3:string[] = [], 
            fruits1 = icons.slice(0,7), 
            fruits2 = icons.slice(0,7), 
            fruits3 = icons.slice(0,7);

        for (let i = 0; i < 3; i++) {
            let temp = 0, element = Math.random();
            
            if (element >= 0.4 && element < 0.75) temp = 1;
            else if (element > 0.75 && element < 0.9) temp = 2;
            else if (element >= 0.9) temp = 3;

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
        
        balance = await updateBalance(-bet, 1);
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

    async function calculate(fruits:string[]) {
        let fruit1:string = fruits[0].split('/')[fruits[0].split('/').length-1],
            fruit2:string = fruits[1].split('/')[fruits[1].split('/').length-1],
            fruit3:string = fruits[2].split('/')[fruits[2].split('/').length-1],
            quips:string[] = ["Not this time!", "No luck!", "Try again!", "Almost!", "Maybe next time!"],
            gain:number = 0;

        feedback = "";
        
        switch (compare(fruit1, fruit2, fruit3)) {
            case 4:
                gain = bet * 100;
                feedback = `+${gain}`;
                break;
            case 5:
                gain = bet * 150;
                feedback = `+${gain}`;
                break;
            case 6:
                gain = bet * 250;
                feedback = `+${gain}`;
                break;
            case 7:
                gain = bet * 500;
                feedback = `+${gain}`;
                break;
            default:
                feedback = quips[giveRandom(quips)];
                break;
        }
        

        // transaction
        if (gain > 0) {
            balance = await updateBalance(gain, 1);
        }

        setTimeout(() => {
            if (autorun && balance !> 1) {
                spin()
            } else {
                spinning = false; 
                if (autorun) autorun = false;
            }
        }, 700)
    }

    // Comparison
    function compare(fruit1:string, fruit2:string, fruit3:string):number {
        let path:number = 0, f1 = "", f2 = "", f3 = "", golds = 0;
        
        if (fruit1.includes("golden")) {
            f1 = fruit1.split("golden")[1];
            golds++;
        } else f1 = fruit1.split('/')[fruit1.split('/').length-1];
        
        if (fruit2.includes("golden")) {
            f2 = fruit2.split("golden")[1];
            golds++;
        } else f2 = fruit2.split('/')[fruit2.split('/').length-1];
        
        if (fruit3.includes("golden")) {
            f3 = fruit3.split("golden")[1];
            golds++;
        } else f3 = fruit3.split('/')[fruit3.split('/').length-1];
        
        if (f1 == f2 && f1 == f3) {
            switch (golds) {
                case 1:
                    path = 5
                    break;
                case 2:
                    path = 6
                    break;
                case 3:
                    path = 7
                    break;
                default:
                    path = 4
                    break;
            }
        }

        return path;
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

<div class="h-screen flex justify-center items-center text-white select-none bg-center bg-no-repeat bg-cover bg-fixed bg-[url($lib/media/images/backgrounds/fruitslotbg.jfif)] overflow-hidden">

  <!-- Back to hub - link -->
  <div class="absolute bottom-2 orangek">
    <a href="/hub" 
       class="text-2xl max-sm:underline hover:underline italic" 
       class:hidden={spinning}>
       {$_("games.back")}
    </a>
  </div>
    
  <div class="pt-2 px-2 bg-red-700 sm:rounded-3xl border-2">
    <h1 class="text-4xl sm:text-5xl text-center font-bold border-b-2 mb-2 orangek">
      Fruit Frenzy Classic
    </h1>
        
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
                     src="/src/lib/media/images/line.png" 
                     alt={i+"-"+index} 
                     class={`goldreel${i+1}`}>
              </div>
            {/each}
          </div>
        </div>
      {/each}
    </div>

    <!-- Panel -->
    <div class="flex flex-col gap-2 border-y-2 py-2">

      <!-- Feedback - Mobile view -->
      <input type="text" 
             disabled class="basis-2/4 text-3xl rounded-2xl orangek sm:hidden text-center pointer-events-none border-2 bg-red-900 border-red-900" 
             bind:value={feedback}>

      <div class="flex flex-row gap-2 orangek select-none">
        
        <!-- Spin -->
        <button class:bg-red-500={!spinning} 
                type="button" 
                class="border-2 border-red-500 basis-1/4 text-3xl rounded-2xl max-sm:basis-1/2 disabled:bg-transparent hover:scale-[1.05] disabled:hover:scale-100 duration-200" 
                class:animate-pulse={spinning} 
                disabled={spinning || !bet || bet < 10 || balance < bet} 
                onclick={spin}>
          {$_("games.fruit-frenzy-classic.spin")}
        </button>

        <!-- Feedback -->
        <input type="text" 
               disabled 
               class="basis-2/4 text-3xl rounded-2xl max-sm:hidden text-center pointer-events-none border-2 bg-red-900 border-red-900" 
               bind:value={feedback}>

        <!-- Auto-Run -->
        <button class:bg-red-500={!autorun} 
                type="button" 
                class="border-red-500 disabled:bg-transparent disabled:hover:scale-100 border-2 basis-1/4 text-3xl rounded-2xl animation max-sm:basis-1/2 hover:scale-[1.05] duration-200" 
                class:animate-pulse={autorun} 
                disabled={!bet || bet < 10 || balance < bet} 
                onclick={() => {autorun = !autorun; if (!spinning) spin();}}>
          {$_(`games.fruit-frenzy-classic.auto`)}
        </button>
      </div>

      <!-- Bet, Balance -->
      <div class="flex flex-row max-lg:flex-col gap-2">
        <div class="flex basis-1/2">
          <span class="inline-flex items-center text-2xl bg-red-900 border-red-900 basis-1/4 border-2 rounded-e-0 border-e-0 rounded-s-2xl justify-center orangek uppercase">
            {$_("games.bet")}:
          </span>
              
          <input type="number" 
                 min=10
                 max={balance} 
                 disabled={spinning} 
                 bind:value={bet} 
                 class="rounded-none basis-3/4 rounded-e-2xl bg-red-50 border-2 text-gray-900 py-2 pe-1 text-center" 
                 placeholder="Place your bet!">
        </div>

        <div class="basis-1/2">
          <div class="flex">
            <span class="inline-flex items-center text-2xl px-1 bg-red-900 border-red-900 border-2 rounded-e-0 border-e-0 rounded-s-2xl basis-3/12 justify-center orangek uppercase">
              {$_("games.balance")}:
            </span>
                        
            <input type="text"
                   disabled bind:value={balance} 
                   class="rounded-none bg-red-50 border border-e-0 text-gray-900 py-2 text-center basis-[63%]">
                        
            <span class="inline-flex items-center text-2xl px-1 bg-red-50 border border-s-0 rounded-e-2xl basis-[12%] justify-end orangek">
              <img src="/src/lib/media/images/chip.png" 
                   alt="chip" 
                   class="h-8">
            </span>
          </div>
        </div>
      </div>
    </div>

    <!-- Rules modal trigger -->
    <button class="text-center text-wrap hover:underline max-sm:underline orangek text-2xl mx-auto flex px-3" 
            onclick={() => modal = true}>
      {$_("games.rules")}
    </button>
  </div>
</div>

<!-- Rules/Description -->
<div class:hidden={!modal} class="relative z-10" aria-labelledby="modal-title" role="dialog" aria-modal="true">
  <div class="fixed inset-0 bg-black/90 transition-opacity" aria-hidden="true"></div>
  <div class="fixed inset-0 z-10 w-screen overflow-y-auto text-white">
    <div class="flex min-h-full justify-center p-4 text-center items-center sm:p-0">
      <div class="shadow-[0_0px_600px_-15px_rgba(0,0,0,0.3)] shadow-white relative transform overflow-hidden bg-red-700 text-left border-2 transition-all sm:my-8 sm:w-full sm:max-w-2xl mx-2 p-2 rounded-3xl">
        <h1 class="text-center text-5xl pb-2 border-b-2 orangek">
          {$_("games.rules")}
        </h1>

        <div class="p-3">
          {#each Array(2) as _, i}
            <Description text={"games.fruit-frenzy-classic.description"+(i+1)}/>
          {/each}
        </div>

        <div class="border-t-2 pt-2 flex justify-center">
          <button class="border-2 text-2xl p-1 rounded-xl w-24 hover:scale-110 hover:bg-white hover:text-red-700 duration-300 orangek" 
                  onclick={() => modal = false}>
            {$_("close")}
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  ::selection {
    background-color: white;
    color: rgb(127, 29, 29);
  }
</style>