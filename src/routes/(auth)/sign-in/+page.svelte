<script>
  import logo from "$lib/media/images/logo.png";
  let val = $state("");
</script>

<form class="bg-black shadow-md rounded px-8 pt-6 pb-8 select-none border-double border-4 border-yellow-600">
  <div class="flex justify-center items-center" data-sveltekit-reload>
    <a href="/">
      <img src={logo} alt="" class="self-center">
    </a>
  </div>
  <div class="mb-4">
    <label class="block text-yellow-600 text-sm font-bold mb-2" for="username">
      Username
    </label>
    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="username" type="text" placeholder="Username">
  </div>
  <div class="mb-6">
    <label class="bloc text-yellow-600 text-sm font-bold mb-2" for="password">
      Password
    </label>
    <input id="password" bind:value={val} class=" appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none " type="password" placeholder="******************" class:border-red-500|important = {val.toString().length < 8}>
      <p id="hided" class="text-red-500 text-xs italic" style:opacity = {val.toString().length > 8 ? "0 " : "100"} >Please choose a password.</p>
      <label class="text-sm font-bold mb-2 text-yellow-600 cursor-pointer">
        <input type="checkbox" name="remember" class=" accent-yellow-600"> Show password
      </label>
    <a class="inline-block align-baseline font-bold text-sm text-yellow-600 hover:underline italic ps-5" href="">
      Forgot Password?
    </a>
  </div>
  <div class="flex justify-center items-center mb-1">
    <button class="bg-yellow-600 hover:bg-black border-yellow-600 border hover:border-opacity-100 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline duration-300 hover:-translate-y-1" type="button">
      Sign In
    </button>
  </div>
  <a class="underline text-yellow-600 flex justify-center items-center" href="/signup">Don't have an account?</a>
</form>