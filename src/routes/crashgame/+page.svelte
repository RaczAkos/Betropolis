
<script lang=ts>
  let canvas,
      multiplierDom,
      cashoutBtn,
      betBtn,
      running = $state(false);
  
  $effect(() => {
  const ctx = canvas.getContext("2d");
  let controls = document.querySelectorAll(".control");
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
        controls.forEach(element => {
          element.firstChild.disabled = false;
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

    ctx.strokeStyle = "#ffcc00";
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
      controls.forEach(element => {
        element.firstChild.disabled = true;
      });
      drawGraph();
    }
  });

  // Cash out
  cashoutBtn.addEventListener("click", () => {
    if (running) {
      running = false;
      cashoutBtn.disabled = true;
    }
  });
});
</script>

<div class="flex justify-center items-center h-screen">
  <div class="text-center w-[70%]">
    <div class="game-area">
      <div class="flex flex-row h-[85%]">
        <div class="px-5 my-auto">
          <form class="w-full max-w-sm ">
            <div class="flex border-b border-yellow-600 py-2">
              <input class="appearance-none bg-transparent border-none w-full text-yellow-500 mr-3 py-1 px-2 focus:outline-none" type="text" placeholder="0" aria-label="Chips">
              <span class="control">
                <button class=" flex-shrink-0 bg-yellow-600 hover:bg-yellow-600 border-yellow-600 hover:border-yellow-600 border-4 rounded" type="button" disabled=false> 
                  <span class="text-xl">&uarr;</span>
                </button>
              </span>
              <span class="control">
                <button class=" flex-shrink-0 border-transparent border-4 text-yellow-600 py-1 px-2 rounded" type="button" disabled=false>
                  <span class="text-xl">&darr;</span>
                </button>
              </span>
                
            </div>
          </form>
          {#each ["0.5x", "2x", "5x", "10x"] as multiplier}
          <span class="hover:border hover:border-yellow-600 control disabled:border-0">
            <button class="text-yellow-600" disabled=false>
            {multiplier}
            </button>
          </span>
            
          {/each}
        </div>
        <div class="grow">
          <canvas bind:this={canvas} class="border border-yellow-600" class:shadow-lg = {running} class:shadow-yellow-600 = {running}></canvas>
        </div>
      </div>
      
      

      <div class="info">
        <p id="multiplier" bind:this={multiplierDom}>1.00x</p>
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

  
  .game-area {
    align-items: center;
    border: 2px solid #444;
    border-radius: 10px;
    padding: 20px;
    background: #1e1e1e;
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