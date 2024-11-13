<script>
    import banner from "$lib/media/videos/banner.mp4";
    let isLoading = true;

</script>

<header class="w-[1440px] xl:w-screen">
    <video  src={banner} autoplay muted loop class=" blur-sm drop-shadow-none sepia-0">
    <div class="overlay">
        <p>asd</p>
    </div>
</header>


<style>
    header{
        
    }
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
</style>
