<svelte:head>
    <title>Sign up! - Betropolis</title>
    <meta name="description" content="The sign up page of Betropolis Casino!">
</svelte:head>

<script lang="ts">
    import logo from "$lib/media/images/logo.png";

    let tabswitch:boolean  = $state(true),
        firstname:string   = $state(""),
        lastname:string    = $state(""),
        username:string    = $state(""),
        birthdate:string   = $state(""),
        gender:number|null = $state(null),
        email:string       = $state(""),
        password:string    = $state(""),
        password2:string   = $state(""),
        passconf:boolean   = $state(false),
        date:Date          = new Date(),
        error:HTMLElement;

    async function sendData(){
        const response = await fetch('/api/submit-data', {
            method: 'POST',
            headers: {
            'Content-Type': 'application/json',
            },
            body: JSON.stringify({ firstname, lastname, birthdate, gender, email, password, date}),
        });
    }
    

    let currentDate:string = date.getFullYear() + "-" + Number(date.getMonth()+1)+ "-" + date.getDate();
        

    // Data validation before tab switching
    function tabcheck() {
        let strRegex = /^[a-zA-Z]+$/;

        if (firstname == "" || lastname == "") error.innerHTML = "Please add your first and last name!";
        if (!strRegex.test(firstname) && !strRegex.test(lastname)) error.innerHTML = "First and last name should only contain letters!";
        else if (!gender) error.innerHTML = "Please select a gender!";
        else if (birthdate == "") error.innerHTML = "Please select your birth date!";
        else if(Number(birthdate.split('-')[0]) < 1900 || Number(date.getFullYear())-1 < Number(birthdate.split('-')[0])) error.innerHTML = "Please give your real birth date!";
        else if (dateChecker()) error.innerHTML = "You need to be at least 18 years old to sign up!";
        else if (username == "") error.innerHTML = "Please add your username!";
        // db username check error.innerHTML = "Given username is already taken, try something else!";
        else {
            tabswitch = true;
            error.innerHTML = "";
        } 
    }

    // Checking if the user is over 18
    function dateChecker(){
        if (Number(birthdate.split('-')[0]) < Number(date.getFullYear())-18) return false;
        else if (Number(birthdate.split('-')[0]) == Number(date.getFullYear())-18) {
            if (Number(birthdate.split('-')[1]) < Number(date.getMonth())+1) return false;
            else if (Number(birthdate.split('-')[1]) ==  Number(date.getMonth())+1){
                if (Number(birthdate.split('-')[2]) < date.getDate()) return false;
            } 
        }
        return true;
    }
</script>

