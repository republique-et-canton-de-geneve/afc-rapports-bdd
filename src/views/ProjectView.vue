<script setup lang="ts">
import { CUCUMBER_REPORTS } from '@/assets/consts'
import { useRoute, useRouter } from 'vue-router'
import { computed, ref, watch } from 'vue'
import type { TreeNode } from 'primevue/treenode'

import * as Gherkin from '@cucumber/gherkin'
import * as Messages from '@cucumber/messages'
import { FEATURE_FILES } from '@/generated/featureFiles'
import CucumberExamples from '@/components/CucumberExamples.vue'
import CucumberSteps from '@/components/CucumberSteps.vue'
import CucumberTags from '@/components/CucumberTags.vue'

const route = useRoute()
const router = useRouter()

// TreeNode
const featuresTreeNode = ref<TreeNode[]>([])
const expandedKeys = ref<{ [key: string]: boolean }>({})

// pour afficher le bon nom dans le fil d'ariane (breadcrumb)
const findNodeByKey = (nodes: TreeNode[], key: string): TreeNode | undefined => {
  for (const node of nodes) {
    if (node.key === key) {
      return node
    }
    if (node.children) {
      const result = findNodeByKey(node.children, key)
      if (result) {
        return result
      }
    }
  }
  return undefined
}

// BreadCrumb
const breadcrumbItems = ref<any[]>([])

const buildBreadcrumb = (decodedFeaturePath: string, reportName: string) => {
  const parts = decodedFeaturePath.split('/')
  let currentKey = ''
  breadcrumbItems.value = [
    { label: reportName, command: () => router.push(`/projets/${route.params.slug}`) }
  ]
  for (let i = 0; i < parts.length; i++) {
    currentKey += (currentKey ? '/' : '') + parts[i]
    const node = findNodeByKey(featuresTreeNode.value, currentKey)
    const label = node?.label || parts[i]
    const feature = parts.slice(0, i + 1).join('/')
    breadcrumbItems.value.push({
      label: label,
      command: () => {
        return router.push({ params: { ...route.params, feature: encodeURIComponent(feature) } })
      }
    })
  }
}

const items = computed(() => {
  const reportName = CUCUMBER_REPORTS.find((report) => report.slug === route.params.slug)?.name || '';
  const baseItems = [
    { label: reportName, command: () => router.push(`/projets/${route.params.slug}`) }
  ]

  if (route.params.feature && typeof route.params.feature === 'string') {
    const featurePath = decodeURIComponent(route.params.feature)
    const parts = featurePath.split('/')
    parts.forEach((part, index) => {
      const feature = parts.slice(0, index + 1).join('/')
      baseItems.push({
        label: part,
        command: () => {
          return router.push({ params: { ...route.params, feature: encodeURIComponent(feature) } })
        }
      })
    })
  }

  return baseItems
})
const home = { icon: 'pi pi-home', command: () => router.push('/') }

watch(
  () => route.params.feature as string,
  (featurePathParam) => {
    featuresTreeNode.value = []

    const baseDir = '/projects/' + route.params.slug
    const reportName = CUCUMBER_REPORTS.find((report) => report.slug === route.params.slug)?.name || '';

    breadcrumbItems.value = [
      { label: reportName, command: () => router.push(`/projets/${route.params.slug}`) }
    ]

    const loadFeatures = (paths: string[]) => {
      const promises = paths.map((featureFilePath) => {
        return fetch(featureFilePath)
          .then((body) => body.text())
          .then((featureFileContent) => buildFeatureNode(parseFeatureFile(featureFileContent)))
          .then((featureNode) => {
            if (featureNode) {
              buildTreeStructure(featureFilePath, featureNode, baseDir)
            }
          })
      })

      return Promise.all(promises)
    }

    if (featurePathParam) {
      const decodedFeaturePath = decodeURIComponent(featurePathParam)
      expandedKeys.value = {
        [decodedFeaturePath]: true
      }

      const featureFilePath = baseDir + '/' + decodedFeaturePath

      // Vérifier si le chemin correspond à un répertoire ou un fichier
      if (FEATURE_FILES.includes(featureFilePath)) {
        // C'est un fichier de fonctionnalité unique
        fetch(featureFilePath)
          .then((body) => body.text())
          .then((featureFileContent) => buildFeatureNode(parseFeatureFile(featureFileContent)))
          .then((featureNode) => {
            if (featureNode) {
              buildTreeStructure(featureFilePath, featureNode, baseDir)

              // Construire le fil d'Ariane
              buildBreadcrumb(decodedFeaturePath, reportName)
            }
          })
      } else {
        // C'est un répertoire, charger toutes les fonctionnalités dans ce répertoire
        const featurePaths = FEATURE_FILES.filter((path) => path.startsWith(featureFilePath + '/'))
        loadFeatures(featurePaths).then(() => {
          // Construire le fil d'Ariane
          buildBreadcrumb(decodedFeaturePath, reportName)
        })
      }
    } else {
      // Charger toutes les fonctionnalités
      expandedKeys.value = {}
      loadFeatures(FEATURE_FILES.filter((path) => path.startsWith(baseDir))).then(() => {
        // Le fil d'Ariane ne contient que le nom du projet
        breadcrumbItems.value = [
          { label: reportName, command: () => router.push(`/projets/${route.params.slug}`) }
        ]
      })
    }
  },
  { immediate: true }
)

