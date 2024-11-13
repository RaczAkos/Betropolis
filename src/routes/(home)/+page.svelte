<script>
    import banner from "$lib/media/videos/banner.mp4";
    let isLoading = true;

</script>

<header class="">
    <video  src={banner} autoplay muted loop class=" blur-sm drop-shadow-none sepia-0">
    <div class="overlay">
        <p>asd</p>
    </div>
</header>


<style>
    video{
        width: 100vw;
    }

    .overlay{
        position:absolute;
        top:50%;
        left:50%;
        z-index:1;
        color: white;
    }
</style>
