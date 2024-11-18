const canvas = document.getElementById("crash-graph");
const ctx = canvas.getContext("2d");

canvas.width = canvas.clientWidth;
canvas.height = canvas.clientHeight;

let multiplier = 1.0;
let running = false;
let crashed = false;

// Animation loop
function drawGraph() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  if (running) {
    multiplier += 0.01; // Increase multiplier
    if (Math.random() < 0.001 || multiplier >= 10) {
      // Random crash or stop at 10x
      running = false;
      crashed = true;
      document.getElementById("cashout-btn").disabled = true;
      alert("Crashed at " + multiplier.toFixed(2) + "x!");
    }
  }

  // Draw line
  ctx.beginPath();
  ctx.moveTo(0, canvas.height);
  ctx.lineTo((canvas.width / 10) * multiplier, canvas.height - (canvas.height / 10) * multiplier);
  ctx.strokeStyle = "#ffcc00";
  ctx.lineWidth = 2;
  ctx.stroke();

  // Update multiplier text
  document.getElementById("multiplier").textContent = multiplier.toFixed(2) + "x";

  if (running || crashed) requestAnimationFrame(drawGraph);
}

// Start the game
document.getElementById("bet-btn").addEventListener("click", () => {
  if (!running && !crashed) {
    running = true;
    multiplier = 1.0;
    document.getElementById("cashout-btn").disabled = false;
    drawGraph();
  }
});

// Cash out
document.getElementById("cashout-btn").addEventListener("click", () => {
  if (running) {
    running = false;
    alert("You cashed out at " + multiplier.toFixed(2) + "x!");
    document.getElementById("cashout-btn").disabled = true;
  }
});
