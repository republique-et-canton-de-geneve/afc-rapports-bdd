<script setup lang="ts">
import PanelMenu from 'primevue/panelmenu';

import type MenuCategorie from '@/models/menu-categorie';
import { CUCUMBER_REPORTS } from '@/assets/consts';
import type { MenuItem } from 'primevue/menuitem'

const mapMenuCategorie: Map<string, MenuCategorie> = new Map();
const BASE_PATH_NAME = 'projets';

// Construire la hiérarchie des catégories
CUCUMBER_REPORTS.forEach((report) => {
  const item: MenuItem = {
    label: report.name,
    url: `${BASE_PATH_NAME}/${report.slug}`
  };

  const categories = report.categorie.split('/');
  construireMapMenuCategorie(mapMenuCategorie, categories, item);
});

// Convertir la hiérarchie en un modèle compatible avec PanelMenu
const menu = convertirMapCategorieEnPanelMenu(mapMenuCategorie);

/**
 * Construit la hiérarchie de catégories à partir des rapports.
 */
function construireMapMenuCategorie(
  map: Map<string, MenuCategorie>,
  categories: string[],
  item: MenuItem
) {
  let currentLevel = map;

  // Parcourir les catégories une par une
  categories.forEach((category, index) => {
    // Vérifier si la catégorie existe au niveau actuel
    if (!currentLevel.has(category)) {
      currentLevel.set(category, { label: category, items: [], subcategories: new Map() });
    }

    // Récupérer ou ajouter la catégorie actuelle
    const currentCategory = currentLevel.get(category)!;

    // Si on est au dernier niveau, ajouter l'élément
    if (index === categories.length - 1) {
      currentCategory.items!.push(item);
    }

    // Passer au niveau inférieur pour les sous-catégories
    currentLevel = currentCategory.subcategories!;
  });
}



/**
 * Convertit une hiérarchie de catégories en un modèle pour PanelMenu.
 */
function convertirMapCategorieEnPanelMenu(
  arborescence: Map<string, MenuCategorie>
): MenuCategorie[] {
  return Array.from(arborescence.values()) // Utiliser Array.from pour transformer les valeurs de la Map en tableau
    .map((category) => ({
      label: category.label,
      items: [
        // Ajouter les éléments de cette catégorie
        ...(category.items?.map((subItem) => ({
          label: subItem.label,
          url: subItem.url ? subItem.url : undefined,
        })) || []),

        // Ajouter les sous-catégories comme items
        ...(category.subcategories
          ? convertirMapCategorieEnPanelMenu(category.subcategories)
          : []),
      ],
    }))
    .sort((a, b) => a.label.localeCompare(b.label));
}


</script>

<template>
  <div id="home-container">
    <nav>
      <PanelMenu :model="menu" multiple/>
     </nav>
 
     <div id="home-content">
       <h2>Bienvenue sur la page des rapports BDD !</h2>
       <p>
         Cette table des matières regroupe les rapports d'exécution des tests BDD (Behaviour Driven
         Development) des différents projets de l'AFC.<br />
         Les scénarios BDD fournissent une vue détaillée des fonctionnalités implémentées dans nos
         applications. Les rapports actuels sont mis à jour automatiquement.
       </p>
     </div>
   </div>
 </template>
 
 <style scoped>
 #home-container {
   display: grid;
   grid-auto-rows: auto 1fr;
   grid-template-areas:
     'nav main';
   min-height: 100%;
 }
 
 #home-content {
   grid-area: main;
   padding: 0 1rem;
 }
 
 nav {
   grid-area: nav;
   background-color: var(--secondary);
 }
 
 a {
   color: inherit; 
   text-decoration: none;
 }
 
 a:visited {
   color: inherit;
 }
 
 p {
   line-height: 1.8;
   font-size: x-large;
 }
 
 h2 {
   font-size: xx-large;
 }
 </style>
