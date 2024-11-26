<script lang="ts">
    $effect(() => {
        const canvas = document.getElementById('wheelCanvas');
        const ctx = canvas?.getContext('2d');
        const spinButton = document.getElementById('spinButton');
        const resultDiv = document.getElementById('result');

        const segments = ["Prize 1", "Prize 2", "Prize 3", "Prize 4", "Prize 5", "Prize 6"];
        const colors = ["#FF5733", "#33FF57", "#3357FF", "#FFFF33", "#FF33FF", "#33FFFF"];
        const segmentAngle = (2 * Math.PI) / segments.length;
        let currentAngle = 0;
        let spinAngle = 0;
        let isSpinning = false;

        // Draw the Wheel
        function drawWheel() {
            for (let i = 0; i < segments.length; i++) {
                ctx.beginPath();
                ctx.moveTo(250, 250);
                ctx.arc(250, 250, 250, segmentAngle * i, segmentAngle * (i + 1));
                ctx.fillStyle = colors[i];
                ctx.fill();
                ctx.closePath();

                // Add text
                ctx.save();
                ctx.translate(250, 250);
                ctx.rotate(segmentAngle * i + segmentAngle / 2);
                ctx.textAlign = "right";
                ctx.fillStyle = "#000";
                ctx.font = "20px Arial";
                ctx.fillText(segments[i], 240, 10);
                ctx.restore();
            }
        }

        // Spin Logic
        function spinWheel() {
            if (isSpinning) return;
            isSpinning = true;
            spinAngle = Math.random() * 2000 + 3000; // Spin angle between 3000 and 5000 degrees
            let spinSpeed = spinAngle / 200; // Controls the duration of spin

            const spinInterval = setInterval(() => {
                currentAngle += spinSpeed;
                spinSpeed *= 0.98; // Slow down the spin

                if (spinSpeed <= 0.1) {
                    clearInterval(spinInterval);
                    isSpinning = false;
                    currentAngle %= 360;
                    determineResult();
                }
                drawSpinningWheel();
            }, 16);
        }

        // Redraw with Rotation
        function drawSpinningWheel() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.save();
            ctx.translate(250, 250);
            ctx.rotate(currentAngle * Math.PI / 180);
            ctx.translate(-250, -250);
            drawWheel();
            ctx.restore();
        }

        // Determine the Result
        function determineResult() {
            const normalizedAngle = (360 - currentAngle % 360) % 360;
            const resultIndex = Math.floor(normalizedAngle / (360 / segments.length));
        }

        // Initialize
        drawWheel();
        spinButton?.addEventListener('click', spinWheel);
    });
    
</script>

<div class="flex justify-center items-center w-auto h-screen">
    <div>
        <canvas id="wheelCanvas" width="500" height="500"></canvas>
    <div id="result">Spin the wheel!</div>
    <button id="spinButton" style="display: block; margin: 20px auto;">Spin</button>
    </div>
</div>

<style>
    #wheelCanvas {
        border: 5px solid #000;
        border-radius: 50%;
        display: block;
        margin: 20px auto;
    }
    #result {
        text-align: center;
        margin-top: 20px;
        font-size: 24px;
        font-weight: bold;
    }
</style>