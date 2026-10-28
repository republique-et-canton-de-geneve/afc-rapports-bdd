<script setup lang="ts">
import type { PropType } from 'vue'
import type * as Messages from '@cucumber/messages'

defineProps({
  steps: {
    type: Array as PropType<readonly Messages.Step[]>,
    required: true
  }
})
</script>

<template>
  <div class="steps">
    <div v-for="step in steps" :key="step.id" class="step">
      <div class="step__title"><strong>{{ step.keyword.trim() }}</strong><span>{{ step.text }}</span></div>
      <pre v-if="step.docString?.content" class="doc-string">{{ step.docString.content }}</pre>
      <div v-if="step.dataTable" class="table-scroll">
        <table class="data-table"><tbody>
          <tr v-for="(row, rowIndex) in step.dataTable.rows" :key="row.id || rowIndex">
            <td v-for="(cell, cellIndex) in row.cells" :key="`${rowIndex}-${cellIndex}`">{{ cell.value }}</td>
          </tr>
        </tbody></table>
      </div>
    </div>
  </div>
</template>

<style scoped>
.steps { display: grid; gap: 7px; margin-top: 10px; }
.step { position: relative; padding-left: 14px; border-left: 2px solid #e5efeb; }
.step__title { display: flex; flex-wrap: wrap; gap: 5px; color: #53645f; font-size: 12px; line-height: 1.6; }
.step__title strong { color: #176b58; font-weight: 600; }
.doc-string { overflow-x: auto; margin: 7px 0 5px; padding: 10px 12px; border: 1px solid #e9eeec; border-radius: 8px; background: #f7f9f8; color: #435751; font-family: 'Consolas', 'Courier New', monospace; font-size: 11px; line-height: 1.6; }
.table-scroll { max-width: 100%; overflow-x: auto; margin-top: 7px; }
.data-table { border-collapse: collapse; color: #4c6059; font-size: 11px; }
.data-table td { padding: 6px 10px; border: 1px solid #dfe9e5; white-space: nowrap; }
.data-table tr:first-child td { background: #f4f8f6; color: #285d4f; font-weight: 600; }
</style>
