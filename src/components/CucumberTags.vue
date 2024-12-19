<template>
  <div class="tags" v-if="tags?.length > 0">
    <Tag severity="info" :value="tag.name" rounded v-for="tag in tags" :key="tag.name"></Tag>
    <br />
  </div>
</template>

<script setup lang="ts">
import type { PropType } from 'vue'
import * as Messages from '@cucumber/messages'
defineProps({
  tags: {
    type: Object as PropType<Array<Messages.Tag>>,
    required: true,
  },
});
</script>
<style scoped>

.tags {
  --p-tag-font-size: 12px;
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
  border-width: 0 2px;
  border-style: solid;
  border-color: #000080;
  color: #297bde;
}
</style>
