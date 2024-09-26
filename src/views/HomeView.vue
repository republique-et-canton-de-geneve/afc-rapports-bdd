<script setup lang="ts">
import { CUCUMBER_REPORTS } from '@/assets/consts'
</script>
<template>
  <div id="home-container">
    <nav>
      <ul>
        <li v-for="report in CUCUMBER_REPORTS" :key="report.name">
          <RouterLink :to="{ name: 'projets', params: { slug: report.slug } }">
            {{ report.name }}
          </RouterLink>
        </li>
      </ul>
    </nav>
    <div id="home-content">
      <h2>Bienvenue sur la page des rapports BDD !</h2>
      <p>
        Cette table des matières regroupe les rapports d'exécution des tests BDD (Behaviour Driven
        Development) des différents projets de l'AFC.<br />
        Les scénarios BDD fournissent une vue détaillée des fonctionnalités implémentées dans nos
        applications. Les rapports actuels sont mis à jour automatiquement.
      </p>
    </div>
  </div>
</template>
<style scoped>
#home-container {
  display: grid;
  grid-auto-rows: auto 1fr;
  grid-template-areas:
    'nav main';
  min-height: 100%;
}

#home-content {
  grid-area: main;
  padding: 0 1rem;
}

nav {
  grid-area: nav;
  background-color: #173647;
}

nav ul {
  list-style-type: none;
  padding: 0;
  margin: 0;
}

nav ul li a {
  color: var(--primary);
  text-decoration: none;
  font-size: xx-large;
  display: block;
  padding: 10px 30px;
}

nav ul li a:hover {
  background-color: var(--primary);
  color: var(--secondary);
}

p {
  line-height: 1.8;
  font-size: x-large;
}

h2 {
  font-size: xx-large;
}
</style>
