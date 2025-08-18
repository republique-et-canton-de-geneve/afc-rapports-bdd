<script setup lang="ts">
import { CUCUMBER_REPORTS } from '@/assets/consts'
import { useRoute, useRouter } from 'vue-router'
import { ref, watch } from 'vue'
import type { TreeNode } from 'primevue/treenode'

import * as Gherkin from '@cucumber/gherkin'
import * as Messages from '@cucumber/messages'
import { FEATURE_FILES } from '@/generated/featureFiles'
import CucumberExamples from '@/components/CucumberExamples.vue'
import CucumberSteps from '@/components/CucumberSteps.vue'
import CucumberTags from '@/components/CucumberTags.vue'

const BASE_URL = import.meta.env.BASE_URL
const BASE_PROJECT_PATH = `${BASE_URL}projets/`
const BASE_PROJECTS_DIR = `${BASE_URL}projects/`
const SLASH = "/";
const FEATURE_SEPARATOR = ":";
const EMPTY_STRING = "";
const NODE_TYPE_DIRECTORY = "directory";
const NODE_TYPE_FEATURE = "feature";
const NODE_TYPE_RULE = "rule";
const NODE_TYPE_SCENARIO = "scenario";
const NODE_TYPE_BACKGROUND = "background";

const route = useRoute()
const router = useRouter()

// Variables réactives pour l'arbre des fonctionnalités et les clés étendues
const featuresTreeNode = ref<TreeNode[]>([])
const expandedKeys = ref<{ [key: string]: boolean }>({})

// Fonction pour trouver un nœud dans l'arbre par sa clé (pour le fil d'ariane)
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

// Données pour le fil d'Ariane (breadcrumb)
const breadcrumbItems = ref<any[]>([])
const home = { icon: 'pi pi-home', command: () => router.push(SLASH) }

// Fonction pour construire le fil d'Ariane
const buildBreadcrumb = (decodedFeaturePath: string, reportName: string) => {
  const parts = decodedFeaturePath.split(SLASH)
  let currentKey = EMPTY_STRING
  breadcrumbItems.value = [
    { label: reportName, command: () => router.push(`${BASE_PROJECT_PATH}${route.params.slug}`) }
  ]
  for (let i = 0; i < parts.length; i++) {
    currentKey += (currentKey ? SLASH : EMPTY_STRING) + parts[i]
    const node = findNodeByKey(featuresTreeNode.value, currentKey)
    const label = node?.label || parts[i]
    const feature = parts.slice(0, i + 1).join(SLASH)
    breadcrumbItems.value.push({
      label: label,
      command: () => {
        return router.push({ params: { ...route.params, feature: encodeURIComponent(feature) } })
      }
    })
  }
}

// Fonction pour charger les fonctionnalités
const loadFeatures = async (paths: string[], baseDir: string) => {
  const promises = paths.map(async (featureFilePath) => {
    const body = await fetch(featureFilePath)
    const featureFileContent = await body.text()
    const featureNode = buildFeatureNode(parseFeatureFile(featureFileContent))
    if (featureNode) {
      buildTreeStructure(featureFilePath, featureNode, baseDir)
    }
  })
  await Promise.all(promises)
}

// Watcher sur le paramètre de route 'feature'
watch(
  () => route.params.feature as string,
  async (featurePathParam) => {
    featuresTreeNode.value = []

    const baseDir = `${BASE_PROJECTS_DIR}${route.params.slug}`
    const reportName =
      CUCUMBER_REPORTS.find((report) => report.slug === route.params.slug)?.name || EMPTY_STRING

    breadcrumbItems.value = [
      { label: reportName, command: () => router.push(`${BASE_PROJECT_PATH}${route.params.slug}`) }
    ]

    if (featurePathParam) {
      const decodedFeaturePath = decodeURIComponent(featurePathParam)
      expandedKeys.value = {
        [decodedFeaturePath]: true
      }

      const featureFilePath = baseDir + SLASH + decodedFeaturePath

      // Vérifier si le chemin correspond à un fichier ou un répertoire
      if (FEATURE_FILES.includes(featureFilePath)) {
        // C'est un fichier de fonctionnalité unique
        const body = await fetch(featureFilePath)
        const featureFileContent = await body.text()
        const featureNode = buildFeatureNode(parseFeatureFile(featureFileContent))
        if (featureNode) {
          buildTreeStructure(featureFilePath, featureNode, baseDir)
          buildBreadcrumb(decodedFeaturePath, reportName)
        }
      } else {
        // C'est un répertoire, charger toutes les fonctionnalités dans ce répertoire
        const featurePaths = FEATURE_FILES.filter((path) => path.startsWith(featureFilePath + SLASH))
        await loadFeatures(featurePaths, baseDir)
        buildBreadcrumb(decodedFeaturePath, reportName)
      }
    } else {
      // Charger toutes les fonctionnalités
      expandedKeys.value = {}
      const featurePaths = FEATURE_FILES.filter((path) => path.startsWith(baseDir))
      await loadFeatures(featurePaths, baseDir)
      // Le fil d'Ariane ne contient que le nom du projet
      breadcrumbItems.value = [
        { label: reportName, command: () => router.push(`${BASE_PROJECT_PATH}${route.params.slug}`) }
      ]
    }
  },
  { immediate: true }
)

