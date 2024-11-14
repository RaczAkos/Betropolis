<script>
    import banner from "$lib/media/videos/banner.mp4";
</script>

<header class="w-[1440px] xl:w-screen">
    <div class="relative text-center">
        <video  src={banner} autoplay muted loop class=" blur-sm drop-shadow-none sepia-0">
        </video>
        <div class="overlay w-screen absolute top-0 left-0 px-20 ">
            <p class="text-xl text-yellow-600">Welcome to Betropolis — your ultimate online destination for thrilling casino games and endless entertainment! Step into a world where the excitement never stops, and every spin, card flip, and roll of the dice brings you closer to unforgettable winnings. At Betropolis, we combine top-tier games, cutting-edge security, and seamless gameplay to create a premium online casino experience.</p>
        </div>
    </div>

</header>
<div class="grid grid-cols-1">
    <table class="text-yellow-600 text-center border-separate [border-spacing:0.75rem] select-none border-spacing-2">
        <thead>
            <tr>
                <td colspan=5 class="text-xl">
                    Choose a card for chance for a free starting bonus!
                </td>
            </tr>
        </thead>
        <tbody class="text-center max-sm:justify-center">
            
        </tbody>
                    <!--<a href="/login" class="font-bold underline">Claim now!</a>-->
    </table>
</div>


<style>
    :global(body){
        overflow-x: hidden;
    }

    td{
        height: 60px;
    }
</style>
