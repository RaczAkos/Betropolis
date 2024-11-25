<script>
    import logo from "$lib/media/images/logo.png";
</script>

<footer class="bg-transparent select-none borgens">
    <div class="w-full mx-auto md:py-4 p-3 text-yellow-600">
        <div class="sm:flex sm:items-center sm:justify-between md:ps-9">
            <a href="/" class="flex items-center max-md:flex-col mb-0 space-x-3 rtl:space-x-reverse">
                <img src={logo} class="max-md:h-32 h-24" alt="Casino logo" />
            </a>
            <ul id='alma' class="flex flex-wrap max-md:flex-col items-center text-xl font-medium mt-5">
                <li>
                    <a href="/login" class="hover:underline sm:me-6">Login</a>
                </li>
                <li>
                    <a href="/about" class="hover:underline sm:me-6">About</a>
                </li>
                <li>
                    <a href="/terms&conditions" class="hover:underline sm:me-6">Terms & Conditions</a>
                </li>
                <li>
                    <a href="/privacy-policy" class="hover:underline sm:me-6">Privacy Policy</a>
                </li>
            </ul>
        </div>
        <hr class="sm:mx-auto border-yellow-600 my-4"/>
        <span class="block text-md text-center">© 2025 - Tamás Szabó, Rácz Ákos Csaba - All Rights Reserved.</span>
    </div>
</footer>