import './assets/main.css'
import 'primeicons/primeicons.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

import PrimeVue from 'primevue/config'
import Aura from '@primevue/themes/aura'
import Tree from 'primevue/tree'
import Fieldset from 'primevue/fieldset'
import Tag from 'primevue/tag'
import Breadcrumb from 'primevue/breadcrumb'

const app = createApp(App)

app.use(router)

app.mount('#app')

app.use(PrimeVue, {
  theme: {
    preset: Aura
  }
})

app.component('Fieldset', Fieldset)
app.component('Tree', Tree)
app.component('Tag', Tag)
app.component('Breadcrumb', Breadcrumb)
