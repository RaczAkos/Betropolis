
<script lang=ts>
  import image from "$lib/media/images/gamelogos/crash.png";
  import chip from "$lib/media/images/chip.png";

  let canvas:any,
      multiplierDom:any,
      cashoutBtn:any,
      betBtn:any,
      running = $state(false),
      amount = $state(0),
      need:any,
      currentAmount = $state(0),
      balance = $state(1000);

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

      function addAmount(){
        currentAmount += amount;
      }

      function subtractAmount(){
        if ((currentAmount - amount) >= 0) {
          currentAmount -= amount;
        }
      }
  
  
  $effect(() => {
  const ctx = canvas.getContext("2d");
  let controls = document.querySelectorAll(".control"),
      ctrlbuttons = document.querySelectorAll(".ctrlbutton");

  canvas.width = canvas.clientWidth;
  canvas.height = canvas.clientHeight;

  let   multiplier = 1.0,
          crashed = false,
          offsetX = 0,
          offsetY = 0,
          speedX = -2,
          speedY = 2;

  // Animation loop
  function drawGraph() {
    

    if (running) {
      multiplier += 0.01;
      if (Math.random() < 0.0015) {
        running = false;
        crashed = true;
        cashoutBtn.disabled = true;
        offsetX = 0;
        offsetY = 0;
        speedX = 0;
        speedY = 0;
        betBtn.removeAttribute("disabled");
        ctrlbuttons.forEach(temp => {
          temp.removeAttribute("disabled");
        });
        controls.forEach(element => {
          if (element != controls[0] && element != controls[1]) {
          element.classList.add("hover:border", "hover:border-yellow-600");
          }
        });
        balance -= currentAmount;
      }
    }

    // Draw line
    ctx.beginPath();
    ctx.moveTo(0, canvas.height);
    if (multiplier <= 5) {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      ctx.lineTo((canvas.width / 10) * multiplier, canvas.height - (canvas.height / 10) * multiplier);
    }
    else{
      offsetX += speedX;
      offsetY += speedY;
      canvas.style.backgroundPosition = `${offsetX}px ${offsetY}px`;
    }

    ctx.strokeStyle = "#00FF00";
    ctx.lineWidth = 1;
    ctx.stroke();

    multiplierDom.textContent = multiplier.toFixed(2) + "x";

    if (running) requestAnimationFrame(drawGraph);
  }
  // Function end

  // Start the game
  betBtn.addEventListener("click", () => {
    betBtn.setAttribute("disabled", "true");
    offsetX = 0;
    offsetY = 0;
    speedX = -2;
    speedY = 2;
    running = false;
    crashed = false;
    if (currentAmount >= 1) {
      if (!running && !crashed) {
      running = true;
      multiplier = 1.0;
      cashoutBtn.disabled = false;
      ctrlbuttons.forEach(temp => {
          temp.setAttribute("disabled", "true");
        });
      controls.forEach(element => {
        if (element != controls[0] && element != controls[1]) {
          element.classList.remove("hover:border", "hover:border-yellow-600");
        }
      });
      drawGraph();
    }
    }
  });

  // Cash out
  cashoutBtn.addEventListener("click", () => {
    if (running) {
      betBtn.removeAttribute("disabled");
      running = false;
      cashoutBtn.disabled = true;
      ctrlbuttons.forEach(temp => {
          temp.removeAttribute("disabled");
        });
        controls.forEach(element => {
          if (element != controls[0] && element != controls[1]) {
          element.classList.add("hover:border", "hover:border-yellow-600");
        }
      });
      balance += currentAmount * multiplier;
    }
  });

});
</script>

