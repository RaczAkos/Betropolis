<script lang="ts">
    import { onMount } from 'svelte';
    const cardsrecord = import.meta.glob("$lib/media/images/findcardgame/cards/*.png");
    import cardback from "$lib/media/images/findcardgame/cardback.png";
    import frenchcards from "$lib/frenchcards";
    import chip from "$lib/media/images/chip.png";

    //Convert Record to Array
    const cardsarray:any[] = [];
    for (const temp in cardsrecord) {
        cardsarray.push(temp);
    }
    let gamearea:any,
        example:any,
        resetBtn:any,
        resetone: any,
        previous = $state(-1),
        rnd = $state(4),
        amount = $state(0),
        need:any,
        balance = $state(1000),
        currentAmount = $state(0);

    onMount(async () => {
        createTable();
	});

    //Generate cards
    function createTable(){
        //Clear table
        gamearea.innerHTML = "";

        //Randomize data sequence
        let shuffled = shuffle(cardsarray);

        //Create all card images
        shuffled.forEach(element => {
            let card = document.createElement("img");
            card.classList.add("!h-full", "!w-full", "object-fill", "duration-500", "cursor-pointer");
            card.addEventListener("click", reveal);
            card.id = element;
            card.src = cardback;
            gamearea?.append(card);
        });
        do {
            rnd = Math.floor(Math.random()*3)
        } while (rnd == previous);
        example.src = frenchcards[rnd]
        previous = rnd;

        document.querySelectorAll(".ctrlbutton").forEach((temp) => {
          temp.removeAttribute("disabled");
        });
    }

    //Card Reveal function
    function reveal(e:any){
        document.querySelectorAll(".ctrlbutton").forEach((temp) => {
          temp.setAttribute("disabled", "true");
        });
        resetBtn.classList.add("shadow-lg", "shadow-yellow-600");
        resetBtn.disabled = false;
        let target = e?.target;
        //Card fold animation
        setTimeout(() => {
            //Reveal card
            target.src = target.id;
        }, 150);
        setTimeout(() => {
          if (target.src.split('_')[target.src.split('_').length-1].split('.')[0] == example.src.split('/')[example.src.split('/').length-1].split('.')[0]) {
            balance += currentAmount;
          }
          else{
            balance -= currentAmount;
          }
        }, 150);
        target.classList.remove("cursor-pointer"); 
        target.classList.add("[transform:rotateY(180deg)]");
    }

    //Table and button reset function
    function resetFunct(){
        resetBtn.disabled = true;
        resetBtn.classList.remove("shadow-lg", "shadow-yellow-600");
        createTable();
    }

    //Randomization function
    function shuffle(array: string[]) {
        let currentIndex = array.length;
        while (currentIndex != 0) {
            let randomIndex = Math.floor(Math.random() * currentIndex);
            currentIndex--;
            [array[currentIndex], array[randomIndex]] = [array[randomIndex], array[currentIndex]];
        }
        return array;
    }

    function calcOne(e:any){
        if (e.target.innerText.length > 3) {
          if (amount >= 2) {
            amount *= parseFloat(e.target.innerText.substr(0 , e.target.innerText.length-1));
          }
        }
        else{
          amount *= parseFloat(e.target.innerText.substr(0 , e.target.innerText.length-1));
        }
        valuechange();
    }

    function valuechange() {
        amount = Math.round(amount)
    }

    function addAmount() {
      if (balance >= amount) {
        currentAmount = Math.round(currentAmount + amount);
      }
    }

    function subtractAmount() {
      if (currentAmount - amount >= 0) {
        currentAmount = Math.round(currentAmount - amount);
      }
    }

    </script>



