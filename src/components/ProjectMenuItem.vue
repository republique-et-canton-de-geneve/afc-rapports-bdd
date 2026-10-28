<script setup lang="ts">
import type { MenuEntry } from '@/models/menu-categorie'

defineProps<{ item: MenuEntry }>()
</script>

<template>
  <v-list-group v-if="item.items?.length" :value="item.label" class="project-menu-group">
    <template #activator="{ props }">
      <v-list-item v-bind="props" :title="item.label" />
    </template>
    <v-list class="nested-project-list" density="comfortable" nav>
      <ProjectMenuItem v-for="child in item.items" :key="child.label" :item="child" />
    </v-list>
  </v-list-group>
  <v-list-item
    v-else
    :to="item.url"
    :title="item.label"
    rounded="lg"
    class="project-link"
  >
    <template #append><span class="list-arrow">→</span></template>
  </v-list-item>
</template>

<style scoped>
.project-link {
  min-height: 43px;
  color: #3984c6;
  font-size: 13px;
}

.project-link :deep(.v-list-item-title) {
  color: inherit;
}

.list-arrow {
  color: #93a39e;
  font-size: 15px;
  transition: transform 0.18s ease;
}

.project-link:hover .list-arrow {
  transform: translateX(3px);
}

.nested-project-list {
  padding-inline-start: 12px;
}
</style>
