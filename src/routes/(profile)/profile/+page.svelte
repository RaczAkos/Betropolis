<script lang="ts">
    import userpng from "$lib/media/images/profile/user.png";
    import { onMount } from "svelte";

    export let data;


</script>

<div class="w-screen bg-[#141a22] justify-center items-center flex changeHeight">    
    <div class="w-[85vw] h-[75vh] bg-[#040d17] flex mx-auto rounded-lg shadow-2xl shadow-[#040d17] flex-col">
        <!--Greeting and Profile data-->
        <div class="ps-4 pt-4 flex flex-col items-start">
            <div class="flex items-start">
                <img src={userpng} class="w-[20px] h-auto" alt="">
                <p class="text-gray-500 ms-2 relative top-[1px]">Welcome, <span class="text-white">{data.user[0].username}</span></p>
            </div>
            <div class="mt-4">
                <img src={data.user[0].avatar+".png"} alt="" class="w-50">
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