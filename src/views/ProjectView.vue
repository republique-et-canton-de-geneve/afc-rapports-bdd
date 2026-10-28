<script setup lang="ts">
import { computed, ref, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import type { InternalItem } from 'vuetify'
import * as Gherkin from '@cucumber/gherkin'
import * as Messages from '@cucumber/messages'
import { CUCUMBER_REPORTS } from '@/assets/consts'
import { FEATURE_FILES } from '@/generated/featureFiles'
import type FeatureTreeNode from '@/models/feature-tree-node'
import CucumberExamples from '@/components/CucumberExamples.vue'
import CucumberSteps from '@/components/CucumberSteps.vue'
import CucumberTags from '@/components/CucumberTags.vue'
import {
  findNodeByKey,
  findOrCreateNode,
  generateCombinationString,
  NODE_TYPE_BACKGROUND,
  NODE_TYPE_DIRECTORY,
  NODE_TYPE_FEATURE,
  NODE_TYPE_RULE,
  NODE_TYPE_SCENARIO
} from '@/service/treenode-service'

const BASE_URL = import.meta.env.BASE_URL
const BASE_PROJECT_PATH = '/projets/'
const BASE_PROJECTS_DIR = `${BASE_URL}projects/`
const SLASH = '/'
const FEATURE_SEPARATOR = ':'
const RULE_SEPARATOR = ' #'
const EMPTY_STRING = ''
const route = useRoute()
const router = useRouter()
const featuresTreeNode = ref<FeatureTreeNode[]>([])
const expandedKeys = ref<string[]>([])
const searchQuery = ref('')
const selectedTags = ref<string[]>([])
const selectedScenario = ref<FeatureTreeNode | null>(null)
const scenarioDialog = ref(false)
const isLoading = ref(true)
const loadError = ref('')
const report = computed(() => CUCUMBER_REPORTS.find((item) => item.slug === route.params.slug))
const breadcrumbItems = ref<Array<{ title: string; to?: string; disabled?: boolean }>>([])
const totalFeatures = computed(() => countFeatures(featuresTreeNode.value))
const filteredTree = computed(() => selectedTags.value.length ? featuresTreeNode.value
  .map((node) => filterNodeByTags(node, new Set(selectedTags.value)))
  .filter((node): node is FeatureTreeNode => Boolean(node)) : featuresTreeNode.value)
const availableTags = computed(() => [...new Set([
  ...selectedTags.value,
  ...collectTags(filteredTree.value)
])].sort((a, b) => a.localeCompare(b)))
watch(selectedTags, () => {
  if (selectedTags.value.length) expandedKeys.value = collectBranchKeys(filteredTree.value)
}, { deep: true })

function collectBranchKeys(nodes: FeatureTreeNode[], result: string[] = []): string[] {
  nodes.forEach((node) => {
    if (node.children?.length) {
      result.push(node.key)
      collectBranchKeys(node.children, result)
    }
  })
  return result
}

function collectTags(nodes: FeatureTreeNode[], result = new Set<string>()): Set<string> {
  nodes.forEach((node) => {
    nodeTags(node).forEach((tag) => result.add(tag.name))
    if (node.children) collectTags(node.children, result)
  })
  return result
}

function filterNodeByTags(
  node: FeatureTreeNode,
  tags: Set<string>,
  inheritedTags: string[] = []
): FeatureTreeNode | undefined {
  const effectiveTags = [...inheritedTags, ...nodeTags(node).map((tag) => tag.name)]
  if (node.type === NODE_TYPE_SCENARIO || node.type === NODE_TYPE_BACKGROUND) {
    return [...tags].every((tag) => effectiveTags.includes(tag)) ? node : undefined
  }
  const children = (node.children || [])
    .map((child) => filterNodeByTags(child, tags, effectiveTags))
    .filter((child): child is FeatureTreeNode => Boolean(child))
  return children.length ? { ...node, children } : undefined
}

function countFeatures(nodes: FeatureTreeNode[]): number {
  return nodes.reduce(
    (count, node) => count + (node.type === NODE_TYPE_FEATURE ? 1 : 0) + countFeatures(node.children || []),
    0
  )
}

function filterTree(value: string, query: string, item?: InternalItem<FeatureTreeNode>): boolean {
  if (!query) return true
  const node = item?.raw || value as unknown as FeatureTreeNode
  const searchable = [node.label, node.concatenatedTags, node.allTags, node.fullText]
    .map((part) => typeof part === 'string' ? part : JSON.stringify(part || ''))
    .join(' ')
    .toLocaleLowerCase()
  return searchable.includes(query.toLocaleLowerCase())
}

function toggleTag(tag: string) {
  selectedTags.value = selectedTags.value.includes(tag)
    ? selectedTags.value.filter((selected) => selected !== tag)
    : [...selectedTags.value, tag]
}

function navigateNode(node: FeatureTreeNode) {
  if (node.type === NODE_TYPE_SCENARIO || node.type === NODE_TYPE_BACKGROUND) {
    selectedScenario.value = node
    scenarioDialog.value = true
    return
  }
  if (node.type === NODE_TYPE_DIRECTORY || node.type === NODE_TYPE_FEATURE) {
    router.push({ params: { ...route.params, feature: encodeURIComponent(node.key) } })
  }
}

function buildBreadcrumb(decodedFeaturePath: string, reportName: string) {
  const basePath = `${BASE_PROJECT_PATH}${route.params.slug}`
  breadcrumbItems.value = [{ title: reportName, to: basePath, disabled: !decodedFeaturePath }]
  if (!decodedFeaturePath) return
  const parts = decodedFeaturePath.split(SLASH)
  let currentKey = EMPTY_STRING
  for (let index = 0; index < parts.length; index++) {
    currentKey += (currentKey ? SLASH : EMPTY_STRING) + parts[index]
    const node = findNodeByKey(featuresTreeNode.value, currentKey)
    const path = parts.slice(0, index + 1).join(SLASH)
    breadcrumbItems.value.push({
      title: node?.label || parts[index],
      to: `${basePath}/${encodeURIComponent(path)}`,
      disabled: index === parts.length - 1
    })
  }
}

async function fetchFeature(path: string): Promise<string> {
  const response = await fetch(path)
  if (!response.ok) throw new Error(`Impossible de charger le rapport (${response.status}).`)
  return response.text()
}

async function loadFeatures(paths: string[], baseDir: string) {
  await Promise.all(paths.map(async (featureFilePath) => {
    const content = await fetchFeature(featureFilePath)
    const node = buildFeatureNode(parseFeatureFile(content), content)
    if (node) buildTreeStructure(featureFilePath, node, baseDir)
  }))
}

watch(
  () => [route.params.slug, route.params.feature] as const,
  async ([slug, featurePathParam]) => {
    featuresTreeNode.value = []
    selectedScenario.value = null
    scenarioDialog.value = false
    isLoading.value = true
    loadError.value = ''
    const baseDir = `${BASE_PROJECTS_DIR}${slug}`
    const reportName = CUCUMBER_REPORTS.find((item) => item.slug === slug)?.name || String(slug)
    const decodedPath = featurePathParam ? decodeURIComponent(String(featurePathParam)) : ''
    expandedKeys.value = decodedPath ? decodedPath.split(SLASH).map((_, index, parts) => parts.slice(0, index + 1).join(SLASH)) : []

    try {
      if (decodedPath) {
        const featureFilePath = `${baseDir}${SLASH}${decodedPath}`
        if (FEATURE_FILES.includes(featureFilePath)) {
          const content = await fetchFeature(featureFilePath)
          const node = buildFeatureNode(parseFeatureFile(content), content)
          if (node) buildTreeStructure(featureFilePath, node, baseDir)
        } else {
          const paths = FEATURE_FILES.filter((path) => path.startsWith(`${featureFilePath}${SLASH}`))
          await loadFeatures(paths, baseDir)
        }
      } else {
        const paths = FEATURE_FILES.filter((path) => path.startsWith(`${baseDir}${SLASH}`))
        await loadFeatures(paths, baseDir)
      }
      buildBreadcrumb(decodedPath, reportName)
    } catch (error) {
      loadError.value = error instanceof Error ? error.message : 'Une erreur est survenue lors du chargement.'
    } finally {
      isLoading.value = false
    }
  },
  { immediate: true }
)

function parseFeatureFile(text: string): Messages.GherkinDocument {
  const builder = new Gherkin.AstBuilder(Messages.IdGenerator.uuid())
  const matcher = new Gherkin.GherkinClassicTokenMatcher()
  const parser = new Gherkin.Parser(builder, matcher)
  return parser.parse(text) as Messages.GherkinDocument
}

function buildTreeStructure(filePath: string, featureNode: FeatureTreeNode, baseDir: string) {
  const parts = filePath.replace(new RegExp(`^${baseDir}/?|/$`, 'g'), '').split('/').filter(Boolean)
  let currentLevel = featuresTreeNode.value
  parts.forEach((part, index) => {
    const existingNode = findOrCreateNode(currentLevel, part, index, parts, featureNode)
    if (index === parts.length - 1) Object.assign(existingNode, featureNode, { key: parts.join('/') })
    currentLevel = existingNode.children || (existingNode.children = [])
  })
}

function buildFeatureNode(document: Messages.GherkinDocument, originalGherkin: string): FeatureTreeNode | undefined {
  const feature = document.feature
  if (!feature) return undefined
  const tags = feature.tags.map((tag) => tag.name)
  return {
    key: feature.name,
    label: feature.name,
    data: feature,
    keyword: feature.keyword,
    children: buildFeatureChildren(feature),
    fullText: document,
    concatenatedTags: tags.join(' '),
    allTags: tags.join(' '),
    feature: true,
    type: NODE_TYPE_FEATURE,
    content: originalGherkin
  }
}

function buildFeatureChildren(feature: Messages.Feature): FeatureTreeNode[] {
  return feature.children.map((child) => {
    if (child.rule) return buildRuleNode(feature, child.rule)
    if (child.background) return buildBackgroundNode(child.background)
    if (child.scenario) return buildScenarioNode(child.scenario)
    return undefined
  }).filter((node): node is FeatureTreeNode => Boolean(node))
}

function buildScenarioNode(scenario: Messages.Scenario): FeatureTreeNode {
  const tags = scenario.tags?.map((tag) => tag.name) || []
  return {
    key: scenario.id,
    label: scenario.name,
    data: scenario,
    keyword: scenario.keyword,
    leaf: true,
    concatenatedTags: tags.join(' '),
    allTags: generateCombinationString(tags.join(' ')),
    fullText: fullTextScenario(scenario),
    type: NODE_TYPE_SCENARIO
  }
}

function fullTextScenario(scenario: Messages.Scenario): string {
  const steps = scenario.steps?.map((step) => [step.text, ...(step.dataTable?.rows.flatMap((row) => row.cells.map((cell) => cell.value)) || [])].join(' ')) || []
  const examples = scenario.examples?.flatMap((example) => example.tableBody.flatMap((row) => row.cells.map((cell) => cell.value))) || []
  return [...steps, ...examples].join(' ')
}

function buildRuleNode(feature: Messages.Feature, rule: Messages.Rule): FeatureTreeNode {
  const tags = rule.tags.map((tag) => tag.name)
  return {
    key: `${feature.name}${RULE_SEPARATOR}${rule.name}`,
    data: rule,
    keyword: rule.keyword,
    label: rule.name,
    leaf: false,
    children: rule.children.map((child) => child.scenario ? buildScenarioNode(child.scenario) : child.background ? buildBackgroundNode(child.background) : undefined)
      .filter((node): node is FeatureTreeNode => Boolean(node)),
    concatenatedTags: tags.join(' '),
    allTags: tags.join(' '),
    type: NODE_TYPE_RULE
  }
}

function buildBackgroundNode(background: Messages.Background): FeatureTreeNode {
  return { key: background.id, data: background, keyword: background.keyword, label: background.name, leaf: true, type: NODE_TYPE_BACKGROUND }
}

function downloadNode(node: FeatureTreeNode) {
  if (!node.content) return
  const blob = new Blob([node.content], { type: 'text/plain;charset=utf-8' })
  const url = URL.createObjectURL(blob)
  const anchor = document.createElement('a')
  anchor.href = url
  anchor.download = `${node.label || 'feature'}.feature`
  anchor.click()
  URL.revokeObjectURL(url)
}

function openViewer(node: FeatureTreeNode, split: boolean) {
  if (!node.content) return
  router.push({ path: '/editor', state: { title: node.label, content: node.content, split } })
}

function nodeTags(node: FeatureTreeNode): readonly Messages.Tag[] {
  const data = node.data as Messages.Feature | Messages.Rule | Messages.Scenario | undefined
  return data?.tags || []
}

function nodeDescription(node: FeatureTreeNode): string | undefined {
  return (node.data as Messages.Feature | Messages.Rule | Messages.Scenario | undefined)?.description
}

function nodeSteps(node: FeatureTreeNode): readonly Messages.Step[] {
  return (node.data as Messages.Scenario | Messages.Background | undefined)?.steps || []
}

function nodeExamples(node: FeatureTreeNode): readonly Messages.Examples[] {
  return (node.data as Messages.Scenario | undefined)?.examples || []
}
</script>

<template>
  <v-container class="project-page px-4 px-md-8 py-6 py-md-9">
    <v-breadcrumbs class="project-breadcrumbs px-0 py-0 mb-5" :items="breadcrumbItems">
      <template #divider><span class="breadcrumb-divider">/</span></template>
      <template #item="{ item }">
        <v-breadcrumbs-item :to="item.to" :disabled="!item.to">
          {{ item.title }}
        </v-breadcrumbs-item>
      </template>
    </v-breadcrumbs>

    <header class="project-header">
      <div>
        <div class="eyebrow">ESPACE PROJET <span>·</span> RAPPORTS BDD</div>
        <h1>{{ report?.name || route.params.slug }}</h1>
        <p>Explorez les fonctionnalités et les scénarios de test métier.</p>
      </div>
      <v-chip class="feature-count" variant="tonal" size="small">
        {{ totalFeatures }} fonctionnalité{{ totalFeatures > 1 ? 's' : '' }}
      </v-chip>
    </header>

    <v-card class="explorer-card" variant="flat">
      <div class="explorer-toolbar">
        <div class="explorer-heading">
          <span class="explorer-mark">BDD</span>
          <div><strong>Explorateur de rapports</strong><small>Structure du projet et scénarios</small></div>
        </div>
        <v-text-field
          v-model="searchQuery"
          class="search-field"
          label="Rechercher dans les rapports"
          placeholder="Nom ou étape…"
          prepend-inner-icon="⌕"
          clearable
          hide-details
          density="compact"
          aria-label="Rechercher dans les rapports"
        />
      </div>
      <div v-if="availableTags.length" class="tag-filter">
        <div class="tag-filter__heading">
          <strong>Filtrer par tag</strong>
          <button v-if="selectedTags.length" class="clear-tags" type="button" @click="selectedTags = []">
            Effacer
          </button>
        </div>
        <div class="tag-options" role="group" aria-label="Filtrer les rapports par tags">
          <v-chip
            v-for="tag in availableTags"
            :key="tag"
            class="tag-option"
            :class="{ 'tag-option--selected': selectedTags.includes(tag) }"
            :variant="selectedTags.includes(tag) ? 'flat' : 'outlined'"
            :color="selectedTags.includes(tag) ? 'primary' : undefined"
            size="small"
            :aria-pressed="selectedTags.includes(tag)"
            @click="toggleTag(tag)"
          >
            {{ tag }}
          </v-chip>
        </div>
        <p v-if="selectedTags.length" class="tag-filter__hint">Affichage des scénarios portant tous les tags sélectionnés.</p>
      </div>
      <v-divider />

      <v-alert v-if="loadError" class="ma-5" type="error" variant="tonal" border="start">
        {{ loadError }}
      </v-alert>
      <div v-else-if="isLoading" class="loading-state">
        <v-progress-circular indeterminate color="primary" size="25" width="2" />
        <span>Chargement des rapports…</span>
      </div>
      <div v-else-if="!featuresTreeNode.length" class="empty-state">
        <strong>Aucun scénario disponible</strong>
        <span>Ce projet ne contient pas encore de fichier Gherkin.</span>
      </div>
      <div v-else-if="!filteredTree.length" class="empty-state">
        <strong>Aucun rapport pour ces tags</strong>
        <span>Essayez de retirer un tag ou effacez le filtre.</span>
        <v-btn variant="text" color="primary" @click="selectedTags = []">Effacer les tags</v-btn>
      </div>
      <v-treeview
        v-else
        class="report-tree"
        :items="filteredTree"
        :opened="expandedKeys"
        :search="searchQuery"
        :custom-filter="filterTree"
        item-title="label"
        item-value="key"
        item-children="children"
        open-on-click
        density="comfortable"
        indent="18"
        lines="one"
        aria-label="Arborescence des rapports Gherkin"
        @update:opened="expandedKeys = $event as string[]"
      >
        <template #title="{ item }">
          <div
            class="tree-node"
            :class="{ 'tree-node--selectable': item.type === NODE_TYPE_SCENARIO || item.type === NODE_TYPE_BACKGROUND }"
            @click.stop="navigateNode(item as FeatureTreeNode)"
          >
            <div class="tree-node__main">
              <span class="node-type">{{ item.type === NODE_TYPE_DIRECTORY ? 'DOSSIER' : item.data?.keyword || 'SCÉNARIO' }}</span>
              <div class="tree-node__title">
                <strong v-if="item.type === NODE_TYPE_FEATURE">{{ item.data?.keyword }}{{ FEATURE_SEPARATOR }}</strong>
                {{ item.label }}
                <span v-if="item.type === NODE_TYPE_SCENARIO || item.type === NODE_TYPE_BACKGROUND" class="scenario-open-hint">Ouvrir →</span>
              </div>
              <p v-if="nodeDescription(item as FeatureTreeNode)" class="tree-node__description">{{ nodeDescription(item as FeatureTreeNode) }}</p>
              <CucumberTags v-if="nodeTags(item as FeatureTreeNode).length" :tags="nodeTags(item as FeatureTreeNode)" />
              <CucumberSteps v-if="nodeSteps(item as FeatureTreeNode).length" :steps="nodeSteps(item as FeatureTreeNode)" />
              <CucumberExamples v-if="nodeExamples(item as FeatureTreeNode).length" :examples="nodeExamples(item as FeatureTreeNode)" />
            </div>
            <div v-if="item.type === NODE_TYPE_FEATURE" class="node-actions" @click.stop>
              <v-btn size="small" variant="text" @click="downloadNode(item as FeatureTreeNode)">Télécharger</v-btn>
              <v-btn size="small" variant="text" @click="openViewer(item as FeatureTreeNode, false)">Consulter</v-btn>
              <v-btn size="small" variant="text" @click="openViewer(item as FeatureTreeNode, true)">Par règles</v-btn>
            </div>
          </div>
        </template>
        <template #no-data>
          <div class="no-results">Aucun résultat pour « {{ searchQuery }} ».</div>
        </template>
      </v-treeview>
    </v-card>
    <div class="project-footnote">Les rapports sont consultables en lecture seule. Le contenu reflète les fichiers Gherkin publiés.</div>

    <v-dialog v-model="scenarioDialog" max-width="820" scrollable>
      <v-card v-if="selectedScenario" class="scenario-dialog">
        <v-card-title class="scenario-dialog__header">
          <div>
            <div class="node-type">{{ selectedScenario.keyword || 'SCÉNARIO' }}</div>
            <h2>{{ selectedScenario.label }}</h2>
          </div>
          <v-btn variant="text" aria-label="Fermer le scénario" @click="scenarioDialog = false">Fermer</v-btn>
        </v-card-title>
        <v-divider />
        <v-card-text class="scenario-dialog__content">
          <p v-if="nodeDescription(selectedScenario)" class="tree-node__description">{{ nodeDescription(selectedScenario) }}</p>
          <CucumberTags v-if="nodeTags(selectedScenario).length" :tags="nodeTags(selectedScenario)" />
          <CucumberSteps v-if="nodeSteps(selectedScenario).length" :steps="nodeSteps(selectedScenario)" />
          <CucumberExamples v-if="nodeExamples(selectedScenario).length" :examples="nodeExamples(selectedScenario)" />
          <div v-if="!nodeSteps(selectedScenario).length && !nodeExamples(selectedScenario).length" class="scenario-empty">
            Aucun détail supplémentaire pour ce scénario.
          </div>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<style scoped>
.project-page { max-width: 1280px; }
.project-breadcrumbs :deep(.v-breadcrumbs-item) { color: #72817d; font-size: 12px; }
.project-breadcrumbs :deep(.v-breadcrumbs-item--disabled) { color: #334c45; opacity: 1; font-weight: 600; }
.breadcrumb-divider { color: #b5c0bc; font-size: 13px; }
.project-header { display: flex; align-items: flex-end; justify-content: space-between; gap: 20px; margin-bottom: 24px; }
.eyebrow { color: #81918c; font-size: 9px; font-weight: 700; letter-spacing: .15em; }
.eyebrow span { padding: 0 5px; color: #b4c0bc; }
.project-header h1 { margin: 8px 0 5px; color: #1a312c; font-size: clamp(27px, 3vw, 37px); font-weight: 600; letter-spacing: -.045em; }
.project-header p { margin: 0; color: #71807b; font-size: 13px; }
.feature-count { flex: 0 0 auto; color: #125b50; font-weight: 600; }
.explorer-card { overflow: hidden; border: 1px solid #e6ece9; background: white; box-shadow: 0 8px 30px rgba(23,43,39,.045); }
.explorer-toolbar { display: flex; align-items: center; justify-content: space-between; gap: 20px; padding: 19px 22px; }
.explorer-heading { display: flex; align-items: center; gap: 12px; }
.explorer-mark { display: grid; width: 38px; height: 38px; place-items: center; border-radius: 12px; background: #eaf4f0; color: #125b50; font-size: 10px; font-weight: 700; }
.explorer-heading div { display: flex; flex-direction: column; gap: 3px; }
.explorer-heading strong { color: #233a34; font-size: 13px; font-weight: 600; }
.explorer-heading small { color: #84918d; font-size: 11px; }
.search-field { max-width: 350px; flex: 1 1 250px; }
.tag-filter { padding: 13px 22px 15px; border-top: 1px solid #f0f3f2; background: #fcfdfd; }
.tag-filter__heading { display: flex; align-items: center; gap: 10px; margin-bottom: 9px; }
.tag-filter__heading strong { color: #53645f; font-size: 11px; font-weight: 600; }
.clear-tags { padding: 0; border: 0; background: transparent; color: #176b58; cursor: pointer; font: inherit; font-size: 10px; }
.tag-options { display: flex; flex-wrap: wrap; gap: 7px; }
.tag-option { max-width: 100%; cursor: pointer; font-family: 'Consolas', 'Courier New', monospace; font-size: 10px; }
.tag-option--selected { color: white; }
.tag-filter__hint { margin: 9px 0 0; color: #82908b; font-size: 10px; }
.report-tree { padding: 15px 21px 20px; }
.report-tree :deep(.v-treeview-item) { align-items: flex-start; }
.report-tree :deep(.v-treeview-item__root) { min-height: auto; padding-block: 4px; }
.report-tree :deep(.v-treeview-item__content) { align-items: flex-start; padding: 7px 0 8px; white-space: normal; }
.report-tree :deep(.v-treeview-item__prepend) { align-self: flex-start; margin-top: 8px; }
.tree-node { width: 100%; min-width: 0; }
.tree-node--selectable { cursor: pointer; }
.tree-node--selectable:hover .tree-node__title { color: #125b50; }
.tree-node__main { min-width: 0; }
.scenario-open-hint { margin-left: 8px; color: #82938c; font-size: 10px; font-weight: 500; opacity: 0; transition: opacity .15s ease; }
.tree-node--selectable:hover .scenario-open-hint, .tree-node--selectable:focus-within .scenario-open-hint { opacity: 1; }
.scenario-dialog__header { display: flex; align-items: flex-start; justify-content: space-between; gap: 16px; padding: 22px 24px 18px; white-space: normal; }
.scenario-dialog__header h2 { margin-top: 5px; color: #203a33; font-size: 20px; font-weight: 600; line-height: 1.35; }
.scenario-dialog__content { max-height: min(70vh, 700px); padding: 21px 24px 28px; }
.scenario-empty { padding: 18px 0; color: #76847e; font-size: 13px; }
@media (hover: none) { .scenario-open-hint { opacity: 1; } }
.node-type { color: #8b9994; font-size: 8px; font-weight: 700; letter-spacing: .13em; }
.tree-node__title { margin-top: 2px; color: #263d37; font-size: 13px; line-height: 1.55; }
.tree-node__title strong { color: #125b50; font-weight: 700; }
.tree-node__description { margin: 4px 0 7px; color: #687772; font-size: 12px; line-height: 1.65; white-space: pre-wrap; }
.node-actions { display: flex; flex-wrap: wrap; gap: 3px; margin-top: 8px; }
.node-actions :deep(.v-btn) { min-height: 30px; padding-inline: 9px; color: #125b50; font-size: 10px; }
.loading-state { display: flex; min-height: 250px; align-items: center; justify-content: center; gap: 12px; color: #788680; font-size: 13px; }
.empty-state { display: flex; min-height: 250px; flex-direction: column; align-items: center; justify-content: center; gap: 7px; color: #76837f; font-size: 12px; }
.empty-state strong { color: #2d433d; font-size: 15px; }
.empty-icon { display: grid; width: 44px; height: 44px; margin-bottom: 5px; place-items: center; border-radius: 14px; background: #eaf4f0; color: #125b50; font-size: 11px; font-weight: 700; }
.no-results { padding: 16px; color: #75827e; font-size: 12px; }
.project-footnote { padding: 18px 4px 0; color: #95a19c; font-size: 10px; }
@media (max-width: 650px) {
  .project-header { align-items: flex-start; }
  .feature-count { margin-top: 7px; }
  .explorer-toolbar { align-items: stretch; flex-direction: column; gap: 14px; padding: 17px; }
  .search-field { max-width: none; flex-basis: auto; }
  .tag-filter { padding-inline: 17px; }
  .report-tree { padding: 12px 8px 16px; }
  .node-actions :deep(.v-btn) { padding-inline: 5px; font-size: 9px; }
}
</style>
