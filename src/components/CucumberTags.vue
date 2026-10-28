<script setup lang="ts">
import type { PropType } from 'vue'
import type * as Messages from '@cucumber/messages'

defineProps({
  tags: {
    type: Array as PropType<readonly Messages.Tag[]>,
    required: true
  }
})
</script>

<template>
  <div v-if="tags.length" class="tags" aria-label="Étiquettes Gherkin">
    <v-chip v-for="tag in tags" :key="tag.id" size="x-small" variant="tonal" color="primary" class="tag-chip">
      {{ tag.name }}
    </v-chip>
  </div>
</template>

<style scoped>
.tags { display: flex; flex-wrap: wrap; gap: 5px; margin-top: 8px; }
.tag-chip { height: 22px; font-family: 'Consolas', 'Courier New', monospace; font-size: 10px; font-weight: 500; }
</style>
