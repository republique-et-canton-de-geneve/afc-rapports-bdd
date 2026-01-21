<script setup lang="ts">

import { computed } from 'vue'
import CodeViewer from '@/views/CodeViewer.vue'

const blocks = computed(() => splitByRule(history.state?.content))

function splitByRule(text: string | undefined) : string[]{
  if(text === undefined) {
    return []
  }
  const blocks:string[] = []
  if(history.state.split) {
    const lines = text.split('\n')
    let currentBlock:string[] = []

    for (const line of lines) {
      if (line.startsWith('  Règle')) {
        if (currentBlock.length) {
          blocks.push(currentBlock.join('\n'))
        }
        currentBlock = [line]
      } else {
        currentBlock.push(line)
      }
    }

    if (currentBlock.length) {
      blocks.push(currentBlock.join('\n'))
    }
  } else {
    blocks.push(text)
  }

  return blocks
}

function getTitle(block:string, index: number) {

  const lignes = block.split('\n');
  let fonction = "Fonctionnalité:";
  let regle = "Règle:";

  const premiereLigne = lignes.find(
    ligne =>
      ligne.includes(fonction) ||
      ligne.includes(regle)
  );

  return premiereLigne
    ? premiereLigne
    : `Bloc ${index + 1}`
}
</script>

<template>
  <div class="rules-container">
    <CodeViewer
      v-for="(block, index) in blocks"
      :key="index"
      :text="block"
      :title="getTitle(block, index)"
      theme="auto"
      class="rule-viewer"
    />
  </div>
</template>

<style scoped>

</style>