// Fonction pour parser un fichier de fonctionnalité Gherkin
const parseFeatureFile = (text: string) => {
  let builder = new Gherkin.AstBuilder(Messages.IdGenerator.uuid())
  let matcher = new Gherkin.GherkinClassicTokenMatcher()
  let parser = new Gherkin.Parser(builder, matcher)
  return parser.parse(text) as Messages.GherkinDocument
}

// Fonction pour construire la structure de l'arbre des fonctionnalités
const buildTreeStructure = (filePath: string, featureNode: TreeNode, baseDir: string): void => {
  const parts = extractFilePathParts(filePath, baseDir);
  let currentLevel = featuresTreeNode.value;

  parts.forEach((part, index) => {
    let existingNode = findOrCreateNode(currentLevel, part, index, parts, featureNode);
    updateFeatureNodeIfNecessary(existingNode, featureNode, index, parts.length);
    currentLevel = existingNode.children!;
  });
};

// Fonction pour extraire les parties du chemin de fichier
const extractFilePathParts = (filePath: string, baseDir: string): string[] => {
  return filePath
    .replace(new RegExp(`^${baseDir}/?|/$`, 'g'), '')
    .split('/')
    .filter(Boolean);
};

// Fonction pour trouver ou créer un nœud existant
const findOrCreateNode = (
  currentLevel: TreeNode[],
  part: string,
  index: number,
  parts: string[],
  featureNode: TreeNode
): TreeNode => {
  let existingNode = currentLevel.find((node) => node.label === part);
  if (!existingNode) {
    existingNode = createNode(part, index, parts, featureNode);
    currentLevel.push(existingNode);
    currentLevel.sort(compareTreeNodes);
  }
  return existingNode;
};

// Fonction pour créer un nœud
const createNode = (
  part: string,
  index: number,
  parts: string[],
  featureNode: TreeNode
): TreeNode => {
  return {
    key: parts.slice(0, index + 1).join('/'),
    label: index === parts.length - 1 ? featureNode.label : part,
    children: [],
    leaf: false,
    data: index === parts.length - 1 ? featureNode.data : undefined,
    feature: index === parts.length - 1 ? featureNode.feature : undefined,
    concatenatedTags: index === parts.length - 1 ? featureNode.concatenatedTags : undefined,
    type: index === parts.length - 1 ? 'feature' : 'directory'
  };
};

// Fonction pour mettre à jour le nœud de fonctionnalité si nécessaire
const updateFeatureNodeIfNecessary = (
  existingNode: TreeNode,
  featureNode: TreeNode,
  index: number,
  partsLength: number
): void => {
  if (index === partsLength - 1) {
    Object.assign(existingNode, {
      label: featureNode.label,
      children: featureNode.children,
      data: featureNode.data,
      concatenatedTags: featureNode.concatenatedTags,
      feature: featureNode.feature,
      leaf: featureNode.leaf,
      type: 'feature'
    });
  }
};

// Fonction pour construire un nœud de fonctionnalité
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
    type: NODE_TYPE_FEATURE
  } as TreeNode
}

// Fonction pour construire les enfants d'une fonctionnalité
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

