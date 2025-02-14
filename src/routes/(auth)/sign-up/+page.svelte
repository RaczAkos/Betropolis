<svelte:head>
    <title>Sign up! - Betropolis</title>
    <meta name="description" content="Welcome to Betropolis — your ultimate online destination for thrilling casino games and endless entertainment! Step into a world where the excitement never stops, and every spin, card flip, and roll of the dice brings you closer to unforgettable winnings. At Betropolis, we combine top-tier games, cutting-edge security, and seamless gameplay to create a premium online casino experience." />
</svelte:head>

<script lang="ts">
    import Input from "$lib/components/Input.svelte";

    interface Registration {
        name:string,
        username:string,
        birthdate:string,
        gender:string|null,
        email:string,
        password:string
    }

    let user: Registration = $state({
            name: "",
            username: "",
            birthdate: "",
            gender: null,
            email: "",
            password: ""
        }),
        type:string      = $state("password"),
        password2:string = $state(""),
        passConf:boolean = $state(false),
        passFormat:boolean = $state(false),
        date = new Date(),
        month = (Number(date.getMonth()) < 9)? "0"+(Number(date.getMonth())+1):date.getMonth()+1,
        day = (date.getDate() < 10)? "0"+date.getDate():date.getDate(),
        currentDate = `${date.getFullYear()-18}-${month}-${day}`,
        conditions:HTMLInputElement,
        over18:HTMLInputElement,
        valid = $state(false);

    // Sign up
    async function signUp(){
        const response = await fetch('/api/sign-up', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(user)
        });
    }

    // Checking password
    $effect(() => {
        passFormat = /^.*(?=.{8,})(?=.*[a-zA-Z])(?=.*\d)(?=.*[.!#$%&? "]).*$/.test(user.password);
        if (passFormat) passConf = (user.password == password2)? true : false;
    })

    // Checking fields
    $effect(() => {
        if ((user.name.length > 3 && user.name.indexOf(' ')) && 
            user.username.length > 4 &&
            user.gender && 
            user.birthdate != "" &&
            /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(user.email) &&
            passConf &&
            conditions.checked &&
            over18.checked
        ) {
            valid = true;
        }
    })
    console.log(currentDate)
    
</script>

<div class="flex sm:flex-row flex-col sm:w-[500px]">

    <div class="sm:w-1/2">
        <!-- Name -->
        <Input id="name" 
        bind:value={user.name}
        label="Full name"/>
        
        <!-- Username -->
        <div class="my-2">
            <Input id="name" 
            bind:value={user.username}
            label="Username" />
        </div>
        
        <!-- Date of birth -->
        <div class="relative">
            <div class="block text-yellow-600 text-md font-bold p-1">Date of birth</div>
            <input bind:value={user.birthdate} max={currentDate} type="date" class="bg-black outline-none border-2 text-yellow-600 text-md rounded-lg focus:ring-yellow-600 border-yellow-600 block w-full p-2 text-center">
        </div>
        <div class="flex flex-row max-sm:flex-col p-1 mb-2 gap-2">
            
            <!-- Gender -->
            <div class="w-full mt-2">
                <p class="block text-yellow-600 font-bold text-md">Gender</p>
                <div class="flex flex-row justify-center items-center h-2/3 gap-3">
                    <div class="basis-1/2">
                        <input bind:group={user.gender} 
                               value='M' 
                               id="gender-male" 
                               type="radio" 
                               name="gender" 
                               class="w-4 h-4 accent-yellow-600 bg-black border-yellow-600 focus:ring-yellow-600 ">
                        <label for="gender-male" 
                               class="ms-1 text-md font-medium text-yellow-600">
                            Male
                        </label>
                    </div>
                    <div class="basis-1/2">
                        <input bind:group={user.gender} 
                               value='F' 
                               id="gender-female" 
                               type="radio" 
                               name="gender" 
                               class="w-4 h-4 accent-yellow-600 bg-black border-yellow-600 focus:ring-yellow-600">
                        <label for="gender-female" 
                               class="ms-1 text-md font-medium text-yellow-600">
                            Female
                        </label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="sm:ms-4 sm:w-1/2">
        <!-- E-mail -->
        <div class="mb-2">
            <Input bind:value={user.email}
            id="email" 
            type="email" 
            label="E-mail"/>
        </div>

        <!-- Password -->
        <div class="mb-2">
            <Input bind:value={user.password} 
                   id="password" 
                   {type} 
                   label="Password"/>
            <div class:text-green-400={passFormat} 
                 class:opacity-100={passFormat} 
                 class="text-gray-300 opacity-50 text-xs text-wrap !text-justify m-1">
                 Password must be at least 8 characters, containing at least 1 uppercase, 1 lowercase and 1 number character.
            </div>
            
            <!-- Show password -->
            <div class="flex justify-center">
              <label class="text-sm font-bold mb-2 text-yellow-600 cursor-pointer block">
                <input type="checkbox" 
                       class="accent-yellow-600" 
                       onchange={() => { 
                         if (type == "password") type = "text";
                         else type = "password";
                       }}>
                 Show password
              </label>
            </div>
        </div>
        <div class="mb-1">
            <Input bind:value={password2} type="password" id="passconf" label="Confirm password"/>
        </div>
        {#if passConf}
            <div class="text-green-400 text-center">Password confirmed.</div>
        {:else}
            <div class="text-red-400 text-center opacity-70">Password not confirmed.</div>
        {/if}
    </div>
</div>

<div class="my-2">
    <label class="text-sm font-bold mb-2 text-yellow-600 cursor-pointer block">
      <input type="checkbox" 
             class="accent-yellow-600" 
             bind:this={conditions}>
       I have read and accept the <a href="/terms&conditions">Terms & Conditions</a> and <a href="/privacy-policy">Privacy policy</a>.
    </label>
    <label class="text-sm font-bold mb-2 text-yellow-600 cursor-pointer block">
        <input type="checkbox" 
               class="accent-yellow-600" 
               bind:this={over18}>
         I am 18 years old or older.
    </label>
</div>

<!-- Sign in -->
<div class="flex justify-center items-center my-1">
    <button class="disabled:opacity-35 disabled:hover:bg-yellow-600 bg-yellow-600 hover:bg-black border-yellow-600 border-2 hover:border-opacity-100 text-black hover:text-yellow-600 disabled:hover:text-black font-bold py-2 px-3 rounded focus:outline-none focus:shadow-outline duration-300" 
            type="button" 
            disabled={!valid} 
            onclick={signUp}>
      Sign In
    </button>
</div>



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