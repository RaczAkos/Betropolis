<script lang="ts">
  import crashpics from "$lib/exports/crashpics";
  import { onMount } from "svelte";
  import { updateBalance, getBalance } from '$lib/exports/balance';

  // Declare variables and states
  let canvas: any,
      multiplierDom: any,
      cashoutBtn: any,
      betBtn: any,
      running = $state(false),
      amount = $state(0),
      resetone: any,
      resettwo: any,
      currentAmount = $state(0),
      balance = $state(1000),
      multiplier = $state(0.0),
      targetMultiplier = $state(2.0),
      carousel = $state(),
      showModal = $state(true),
      currentSlide = $state(0),
      totalSlides = $state(3),
      k = 0.0025; // Constant for crash probability calculation

  // Function to calculate the new amount based on button clicked
  function calcOne(e: any) {
    if (e.target.innerText.length > 3) {
      if (amount >= 2) {
        amount = Math.round(amount * parseFloat(e.target.innerText.substr(0, e.target.innerText.length - 1)));
      }
    } else {
      amount = Math.round(amount * parseFloat(e.target.innerText.substr(0, e.target.innerText.length - 1)));
    }
    valuechange(); // Update the amount value
  }

  // Function to round the amount value
  function valuechange() {
    amount = Math.round(amount);
  }

  // Function to add amount to current amount if balance allows
  function addAmount() {
    if (balance >= amount) {
      currentAmount = Math.round(currentAmount + amount);
    }
  }

  // Function to subtract amount from current amount if possible
  function subtractAmount() {
    if (currentAmount - amount >= 0) {
      currentAmount = Math.round(currentAmount - amount);
    }
  }


  // Exponential crash probability calculation function
  function get_crash_probability(multiplier: any, k: any) {
    // Adjust k to make crashes rarer
    const adjustedK = k * 0.4;
    return 1 - Math.exp(-adjustedK * (multiplier - 1));
}

  // Function to handle modal slide navigation
  function nextSlide() {
    currentSlide++;
    if (currentSlide >= totalSlides) {
      showModal = false; // Hide modal after last slide
    }
  }

  onMount(async () => {
    balance = await getBalance()
  })

  // Effect to handle the game logic and animation
  $effect(() => {
    const ctx = canvas.getContext("2d");
    let ctrlbuttons = document.querySelectorAll(".ctrlbutton"),
        crashText = document.querySelector("#crashText");

    // Set canvas dimensions
    canvas.width = canvas.clientWidth;
    canvas.height = canvas.clientHeight;

    multiplier = 0.0; // Initialize multiplier
    let crashed = false,
        offsetX = 0,
        offsetY = 0,
        speedX = -2,
        speedY = 2,
        even = 0,
        stopadding = false;

    // Animation loop to draw the graph
    async function drawGraph() {
      if (running) {
        // Increment multiplier based on conditions
        if (multiplier >= 1) {
          if (even % 3 === 0) {
            multiplier += 0.01;
          }
        } else {
          multiplier += 0.01;
        }
        even++;
        // Calculate crash probability and determine if crashed
        let crash_probability = get_crash_probability(multiplier, k);
        let random_value = Math.random();
        let decideIfCrashed = random_value < crash_probability;
        if (decideIfCrashed) {
          if (crashText) {
            crashText.classList.remove("hidden");
            setTimeout(() => {
              crashText.classList.add("hidden");
            }, 3000);
          }
          multiplierDom.classList.remove("text-yellow-600");
          multiplierDom.classList.add("text-red-600");
          crashed = true;
          cashoutBtn.disabled = true;
          offsetX = 0;
          offsetY = 0;
          speedX = 0;
          speedY = 0;
          betBtn.removeAttribute("disabled");
          ctrlbuttons.forEach((temp) => {
            temp.removeAttribute("disabled");
            if (temp !== ctrlbuttons[0] && temp !== ctrlbuttons[1]) {
              temp.classList.add("hover:border", "hover:border-yellow-600");
            }
          });
          running = false; // Stop the game
        }

        // Check if multiplier reached target
        if (multiplier >= targetMultiplier) {
          cashoutBtn.disabled = true;
          ctrlbuttons.forEach((temp) => {
            temp.removeAttribute("disabled");
          });
          if (!stopadding) {
            stopadding = true; // Stop adding to balance
            balance = await updateBalance(Math.round(currentAmount * targetMultiplier), 2);
          }
        }
      }

      // Draw the graph line
      ctx.beginPath();
      ctx.moveTo(0, canvas.height);
      if (multiplier <= 5 || multiplier <= 1) {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.lineTo((canvas.width / 10) * multiplier, canvas.height - (canvas.height / 10) * multiplier);
      } else {
        offsetX += speedX;
        offsetY += speedY;
        canvas.style.backgroundPosition = `${offsetX}px ${offsetY}px`;
      }

      ctx.strokeStyle = "#00FF00";
      ctx.lineWidth = 1;
      ctx.stroke();

      multiplierDom.textContent = multiplier.toFixed(2) + "x";

      if (running && !crashed) requestAnimationFrame(drawGraph); // Loop animation per browser fps
    }

    // Start the game on Bet button click
    betBtn.addEventListener("click", async () => {
      if (currentAmount >= 1) {
        if (targetMultiplier >= 2) {
          if (balance - currentAmount >= 0) {
            balance = await updateBalance(-currentAmount, 2);
            running = false;
            crashed = false;
            stopadding = false;
            if (!running && !crashed) {
              offsetX = 0;
              offsetY = 0;
              speedX = -2;
              speedY = 2;
              multiplierDom.classList.remove("text-red-600");
              multiplierDom.classList.add("text-yellow-600");
              betBtn.setAttribute("disabled", "true");
              crashText?.classList.add("hidden");
              running = true; // Start the game
              multiplier = 0.0; // Reset multiplier
              cashoutBtn.disabled = false;
              ctrlbuttons.forEach((temp) => {
                temp.setAttribute("disabled", "true");
              });
              drawGraph(); // Start drawing the graph
            }
          }
        }
      }
    });

    cashoutBtn.addEventListener("click", async () => {
      if (running) {
          betBtn.removeAttribute("disabled");
          cashoutBtn.disabled = true;

          if (multiplier < targetMultiplier) {
              balance = await updateBalance(Math.round(currentAmount / 2), 2); // Half return if cashed out early
          }

          ctrlbuttons.forEach((temp) => {
              temp.removeAttribute("disabled");
          });

          crashed = true; // Mark as crashed
      }
    });
});

