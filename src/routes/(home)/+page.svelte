<script>
    import banner from "$lib/media/videos/banner.mp4";
    let isLoading = true;

</script>


<header class="">
    <video  src={banner} autoplay muted loop class=" blur-sm drop-shadow-none sepia-0"></video>
</header>


<style>
    video{
        width: 100%;
    }

:global(body){
    background-color: black;
}
</style>
