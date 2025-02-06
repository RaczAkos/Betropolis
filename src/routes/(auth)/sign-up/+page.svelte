<svelte:head>
    <title>Sign up! - Betropolis</title>
    <meta name="description" content="Welcome to Betropolis — your ultimate online destination for thrilling casino games and endless entertainment! Step into a world where the excitement never stops, and every spin, card flip, and roll of the dice brings you closer to unforgettable winnings. At Betropolis, we combine top-tier games, cutting-edge security, and seamless gameplay to create a premium online casino experience." />
</svelte:head>

<script lang="ts">
    import Input from "$lib/components/Input.svelte";
    let user = $state({
            name: "",
            username: "",
            birthdate: "",
            gender: null,
            email: "",
            password: ""
        }),
        birthdate:string   = $state(""),
        gender:number|null = $state(null),
        password:string    = $state(""),
        password2:string   = $state(""),
        passconf:boolean   = $state(false),
        error:HTMLElement;

    async function sendData(){
        const response = await fetch('/api/submit-data', {
            method: 'POST',
            headers: {
            'Content-Type': 'application/json',
            },
            body: JSON.stringify(user),
        });
    }
    
</script>


<div>
    <!-- Name, Username -->
    <Input id="name" 
           bind:value={user.name}
           label="Name"/>

    <div class="my-2">
    <Input id="name" 
           bind:value={user.username}
           label="Username" />
    </div>
    
    <div class="flex flex-row max-sm:flex-col p-1 mb-2 gap-2">
        
        <!-- Date of birth -->
        <div class="relative max-w-sm basis-1/2">
            <div class="block text-yellow-600 text-md font-bold p-1 text-center">Date of birth</div>
            <input bind:value={birthdate} type="date" class="bg-black outline-none border-2 text-yellow-600 text-md rounded-lg focus:ring-yellow-600 border-yellow-600 block w-full p-2 text-center">
        </div>
        
        <!-- Gender select -->
        <div class="basis-1/2 p-1">
            <p class="block text-yellow-600 font-bold text-md text-center">Gender</p>
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
    
<div>
    <div class="mb-2 p-1">
        <Input bind:value={user.email}
               id="email" 
               type="email" 
               label="email"
               placeholder="example@example.com"/>
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