const parseFeatureFile = (text: string) => {
  let builder = new Gherkin.AstBuilder(Messages.IdGenerator.uuid())
  let matcher = new Gherkin.GherkinClassicTokenMatcher()
  let parser = new Gherkin.Parser(builder, matcher)
  return parser.parse(text) as Messages.GherkinDocument
}

const buildTreeStructure = (filePath: string, featureNode: TreeNode, baseDir: string): void => {
  const parts = filePath
    .replace(new RegExp(`^${baseDir}/?|/$`, 'g'), '')
    .split('/')
    .filter(Boolean)

  let currentLevel = featuresTreeNode.value

  parts.forEach((part, index) => {
    let existingNode = currentLevel.find((node) => node.label === part)
    if (!existingNode) {
      existingNode = {
        key: parts.slice(0, index + 1).join('/'),
        label: index === parts.length - 1 ? featureNode.label : part,
        children: [],
        leaf: false,
        data: index === parts.length - 1 ? featureNode.data : undefined,
        feature: index === parts.length - 1 ? featureNode.feature : undefined,
        concatenatedTags: index === parts.length - 1 ? featureNode.concatenatedTags : undefined,
        type: index === parts.length - 1 ? 'feature' : 'directory' // Ajout de la propriété type
      }
      currentLevel.push(existingNode)
      currentLevel.sort(compareTreeNodes)
    } else {
      // Mise à jour du type si nécessaire
      existingNode.type = index === parts.length - 1 ? 'feature' : 'directory'
    }
    if (index === parts.length - 1) {
      // Mise à jour des informations du nœud de fonctionnalité
      existingNode.label = featureNode.label
      existingNode.children = featureNode.children
      existingNode.data = featureNode.data
      existingNode.concatenatedTags = featureNode.concatenatedTags
      existingNode.feature = featureNode.feature
      existingNode.leaf = featureNode.leaf
      existingNode.type = 'feature' // Assurer que le type est 'feature'
    }
    currentLevel = existingNode.children!
  })
}

const buildFeatureNode = (document: Messages.GherkinDocument | undefined): TreeNode | undefined => {
  const feature = document?.feature
  if (!feature) return undefined
  return {
    key: feature.name,
    data: feature,
    label: feature.name,
    leaf: false,
    children: buildFeatureChildren(feature.children),
    concatenatedTags: feature.tags.map((tag) => tag.name).join(),
    feature: true,
    type: 'feature'
  } as TreeNode
}

const buildFeatureChildren = (features: readonly Messages.FeatureChild[]): TreeNode[] => {
  return features
    .map((featureChild: Messages.FeatureChild) => {
      if (featureChild.rule) {
        return buildRuleNode(featureChild.rule)
      }
      if (featureChild.background) {
        return buildBackgroundNode(featureChild.background)
      }
      if (featureChild.scenario) {
        return buildScenarioNode(featureChild.scenario)
      }
    })
    .filter(Boolean) as TreeNode[]
}
const buildScenarioNode = (scenario: Messages.Scenario) => {
  return {
    key: scenario.id,
    data: scenario,
    label: scenario.name,
    leaf: true,
    concatenatedTags: scenario.tags.map((tag) => tag.name).join()
  } as TreeNode
}

const buildRuleNode = (rule: Messages.Rule) => {
  return {
    key: rule.id,
    data: rule,
    label: rule.name,
    leaf: false,
    children: buildRuleChildren(rule.children),
    concatenatedTags: rule.tags.map((tag) => tag.name).join(),
    rule: true
  } as TreeNode
}

const buildRuleChildren = (elements: readonly Messages.RuleChild[]) => {
  return elements.map((ruleChild: Messages.RuleChild) => {
    if (ruleChild.scenario) {
      return buildScenarioNode(ruleChild.scenario)
    }
    if (ruleChild.background) {
      return buildBackgroundNode(ruleChild.background)
    }
  })
}