<form class=" bg-black shadow-md rounded px-8 pt-6 pb-8 select-none border-double border-yellow-600 border-4">

    <!-- Logo, Welcome -->
    <div class="flex justify-center items-center" data-sveltekit-reload>
        <a href="/"><img src={logo} alt="Casino Logo" class="self-center"></a>
    </div>
    <div class="w-full text-center text-yellow-600 text-xl font-bold my-2 italic">Welcome to Betropolis!</div>

    <div class:hidden={tabswitch}>

        <!-- Name, Username -->
        <div class="flex flex-row max-sm:flex-col mb-2">
            <div class="basis-1/2 p-1">
                <label class="block text-yellow-600 text-md font-bold mb-1 text-center" for="firstname">First name <span class="text-sm italic">(required)</span></label>
                <input bind:value={firstname} type="text" placeholder="First name" class="text-center shadow appearance-none border-2 border-yellow-600 rounded w-full py-2 px-3 placeholder:text-yellow-600 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black">
            </div>
            <div class="basis-1/2 p-1">
                <label class="block text-yellow-600 text-md font-bold mb-1 text-center" for="lastname">Last name <span class="text-sm italic">(required)</span></label>
                <input bind:value={lastname} type="text" placeholder="Last name" class=" text-center shadow appearance-none border-2 border-yellow-600 rounded w-full py-2 px-3 placeholder:text-yellow-600 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black">
            </div>
        </div>
        <div class="mb-2 p-1">
            <label class="block text-yellow-600 text-md font-bold mb-1 text-center" for="username">Username <span class="text-sm italic">(required)</span></label>
            <input bind:value={username} type="text" placeholder="Username" class="text-center shadow appearance-none border-2 border-yellow-600 rounded w-full py-2 px-3 placeholder:text-yellow-600 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black">
        </div>
        
        <div class="flex flex-row max-sm:flex-col p-1 mb-2 gap-2">
            
            <!-- Date of birth -->
            <div class="relative max-w-sm basis-1/2">
                <div class="block text-yellow-600 text-md font-bold p-1 text-center">Date of birth <span class="text-sm italic">(required)</span></div>
                <input bind:value={birthdate} min="1900-01-01" max={currentDate} type="date" class="bg-black outline-none border-2 text-yellow-600 text-md rounded-lg focus:ring-yellow-600 border-yellow-600 block w-full p-2 text-center">
            </div>
            
            <!-- Gender select -->
            <div class="basis-1/2 p-1">
                <p class="block text-yellow-600 font-bold text-md text-center">Gender <span class="text-sm italic">(required)</span></p>
                <div class="flex flex-row justify-center items-center h-2/3 gap-3">
                    <div>
                        <input bind:group={gender} value=1 id="default-radio-1" type="radio" name="gender" class="w-4 h-4 accent-yellow-600 bg-black border-yellow-600 focus:ring-yellow-600 ">
                        <label for="gender-male" class="ms-1 text-md font-medium text-yellow-600">Male</label>
                    </div>
                    <div>
                        <input bind:group={gender} value=0 id="gender-female" type="radio" name="gender" class="w-4 h-4 accent-yellow-600 bg-black border-yellow-600 focus:ring-yellow-600 ">
                        <label for="gender-female" class="ms-1 text-md font-medium text-yellow-600">Female</label>
                    </div>
                </div>
            </div>
        </div>
    </div>
        
    <div class:hidden={!tabswitch}>
        <div class="mb-2 p-1">
            <label class="block text-yellow-600 text-md font-bold mb-1" for="email">E-mail <span class="text-sm italic">(required)</span></label>
            <input bind:value={email} type="text" placeholder="E-mail" id="email" class="shadow appearance-none border-2 border-yellow-600 rounded w-full py-2 px-3 placeholder:text-yellow-600 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black">
        </div>
        <div class="mb-2 p-1">
            <label class="block text-yellow-600 text-md font-bold mb-1" for="username">Password <span class="text-sm italic">(required)</span></label>
            <input bind:value={password} type="password" placeholder="Password" class="shadow appearance-none border-2 border-yellow-600 rounded w-full py-2 px-3 placeholder:text-yellow-600 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black">
            <span></span>
        </div>
        <div class="mb-2 p-1">
            <label class="block text-yellow-600 text-md font-bold mb-1" for="passconf">Confirm Password</label>
            <input bind:value={password2} type="password" id="passconf" placeholder="Password again" class="shadow appearance-none border-2 border-yellow-600 rounded w-full py-2 px-3 placeholder:text-yellow-600 text-yellow-600 leading-tight focus:outline-none focus:shadow-outline bg-black">
        </div>
    </div>
    
    <div bind:this={error} class="text-red-600 my-2 text-center font-bold"></div>
    
    <div class="w-full text-center" class:hidden={tabswitch}>
        <button class="hover:bg-yellow-600 bg-black border border-yellow-600 hover:-translate-y-1 text-yellow-600 hover:text-black font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline duration-300" type="button" onclick={tabcheck}>Continue</button>
    </div>
    <div class="w-full text-center" class:hidden={!tabswitch}>
        <button class="hover:bg-yellow-600 bg-black border border-yellow-600 hover:-translate-y-1 text-yellow-600 hover:text-black font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline duration-300 me-2" type="button" onclick={() => tabswitch = false}>Go back</button>
        <button class="hover:bg-yellow-600 bg-black border border-yellow-600 hover:-translate-y-1 text-yellow-600 hover:text-black font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline duration-300" type="button" onclick={sendData}>Sign up!</button>
    </div>


</form>

<style>

    input[type="date"] {
        position: relative;
        appearance: none;
        -webkit-appearance: none;
        box-sizing: border-box;
    }

    input[type="date"]::-webkit-calendar-picker-indicator {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        width: 16px;
        height: 16px;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" fill="goldenrod" viewBox="0 0 24 24"><path d="M7 10l5 5 5-5H7z"/></svg>') no-repeat center;
        background-size: contain;
        cursor: pointer;
        opacity: 1;
    }






</style>