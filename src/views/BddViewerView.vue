<script setup lang="ts">
import { computed } from 'vue'
import CodeViewer from '@/views/CodeViewer.vue'

const title = computed(() => String(history.state?.title || 'Rapport BDD'))
const blocks = computed(() => splitByRule(history.state?.content))

function splitByRule(text: string | undefined): string[] {
  if (text === undefined) return []
  if (!history.state?.split) return [text]
  const blocks: string[] = []
  let currentBlock: string[] = []
  for (const line of text.split('\n')) {
    if (line.startsWith('  Règle')) {
      if (currentBlock.length) blocks.push(currentBlock.join('\n'))
      currentBlock = [line]
    } else {
      currentBlock.push(line)
    }
  }
  if (currentBlock.length) blocks.push(currentBlock.join('\n'))
  return blocks
}

function getTitle(block: string, index: number) {
  return block.split('\n').find((line) => line.includes('Fonctionnalité:') || line.includes('Règle:')) || `Bloc ${index + 1}`
}
</script>

<template>
  <v-container class="viewer-page px-4 px-md-8 py-7 py-md-10">
    <div class="viewer-heading">
      <v-btn class="back-button" variant="text" :to="{ name: 'home' }">← Retour au catalogue</v-btn>
      <div class="viewer-title-row">
        <div><div class="eyebrow">LECTURE DU RAPPORT</div><h1>{{ title }}</h1></div>
        <v-chip variant="tonal" color="primary" size="small">Lecture seule</v-chip>
      </div>
      <p>Contenu source du fichier Gherkin, prêt à être consulté ou partagé.</p>
    </div>
    <div v-if="blocks.length" class="viewer-blocks">
      <CodeViewer v-for="(block, index) in blocks" :key="index" :text="block" :title="getTitle(block, index)" theme="auto" />
    </div>
    <v-card v-else class="missing-report" variant="flat">
      <h2>Rapport indisponible</h2>
      <p>Ouvrez un fichier depuis le catalogue pour consulter son contenu.</p>
      <v-btn color="primary" :to="{ name: 'home' }">Revenir au catalogue</v-btn>
    </v-card>
  </v-container>
</template>

<style scoped>
.viewer-page { max-width: 1280px; }
.viewer-heading { margin-bottom: 23px; }
.back-button { margin: 0 0 15px -10px; color: #637670; font-size: 12px; }
.viewer-title-row { display: flex; align-items: center; justify-content: space-between; gap: 16px; }
.eyebrow { color: #87958f; font-size: 9px; font-weight: 700; letter-spacing: .15em; }
h1 { margin: 7px 0 0; color: #1a312c; font-size: clamp(24px, 3vw, 34px); font-weight: 600; letter-spacing: -.04em; }
.viewer-heading > p { margin: 8px 0 0; color: #72817c; font-size: 13px; }
.viewer-blocks { display: grid; gap: 18px; }
.missing-report { display: grid; min-height: 300px; place-content: center; justify-items: center; gap: 8px; border: 1px solid #e5ebe8; text-align: center; }
.missing-report h2 { margin: 0; color: #263c36; font-size: 18px; }
.missing-report p { margin: 0 0 8px; color: #75827e; font-size: 13px; }
</style>
