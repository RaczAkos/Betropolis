<script lang="ts">
  import { onMount } from 'svelte';
  import { scale } from 'svelte/transition';
  import { updateBalance, getBalance } from '$lib/exports/balance';

  // Import assets
  const cardsrecord = import.meta.glob("$lib/media/images/findcardgame/cards/*.png");
  import cardback from "$lib/media/images/findcardgame/cardback.png";
  import frenchcards from "$lib/exports/frenchcards";
  import chip from "$lib/media/images/chip.png";
  import { _ } from 'svelte-i18n';

  // Convert Record to Array
  const cardsarray: any[] = [];
  for (const temp in cardsrecord) {
      cardsarray.push(temp);
  }

  // Game state variables
  let gamearea: any,
      example: any,
      resetBtn: any,
      resetone: any,
      previous = $state(-1),
      rnd = $state(4),
      amount = $state(0),
      balance = $state(0),
      currentAmount = $state(0),
      gameIsRunning = $state(false),
      isZoomed = $state(false),
      correctGuess = $state(false);

  onMount(async () => {
      createTable();
      balance = await getBalance();
  });


  // Generate game table
  function createTable() {
      // Clear table
      gamearea.innerHTML = "";

      // Randomize card order
      let shuffled = shuffle(cardsarray);

      // Create card elements
      shuffled.forEach(element => {
          let card = document.createElement("img");
          card.classList.add("!h-full", "!w-full", "object-fill", "duration-500", "cursor-pointer", "forqs");
          card.addEventListener("click", reveal);
          card.id = element;
          card.src = cardback;
          gamearea?.append(card);
      });

      // Select a random example card
      do {
          rnd = Math.floor(Math.random() * 3);
      } while (rnd == previous);
      
      example.src = frenchcards[rnd];
      previous = rnd;
  }


  // Reveal card function
  function reveal(e: any) {
      if (currentAmount != 0) {
        if (gameIsRunning) {
          let target = e?.target;
          // Card flip animation
          setTimeout(() => {
               target.src = target.id; // Reveal card
          }, 150);
          setTimeout(async () => {
            if (
              target.src.split('_').pop()?.split('.')[0] === example.src.split('/').pop()?.split('.')[0] ||
              target.src.split('_').pop()?.split('.')[0] === "joker"
            ) 
            {
              balance = await updateBalance(amount * 3, 3);
              currentAmount--;
              correctGuess = true;
              //Preventing cards from being folded up, while win animations -> no bug
              document.querySelectorAll(".forqs").forEach((onecard) => {
                onecard.removeEventListener('click', reveal)
              });
              setTimeout(() => {
                correctGuess = !correctGuess;
                document.querySelectorAll(".forqs").forEach((onecard) => {
                  onecard.addEventListener('click', reveal)
                });
              }, 750);
            } 
            else 
            {
              currentAmount--;
            }
            if (currentAmount == 0) {
              gameIsRunning = false;
              resetone.disabled = false;
              resetBtn.disabled = true;
              document.querySelectorAll(".ctrlbutton").forEach((temp) => {
                temp.removeAttribute("disabled");
              });
            }
          }, 150);
          target.classList.remove("cursor-pointer");
          target.classList.add("[transform:rotateY(180deg)]");
          }
        else {
          alert("Start the game first!");
        }
      }
      else 
      {
        alert("Buy some cards first!");
      }
  }

  // Start game function
  async function startFunct() {
      resetBtn.disabled = true;
      gameIsRunning = true;
      balance = await updateBalance(-(amount*currentAmount), 3);
      document.querySelectorAll(".ctrlbutton").forEach((temp) => {
          temp.setAttribute("disabled", "true");
      });

      resetBtn.classList.remove("shadow-lg", "shadow-yellow-600");
      createTable();
  }

  // Shuffle array function
  function shuffle(array: string[]) {
      let currentIndex = array.length;
      while (currentIndex != 0) {
          let randomIndex = Math.floor(Math.random() * currentIndex);
          currentIndex--;
          [array[currentIndex], array[randomIndex]] = [array[randomIndex], array[currentIndex]];
      }
      return array;
  }

  // Calculate multiplier
  function calcOne(e: any) {
      let multiplier = parseFloat(e.target.innerText.substr(0, e.target.innerText.length - 1));
      if (!isNaN(multiplier)) {
          amount *= multiplier;
          valuechange();
      }
  }

  // Update amount value
  function valuechange() {
      amount = Math.round(amount);
  }

  // Add bet amount
  function addAmount() {
      if (balance >= amount && amount > 0) {
          Array.from(document.querySelectorAll(".ctrlbutton"))
              .slice(2)
              .forEach((temp) => temp.setAttribute("disabled", "true"));

          balance -= amount;
          currentAmount++;
      }
  }

  // Subtract bet amount
  function subtractAmount() {
      if (currentAmount > 0) {
          balance += amount;
          currentAmount--;

          if (currentAmount == 0) {
              document.querySelectorAll(".ctrlbutton").forEach((temp) => {
                  temp.removeAttribute("disabled");
              });
          }
      }
  }
</script>


