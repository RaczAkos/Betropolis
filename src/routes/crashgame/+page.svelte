
<script lang=ts>
  import image from "$lib/media/images/gamelogos/crash.png";


  let canvas,
      multiplierDom,
      cashoutBtn,
      betBtn,
      running = $state(false);
  
  $effect(() => {
  const ctx = canvas.getContext("2d");
  let controls = document.querySelectorAll(".control"),
      ctrlbuttons = document.querySelectorAll(".ctrlbutton");
  canvas.width = canvas.clientWidth;
  canvas.height = canvas.clientHeight;

  let multiplier = 1.0,
      crashed = false,
      offsetX = 0,
      offsetY = 0,
      speedX = -2,
      speedY = 2;

  // Animation loop
  function drawGraph() {

    if (running) {
      multiplier += 0.01;
      if (Math.random() < 0.0005) {
        running = false;
        crashed = true;
        cashoutBtn.disabled = true;
        offsetX = 0;
        offsetY = 0;
        speedX = 0;
        speedY = 0;
        ctrlbuttons.forEach(temp => {
          temp.removeAttribute("disabled");
        });
        controls.forEach(element => {
          if (element != controls[0] && element != controls[1]) {
          element.classList.add("hover:border", "hover:border-yellow-600");
        }
      });
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

    if (running || crashed) requestAnimationFrame(drawGraph);
  }

  // Start the game
  betBtn.addEventListener("click", () => {
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
        element.children[0].ariaDisabled = "true";
      });
      drawGraph();
    }
  });

  // Cash out
  cashoutBtn.addEventListener("click", () => {
    if (running) {
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
    }
  });
});
</script>

<div class="flex justify-center items-center h-screen select-none sad">
  <div class="text-center w-[70%]">
    <div class="game-area shadow-lg shadow-yellow-600">
      <div class="flex flex-row h-[85%] max-sm:flex-col">
        <div class="px-5 my-auto">
          <div class="overflow-clip w-[25vw]">
            <img src="{image}" alt="" class="scale-150">
          </div>
          <!--Define amount-->
          <form class="w-full max-w-sm mb-auto">
            <div class="flex border-b border-yellow-600 py-2">
              <input class="appearance-none bg-transparent border-none w-full text-gray-400 mr-3 py-1 px-2 focus:outline-none" type="text" value="0" aria-label="Chips">
              <!--Add/subtract buttons-->
              <span class="control">
                <button class=" flex-shrink-0 bg-yellow-600 hover:bg-yellow-600 border-yellow-600 hover:border-yellow-600 border-4 rounded ctrlbutton" type="button" > 
                  <span class="text-xl">&uarr;</span>
                </button>
              </span>
              <span class="control">
                <button class=" flex-shrink-0 border-transparent border-4 text-yellow-600 py-1 px-2 rounded ctrlbutton" type="button" >
                  <span class="text-xl">&darr;</span>
                </button>
              </span>
            </div>
          </form>


          <!--Multiplier buttons-->
          {#each ["0.5x", "2x", "5x", "10x"] as multiplier}
          <span class="hover:border hover:border-yellow-600 control">
            <button class="text-yellow-600 ctrlbutton"  onclick={() => {console.log("clicked")}}>
            {multiplier}
            </button>
          </span>
          {/each}

          <!--Current chips in-->
          <div class="text-start">
            <form >
              <label class="block">
                <span class="block text-xl font-medium text-yellow-600 py-5 ">Current</span>
                <input class="text-green-700 text-lg text-center bg-black border-b border-yellow-600" type="text" disabled value="1000000"/>
              </label>
            </form>
    
            <!--Current chips in-->
            <form class="">
              <label class="block">
                <span class="block text-xl font-medium text-yellow-600 py-5">Total</span>
                <input class="text-green-700 text-lg text-center bg-black border-b border-yellow-600" type="text" disabled value="1000000"/>
              </label>
            </form>
          </div>
       
        </div>    

        <!--Moving scale-->
        <div class="grow">
          <canvas bind:this={canvas} class="border border-yellow-600" class:shadow-lg = {running} class:shadow-yellow-600 = {running}></canvas>
        </div>
      </div>
      
      <div class="info">
        <!--Multiplier-->
        <p id="multiplier" bind:this={multiplierDom}>1.00x</p>
        <!--Bet/CashOut buttons-->
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

  .sad{
    background-image: url("../../lib/media/images/asd.jfif") !important;
    background-size: cover;
  }

  .game-area {
    align-items: center;
    border-radius: 10px;
    padding: 20px;
    height: 90vh;
  }
  
  canvas {
    background-image: url('../../lib/media/images/net.png');
    background-repeat: repeat;
    background-size: auto;
    background-position: 0 0;
    width: 100%;
    height: 100%;
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
  
</style>