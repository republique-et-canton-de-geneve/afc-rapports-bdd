<template>
  <div class="code-viewer fullscreen" :class="themeClass">
    <div class="toolbar">
      <span class="title">{{ title }}</span>
      <button class="copy-btn" @click="copy">
        {{ copied ? 'Copié ✔' : 'Copier' }}
      </button>
    </div>

    <div class="editor">
      <div class="lines" ref="linesRef">
        <div
          v-for="n in lineCount"
          :key="n"
          class="line-number"
        >
          {{ n }}
        </div>
      </div>

      <pre class="content" ref="contentRef">
<code>{{ text }}</code>
      </pre>
    </div>
  </div>
</template>

<script setup>
import { computed, ref, onMounted } from 'vue'

const props = defineProps({
  text: { type: String, required: true },
  title: { type: String, default: 'Contenu' },
  theme: {
    type: String,
    default: 'auto',
    validator: v => ['light', 'dark', 'auto'].includes(v)
  }
})

const copied = ref(false)
const contentRef = ref(null)
const linesRef = ref(null)

const lineCount = computed(() =>
  props.text.split('\n').length || 1
)

const themeClass = computed(() => {
  if (props.theme === 'auto') {
    return window.matchMedia('(prefers-color-scheme: dark)').matches
      ? 'dark'
      : 'light'
  }
  return props.theme
})

const copy = async () => {
  await navigator.clipboard.writeText(props.text)
  copied.value = true
  setTimeout(() => (copied.value = false), 1500)
}

const syncScroll = () => {
  linesRef.value.scrollTop = contentRef.value.scrollTop
}

onMounted(() => {
  contentRef.value.addEventListener('scroll', syncScroll)
})
</script>

<style scoped>
/* ===== Fullscreen container ===== */
.fullscreen {
  width: 100vw;
  //height: 100dvh; /* mobile safe */
  display: flex;
  flex-direction: column;
}

/* ===== Container ===== */
.code-viewer {
  border: 1px solid;
  font-family: Consolas, Monaco, 'Courier New', monospace;
  font-size: 13px;
}

/* ===== Toolbar ===== */
.toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 12px;
  border-bottom: 1px solid;
  flex-shrink: 0;
}

/* ===== Editor ===== */
.editor {
  flex: 1;
  display: flex;
  overflow: hidden;
}

/* ===== Line numbers ===== */
.lines {
  padding: 10px 6px;
  text-align: right;
  user-select: none;
  overflow: hidden;
}

.line-number {
  height: 1.4em;
  line-height: 1.4em;
}

/* ===== Content ===== */
.content {
  margin: 0;
  padding: 10px;
  overflow: auto;
  white-space: pre;
  flex: 1;
}

/* ===== Copy button ===== */
.copy-btn {
  border: none;
  padding: 4px 10px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
}

/* ===== Light theme ===== */
.light {
  background: #ffffff;
  color: #1f2937;
  border-color: #d1d5db;
}

.light .toolbar {
  background: #f9fafb;
  border-color: #e5e7eb;
}

.light .lines {
  background: #f3f4f6;
  color: #6b7280;
}

.light .copy-btn {
  background: #2563eb;
  color: white;
}

/* ===== Dark theme ===== */
.dark {
  background: #1e1e1e;
  color: #d4d4d4;
  border-color: #333;
}

.dark .toolbar {
  background: #2d2d2d;
  border-color: #333;
}

.dark .lines {
  background: #252526;
  color: #858585;
}

.dark .copy-btn {
  background: #3b82f6;
  color: white;
}
</style>