// Fonction pour construire un nœud de scénario
const buildScenarioNode = (scenario: Messages.Scenario) => {
  return {
    key: scenario.id,
    data: scenario,
    label: scenario.name,
    leaf: true,
    concatenatedTags: scenario.tags.map((tag) => tag.name).join(),
    type: NODE_TYPE_SCENARIO
  } as TreeNode
}

// Fonction pour construire un nœud de règle
const buildRuleNode = (rule: Messages.Rule) => {
  return {
    key: rule.id,
    data: rule,
    label: rule.name,
    leaf: false,
    children: buildRuleChildren(rule.children),
    concatenatedTags: rule.tags.map((tag) => tag.name).join(),
    type: NODE_TYPE_RULE
  } as TreeNode
}

// Fonction pour construire les enfants d'une règle
const buildRuleChildren = (elements: readonly Messages.RuleChild[]): TreeNode[] => {
  return elements
    .map((ruleChild: Messages.RuleChild) => {
      if (ruleChild.scenario) {
        return buildScenarioNode(ruleChild.scenario)
      }
      if (ruleChild.background) {
        return buildBackgroundNode(ruleChild.background)
      }
    })
    .filter(Boolean) as TreeNode[]
}

// Fonction pour construire un nœud de background
const buildBackgroundNode = (background: Messages.Background) => {
  return {
    key: background.id,
    data: background,
    label: background.name,
    leaf: true,
    type: NODE_TYPE_BACKGROUND
  } as TreeNode
}

// Fonction de comparaison pour trier les nœuds de l'arbre
const compareTreeNodes = (a: TreeNode, b: TreeNode): number => {
  if (a.type === NODE_TYPE_DIRECTORY && b.type !== NODE_TYPE_DIRECTORY) return -1
  if (a.type !== NODE_TYPE_DIRECTORY && b.type === NODE_TYPE_DIRECTORY) return 1

  if (!a.label || !b.label) return 0

  if (a.type === NODE_TYPE_FEATURE && b.type === NODE_TYPE_FEATURE) {
    const numA = extractFeatureNumber(a.label)
    const numB = extractFeatureNumber(b.label)
    if (numA !== null && numB !== null) {
      return numA - numB
    }
  }

  return a.label.localeCompare(b.label)
}

// Fonction pour extraire le numéro de la fonctionnalité
const extractFeatureNumber = (label: string): number | null => {
  const match = label.match(/F(\d+)/)
  if (match && match[1]) {
    return parseInt(match[1], 10)
  }
  return null
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
          <span v-if="slotProps.node.type === NODE_TYPE_DIRECTORY">
            <router-link
              :to="{
                params: { ...$route.params, feature: encodeURIComponent(slotProps.node.key || EMPTY_STRING) }
              }"
              class="directory-link"
            >
              <i class="pi pi-folder"></i>
              <span>&nbsp;{{ slotProps.node.label }}</span>
            </router-link>
          </span>
          <!-- Permalinks pour les fonctionnalités -->
          <span v-else-if="slotProps.node.type === NODE_TYPE_FEATURE">
            <router-link
              :to="{
                params: { ...$route.params, feature: encodeURIComponent(slotProps.node.key || EMPTY_STRING) }
              }"
            >
              <i class="pi pi-link"></i>
            </router-link>
            <!-- Affichage du mot-clé et du label -->
            <b>&nbsp;{{ slotProps.node.data?.keyword }}</b>
            <span v-if="slotProps.node.type === NODE_TYPE_FEATURE || slotProps.node.type === NODE_TYPE_RULE"> {{ FEATURE_SEPARATOR }} </span>
            <span v-else>&nbsp;</span>
            <span>{{ slotProps.node.label }}</span>
          </span>
          <!-- Autres cas (règles, scénarios, etc.) -->
          <span v-else>
            <!-- Affichage du mot-clé et du label -->
            <b>&nbsp;{{ slotProps.node.data?.keyword }}</b>
            <span v-if="slotProps.node.type === NODE_TYPE_FEATURE || slotProps.node.type === NODE_TYPE_RULE"> {{ FEATURE_SEPARATOR }} </span>
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
  color: inherit;
  text-decoration: none;
  cursor: default;
}

.directory-link:hover,
.directory-link:active,
.directory-link:visited {
  color: inherit;
  text-decoration: none;
}

.description {
  white-space: pre-wrap;
  word-wrap: break-word;
  font-family: inherit;
  padding-top: 5px;
}
</style>
