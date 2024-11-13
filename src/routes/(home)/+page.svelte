<script>
    import banner from "$lib/media/videos/banner.mp4";
    let isLoading = true;

</script>

<<<<<<< HEAD
<header class="w-[1440px] xl:w-screen">
=======
<header class="md:w-[1920px]">
>>>>>>> 8d5e8a9f35495c2ffcde52d59b13fa2fe4be90eb
    <video  src={banner} autoplay muted loop class=" blur-sm drop-shadow-none sepia-0">
    <div class="overlay">
        <p>asd</p>
    </div>
</header>


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
</style>
