<template>
  <div class="example" v-for="example in examples">

    <div class="title">
      <b>{{ example.keyword }}: </b> {{ example.name }}
    </div>
    <table>
      <thead v-if="example.tableHeader">
      <tr>
        <th v-for="cell in example.tableHeader.cells" :key="cell.value">
          {{cell.value}}
        </th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="row in example.tableBody" :key="row.id">
        <td v-for="cell in row.cells" :key="cell.value">
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
  examples: {
    type: Object as PropType<Array<Messages.Examples>>,
    required: true,
  },
});
</script>
<style scoped>
.title{
  padding-bottom: 5px;
}
.example{
  padding-top: 10px;
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
