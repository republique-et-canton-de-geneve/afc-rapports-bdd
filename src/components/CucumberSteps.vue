<template>
  <div class="step" v-for="step in steps" :key="step.id">

    <div class="title">
    <b>{{ step.keyword }}</b> {{ step.text }}
    </div>
    <table v-if="step.dataTable">
      <tbody>
      <tr v-for="(row, rowIndex) in step.dataTable.rows" :key="row.id ?? rowIndex">
        <td v-for="(cell, cellIndex) in row.cells" :key="cell.value ?? cellIndex">
          {{cell.value}}
        </td>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup lang="ts">
import type { PropType } from 'vue'
import * as Messages from '@cucumber/messages'
defineProps({
  steps: {
    type: Object as PropType<Array<Messages.Step>>,
    required: true,
  },
});
</script>
<style scoped>

.step {
  padding-left: 20px;
}

table {
  display: table;
  border-collapse: separate;
  box-sizing: border-box;
  text-indent: initial;
  unicode-bidi: isolate;
  border-spacing: 2px;
  border-color: gray;
}

tr {
  display: table-row;
  vertical-align: inherit;
  unicode-bidi: isolate;
  border-color: inherit;
}

td, th {
  padding: .4em .6em;
  border-width: 0 2px 0 0;
  border-style: solid;
  border-color: #000080;
  color: #297bde;
}

td:first-child, th:first-child {
  border-width: 0 2px;
}
</style>
