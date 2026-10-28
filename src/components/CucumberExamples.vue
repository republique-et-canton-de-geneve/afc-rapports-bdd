<script setup lang="ts">
import type { PropType } from 'vue'
import type * as Messages from '@cucumber/messages'

defineProps({
  examples: {
    type: Array as PropType<readonly Messages.Examples[]>,
    required: true
  }
})
</script>

<template>
  <section v-for="example in examples" :key="example.id" class="example">
    <h4><strong>{{ example.keyword }} :</strong> {{ example.name }}</h4>
    <div class="table-scroll">
      <table class="examples-table">
        <thead v-if="example.tableHeader"><tr>
          <th v-for="(cell, index) in example.tableHeader.cells" :key="`${index}-${cell.value}`">{{ cell.value }}</th>
        </tr></thead>
        <tbody><tr v-for="row in example.tableBody" :key="row.id">
          <td v-for="(cell, index) in row.cells" :key="`${row.id}-${index}`">{{ cell.value }}</td>
        </tr></tbody>
      </table>
    </div>
  </section>
</template>

<style scoped>
.example { margin-top: 13px; }
.example h4 { margin: 0 0 8px; color: #566862; font-size: 11px; font-weight: 500; }
.example h4 strong { color: #176b58; font-weight: 700; }
.table-scroll { max-width: 100%; overflow-x: auto; }
.examples-table { width: max-content; min-width: 45%; border-collapse: separate; border-spacing: 0; border: 1px solid #dfe9e5; border-radius: 8px; color: #4c6059; font-size: 11px; overflow: hidden; }
.examples-table th, .examples-table td { padding: 7px 11px; border-right: 1px solid #e3ebe7; border-bottom: 1px solid #e3ebe7; text-align: left; white-space: nowrap; }
.examples-table th { background: #f2f7f4; color: #285d4f; font-weight: 600; }
.examples-table tr:last-child td { border-bottom: 0; }
.examples-table th:last-child, .examples-table td:last-child { border-right: 0; }
</style>
