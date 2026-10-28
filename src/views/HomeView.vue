<script setup lang="ts">
import { computed } from 'vue'
import type MenuCategorie from '@/models/menu-categorie'
import type { MenuEntry } from '@/models/menu-categorie'
import { CUCUMBER_REPORTS } from '@/assets/consts'
import ProjectMenuItem from '@/components/ProjectMenuItem.vue'

const categoryMap = new Map<string, MenuCategorie>()
const projectCount = CUCUMBER_REPORTS.length

function addProject(categories: string[], project: MenuEntry) {
  let currentLevel = categoryMap
  categories.forEach((category, index) => {
    if (!currentLevel.has(category)) {
      currentLevel.set(category, { label: category, items: [], subcategories: new Map() })
    }
    const current = currentLevel.get(category)!
    if (index === categories.length - 1) current.items.push(project)
    currentLevel = current.subcategories!
  })
}

function mapToMenu(map: Map<string, MenuCategorie>): MenuEntry[] {
  return Array.from(map.values())
    .map((category) => ({
      label: category.label,
      items: [
        ...(category.subcategories ? mapToMenu(category.subcategories) : []),
        ...category.items
      ]
    }))
    .sort((a, b) => a.label.localeCompare(b.label))
}

CUCUMBER_REPORTS.forEach((report) => {
  addProject(report.categorie.split('/'), {
    label: report.name,
    url: `/projets/${encodeURIComponent(report.slug)}`
  })
})

const categories = computed(() => mapToMenu(categoryMap))

function countProjects(category: MenuEntry): number {
  return (category.items || []).reduce((count, item) => count + (item.url ? 1 : countProjects(item)), 0)
}
</script>

<template>
  <v-container class="home-page px-5 px-md-8 py-8 py-md-10">
    <section class="catalog-section">
      <div class="section-heading">
        <div>
          <h1>Rapports BDD</h1>
          <p>Parcourez les projets et leurs scénarios de test.</p>
        </div>
        <span class="project-count">{{ projectCount }} projet{{ projectCount > 1 ? 's' : '' }}</span>
      </div>

      <div v-if="categories.length" class="category-grid">
        <v-card
          v-for="category in categories"
          :key="category.label"
          class="category-card"
          variant="flat"
        >
          <div class="category-card__header">
            <h2>{{ category.label }}</h2>
            <span class="category-count">{{ countProjects(category) }}</span>
          </div>
          <v-divider />
          <v-list class="project-list" density="comfortable" nav>
            <ProjectMenuItem v-for="item in category.items" :key="item.label" :item="item" />
          </v-list>
        </v-card>
      </div>

      <v-card v-else class="empty-catalog" variant="flat">
        <div class="empty-mark">BDD</div>
        <h3>Aucun rapport à afficher</h3>
        <p>Les rapports apparaîtront ici dès que des fichiers Gherkin seront configurés.</p>
      </v-card>
    </section>

  </v-container>
</template>

<style scoped>
.home-page {
  max-width: 1120px;
}
.catalog-section {
  padding-top: 8px;
}
.section-heading {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  margin-bottom: 20px;
}
.section-heading h1 {
  margin: 0 0 4px;
  color: #1a312c;
  font-size: 27px;
  font-weight: 600;
  letter-spacing: -0.035em;
}
.section-heading p {
  margin: 0;
  color: #72817d;
  font-size: 13px;
}
.project-count {
  color: #72817d;
  font-size: 12px;
}
.category-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 17px;
}
.category-card {
  overflow: hidden;
  border: 1px solid #e7ecea;
  background: white;
  box-shadow: 0 5px 18px rgba(23, 43, 39, 0.035);
}
.category-card__header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  padding: 15px 18px;
}
.category-card h2 {
  margin: 0;
  color: #1b342e;
  font-size: 14px;
  font-weight: 600;
}
.category-count {
  display: grid;
  width: 25px;
  height: 25px;
  margin-left: auto;
  place-items: center;
  border-radius: 50%;
  background: #f3f6f5;
  color: #75847f;
  font-size: 10px;
}
.project-list {
  padding: 8px 12px 12px;
}
.empty-catalog {
  display: grid;
  min-height: 230px;
  place-content: center;
  justify-items: center;
  border: 1px dashed #d5dfdb;
  background: rgba(255, 255, 255, 0.65);
  text-align: center;
}
.empty-mark {
  display: grid;
  width: 48px;
  height: 48px;
  place-items: center;
  border-radius: 14px;
  background: #eaf4f0;
  color: #125b50;
  font-size: 12px;
  font-weight: 700;
}
.empty-catalog h3 {
  margin: 15px 0 4px;
  font-size: 17px;
}
.empty-catalog p {
  max-width: 360px;
  margin: 0;
  color: #74827e;
  font-size: 13px;
}
@media (max-width: 640px) {
  .section-heading h1 {
    font-size: 23px;
  }
  .category-grid {
    grid-template-columns: 1fr;
  }
}
</style>
