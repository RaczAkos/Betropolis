<script lang="ts">
  import type { Game } from "$lib/interfaces";

  let { game }: { game: Game } = $props();
</script>

<a href={game.route}>
  <div class="border-2 sm:[&_*]:hover:scale-125 border-yellow-600 hover:border-white 
              rounded-2xl flex justify-center items-center h-64 bg-cover bg-center duration-500" 
       style="background-image: url(/src/lib/media/images/backgrounds/{game.image});">
    <h2 class="text-4xl {game.font} duration-300 ">
      {game.name}
    </h2>
  </div>
</a>