const buildBackgroundNode = (background: Messages.Background) => {
  return {
    key: background.id,
    data: background,
    label: background.name,
    leaf: true
  } as TreeNode
}

const compareTreeNodes = (a: TreeNode, b: TreeNode) => {
  const aType = a.type
  const bType = b.type

  if (aType === 'directory' && bType !== 'directory') {
    return -1 // a est un répertoire, b n'est pas un répertoire, a vient en premier
  } else if (aType !== 'directory' && bType === 'directory') {
    return 1 // b est un répertoire, a n'est pas un répertoire, b vient en premier
  } else {
    // Les deux sont du même type
    if (!a.label || !b.label) {
      return 0
    }

    // Si les deux sont des fonctionnalités, trier par numéro de fonctionnalité
    if (aType === 'feature' && bType === 'feature') {
      // Extraction des numéros de fonctionnalité (par exemple, F1, F2)
      const numA = parseInt(a.label.match(/F(\d+)/)?.[1] || '', 10)
      const numB = parseInt(b.label.match(/F(\d+)/)?.[1] || '', 10)

      if (!isNaN(numA) && !isNaN(numB)) {
        return numA - numB // Tri numérique par numéro de fonctionnalité
      }

      // Si pas de numéros, tri alphabétique
      return a.label.localeCompare(b.label)
    }

    // Pour les répertoires ou autres types, tri alphabétique
    return a.label.localeCompare(b.label)
  }
}
</script>

<template>
  <Breadcrumb :model="breadcrumbItems" :home="home" />
  <div v-if="featuresTreeNode">
    <Tree
      :value="featuresTreeNode"
      :filter="true"
      filterMode="lenient"
      filterBy="label,concatenatedTags"
      :expandedKeys="expandedKeys"
    >
      <template #default="slotProps">
        <CucumberTags :tags="slotProps.node.data?.tags" />
        <div class="title">
          <!-- Répertoires cliquables avec icône et label -->
          <span v-if="slotProps.node.type === 'directory'">
            <router-link
              :to="{
                params: { ...$route.params, feature: encodeURIComponent(slotProps.node.key || '') }
              }"
              class="directory-link"
            >
              <i class="pi pi-folder"></i>
              <span>&nbsp;{{ slotProps.node.label }}</span>
            </router-link>
          </span>
          <!-- Permalinks pour les fonctionnalités -->
          <span v-else-if="slotProps.node.feature">
            <router-link
              :to="{
                params: { ...$route.params, feature: encodeURIComponent(slotProps.node.key || '') }
              }"
            >
              <i class="pi pi-link"></i>
            </router-link>
            <!-- Affichage du mot-clé et du label -->
            <b>&nbsp;{{ slotProps.node.data?.keyword }}</b>
            <span v-if="slotProps.node.feature || slotProps.node.rule"> : </span>
            <span v-else>&nbsp;</span>
            <span>{{ slotProps.node.label }}</span>
          </span>
          <!-- Autres cas (règles, scénarios, etc.) -->
          <span v-else>
            <!-- Affichage du mot-clé et du label -->
            <b>&nbsp;{{ slotProps.node.data?.keyword }}</b>
            <span v-if="slotProps.node.feature || slotProps.node.rule"> : </span>
            <span v-else>&nbsp;</span>
            <span>{{ slotProps.node.label }}</span>
          </span>
        </div>
        <div class="description" v-if="slotProps.node.data?.description">
          {{ slotProps.node.data.description }}
        </div>
        <CucumberSteps v-if="slotProps.node.data?.steps" :steps="slotProps.node.data?.steps" />
        <CucumberExamples
          v-if="slotProps.node.data?.examples"
          :examples="slotProps.node.data?.examples"
        />
      </template>
    </Tree>
  </div>
  <div v-else><i class="pi pi-spin pi-spinner"></i> Chargement en cours</div>
</template>

<style scoped>
.directory-link {
  color: inherit; /* Utiliser la couleur de texte héritée */
  text-decoration: none; /* Supprimer le soulignement */
}

.directory-link:hover,
.directory-link:active,
.directory-link:visited {
  color: inherit; /* Empêcher le changement de couleur au survol, au clic et pour les liens visités */
  text-decoration: none;
}

.directory-link {
  cursor: default; /* Le curseur reste le même (pas de pointeur de lien) */
}

/* Vos autres styles existants */
.description {
  white-space: pre-wrap;
  word-wrap: break-word;
  font-family: inherit;
  padding-top: 5px;
}
</style>
