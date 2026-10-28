export interface MenuEntry {
  label: string
  url?: string
  items?: MenuEntry[]
}

export default interface MenuCategorie {
  label: string
  items: MenuEntry[]
  subcategories?: Map<string, MenuCategorie>
}
