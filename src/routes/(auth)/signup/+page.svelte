<script>
    import logo from "$lib/media/images/logo.png";
</script>

<form class=" bg-black shadow-md rounded px-8 pt-6 pb-8 select-none border-double border-yellow-600 border-4">

    <!-- Logo, Welcome -->
    <div class="flex justify-center items-center">
        <a href="/">
            <img src={logo} alt="Casino Logo" class="self-center">
        </a>
    </div>
    <div class="w-full text-center text-yellow-600 text-xl font-bold my-2 italic">
        Welcome to Betropolis!
    </div>

    <!-- Name, Username -->
    <div class="flex flex-row max-sm:flex-col">
        <div class="basis-1/2 p-1">
            <label class="block text-yellow-600 text-md font-bold mb-2" for="firstname">
                First name <span class="text-sm italic">(required)</span>
            </label>
            <input id="firstname" type="text" placeholder="First name" class="shadow appearance-none border-2 border-yellow-600 rounded w-full py-2 px-3 placeholder:text-yellow-600 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black">
        </div>
        <div class="basis-1/2 p-1">
            <label class="block text-yellow-600 text-md font-bold mb-2" for="lastname">
                Last name <span class="text-sm italic">(required)</span>
            </label>
            <input id="lastname" type="text" placeholder="Last name" class="shadow appearance-none border-2 border-yellow-600 rounded w-full py-2 px-3 placeholder:text-yellow-600 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black">
        </div>
    </div>
    <div class="mb-2 p-1">
      <label class="block text-yellow-600 text-md font-bold mb-2" for="username">
        Username <span class="text-sm italic">(required)</span>
      </label>
      <input id="username" type="text" placeholder="Username" class="shadow appearance-none border-2 border-yellow-600 rounded w-full py-2 px-3 placeholder:text-yellow-600 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black">
    </div>

    <!-- Date of birth -->
    <div class="block text-yellow-600 text-md font-bold p-1">Date of birth <span class="text-sm italic">(required)</span></div>
    <div class="flex flex-row p-1 mb-2">
        <select id="day" class="basis-1/3 block py-2.5 text-sm text-yellow-600 bg-transparent border-0 border-b-2 border-yellow-600 appearance-none focus:outline-none focus:ring-0 focus:border-gray-200">
            <option selected hidden>Day</option>
            {#each {length: 31} as _, i}
                <option value={i+1} class="bg-black">
                    Day: {#if i+1 < 10}0{i+1}{:else}{i+1}{/if}
                </option>
            {/each}
        </select>
        <select id="month" class="basis-1/3 block py-2.5 text-sm text-yellow-600 bg-transparent border-0 border-b-2 border-yellow-600 appearance-none focus:outline-none focus:ring-0 focus:border-gray-200">
            <option selected hidden>Month</option>
            {#each {length: 12} as _, i}
                <option value={i+1} class="bg-black">
                    Month: {#if i+1 < 10}0{i+1}{:else}{i+1}{/if}
                </option>
            {/each}
        </select>
        <select id="year" class="basis-1/3 block py-2.5 text-sm text-yellow-600 bg-transparent border-0 border-b-2 border-yellow-600 appearance-none  focus:outline-none focus:ring-0 focus:border-gray-200">
            <option selected hidden>Year</option>
            {#each {length: 2024} as _, i}
                <option value={i+1} class="bg-black">
                    Year: {i+1}
                </option>
            {/each}
        </select>
    </div>

    <!-- Gender select -->
    <div class="mb-4 p-1">
        <p class="block text-yellow-600 font-bold text-md">Gender <span class="text-sm italic">(required)</span></p>
        <div class="inline-block">
            <input id="default-radio-1" type="radio" value="" name="default-radio" class="w-4 h-4 accent-yellow-600 bg-black border-yellow-600 focus:ring-yellow-600 ">
            <label for="default-radio-1" class="ms-2 text-sm font-medium text-yellow-600">Male</label>
        </div>
        <div class="inline-block">
            <input checked id="default-radio-2" type="radio" value="" name="default-radio" class="w-4 h-4 accent-yellow-600 bg-gray-100 border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
            <label for="default-radio-2" class="ms-2 text-sm font-medium text-yellow-600">Female</label>
        </div>
    </div>
    
    <div class="w-full text-center">
      <button class="bg-yellow-600 hover:bg-black border border-yellow-600 hover:-translate-y-1 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline duration-300" type="button">
        Continue
      </button>
    </div>

    
    <div class="hidden">
        <div class="mb-4 p-1">
            <label class="bloc text-yellow-600 text-sm font-bold mb-2" for="password">
              Password <span class="text-sm italic">(required)</span>
            </label>
            <input id="password" type="password" class="shadow appearance-none border border-red-500 rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline">
        </div> 
        <div class="mb-4 p-1">
          <label class="bloc text-yellow-600 text-sm font-bold mb-2" for="password">
            Password
          </label>
          <input id="password" type="password" class="shadow appearance-none border border-red-500 rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline">
        </div>
    </div>
</form>
