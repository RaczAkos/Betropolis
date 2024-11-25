<script>
    import { onMount } from 'svelte';
    const cards = import.meta.glob("$lib/media/images/findcardgame/cards/*.png");
    import cardback from "$lib/media/images/findcardgame/cardback.jfif"

    onMount(async () => {
		let gamearea = document.getElementById("gamearea");

        for (const temp of Object.entries(cards)) {
            let card = document.createElement("img");
            card.classList.add("rounded-2xl");
            card.src = cardback;
            gamearea?.append(card);
        }
	});
    

</script>
<div class="flex justify-center">
    <div id="gamearea" class="grid grid-cols-6 gap-4 w-[60%]">

    </div>
</div>


<style>
    img{
    }
</style>