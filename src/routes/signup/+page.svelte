<svelte:head>
    <title>Sign up! - Betropolis</title>
    <meta name="description" content="The sign up page of Betropolis Casino!">
</svelte:head>

<script lang="ts">
    import logo from "$lib/media/images/logo.png";

    let tabswitch:boolean = $state(false),
        firstname:string  = $state(""),
        lastname:string   = $state(""),
        username:string   = $state(""),
        birthdate:string  = $state(""),
        gender:string     = $state(""),
        date:Date         = new Date(),
        error:HTMLElement;

    let currentDate:string = date.getFullYear() + "-" + Number(date.getMonth()+1)+ "-" + 11;
    console.log(currentDate)
        

    function tabcheck() {
        let strRegex = /^[a-zA-Z]+$/;

        if (firstname == "" || lastname == "") error.innerHTML = "Please add your first and last name!";
        if (!strRegex.test(firstname) && !strRegex.test(lastname)) error.innerHTML = "First and last name should only contain letters!";
        else if (gender == "") error.innerHTML = "Please select a gender!";
        else if (birthdate == "") error.innerHTML = "Please select your birth date!";
        else if(Number(birthdate.split('-')[0]) < 1900 || Number(date.getFullYear)-1 < Number(birthdate.split('-')[0])) error.innerHTML = "Please give your real birth date!";
        else if (false) error.innerHTML = "You need to be at least 18 years old to sign up!"
        else {
            tabswitch = true;
            error.innerHTML = "";
        } 
    }
</script>

<form class=" bg-black shadow-md rounded px-8 pt-6 pb-8 select-none border-double border-yellow-600 border-4">

    <!-- Logo, Welcome -->
    <div class="flex justify-center items-center" data-sveltekit-reload>
        <a href="/"><img src={logo} alt="Casino Logo" class="self-center"></a>
    </div>
    <div class="w-full text-center text-yellow-600 text-xl font-bold my-2 italic">Welcome to Betropolis! </div>

    <div class:hidden={tabswitch}>

        <!-- Name, Username -->
        <div class="flex flex-row max-sm:flex-col mb-2">
            <div class="basis-1/2 p-1">
                <label class="block text-yellow-600 text-md font-bold mb-2" for="firstname">First name {birthdate} <span class="text-sm italic">(required)</span></label>
                <input bind:value={firstname} type="text" placeholder="First name" class="shadow appearance-none border-2 border-yellow-600 rounded w-full py-2 px-3 placeholder:text-yellow-600 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black">
            </div>
            <div class="basis-1/2 p-1">
                <label class="block text-yellow-600 text-md font-bold mb-2" for="lastname">Last name <span class="text-sm italic">(required)</span></label>
                <input bind:value={lastname} type="text" placeholder="Last name" class="shadow appearance-none border-2 border-yellow-600 rounded w-full py-2 px-3 placeholder:text-yellow-600 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black">
            </div>
        </div>
        <div class="mb-2 p-1">
            <label class="block text-yellow-600 text-md font-bold mb-2" for="username">Username <span class="text-sm italic">(required)</span></label>
            <input bind:value={username} type="text" placeholder="Username" class="shadow appearance-none border-2 border-yellow-600 rounded w-full py-2 px-3 placeholder:text-yellow-600 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black">
        </div>
        
        <div class="flex flex-row max-sm:flex-col p-1 mb-2 gap-2">
            
            <!-- Date of birth -->
            <div class="relative max-w-sm basis-1/2">
                <div class="block text-yellow-600 text-md font-bold p-1">Date of birth <span class="text-sm italic">(required)</span></div>
                <input bind:value={birthdate} min="1900-01-01" max={currentDate} type="date" class="bg-black outline-none border-2 text-yellow-600 text-md rounded-lg focus:ring-yellow-600 border-yellow-600 block w-full p-2 text-center">
            </div>
            
            <!-- Gender select -->
            <div class="basis-1/2 p-1">
                <p class="block text-yellow-600 font-bold text-md">Gender <span class="text-sm italic">(required)</span></p>
                <div class="flex flex-row justify-center items-center h-2/3 gap-2">
                    <div>
                        <input bind:group={gender} value="male" id="default-radio-1" type="radio" name="default-radio" class="w-4 h-4 accent-yellow-600 bg-black border-yellow-600 focus:ring-yellow-600 ">
                        <label for="default-radio-1" class="ms-1 text-md font-medium text-yellow-600">Male</label>
                    </div>
                    <div>
                        <input bind:group={gender} value="female" id="default-radio-2" type="radio" name="default-radio" class="w-4 h-4 accent-yellow-600 bg-black border-yellow-600 focus:ring-yellow-600 ">
                        <label for="default-radio-2" class="ms-1 text-md font-medium text-yellow-600">Female</label>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class:hidden={!tabswitch}>
        <div class="mb-2 p-1">
            <label class="bloc text-yellow-600 text-sm font-bold mb-2" for="password">
              Password <span class="text-sm italic">(required)</span>
            </label>
            <input id="password" type="password" class="shadow appearance-none border border-red-500 rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline">
        </div> 
        <div class="mb-4 p-1">
          <label class="bloc text-yellow-600 text-sm font-bold mb-2" for="passwordconfirm">Password</label>
          <input id="passwordconfirm" type="password" class="shadow appearance-none border border-red-500 rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline">
        </div>
    </div>
    
    
    <div bind:this={error} class="text-red-600 my-2 text-center font-bold"></div>

    <div class="w-full text-center" class:hidden={tabswitch}>
        <button class="hover:bg-yellow-600 bg-black border border-yellow-600 hover:-translate-y-1 text-yellow-600 hover:text-black font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline duration-300" type="button" onclick={tabcheck}>Continue</button>
    </div>
    <div class="w-full text-center" class:hidden={!tabswitch}>
        <button class="hover:bg-yellow-600 bg-black border border-yellow-600 hover:-translate-y-1 text-yellow-600 hover:text-black font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline duration-300 me-2" type="button" onclick={() => tabswitch = false}>Go back</button>
        <button class="hover:bg-yellow-600 bg-black border border-yellow-600 hover:-translate-y-1 text-yellow-600 hover:text-black font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline duration-300" type="button">Sign up</button>
    </div>


</form>
