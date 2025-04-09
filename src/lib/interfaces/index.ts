export interface userData {
  balance: number,
  username: string
}

export interface Feedback {
  success?: string,
  error?: string
}

export interface FriendData {
  id: number,
  senderId?: number,
  username?: string
}

export interface Game {
  name:string,
  image: string,
  route: string,
  font: string
}

export interface HubNavButton {
  click: Boolean,
  img: string,
  alt: string,
  text: string,
  notification?: number|null
}

export interface Language {
  id: string,
  name: string,
  defaultName: string,
  img: string
}

// For Menus also
export interface Modal {
  show: boolean,
  selectedLang?: string,
  defaultLang?: boolean,
  notification?: number,
  user?: userData
}

export interface HubNavLi {
  text: string, 
  type?: string, 
  href?: string, 
  show?: boolean, 
  notification?: number|null
}

// For Footer also
export interface Navbar {
  logged: boolean, 
  home: boolean
}

export interface Search {
  search: string, 
  searchBar: boolean
}

export interface Registration {
  name:string,
  username:string,
  birthdate:string,
  gender:number|null,
  email:string,
  password:string,
  picture:string,
  lang:string
}

export interface Paragraph {
  param: string, 
  index: number
}

export interface Input {
  value?: string|number, 
  disabled?: boolean, 
  type?: string, 
  id?: string, 
  placeholder?: string, 
  label?: string|null, 
  name?: string, 
  required?: boolean,
  onpaste?: any
}