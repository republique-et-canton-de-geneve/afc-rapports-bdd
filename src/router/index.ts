import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import ProjectView from '@/views/ProjectView.vue'
import BddViewerView from '@/views/BddViewerView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/editor',
      name: 'editor',
      component: BddViewerView, props: true
    },
    {
      path: '/projets/:slug/:feature(.*)?',
      name: 'projets',
      component: ProjectView
    }
  ]
})

export default router
