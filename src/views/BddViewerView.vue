<script setup lang="ts">

import { computed } from 'vue'
import CodeViewer from '@/views/CodeViewer.vue'

const blocks = computed(() => splitByRule(history.state.content))

function splitByRule(text: string) {
  const blocks = []
  if(history.state.split) {
    const lines = text.split('\n')
    let currentBlock = []

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
function getTitle(block, index) {
  const firstLine = block.split('\n')[0]
  return firstLine.startsWith('Règle')
    ? firstLine
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
