<svelte:head>
  <title>{$_("page.profile.title")}: {page.params.friend} - Betropolis</title>
</svelte:head>

<script lang="ts">
  import { page } from "$app/state";
  import { _ } from "svelte-i18n";

  let {data} = $props(),
      chipsSpent:number = $state(!data.error ? calculateChips(0) : 0), 
      chipsEarned:number = $state(!data.error ? calculateChips(1) : 0),
      fields = [
        { // Avatar and balance
          avatar: true, 
          text: "games.balance", 
          content: !data.error ? data.user[0].balance : 0, 
          chips: true 
        },
        { // Balance spent
          avatar: false, 
          text: "page.profile.spent", 
          img: "/src/lib/media/images/profile/flying-money.png", 
          content: chipsSpent*-1, 
          chips: true 
        },
        { // Balance earned
          avatar: false, 
          text: "page.profile.gained", 
          img: "/src/lib/media/images/profile/income.png", 
          content: chipsEarned, 
          chips: true 
        },
        { // Last game played
          avatar: false, 
          text: "page.profile.played", 
          img: "/src/lib/media/images/profile/joystick.png", 
          chips: false 
        },
      ],
      selectedGame:number|null = $state(!data.error ? (data.lastPlayed.length != 0) ? data.lastPlayed[0].gameid : null : null);
  
  // Calculating total earned and lost chips
  function calculateChips(type: number): number {
    let chips: number = 0;
    for (let index = 0; index < data.transaction.length; index++) {
      if (type ? data.transaction[index].gain > 0 : data.transaction[index].gain < 0) chips += data.transaction[index].gain;
    }
    return chips;
  }
</script>

<div class="mt-2 w-full h-full bg-[#141a22] rounded-lg p-8 flex flex-col gap-8 overflow-y-auto scrollDesign">
  {#if !data.error}
  <div class="flex flex-wrap xl:flex-nowrap items-start gap-8">
    <div class="flex-1">
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        {#each fields as field}
          <div class="bg-[#040d17] drop-shadow-lg p-4 text-center rounded-lg ">
              {#if !field.avatar}
                <img src={field.img}
                     alt={field.text}
                     class="w-28 mx-auto md:w-32 lg:w-40">
              {:else}
                <img src={data.user[0].avatar + ".png"} 
                     alt="avatar" 
                     class="w-28 mx-auto md:w-32 lg:w-40 rounded-full border-4 border-white shadow-xl shadow-gray-500/50">
              {/if}
              <p class="text-gray-500 py-3 text-lg text-nowrap">
                {$_(field.text)}
              </p>
              <p class="inline { field.chips ? "text-yellow-600": "text-pink-600"}  text-lg text-nowrap">
                {#if field.chips}
                  <img src="/src/lib/media/images/chip.png" 
                       alt="chip" 
                       class="w-[20px] inline pb-1">
                  {field.content}
                {:else}
                  {#if data.lastPlayed.length == 0}
                    {$_("page.profile.noGame")}
                  {:else}
                    {data.lastPlayed[0].name}
                  {/if}
                {/if}
              </p>
          </div>
        {/each}
      </div>
    </div>
  </div>
  <div class="w-full h-full text-gray-500">
    <div class="flex">
      {#each data.games as game}
        <button class="p-3 border border-gray-500 border-b-0 rounded-t-lg hover:bg-[#040d17]"
                onclick={() => selectedGame = game.gameid}>
          {game.name}
        </button>
      {/each}
    </div>
    <div class="w-full overflow-auto scrollDesign max-h-[30vh] sm:max-h-[40vh] md:max-h-[40vh]">
      {#if selectedGame}
        <div class="w-full">
          <table class="w-full border border-gray-700">
            <thead>
              <tr class="bg-[#040d17] text-white">
                {#each Object.keys(data.transaction[0]) as key}
                  {#if key != "gameid"}
                    <th class="p-2 border border-gray-600">
                      {$_(`page.profile.table.${key}`)}
                    </th>
                  {/if}
                {/each}
              </tr>
            </thead>
            <tbody>
              {#each data.transaction as row}
                {#if row.gameid == selectedGame}                                             
                  <tr class="text-center {row.gain > 0 ? "text-green-600": "text-red-600"}">
                    {#each Object.entries(row) as [key, value]}
                      {#if key != "gameid"}
                          <td class="p-2 border border-gray-600">
                            {value}
                          </td>
                      {/if}
                    {/each}
                  </tr>
                {/if}
              {/each}
            </tbody>
          </table>
        </div>
      {/if}
    </div>
  </div>
  {:else}
    <div class="m-auto text-red-600 font-bold text-xl md:text-5xl">
      {$_("friends.errors.add." + data.error)}
    </div>
  {/if}
</div>