<div class="flex justify-center items-center h-screen select-none bgImg">
  <div class="text-center md:w-[70%]">
    <div class="game-area shadow-lg shadow-yellow-600 overflow-hidden">
      <div class="flex flex-row h-[85%]">
        <div class="px-5 my-auto">
          <div class="overflow-clip w-[25vw] min-w-[200px] mx-auto">
            <img src="{image}" alt="" class="scale-150">
          </div>

          <!-- Define amount -->
          <form class="w-full max-w-sm mb-auto">
            <div class="flex border-b border-yellow-600 py-2">
              <input
                bind:value={amount}
                bind:this={need}
                oninput={valuechange}
                onfocus={() => (need.value = "")}
                min="1"
                class="appearance-none bg-transparent border-none w-full text-gray-400 mr-3 py-1 px-2 focus:outline-none"
                type="number"
                aria-label="Chips"
              >
              <span class="control">
                <button
                  onclick={addAmount}
                  class="flex-shrink-0 bg-yellow-600 hover:bg-yellow-600 border-yellow-600 hover:border-yellow-600 border-4 rounded ctrlbutton"
                  type="button"
                >
                  <span class="text-xl">&uarr;</span>
                </button>
              </span>
              <span class="control">
                <button
                  onclick={subtractAmount}
                  class="flex-shrink-0 border-transparent border-4 text-yellow-600 py-1 px-2 rounded ctrlbutton"
                  type="button"
                >
                  <span class="text-xl">&darr;</span>
                </button>
              </span>
            </div>
          </form>

          <!-- Multiplier buttons -->
          <div class="grid grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-2 ">
            {#each ["0.5x", "2x", "5x", "10x"] as multiplier}
            <span class="border border-opacity-0 border-yellow-600 hover:border-opacity-100 flex justify-center rounded-lg">
              <button class="text-yellow-600 ctrlbutton control" onclick={calcOne}>
                {multiplier}
              </button>
            </span>
            {/each}
          </div>

          <!-- Current Chips an Balance-->
          <div class="info-container mt-5 w-[80%]">
            <!-- Current Chips -->
            <div class="info-item ">
              <span class="block text-xl font-medium text-yellow-600 text-start">Current bet</span>
              <div class="flex items-center space-x-2">
                <input
                  bind:value={currentAmount}
                  min="1"
                  class="text-green-700 text-lg text-center bg-black border-b border-yellow-600 flex-grow"
                  type="text"
                  disabled
                >
                <img src="{chip}" alt="chip" class="w-[30px] max-sm:hidden">
              </div>
            </div>

            <!-- Balance -->
            <div class="info-item">
              <span class="block text-xl font-medium text-yellow-600 text-start">Balance</span>
              <div class="flex items-center space-x-2">
                <input
                  bind:value={balance} 
                  class="text-green-700 text-lg text-center bg-black border-b border-yellow-600 flex-grow"
                  type="text"
                  disabled
                >
                <img src="{chip}" alt="chip" class="w-[30px] max-sm:hidden">
              </div>
            </div>
          </div>
        </div>

        <!-- Moving Scale -->
        <div class="grow">
          <canvas
            bind:this={canvas}
            class="border border-yellow-600 h-full"
            class:shadow-lg={running}
            class:shadow-yellow-600={running}
          ></canvas>
        </div>
      </div>

      <div class="info">
        <!-- Multiplier -->
        <p id="multiplier" bind:this={multiplierDom}>1.00x</p>
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

  .bgImg{
    background-image: url("../../lib/media/images/crashgame/asd.jfif") !important;
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
    background-image: url('../../lib/media/images/crashgame/net.png');
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
  
  .info p {
    font-size: 24px;
    font-weight: bold;
    color: #ffcc00;
    margin-bottom: 10px;
  }
  
  button {
    margin: 5px;
    padding: 10px 20px;
    font-size: 16px;
    font-weight: bold;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }
  
  #bet-btn {
    background-color: #28a745;
    color: #fff;
  }
  
  #bet-btn:hover {
    background-color: #218838;
  }
  
  #cashout-btn {
    background-color: #dc3545;
    color: #fff;
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

  .info-item {
    width: 100%;
  }
</style>