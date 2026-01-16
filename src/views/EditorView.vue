<script setup lang="ts">

import { ref } from 'vue'

const content = ref<string>(history.state.content)

</script>

<template>
  <Editor v-model="content" editorStyle="height: 320px" />
<pre>
  {{content}}
</pre>
</template>

<style scoped>

</style>
