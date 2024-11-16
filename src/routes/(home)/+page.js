import { browser } from '$app/environment'
import club from "$lib/media/images/clubs.png"
import diamond from "$lib/media/images/diamond.png"
import heart from "$lib/media/images/heart.png"
import spade from "$lib/media/images/spades.png"
if (browser) {
    let tbody = document.querySelector("tbody"),
    tr = document.createElement("tr");
    for (let i = 0; i < 4; i++) {
        let td = document.createElement("td");
        td.classList.add(
            "space-x-3",
            "h-44",
            "hover:shadow-yellow-600",
            "cursor-pointer", 
            "bg-[linear-gradient(45deg,transparent_25%,rgba(68,68,68,.2)_50%,transparent_75%,transparent_100%)]", 
            "bg-zinc-950",
            "rounded-xl",
            "bg-[length:250%_250%,100%_100%]",
            "bg-[position:-100%_0,0_0]",
            "bg-no-repeat",
            "shadow-2xl",
            "hover:bg-[position:200%_0,0_0]",
            "hover:duration-[750ms]",
            "flex",
            "items-center",
            "justify-center",
            "transition-all"
        );
        td.addEventListener("click", reveal);
        tr.classList.add("ledBorder");
        tr.append(td);
        tr.classList.add("grid", "grid-cols-4", "gap-2", "max-sm:grid-cols-2");
    }

    tbody?.append(tr);
    let cards = document.querySelectorAll("tbody tr td:not(.modalImg)"),
    symbols = [
        club, diamond, heart, spade
    ];    
    symbols.sort( () => .5 - Math.random() );

    for (let i = 0; i < cards.length; i++) {
        cards[i].innerHTML = "<img src='" + symbols[i] + "' class='h-1/2 w-auto'>";
    }


    let   modal = document.getElementById("prize"),
    modalCancel = document.getElementById("cancel");
    modalCancel?.addEventListener("click", closeModal);

    function reveal(e) {
        let target = e.target;
        target.classList.add("chosen");
        let no = document.querySelectorAll("tbody tr td:not(.chosen)").forEach(element => {
            element.removeEventListener("click", reveal);
        });
        modal?.classList.remove("hidden");
    }

    function closeModal() {
        modal?.classList.add("hidden");
    }

    let modalImgs = document.querySelectorAll("td.modalImg");
    modalImgs[0].parentElement?.classList.add("grid", "grid-cols-4", "gap-2", "max-sm:grid-cols-2");
    modalImgs[0].parentElement?.parentElement?.classList.add("ledBorder");
    modalImgs[0].parentElement?.parentElement?.parentElement?.classList.add("w-full");
    modalImgs.forEach(element => {
        element.classList.add(
            "space-x-3",
            "h-20", 
            "bg-zinc-950",
            "rounded-xl",
            "flex",
            "items-center",
            "justify-center",
            "transition-all"
        );
        element.classList.add("w-auto");
    });
}
