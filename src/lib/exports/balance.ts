export async function updateBalance(addToBalance: number, game:any) {
    const response = await fetch('/api/balance-update', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ 
            number: addToBalance,
            gameid: game
        }),
    });

    const data = await response.json();
    console.log(data);
    return data.newBalance;
}

export async function getBalance() {
    const response = await fetch('/api/balance-update');
    const data = await response.json();
    return data.balance;
}
