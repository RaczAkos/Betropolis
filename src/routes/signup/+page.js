import { browser } from '$app/environment';
if (browser) {
    const btn = document.getElementById("btn");
    const pswForm = document.getElementById("pswForm");
    btn?.addEventListener("click", () => {
        pswForm?.classList.remove("hidden")
    });
}
