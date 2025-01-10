import type { MenuItem } from 'primevue/menuitem'

export default interface MenuCategorie {
  label: string;
  items: MenuItem[];
  subcategories?: Map<string, MenuCategorie>;
};