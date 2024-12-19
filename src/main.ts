import './assets/main.css'
import 'primeicons/primeicons.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

import PrimeVue from 'primevue/config'
import Tree from 'primevue/tree'
import Fieldset from 'primevue/fieldset'
import Tag from 'primevue/tag'
import Breadcrumb from 'primevue/breadcrumb'
import PanelMenu from 'primevue/panelmenu'
import Aura from '@primevue/themes/aura';
import { definePreset } from '@primevue/themes'

const app = createApp(App)
const myPreset = definePreset(Aura, {
  components: {
    panelmenu: {
      panel: {
        background: 'var(--secondary)',
        border: {
          color: 'transparent'
        },
        first: {
          border: {
            color: 'transparent'
          }
        },
        last: {
          border: {
            color: 'transparent'
          }
        }
      },
      item: {
        color: 'var(--primary)',
        padding: "1em",
        focus: {
          color: 'var(--secondary)',
          background: 'var(--primary)'
        }
      }
    }
  }
})
app.use(router)

app.mount('#app')

app.use(PrimeVue, {
  theme: {
    preset: myPreset,
  }
})

app.component('Fieldset', Fieldset)
app.component('Tree', Tree)
app.component('Tag', Tag)
app.component('Breadcrumb', Breadcrumb)
app.component('PanelMenu', PanelMenu); 