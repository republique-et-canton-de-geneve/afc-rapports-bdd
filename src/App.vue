<script setup lang="ts">
import { RouterView } from 'vue-router'
</script>

<template>
  <div id="app-container">
    <header>
      <h1>Rapports BDD</h1>
    </header>
    <main>
      <RouterView />
    </main>
  </div>
</template>

<style scoped>
#app-container {
  display: grid;
  grid-auto-rows: auto 1fr;
  grid-template-areas:
    'header'
    'main';
  min-height: 100vh;
}

header {
  grid-area: header;
  color: var(--primary);
  background-color: var(--accent);
  text-align: center;
}

main {
  grid-area: main;
  color: var(--secondary);
  background-color: var(--primary);
}
</style>
