<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, ref } from 'vue'

const props = defineProps({
  text: { type: String, required: true },
  title: { type: String, default: 'Contenu' },
  theme: {
    type: String,
    default: 'auto',
    validator: (value: string) => ['light', 'dark', 'auto'].includes(value)
  }
})

const copied = ref(false)
const linesRef = ref<HTMLElement | null>(null)
const contentRef = ref<HTMLElement | null>(null)
const isDark = ref(false)
const lineCount = computed(() => props.text.split('\n').length || 1)
let copyTimeout: ReturnType<typeof setTimeout> | undefined
let colorScheme: MediaQueryList | undefined

function updateColorScheme() {
  isDark.value = props.theme === 'dark' || (props.theme === 'auto' && Boolean(colorScheme?.matches))
}

async function copy() {
  try {
    await navigator.clipboard.writeText(props.text)
    copied.value = true
    if (copyTimeout) clearTimeout(copyTimeout)
    copyTimeout = setTimeout(() => { copied.value = false }, 1800)
  } catch {
    copied.value = false
  }
}

function syncScroll() {
  if (linesRef.value && contentRef.value) linesRef.value.scrollTop = contentRef.value.scrollTop
}

onMounted(() => {
  colorScheme = window.matchMedia('(prefers-color-scheme: dark)')
  updateColorScheme()
  colorScheme.addEventListener('change', updateColorScheme)
  contentRef.value?.addEventListener('scroll', syncScroll)
})

onBeforeUnmount(() => {
  colorScheme?.removeEventListener('change', updateColorScheme)
  contentRef.value?.removeEventListener('scroll', syncScroll)
  if (copyTimeout) clearTimeout(copyTimeout)
})
</script>

<template>
  <section class="code-viewer" :class="{ 'code-viewer--dark': isDark }">
    <header class="toolbar">
      <div class="toolbar-title"><span class="file-mark">.feature</span><strong>{{ title }}</strong></div>
      <v-btn size="small" variant="tonal" color="primary" @click="copy">
        {{ copied ? 'Copié' : 'Copier le contenu' }}
      </v-btn>
    </header>
    <div class="editor">
      <div ref="linesRef" class="line-numbers" aria-hidden="true">
        <span v-for="line in lineCount" :key="line">{{ line }}</span>
      </div>
      <pre ref="contentRef" class="code-content"><code>{{ text }}</code></pre>
    </div>
  </section>
</template>

<style scoped>
.code-viewer { display: flex; width: 100%; min-height: 300px; flex-direction: column; overflow: hidden; border: 1px solid #e1e8e5; border-radius: 14px; background: #fff; color: #273b35; font-family: 'Consolas', 'Courier New', monospace; }
.toolbar { display: flex; min-height: 52px; align-items: center; justify-content: space-between; gap: 12px; padding: 8px 14px; border-bottom: 1px solid #e8eeeb; background: #f8faf9; }
.toolbar-title { display: flex; min-width: 0; align-items: center; gap: 10px; }
.toolbar-title strong { overflow: hidden; color: #364b44; font-family: 'DM Sans', 'Segoe UI', sans-serif; font-size: 12px; font-weight: 600; text-overflow: ellipsis; white-space: nowrap; }
.file-mark { padding: 4px 6px; border: 1px solid #dce7e2; border-radius: 5px; color: #687a73; font-size: 9px; }
.editor { display: flex; min-height: 245px; flex: 1; overflow: hidden; }
.line-numbers { display: flex; min-width: 48px; flex-direction: column; overflow: hidden; padding: 16px 10px 16px 8px; background: #f8faf9; color: #a3aeaa; font-size: 11px; line-height: 1.7; text-align: right; user-select: none; }
.code-content { flex: 1; overflow: auto; margin: 0; padding: 16px; color: inherit; font-size: 11px; line-height: 1.7; tab-size: 2; white-space: pre; }
.code-viewer--dark { border-color: #293b36; background: #172521; color: #d4e0da; }
.code-viewer--dark .toolbar { border-color: #293b36; background: #1c2b26; }
.code-viewer--dark .toolbar-title strong { color: #d4e0da; }
.code-viewer--dark .file-mark { border-color: #344840; color: #a8bbb1; }
.code-viewer--dark .line-numbers { background: #1c2b26; color: #73877e; }
@media (max-width: 560px) {
  .toolbar { align-items: flex-start; }
  .toolbar-title strong { max-width: 150px; }
  .line-numbers { min-width: 38px; padding-inline: 6px; }
  .code-content { padding: 14px 10px; }
}
</style>