{#if isZoomed}
  <!-- Zoomed-in game start message -->
  <div class="fixed inset-0 max-lg:left-1/3 flex items-center justify-center">
    <p class="text-[120px] font-bold animate-pulse transition-transform duration-500 text-yellow-600 textShadow"
       id="creditShow"
       transition:scale={{ start: 0.2, duration: 500 }}>
       Game started!
    </p>
  </div>
{/if}

{#if correctGuess}
  <!-- Zoomed-in game start message -->
  <div class="fixed inset-0 max-lg:left-1/3 flex items-center justify-center">
    <p class="text-[120px] font-bold animate-pulse transition-transform duration-500 text-yellow-600 textShadow"
       id="creditShow"
       transition:scale={{ start: 0.2, duration: 500 }}>
       +{amount * 3}
    </p>
  </div>
{/if}

<div class="flex justify-center h-full select-none overflow-y-scroll no-scrollbar">   
  
  <!-- Sidebar -->
  <div class="fixed bottom-0 inset-y-0 left-0 w-[15%] items-center bg-black shadow-[20px_6px_20px_14px_#000000]">
    
    <!-- Start Button -->
    <div class="flex items-center h-auto"> 
      <button bind:this={resetBtn} 
              onclick={() => {  
                startFunct(); 
                isZoomed = !isZoomed; 
                setTimeout(() => {
                  isZoomed = !isZoomed;
                }, 2000); 
              }} 
              class="resetter w-full h-[100px] bg-transparent enabled:hover:bg-yellow-600 enabled:hover:text-black text-white font-bold 
                     py-2 px-4 rounded border border-yellow-600 {currentAmount > 54 || currentAmount < 1 ? "shadow-none" : "shadow-lg shadow-yellow-600"}"
              disabled={currentAmount > 54 || currentAmount < 1 ? true : false}>
        {$_("games.find-card.start")}
      </button>  
    </div>

    <!-- Betting Form -->
    <form class="w-full max-w-sm mb-auto">
      <div class="border-b border-yellow-600 py-2 flex flex-col xl:flex-row xxl:flex">
        
        <!-- Input field for chips -->
        <input bind:value={amount}
               bind:this={resetone}
               oninput={valuechange}
               onfocus={() => (resetone.value = "")}
               min="1"
               class="appearance-none bg-transparent border-none w-full text-gray-400 py-1 px-2 focus:outline-none md:mb-0 mb-3"
               type="number"
               aria-label="Chips to add" 
               placeholder="Chips to add">
    
        <!-- Buttons Wrapper -->
    <div class="flex flex-col lg:flex-row  space-y-2 sm:space-y-0 sm:space-x-2 md:space-x-0">
      <span class="control">
        <button onclick={addAmount} 
                class="bg-yellow-600 hover:bg-yellow-600 border-yellow-600 hover:border-yellow-600 border-4 rounded ctrlbutton w-full" 
                type="button">
          <span class="text-xl">
            +1
          </span>
        </button>
      </span>

      <span class="control">
        <button onclick={subtractAmount} 
                class="border-transparent border-4 text-yellow-600 py-1 px-2 rounded ctrlbutton w-full" 
                type="button">
          <span class="text-xl">
            -1
          </span>
        </button>
      </span>
    </div>
    
      </div>
    </form>

    <!-- Multiplier Buttons -->
    <div class="grid max-sm:grid-cols-1 grid-cols-2 lg:grid-cols-3">
      {#each ["0.5x", "2x", "5x", "10x"] as multiplier}
        <div class="border border-opacity-0 border-yellow-600 hover:border-opacity-100 flex justify-center rounded-lg">
          <button class="text-yellow-600 ctrlbutton control" onclick={calcOne}>
            {multiplier}
          </button>
        </div>
      {/each}
    </div>
    
    <!-- Current Chips In -->
    <div class="text-start">
      <form>
        <label class="block">
          <span class="block text-xl font-medium text-yellow-600 py-5">
            {$_("games.find-card.cards")}
          </span>
          <div class="flex items-center space-x-2">
            <input bind:value={currentAmount} 
                   min="1" 
                   class="text-green-700 text-lg text-center bg-black sm:border-b border-yellow-600 w-[80%]" 
                   type="text" 
                   disabled>
            <img src="{chip}" alt="chip" class="w-[30px] max-sm:hidden">
          </div>
        </label>
      </form>

      <!-- Balance -->
      <form>
        <label class="block">
          <span class="block text-xl font-medium text-yellow-600 py-5">
            {$_("games.balance")}
          </span>
          <div class="flex items-center space-x-2">
            <input class="text-green-700 text-lg text-center bg-black sm:border-b border-yellow-600 w-[80%]" 
                   type="text" 
                   disabled 
                   bind:value={balance}>
            <img src="{chip}" alt="chip" class="w-[30px] max-sm:hidden">
          </div>
        </label>
      </form>
    </div>
  </div>

  <!-- Example Card -->
  <div class="fixed bottom-0 left-0 w-[15%] items-center">
    <div class="flex items-center h-auto"> 
      <a href="/hub" class="relative inline-block">
        <span title="Back to hub">
          <img bind:this={example} 
          src="" 
          alt="Example card" 
          class="border rounded-2xl bg-gray-300 shadow-xl shadow-white hover:shadow-2xl hover:shadow-white transition-all duration-300">
        </span>
      </a>
    </div>
  </div>

  <!-- Game Area -->
  <div bind:this={gamearea} 
       class="grid grid-cols-3 md:grid-cols-6 xl:grid-cols-9 gap-4 ps-[20%] pe-[5%] w-auto {correctGuess ? 'opacity-10': 'opacity-100'}"
       class:hidden={isZoomed}>
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
