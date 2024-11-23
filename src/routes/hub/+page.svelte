<script lang="ts">
  import images from "$lib/hubgames";
</script>
<div class="flex justify-center max-h-[85%] overflow-y-scroll pt-[3%] no-scrollbar">
    <div class="grid py-[2%] xl:w-2/3 text-yellow-600 text-xl max-xl:px-[10%] max-xl:py-[3%]">
        <p class=" outline-black outline-4 mb-4 border-b border-yellow-600 pb-5">Crash</p>
        <div class="grid grid-cols-3 gap-6 max-xl:grid-cols-2">
            {#each {length: 3} as game, i}
                <img src="{images[0]}" alt="" class="hover:shadow-lg hover:shadow-yellow-600 blur-sm hover:blur-none duration-500">
            {/each}
        </div>
        <p class=" outline-black outline-4 mb-4 border-b border-yellow-600 mt-4 pb-5">Crash</p>
        <div class="grid grid-cols-3 gap-6 max-xl:grid-cols-2">
            {#each {length: 3} as img, i}
                <img src="{images[0]}" alt="" class="hover:shadow-lg hover:shadow-yellow-600 blur-sm hover:blur-none duration-500">
            {/each}
        </div>
        <p class=" outline-black outline-4 mb-4 border-b border-yellow-600 mt-4 pb-5">Crash</p>
        <div class="grid grid-cols-3 gap-6 max-xl:grid-cols-2">
            {#each {length: 3} as img, i}
                <img src="{images[0]}" alt="" class="hover:shadow-lg hover:shadow-yellow-600 blur-sm hover:blur-none duration-500">
            {/each}
        </div>
        <p class=" outline-black outline-4 mb-4 border-b border-yellow-600 mt-4 pb-5">Crash</p>
        <div class="grid grid-cols-3 gap-6 max-xl:grid-cols-2">
            {#each {length: 3} as img, i}
                <img src="{images[0]}" alt="" class="hover:shadow-lg hover:shadow-yellow-600 blur-sm hover:blur-none duration-500">
            {/each}
        </div>
        <p class=" outline-black outline-4 mb-4 border-b border-yellow-600 mt-4 pb-5">Crash</p>
        <div class="grid grid-cols-3 gap-6 max-xl:grid-cols-2">
            {#each {length: 3} as img, i}
                <img src="{images[0]}" alt="" class="hover:shadow-lg hover:shadow-yellow-600 blur-sm hover:blur-none duration-500">
            {/each}
        </div>
    </div>
</div>



<style>
</style>