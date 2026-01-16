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
import {
  findNodeByKey,
  findOrCreateNode, generateCombinationString, NODE_TYPE_BACKGROUND, NODE_TYPE_DIRECTORY,
  NODE_TYPE_FEATURE,
  NODE_TYPE_RULE, NODE_TYPE_SCENARIO
} from '@/service/treenode-service'

const BASE_URL = import.meta.env.BASE_URL
const BASE_PROJECT_PATH = '/projets/'
const BASE_PROJECTS_DIR = `${BASE_URL}projects/`
const SLASH = "/";
const FEATURE_SEPARATOR = ":";
const RULE_SEPARATOR = " #";
const EMPTY_STRING = "";

const route = useRoute()
const router = useRouter()

// Variables réactives pour l'arbre des fonctionnalités et les clés étendues
const featuresTreeNode = ref<TreeNode[]>([])
const expandedKeys = ref<{ [key: string]: boolean }>({})


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
      allTags: featureNode.allTags,
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
    children: buildFeatureChildren(feature),
    fullText: document,
    concatenatedTags: feature.tags.map((tag) => tag.name).join(" "),
    allTags: feature.tags.map((tag) => tag.name).join(" "),
    feature: true,
    type: NODE_TYPE_FEATURE
  } as TreeNode
}

// Fonction pour construire les enfants d'une fonctionnalité
const buildFeatureChildren = (featureParent:Messages.Feature): TreeNode[] => {
  return featureParent.children
    .map((featureChild: Messages.FeatureChild) => {
      if (featureChild.rule) {
        return buildRuleNode(featureParent, featureChild.rule)
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
    concatenatedTags: scenario.tags?.map((tag) => tag.name).join(),
    allTags: generateAllTags(scenario.tags as Messages.Tag[]),
    fullText: fullTextScenario(scenario),
    type: NODE_TYPE_SCENARIO
  } as TreeNode
}

const generateAllTags = (tags: Messages.Tag[]):string => {
  return generateCombinationString(tags?.map((tag) => tag.name).join(" "));
}

const fullTextScenario = (scenario: Messages.Scenario):string => {
  return scenario
          .steps?.map((s) => s.text + " " + s.dataTable?.rows.map(
              (r) => {
                return r.cells.map(c => c.value).join(" ")
              }

          )).join(" ") + " " +

      scenario.examples.map(
        (e) => {
          // lignes
          return e.tableBody.map((tb) => {
            // cellules
            return tb.cells.map(c => c.value).join(" ")
          }).join(" ")
        }

      )
      .join(" ");
}

// Fonction pour construire un nœud de règle
const buildRuleNode = (featureParent:Messages.Feature, rule: Messages.Rule) => {

  return {
    key: featureParent.name+ RULE_SEPARATOR + rule.name,
    data: rule,
    label: rule.name,
    leaf: false,
    children: buildRuleChildren(rule.children),
    concatenatedTags: rule.tags.map((tag) => tag.name).join(),
    allTags: rule.tags.map((tag) => tag.name).join(" "),
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

</script>

<template>
  <Breadcrumb :model="breadcrumbItems" :home="home" />
  <div v-if="featuresTreeNode">
    <Tree
      :value="featuresTreeNode"
      filter
      filterMode="lenient"
      filter-by="label,concatenatedTags,allTags,fullText"
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
          <span v-else-if="slotProps.node.type === NODE_TYPE_RULE">
            <!-- Affichage du mot-clé et du label -->
            <b> <i class="pi pi-link"></i>&nbsp;{{ slotProps.node.data?.keyword }}</b>
            <span > {{ FEATURE_SEPARATOR }} </span>
            <span>{{ slotProps.node.label }}</span>
            >
          </span>
          <!-- Autres cas (règles, scénarios, etc.) -->
          <span v-else>
            <!-- Affichage du mot-clé et du label -->
            <b>&nbsp;{{ slotProps.node.data?.keyword }}</b>
            <span v-if="slotProps.node.type === NODE_TYPE_FEATURE || slotProps.node.type === NODE_TYPE_RULE"> {{ FEATURE_SEPARATOR }} </span>
            <span v-else>&nbsp;</span>
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
