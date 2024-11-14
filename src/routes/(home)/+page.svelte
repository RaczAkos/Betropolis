<script>
    import banner from "$lib/media/videos/banner.mp4";
</script>

<header class="w-[1440px] xl:w-screen">
    <video  src={banner} autoplay muted loop class=" blur-sm drop-shadow-none sepia-0">
    <div class="overlay">
        <p>asd</p>
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

    .overlay{
        position:absolute;
        top:50%;
        left:50%;
        z-index:1;
        color: white;
    }
    td{
        height: 60px;
    }
</style>