</script>

{#if showModal}
  <div class="fixed inset-0 flex items-center justify-center z-50 modalbg">
    <div class="p-5 rounded-lg shadow-lg w-[80vw] max-w-3xl">
      <div
        id="horizontal-thumbnails"
        bind:this={carousel}
        data-carousel={JSON.stringify({ loadingClasses: "opacity-0" })}
        class="relative w-full overflow-hidden"
      >
        <div class="carousel flex w-full h-full">
          <div
            class="carousel-body flex w-full h-full transition-transform duration-500"
            style="transform: translateX(-{currentSlide * 100}%);"
          >
            <!-- Slide 1: Text at the bottom-->
            <div class="carousel-slide w-full flex-shrink-0 relative">
              <div class="flex w-full h-full justify-center">
                <img src={crashpics[3]} class="w-full h-full object-cover"/>
              </div>
              {#if currentSlide === 0}
              <div class="absolute top-0 left-0 w-full bg-black bg-opacity-50 text-white p-4 text-center">
                <p class="text-yellow-600 text-4xl">For beginners</p>
              </div>
                <div class="absolute bottom-0 left-0 w-full bg-black bg-opacity-50 text-white p-4 text-center">
                  <p>Here you can enter the amount of <span class="text-yellow-600">chips</span> you would like to increase or decrease your current bet with. After setting the correct amount, add or subtract it from the current bet with the &uarr; or &darr; buttons.</p>
                  <p>Add your <span class="text-red-600">target multiplier</span> where you want to withdraw your bet.</p>
                </div>
              {/if}
            </div>

            <!-- Slide 2: Text at the top-->
            <div class="carousel-slide w-full flex-shrink-0 relative">
              <div class="flex w-full h-full justify-center">
                <img src={crashpics[4]} class="w-full h-full object-cover"/>
              </div>
              {#if currentSlide === 1}
                <div class="absolute top-0 left-0 w-full bg-black bg-opacity-50 text-white p-4 text-center">
                  <p>Here you can see your <span class="text-yellow-600">current multiplier</span>.</p>
                  <p>With the <span class="text-green-600">Bet now</span> button, if the current bet is added, and you have enough balance, it will start the game.</p>
                  <p>You can press the <span class="text-red-600">Cash out</span> button, if during the game, you decided that your <span class="text-red-600">target multiplier</span> is way too risky, so you want to instantly take your chips out. Be careful though, if you withdraw before the <span class="text-yellow-600">multiplier</span> reaches your <span class="text-red-600">target</span>, you will only receive half of your current bet.</p>
                </div>
              {/if}
            </div>

            <!-- Slide 3: Text on the left-->
            <div class="carousel-slide w-full flex-shrink-0 relative">
              <div class="flex w-full h-full justify-center">
                <img src={crashpics[5]} class="w-full h-full object-cover"/>
              </div>
              {#if currentSlide === 2}
                <div class="absolute bottom-0 left-0 h-1/2 w-[40%] bg-black bg-opacity-50 text-white p-4 flex items-center">
                  <p>This is your game field. Here you can see the scale go up as the multiplier grows.</p>
                </div>
                <div class="absolute bottom-0 left-0 h-1/2 w-[40%] text-[60px] text-end bg-opacity-50 p-4 flex items-center">
                  <p class="w-full text-yellow-600">&#8599;</p>
                </div>
              {/if}
            </div>
          </div>
        </div>

        <!-- Thumbnails -->
        <div class="carousel-pagination grid grid-cols-3 justify-center gap-2 mt-4">
          <img
            src={crashpics[3]}
            class="object-cover cursor-pointer {currentSlide === 0 ? 'opacity-100 border-yellow-600 border' : 'opacity-50 border-none'}"
            alt="mountain"
            onclick={() => (currentSlide = 0)}
          />
          <img
            src={crashpics[4]}
            class="object-cover cursor-pointer {currentSlide === 1 ? 'opacity-100 border-yellow-600 border' : 'opacity-50 border-none'}"
            alt="sand"
            onclick={() => (currentSlide = 1)}
          />
          <img
            src={crashpics[5]}
            class="object-cover cursor-pointer {currentSlide === 2 ? 'opacity-100 border-yellow-600 border' : 'opacity-50 border-none'}"
            alt="cloud"
            onclick={() => (currentSlide = 2)}
          />
        </div>

        <!-- Navigation -->
        {#if currentSlide !== 0}
          <button
            type="button"
            class="absolute top-[40%] left-4 transform -translate-y-1/2 bg-yellow-600 rounded-full"
            onclick={() => (currentSlide = Math.max(0, currentSlide - 1))}
          >
            &#10094;
          </button>
        {/if}
        {#if currentSlide !== 2}
          <button
            type="button"
            class="absolute top-[40%] right-4 transform -translate-y-1/2 bg-yellow-600 rounded-full"
            onclick={nextSlide}
          >
            &#10095;
          </button>
        {:else}
          <button
            type="button"
            class="absolute top-[40%] right-4 transform -translate-y-1/2 bg-yellow-600 rounded-full"
            onclick={nextSlide}
          >
            &#10008;
          </button>
        {/if}
      </div>
    </div>
  </div>
{/if}

<div class="flex justify-center items-center h-screen select-none bgImg">
  <div class="text-center md:w-[70%]">
    <div class="game-area shadow-yellow-600 shadow-lg">
      <div class="flex h-[85%] overflow-y-scroll overflow-x-hidden">
        <div class="px-5 my-auto">
          <div class="overflow-clip w-[25vw] min-w-[100px] mx-auto kep">
            <a href="/hub" class="relative inline-block">
                <span title="Back to hub">
                    <img src="{crashpics[0]}" class="scale-150 hover:opacity-40">
                </span>
            </a>
          </div>
          <!-- Define amount -->
          <form class="w-full max-w-sm mb-4">
            <div class="flex border-b border-yellow-600 py-2">
              <input
                bind:value={amount}
                bind:this={resetone}
                oninput={valuechange}
                onfocus={() => (resetone.value = "")}
                min="1"
                class="appearance-none bg-transparent border-none w-full text-gray-400 mr-3 py-1 px-2 focus:outline-none"
                type="number"
                aria-label="Chips to add" 
                placeholder="Chips to add"
              >
              <span>
                <button
                  onclick={addAmount}
                  class="flex-shrink-0 bg-yellow-600 hover:bg-yellow-600 border-yellow-600 hover:border-yellow-600 border-4 rounded ctrlbutton"
                  type="button"
                >
                  <span class="text-xl">&uarr;</span>
                </button>
              </span>
              <span>
                <button
                  onclick={subtractAmount}
                  class="flex-shrink-0 border-transparent border-4 text-yellow-600 py-1 px-2 rounded ctrlbutton"
                  type="button"
                >
                  <span class="text-xl">&darr;</span>
                </button>
              </span>
            </div>
            <div class="flex border-b border-yellow-600 py-2">
              <!-- Target Multiplier -->
              <div class="w-full">
                <div class="flex items-center space-x-2">
                  <input
                    bind:value={targetMultiplier} 
                    bind:this={resettwo}
                    oninput={valuechange} 
                    onfocus={() => (resettwo.value = "")} 
                    class="appearance-none bg-transparent border-none w-full text-gray-400 mr-3 py-1 px-2 focus:outline-none"
                    type="number"
                    aria-label="Target Multiplier (2 or higher)"
                    placeholder="Target Multiplier (2 or higher)"
                    step="0.1"
                    min="2"
                  >
                  <img src="{crashpics[2]}" alt="chip" class="w-[30px] max-sm:hidden">
                </div>
              </div>
            </div>
          </form>

          <!-- Multiplier buttons -->
          <div class="grid grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-2">
            {#each ["0.5x", "2x", "5x", "10x"] as multiplier}
              <button class="text-yellow-600 ctrlbutton firetext fireborder" onclick={calcOne}>
                {multiplier}
              </button>
            {/each}
          </div>

          <!-- Current Chips and Balance-->
          <div class="info-container mt-5 w-[80%]">
            <!-- Current Chips -->
            <div class="w-full">
              <span class="block text-xl font-medium text-yellow-600 text-start">Current bet</span>
              <div class="flex items-center space-x-2">
                <input
                  bind:value={currentAmount}
                  min="1"
                  class="text-green-700 text-lg text-center bg-black border-b border-yellow-600 flex-grow"
                  type="text"
                  disabled
                >
                <img src="{crashpics[1]}" alt="chip" class="w-[30px] max-sm:hidden">
              </div>
            </div>

            <!-- Balance -->
            <div class="w-full">
              <span class="block text-xl font-medium text-yellow-600 text-start">Balance</span>
              <div class="flex items-center space-x-2">
                <input
                  bind:value={balance}
                  class="text-green-700 text-lg text-center bg-black border-b border-yellow-600 flex-grow"
                  type="text"
                  disabled
                >
                <img src="{crashpics[1]}" alt="chip" class="w-[30px] max-sm:hidden">
              </div>
            </div>
          </div>
        </div>

        <!-- Moving Scale -->
        <div class="grow items-center max-md:ps-1">
          <p class='dracutaz text-center text-red-600 text-[120px] max-md:text-[70px] max-sm:text-[40px] max-xs:text-[15px] hidden absolute top-1/4 left-1/4 lg:top-1/3 lg:left-1/3 firetext' id='crashText'>Crashed at {multiplier.toFixed(2)}x!</p>
          <canvas
            bind:this={canvas}
            class="h-full fireborder"
            class:shadow-lg={running}
            class:shadow-yellow-600={running}
          ></canvas>
        </div>
      </div>

      <div class="info">
        <!-- Multiplier -->
        <p id="multiplier" class="text-yellow-600 text-[24px] font-bold mb-[10px]" bind:this={multiplierDom}>{multiplier}x</p>
        <!-- Bet/CashOut buttons -->
        <button bind:this={betBtn} id="bet-btn">Bet Now</button>
        <button bind:this={cashoutBtn} id="cashout-btn" disabled>Cash Out</button>
      </div>
    </div>
    <footer>
      <p>© 2024 Betropolis. Gamble responsibly.</p>
    </footer>
  </div>
</div>

<style>
  @-webkit-keyframes MOVE-BG {
    from {
      transform: translateX(0);
    }
    to { 
      transform: translateX(-187%);
    }
  }

  .bgImg {
    background-image: url("src/lib/media/images/backgrounds/dragon.jfif") !important;
    background-size: cover;
  }

  .game-area {
    align-items: center;
    border-radius: 10px;
    padding: 20px;
    height: 90vh;
    overflow: hidden;
  }
  
  canvas {
    background-image: url('../../../lib/media/images/crashgame/net.png');
    background-repeat: repeat;
    background-size: auto;
    background-position: 0 0;
    width: 100%;
    border-radius: 8px;
  }
  
  .info {
    align-items: center;
    margin-top: 20px;
  }
  
  button {
    padding: 10px 20px;
    font-size: 16px;
    font-weight: bold;
    border: none;
    border-radius: 5px;
  }
  
  #bet-btn {
    background-color: #28a745;
    color: #fff;
    font-size: 20px;
  }
  
  #bet-btn:hover {
    background-color: #218838;
  }
  
  #cashout-btn {
    background-color: #dc3545;
    color: #fff;
    font-size: 20px;
  }
  
  #cashout-btn:hover {
    background-color: #c82333;
  }
  
  footer {
    margin-top: 20px;
    font-size: 12px;
    color: #666;
  }

  .info-container {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    max-width: 100%;
  }

  
  .firetext {
    animation: burn 1.5s linear infinite alternate;
  }

  @keyframes burn {
    from { text-shadow: -.1em 0 .3em #fefcc9, .1em -.1em .3em #feec85, -.2em -.2em .4em #ffae34, .2em -.3em .3em #ec760c, -.2em -.4em .4em #cd4606, .1em -.5em .7em #973716, .1em -.7em .7em #451b0e; }
    45%  { text-shadow: .1em -.2em .5em #fefcc9, .15em 0 .4em #feec85, -.1em -.25em .5em #ffae34, .15em -.45em .5em #ec760c, -.1em -.5em .6em #cd4606, 0 -.8em .6em #973716, .2em -1em .8em #451b0e; }
    70%  { text-shadow: -.1em 0 .3em #fefcc9, .1em -.1em .3em #feec85, -.2em -.2em .6em #ffae34, .2em -.3em .4em #ec760c, -.2em -.4em .7em #cd4606, .1em -.5em .7em #973716, .1em -.7em .9em #451b0e; }
    to   { text-shadow: -.1em -.2em .6em #fefcc9, -.15em 0 .6em #feec85, .1em -.25em .6em #ffae34, -.15em -.45em .5em #ec760c, .1em -.5em .6em #cd4606, 0 -.8em .6em #973716, -.2em -1em .8em #451b0e; }
  }

  .fireborder {
    position: relative;
    animation: burning 1.5s linear infinite alternate;
  }

  .fireborder::before {
    content: "";
    position: absolute;
    inset: 0; /* Covers the entire div */
    border-radius: 4px; /* Optional: matches your div style */
    z-index: -1; /* Places it behind the div content */
    box-shadow: 
      -.1em 0 .3em #fefcc9, 
      .1em -.1em .3em #feec85, 
      -.2em -.2em .4em #ffae34, 
      .2em -.3em .3em #ec760c, 
      -.2em -.4em .4em #cd4606, 
      .1em -.5em .7em #973716, 
      .1em -.7em .7em #451b0e;
    animation: burning 1.5s linear infinite alternate;
  }

  @keyframes burning {
    from {
      box-shadow: 
        -.1em 0 .3em #fefcc9, 
        .1em -.1em .3em #feec85, 
        -.2em -.2em .4em #ffae34, 
        .2em -.3em .3em #ec760c, 
        -.2em -.4em .4em #cd4606, 
        .1em -.5em .7em #973716, 
        .1em -.7em .7em #451b0e;
    }
    45% {
      box-shadow: 
        .1em -.2em .5em #fefcc9, 
        .15em 0 .4em #feec85, 
        -.1em -.25em .5em #ffae34, 
        .15em -.45em .5em #ec760c, 
        -.1em -.5em .6em #cd4606, 
        0 -.8em .6em #973716, 
        .2em -1em .8em #451b0e;
    }
    70% {
      box-shadow: 
        -.1em 0 .3em #fefcc9, 
        .1em -.1em .3em #feec85, 
        -.2em -.2em .6em #ffae34, 
        .2em -.3em .4em #ec760c, 
        -.2em -.4em .7em #cd4606, 
        .1em -.5em .7em #973716, 
        .1em -.7em .9em #451b0e;
    }
    to {
      box-shadow: 
        -.1em -.2em .6em #fefcc9, 
        -.15em 0 .6em #feec85, 
        .1em -.25em .6em #ffae34, 
        -.15em -.45em .5em #ec760c, 
        .1em -.5em .6em #cd4606, 
        0 -.8em .6em #973716, 
        -.2em -1em .8em #451b0e;
    }
  }

  @media (max-height: 768px) {
    .specmax {
      background: rgb(202,138,4);
      background: linear-gradient(90deg, rgba(202,138,4,1) 0%, rgba(0,0,0,1) 8%, rgba(0,0,0,1) 92%, rgba(202,138,4,1) 100%); 
    }
  }

  ::-webkit-scrollbar {
    display: none; /* Hide scrollbar */
  }
</style>