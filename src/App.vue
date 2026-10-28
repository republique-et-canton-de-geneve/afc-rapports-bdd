<script setup lang="ts">
import { computed, ref } from 'vue'
import { RouterView, useRoute } from 'vue-router'

const route = useRoute()
const drawer = ref(false)
const isHome = computed(() => route.name === 'home')
const isEditor = computed(() => route.name === 'editor')
</script>

<template>
  <v-app>
    <v-app-bar class="app-bar" flat height="76">
      <v-container class="app-bar__content d-flex align-center px-5 px-md-8">
        <v-btn
          class="brand-button px-0"
          variant="text"
          :to="{ name: 'home' }"
          aria-label="Retour à l’accueil Rapports BDD"
        >
          <span class="brand-mark">BDD</span>
          <span class="brand-copy">
            <strong>Rapports BDD</strong>
            <small>Observatoire des tests métier</small>
          </span>
        </v-btn>

        <v-spacer />

        <v-btn
          class="desktop-home-button d-none d-sm-flex"
          variant="text"
          :to="{ name: 'home' }"
          :active="isHome"
        >
          Catalogue
        </v-btn>
        <v-chip v-if="!isEditor" class="status-chip d-none d-md-flex ml-3" size="small" variant="tonal">
          <span class="status-dot" /> Rapports à jour
        </v-chip>
        <v-app-bar-nav-icon class="d-flex d-sm-none ml-2" aria-label="Ouvrir le menu" @click="drawer = !drawer" />
      </v-container>
    </v-app-bar>

    <v-navigation-drawer v-model="drawer" location="right" temporary width="280">
      <v-list nav>
        <v-list-item :to="{ name: 'home' }" title="Catalogue" />
      </v-list>
    </v-navigation-drawer>

    <v-main class="app-main">
      <RouterView />
    </v-main>
  </v-app>
</template>

<style scoped>
.app-bar {
  border-bottom: 1px solid #e6ebe9;
  background: rgba(255, 255, 255, 0.96);
}

.app-bar__content {
  max-width: 1440px;
  height: 100%;
}

.brand-button {
  min-height: 54px;
  text-align: left;
}

.brand-mark {
  display: grid;
  width: 42px;
  height: 42px;
  margin-right: 12px;
  place-items: center;
  border-radius: 13px;
  background: #125b50;
  color: white;
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 0.04em;
}

.brand-copy {
  display: flex;
  flex-direction: column;
  gap: 2px;
  color: #172b27;
  line-height: 1.2;
}

.brand-copy strong {
  font-size: 15px;
  font-weight: 700;
}

.brand-copy small {
  color: #73817d;
  font-size: 11px;
  font-weight: 500;
}

.status-chip {
  color: #176b48;
  font-weight: 600;
}

.status-dot {
  width: 7px;
  height: 7px;
  margin-right: 7px;
  border-radius: 50%;
  background: #25a56a;
}

.app-main {
  min-height: calc(100vh - 76px);
}
</style>
