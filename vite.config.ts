import { fileURLToPath, URL } from 'node:url'
import path from 'node:path'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'

// https://vitejs.dev/config/
export default defineConfig({
  base: process.env.BASE_PATH ?? '/',
  publicDir: process.env.FEATURES_DIR ? path.resolve(process.env.FEATURES_DIR) : 'public',
  plugins: [
    vue(),
    vueDevTools(),
  ],
  build: {
    outDir: process.env.OUT_DIR || 'dist'
  },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  }
})
