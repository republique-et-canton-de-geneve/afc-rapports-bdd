import './assets/main.css'
import 'vuetify/styles'

import { createApp, defineComponent, h, type PropType } from 'vue'
import type { IconProps } from 'vuetify'
import { createVuetify } from 'vuetify'
import * as components from 'vuetify/components'
import * as directives from 'vuetify/directives'
import App from './App.vue'
import router from './router'

const TextIcon = defineComponent({
  props: {
    icon: { type: [String, Object, Function, Array] as PropType<IconProps['icon']>, required: false },
    tag: { type: [String, Object, Function] as PropType<IconProps['tag']>, required: true },
    disabled: { type: Boolean, default: false }
  },
  setup(props) {
    return () => h(props.tag as string, { class: 'text-icon', 'aria-hidden': 'true' }, typeof props.icon === 'string' ? props.icon : '')
  }
})

const vuetify = createVuetify({
  components,
  directives,
  icons: {
    defaultSet: 'text',
    aliases: {
      collapse: '−',
      expand: '+',
      dropdown: '⌄',
      prev: '‹',
      next: '›',
      close: '×',
      clear: '×',
      info: 'i',
      warning: '!',
      error: '×',
      success: '✓',
      loading: '◌',
      treeviewExpand: '+',
      treeviewCollapse: '−',
      file: '▤'
    },
    sets: { text: { component: TextIcon } }
  },
  theme: {
    defaultTheme: 'reportsLight',
    themes: {
      reportsLight: {
        dark: false,
        colors: {
          background: '#f4f6f8',
          surface: '#ffffff',
          primary: '#125b50',
          secondary: '#536b67',
          error: '#b42318',
          info: '#176b87',
          success: '#16794b',
          warning: '#9a6700',
          'on-background': '#172b27',
          'on-surface': '#172b27'
        }
      }
    }
  },
  defaults: {
    VBtn: { rounded: 'lg', style: 'text-transform: none; letter-spacing: 0' },
    VCard: { rounded: 'xl' },
    VTextField: { variant: 'outlined', density: 'comfortable', hideDetails: 'auto' }
  }
})

createApp(App).use(router).use(vuetify).mount('#app')
