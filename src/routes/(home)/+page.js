import { browser } from '$app/environment';
if (browser) {
    let tbody = document.querySelector("tbody");
    let tr = document.createElement("tr");
    for (let i = 0; i < 6; i++) {
        let td = document.createElement("td");
        td.classList.add("border",
            "border-yellow-600",
            "space-x-3",
            "h-44",
            "hover:shadow-yellow-600",
            "cursor-pointer", 
            "bg-[linear-gradient(45deg,transparent_25%,rgba(68,68,68,.2)_50%,transparent_75%,transparent_100%)]", 
            "bg-zinc-950",
            "rounded-xl",
            "border",
            "border-slate-900",
            "bg-[length:250%_250%,100%_100%]",
            "bg-[position:-100%_0,0_0]",
            "bg-no-repeat",
            "shadow-2xl",
            "hover:bg-[position:200%_0,0_0]",
            "hover:duration-[750ms]",
            "flex",
            "items-center",
            "justify-center",
            "col"
        );
        let text = document.createElement("p");
        text.innerText = "Choose";
        td.append(text);
        td.addEventListener("click", reveal);
        tr.append(td);
        tr.classList.add("grid", "grid-cols-6", "gap-2", "max-sm:grid-cols-2", "max-sm:");
    }
    tbody?.append(tr);

    function reveal(e) {
        let target = e.target;
    }
}