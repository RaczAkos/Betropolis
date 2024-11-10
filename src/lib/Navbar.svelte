<script>
	import logo from '$lib/media/images/logo.png';
</script>

<nav>
    <div class="justify-center w-screen relative">
        <div class="navone absolute">
            <div class="navsec inline-block text-white border rounded-md hover:bg-yellow-600 hover:text-black hover:border-yellow-600">
                <a href="/conditions"><h1>Terms & conditions</h1></a>
            </div>
            <div class="navsec inline-block text-white border rounded-md hover:bg-yellow-600 hover:text-black hover:border-yellow-600">
                <a href="/policy"><h1>Privacy Policy</h1></a>
            </div>
        </div>
        <div class="flex flex-row justify-center items-center">
            <img src="{logo}" alt="">
        </div>
        <div class="navone absolute inset-y-0 right-0 align-middle">
            <div class="navsec inline-block text-white border rounded-md hover:bg-yellow-600 hover:text-black hover:border-yellow-600">
                <a href="/login"><h1>Log in</h1></a>
            </div>
            <div class="navsec inline-block border rounded-md bg-yellow-600 text-black border-yellow-600">
                <a href="/signUp"><h1>Sign up</h1></a>
            </div>
        </div>
    </div>
</nav>