import { json } from "@sveltejs/kit";

export async function profileChange(img:string, name:string, email:string, password:boolean, language:string) {
    const response = await fetch('/api/profile', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ 
            newPicture: img,
            newName: name,
            newEmail: email,
            newPassword: password,
            newLanguage: language
        }),
    });
    const data = await response.json();
}
export async function getUser() {
    const response = await fetch('/api/profile');
    const data = await response.json();
    return data;
}