<div class="flex justify-center h-full select-none overflow-y-scroll no-scrollbar">

    <!--Sidebar-->
    <div class="fixed bottom-0 inset-y-0 left-0 w-[15%] items-center bg-black shadow-[20px_6px_20px_14px_#000000]">
        <div class="flex items-center h-auto"> 
            <button bind:this={resetBtn} 
                    onclick="{resetFunct}" 
                    class="resetter w-full h-[100px] bg-transparent enabled:hover:bg-yellow-600 enabled:hover:text-black text-white font-bold py-2 px-4 rounded border border-yellow-600" 
                    disabled>
              Reset
            </button>  
        </div>
        <form class="w-full max-w-sm mb-auto">
            <div class="lg:flex border-b border-yellow-600 py-2">
              <input bind:value={amount}
                     bind:this={resetone}
                     oninput={valuechange}
                     onfocus={() => (resetone.value = "")}
                     min="1"
                     class="appearance-none bg-transparent border-none w-full text-gray-400 mr-3 py-1 px-2 focus:outline-none"
                     type="number"
                     aria-label="Chips to add" 
                     placeholder="Chips to add"
              >
              <!--Add/subtract buttons-->
              <span class="control">
                <button onclick={addAmount} 
                        class=" bg-yellow-600 hover:bg-yellow-600 border-yellow-600 hover:border-yellow-600 border-4 rounded ctrlbutton" 
                        type="button"
                > 
                  <span class="text-xl">&uarr;</span>
                </button>
              </span>
              <span class="control">
                <button onclick={subtractAmount} class="border-transparent border-4 text-yellow-600 py-1 px-2 rounded ctrlbutton" type="button" >
                  <span class="text-xl">&darr;</span>
                </button>
              </span>
            </div>
          </form>

          <!--Multiplier buttons-->
          <div class="grid max-sm:grid-cols-1 grid-cols-2 lg:grid-cols-3 ">
            {#each ["0.5x", "2x", "5x", "10x"] as multiplier}
              <div class="border border-opacity-0 border-yellow-600 hover:border-opacity-100 flex justify-center rounded-lg">
                <button class="text-yellow-600 ctrlbutton control"  onclick={calcOne}>
                  {multiplier}
                </button>
              </div>
            {/each}
          </div>
          
          <!-- Current Chips In -->
          <div class="text-start">
            <form>
                <label class="block">
                    <span class="block text-xl font-medium text-yellow-600 py-5">Current bet</span>
                    <div class="flex items-center space-x-2">
                        <input 
                            bind:value={currentAmount} 
                            min="1" 
                            class="text-green-700 text-lg text-center bg-black sm:border-b border-yellow-600 w-[80%]" 
                            type="text" 
                            disabled
                        >
                        <img src="{chip}" alt="chip" class="w-[30px]">
                    </div>
                </label>
            </form>

            <!-- Balance -->
            <form>
                <label class="block">
                    <span class="block text-xl font-medium text-yellow-600 py-5">Balance</span>
                    <div class="flex items-center space-x-2">
                        <input 
                            class="text-green-700 text-lg text-center bg-black sm:border-b border-yellow-600 w-[80%]" 
                            type="text" 
                            disabled 
                            bind:value={balance}
                        >
                        <img src="{chip}" alt="chip" class="w-[30px]">
                    </div>
                </label>
            </form>
          </div>
    </div>

    <!--Example card-->
    <div class="fixed bottom-0 left-0 w-[15%] items-center">
        <div class="flex items-center h-auto"> 
            <img bind:this={example} 
                 src="" 
                 alt="" 
                 class="border rounded-2xl bg-gray-300"
            >
        </div>
    </div>

    <!--Gamearea-->
    <div bind:this={gamearea} 
         class="grid grid-cols-3 md:grid-cols-6 lg:grid-cols-9 gap-4 ps-[20%] pe-[5%] w-auto"
    >
    </div>
</div>


<style>
button:not(.resetter) {
    margin: 5px;
    padding: 10px 20px;
    font-size: 16px;
    font-weight: bold;
    border-radius: 5px;
    cursor: pointer;
  }
</style>