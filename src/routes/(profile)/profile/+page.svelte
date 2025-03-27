<script lang="ts">
    import userpng from "$lib/media/images/profile/user.png";
    import flymoney from "$lib/media/images/profile/flying-money.png";
    import income from "$lib/media/images/profile/income.png";
    import joystick from "$lib/media/images/profile/joystick.png";
    import chip from "$lib/media/images/chip.png";

    let { data } = $props();

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
            <div class="mt-4 w-[90%] bg-[#141a22] mx-auto rounded-lg p-8 flex items-center gap-8">
                <!-- Avatar Section -->
                <div class="relative transition-all duration-300 lg:w-[170px] md:w-[150px] sm:w-[120px] w-[100px] flex-shrink-0">
                    <img src={data.user[0].avatar+".png"} 
                         alt="User Avatar" 
                         class="rounded-full border-4 border-white shadow-xl shadow-gray-500/50 hover:shadow-2xl hover:shadow-gray-700/50 transition-all duration-300"
                         onmouseover="{pictureHover}"
                         onmouseout="{pictureLeave}">
            
                    <button class="absolute top-[45%] left-1/2 -translate-x-1/2 -translate-y-1/2 opacity-0 hover:opacity-100 transition-opacity duration-300 bg-transparent border-0 p-0 w-10 h-10 rounded-full" id="picChangebtn">
                        <i class="fas fa-sync-alt text-white text-3xl"></i>
                    </button>
            
                    <div class="mt-4 text-center">
                        <p class="text-yellow-600 text-xl max-sm:text-lg inline">
                            <img src="{chip}" alt="Chip Icon" class="w-[20px] inline">{data.user[0].balance}
                        </p>
                    </div>
                </div>
            
                <!-- Scrollable Profile Stats Section -->
                <div class="w-full overflow-x-auto">
                    <div class="min-[1311px]:grid min-[1311px]:grid-cols-3 gap-4 
                                max-[1310px]:flex max-[1310px]:space-x-2 overflow-x-auto">
                        <!-- Chips Spent -->
                        <div class="bg-[#040d17] drop-shadow-lg p-4 text-center rounded-lg min-w-[240px]">
                            <img src="{flymoney}" alt="Chips Spent" class="w-[100px] mx-auto">
                            <p class="text-gray-500 py-3 text-lg">Chips Spent</p>
                            <p class="inline text-yellow-600 text-lg"><img src="{chip}" alt="Chip Icon" class="w-[20px] inline pb-1">1500</p>
                        </div>
            
                        <!-- Chips Earned -->
                        <div class="bg-[#040d17] drop-shadow-lg p-4 text-center rounded-lg min-w-[240px]">
                            <img src="{income}" alt="Chips Earned" class="w-[100px] mx-auto">
                            <p class="text-gray-500 py-3 text-lg">Chips Earned</p>
                            <p class="inline text-yellow-600 text-lg"><img src="{chip}" alt="Chip Icon" class="w-[20px] inline pb-1">1500</p>
                        </div>
            
                        <!-- Last Game Played -->
                        <div class="bg-[#040d17] drop-shadow-lg p-4 text-center rounded-lg min-w-[240px]">
                            <img src="{joystick}" alt="Last Game Played" class="w-[100px] mx-auto">
                            <p class="text-gray-500 py-3 text-lg">Last Game Played</p>
                            <p class="text-pink-600 text-lg">Fruit-frenzy-classic</p>
                        </div>
                    </div>
                </div>
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