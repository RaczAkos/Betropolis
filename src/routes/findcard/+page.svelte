<script>
    import { onMount } from 'svelte';
    const cards = import.meta.glob("$lib/media/images/findcardgame/cards/*.png");
    import cardback from "$lib/media/images/findcardgame/cardback.jfif"

    onMount(async () => {
		let gamearea = document.getElementById("gamearea");

        for (const [key, value] of Object.entries(cards)) {
            let card = document.createElement("img");
            card.classList.add("rounded-2xl", "!h-full", "!w-full");
            card.id = value.name;
            card.src = cardback;
            gamearea?.append(card);
        }
	});
    

</script>
<div class="flex justify-center h-full select-none overflow-y-scroll no-scrollbar">
    <div class="fixed bottom-0 top-1/3 left-0 w-[15%] items-center">
        <div class="flex items-center">
            <img src="{cardback}" alt="" class="border sm:rounded-2xl bg-gray-300" id="example">
        </div>
    </div>
    <div id="gamearea" class="grid grid-cols-3 md:grid-cols-6 lg:grid-cols-9 gap-4 px-[20%]">
        
    </div>
</div>


<style>
    img{
    }
</style>