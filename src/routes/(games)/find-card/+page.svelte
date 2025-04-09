<svelte:head>
  <title>Find Card - Betropolis</title>
</svelte:head>

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
          let target = e.target;
          target.classList.remove("forqs");
          target.removeEventListener('click', reveal);
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
       transition:scale={{ start: 0.1, duration: 500 }}>
       {$_("games.find-card.started")}
    </p>
  </div>
{/if}

{#if correctGuess}
  <!-- Zoomed-in game start message -->
  <div class="fixed inset-0 max-lg:left-1/3 flex items-center justify-center">
    <p class="text-[120px] font-bold animate-pulse transition-transform duration-500 text-yellow-600 textShadow"
       id="creditShow"
       transition:scale={{ start: 0.1, duration: 500 }}>
       +{amount * 3}
    </p>
  </div>
{/if}

<div class="select-none {correctGuess ? 'opacity-30': 'opacity-100'}">
  
  <!-- Bottombar -->
  <div class="fixed z-10 bottom-0 w-full flex flex-row justify-center gap-1 sm:gap-2 
              lg:gap-10 items-center bg-black shadow-[20px_6px_20px_14px_#000000] p-1 max-h-[200px]">
    
    <!-- Start Button -->
    <div class="flex items-center flex-col p-1 max-sm:w-36"> 
      <button bind:this={resetBtn} 
              onclick={() => {  
                startFunct(); 
                isZoomed = !isZoomed; 
                setTimeout(() => {
                  isZoomed = !isZoomed;
                }, 1000); 
              }} 
              class="disabled:opacity-50 resetter w-full bg-transparent 
                     enabled:hover:bg-yellow-600 enabled:hover:text-black
                     text-white font-bold py-2 px-4 rounded border border-yellow-600 
                       duration-300 text-2xl"
              disabled={currentAmount > 18 || currentAmount < 1 ? true : false || gameIsRunning}>
        {$_("games.find-card.start")}
      </button>

      <!-- Balance -->
      <form>
        <label class="block">
          <span class="block text-xl font-medium text-yellow-600 py-2">
            {$_("games.balance")}
          </span>
          <div class="flex items-center space-x-2">
            <input class="text-green-700 text-lg text-center bg-black border-yellow-600 w-[80%] border-b" 
                   type="text" 
                   disabled 
                   bind:value={balance}>
            <img src="{chip}" alt="chip" class="w-[30px]">
          </div>
        </label>
      </form>
    </div>

    <!-- Betting Form -->
    <form class="w-full max-w-sm max-lg:max-w-32">
      <div class=" py-2 flex flex-col">
        
        <!-- Input field for chips -->
        <input bind:value={amount} 
               bind:this={resetone}
               min="1" 
               oninput={valuechange}
               disabled={gameIsRunning}
               onfocus={() => (resetone.value = "")}
               class="text-green-700 text-lg text-center bg-black border-yellow-600 border-b focus:outline-none" 
               type="number"
               aria-label="Chips to add" 
               placeholder="Chips to add">
    
        <!-- Buttons Wrapper -->
        <div class="flex flex-row gap-1 mt-1">
          <div class="control basis-1/2">
            <button onclick={addAmount} 
                    disabled={gameIsRunning}
                    class="bg-yellow-600 hover:bg-yellow-600 border-yellow-600
                           hover:border-yellow-600 py-1 px-2 border-2 rounded w-full" 
                    type="button">
              <span class="sm:text-xl">
                +1
              </span>
            </button>
          </div>

          <div class="control basis-1/2">
            <button onclick={subtractAmount} 
                    disabled={gameIsRunning}
                    class="border-transparent border-2 border-yellow-600 text-yellow-600 py-1 px-2 rounded w-full" 
                    type="button">
              <span class="sm:text-xl">
                -1
              </span>
            </button>
          </div>
        </div>

        <div>
          <label class="block">
            <span class="block text-xl font-medium text-yellow-600 py-2">
              {$_("games.find-card.cards")}
            </span>
            <div class="flex items-center">
              <input bind:value={currentAmount} 
                     min="1" 
                     class="text-green-700 text-lg text-center bg-black border-b border-yellow-600 w-full" 
                     type="text" 
                     disabled>
            </div>
          </label>
        </div>
      </div>
    </form>

    <!-- Example Card -->
    <div class=" items-center">
      <div class="flex items-center h-auto"> 
        <div class="relative inline-block">
          <div class="p-1 sm:p-3">
            <img bind:this={example} 
                 src="" 
                 alt="Example card" 
                 class="border h-20 lg:h-36 rounded-2xl bg-gray-300 p-4">
          </div>
        </div>
      </div>
      <a href="/hub" 
         class="text-yellow-600 text-center w-full italic hover:sm:underline max-sm:underline"
         class:invisible={gameIsRunning}>
        <div>
          {$_("games.back")}
        </div>
      </a>
    </div>
  </div>


  <!-- Game Area -->
  <div bind:this={gamearea} 
       class="grid grid-cols-3 lg:grid-cols-6 xxl:grid-cols-9 gap-4 p-5 md:p-10 {correctGuess ? 'opacity-10': 'opacity-100'}"
       class:hidden={isZoomed}>
  </div>
  <div class="h-[200px]"></div>
</div>