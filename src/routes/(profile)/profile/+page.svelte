<script lang="ts">
    import userpng from "$lib/media/images/profile/user.png";
    import { onMount } from "svelte";

    let data = $props();

        let isHovered = $state(false);

    function pictureHover() {
        let picture = document.getElementById('picChangebtn');
        picture?.classList.add('opacity-100');
    }

    function pictureLeave() {
        let picture = document.getElementById('picChangebtn');
        picture?.classList.remove('opacity-100');
    }
</script>
<!--For the reload button-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />

<div class="w-screen bg-[#141a22] justify-center items-center flex changeHeight">    
    <div class="w-[85vw] h-[75vh] bg-[#040d17] flex mx-auto rounded-lg shadow-2xl shadow-[#040d17] flex-col">
        <!--Greeting and Profile data-->
        <div class="ps-4 pt-4 flex flex-col items-start">
            <div class="flex items-start">
                <img src={userpng} class="w-[20px] h-auto" alt="">
                <p class="text-gray-500 ms-2 relative top-[1px]">Welcome, <span class="text-white">{data.user[0].username}</span></p>
            </div>
            <div class="mt-4 relative">
                <img src={data.user[0].avatar+".png"} 
                alt="" 
                class="w-50 rounded-full border-4 border-white shadow-xl shadow-gray-500/50 hover:shadow-2xl hover:shadow-gray-700/50 transition-all duration-300"
                onmouseover="{pictureHover}"
                onmouseout="{pictureLeave}">
                <button class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 opacity-0 hover:opacity-100 transition-opacity duration-300 bg-transparent border-0 p-0 w-10 h-10 rounded-full"  id="picChangebtn">
                    <i class="fas fa-sync-alt text-white text-3xl"></i>
                </button>
            </div>
        </div>        
    </div>
</div>



<style>
    @media (max-width: 768px) { /* md breakpoint in Tailwind */
        .changeHeight {
            height: calc(100vh - 96px) !important;
        }
    }
    @media (min-width: 768px) { /* md breakpoint in Tailwind */
        .changeHeight {
            height: calc(100vh - 88px) !important;
        }
    }

</style>