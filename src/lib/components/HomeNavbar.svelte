<script>
	import logo from '$lib/media/images/logo.png';
    let { signin, signup, linksignin, linksignup } = $props();
</script>

<nav>
    <div class="w-screen flex justify-between max-sm:hidden borgens">
        <div class="place-items-start w-1/3 place-content-center">
            <div class="text-2xl inline-block ms-5 p-2 shadow-lg  text-white border rounded-md hover:bg-yellow-600 hover:text-black hover:border-yellow-600">
                <a href="/conditions"><h1>Rules & Games</h1></a>
            </div>
        </div>
        <div class="w-1/3 place-items-center place-content-center grid p-1">
            <a href="/">
                <img src="{logo}" alt="Casino Logo" class="h-[90px]">
            </a>
        </div>
        <div class="place-content-center w-1/3 place-items-end">
            <div class="text-2xl inline-block float-end p-2 border rounded-md bg-yellow-600 text-black border-yellow-600 me-5 hover:scale-110">
                <a href={linksignup}><h1>{signup}</h1></a>
            </div>
            <div class="text-2xl inline-block float-end p-2 shadow-lg text-white border rounded-md hover:bg-yellow-600 hover:text-black hover:border-yellow-600 me-3">
                <a href={linksignin}><h1>{signin}</h1></a>
            </div>
        </div>
    </div>
    <div class="sm:hidden p-2">
        <img src="{logo}" alt="Casino Logo" class="h-[90px]">
    </div>
</nav>

<style>
    nav{
        background: rgb(0,0,0);
        background: linear-gradient(90deg, rgba(0,0,0,1) 30%, rgba(165, 128, 5, 0.705) 50%, rgba(0,0,0,1) 70%);
    }
</style>