<script>
	import logo from '$lib/media/images/logo.png';
</script>

<nav>
    <div class="w-screen flex justify-between max-sm:hidden">
        <div class="place-items-start w-1/3 place-content-center">
            <div class="text-2xl inline-block ms-5 p-2 shadow-lg shadow-yellow-600 text-white border rounded-md hover:bg-yellow-600 hover:text-black hover:border-yellow-600">
                <a href="/conditions"><h1>Rules & Games</h1></a>
            </div>
        </div>
        <div class="w-1/3 place-items-center place-content-center grid p-1">
            <img src="{logo}" alt="Casino Logo" class="h-24">
        </div>
        <div class="place-content-center w-1/3 place-items-end">
            <div class="text-2xl inline-block float-end p-2 border rounded-md bg-yellow-600 text-black border-yellow-600 me-5">
                <a href="/signUp"><h1>Sign up</h1></a>
            </div>
            <div class="text-2xl inline-block float-end p-2 shadow-lg shadow-yellow-600 text-white border rounded-md hover:bg-yellow-600 hover:text-black hover:border-yellow-600 me-3">
                <a href="/login"><h1>Log in</h1></a>
            </div>
        </div>
    </div>
</nav>