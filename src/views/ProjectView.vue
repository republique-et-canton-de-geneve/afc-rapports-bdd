<script setup lang="ts">
import {CUCUMBER_REPORTS} from '@/assets/consts'
import {useRoute, useRouter} from 'vue-router'
import {computed, ref, watch} from 'vue'
import type {TreeNode} from 'primevue/treenode'

import * as Gherkin from '@cucumber/gherkin'
import * as Messages from '@cucumber/messages'
import {FEATURE_FILES} from '@/generated/featureFiles'
import CucumberExamples from '@/components/CucumberExamples.vue'
import CucumberSteps from '@/components/CucumberSteps.vue'
import CucumberTags from '@/components/CucumberTags.vue'

const route = useRoute()
const router = useRouter()

// TreeNode
const featuresTreeNode = ref<TreeNode[]>([])
const expandedKeys = ref<{ [key: string]: boolean }>({})

// BreadCrumb
const items = computed(() => {
  const reportName = CUCUMBER_REPORTS.find((report) => report.slug === route.params.slug)?.name
  const baseItems = [
    {label: reportName, command: () => router.push(`/projets/${route.params.slug}`)}
  ]

  if (route.params.feature && typeof route.params.feature === 'string') {
    baseItems.push({label: route.params.feature, command: () => Promise.resolve()})
  }

  return baseItems
})
const home = {icon: 'pi pi-home', command: () => router.push('/')}

watch(
    () => route.params.feature as string,
    (featurePathParam) => {
      featuresTreeNode.value = []
      expandedKeys.value = {
        [featurePathParam]: true
      }

      FEATURE_FILES
          .filter((path) => path.startsWith('/projects/' + route.params.slug))
          .forEach((featureFilePath) => {
            fetch(featureFilePath)
                .then((body) => body.text())
                .then((featureFileContent) => buildFeatureNode(parseFeatureFile(featureFileContent)))
                .then((featureNode) => {
                  if (featureNode && (!featurePathParam || featurePathParam === featureNode.label)) {
                    featuresTreeNode.value.push(featureNode)
                    featuresTreeNode.value.sort(compareTreeNodes)
                  }
                })
          })
    },
    {immediate: true}
)

const parseFeatureFile = (text: string) => {
  let builder = new Gherkin.AstBuilder(Messages.IdGenerator.uuid())
  let matcher = new Gherkin.GherkinClassicTokenMatcher()
  let parser = new Gherkin.Parser(builder, matcher)
  return parser.parse(text) as Messages.GherkinDocument
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
    concatenatedTags: feature.tags.map(tag => tag.name).join(),
    feature: true
  } as TreeNode
}

const buildFeatureChildren = (features: readonly Messages.FeatureChild[]) => {
  return features.map((featureChild: Messages.FeatureChild) => {
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
}

const buildScenarioNode = (scenario: Messages.Scenario) => {
  return {
    key: scenario.id,
    data: scenario,
    label: scenario.name,
    leaf: true,
    concatenatedTags: scenario.tags.map(tag => tag.name).join()
  } as TreeNode
}

const buildRuleNode = (rule: Messages.Rule) => {
  return {
    key: rule.id,
    data: rule,
    label: rule.name,
    leaf: false,
    children: buildRuleChildren(rule.children),
    concatenatedTags: rule.tags.map(tag => tag.name).join()
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
  if (!a.label || !b.label) {
    return 0
  }

  // Cherche 'F' suivi d'un ou plusieurs chiffres
  const numA = parseInt(a.label.match(/^F(\d+)/)?.[1] || '', 10)
  const numB = parseInt(b.label.match(/^F(\d+)/)?.[1] || '', 10)

  // Si les deux labels ont des numéros, on les compare numériquement
  if (!isNaN(numA) && !isNaN(numB)) {
    return numA - numB
  }

  // Si un des labels n'a pas de numéro, on fait une comparaison lexicographique
  return a.label.localeCompare(b.label)
}
</script>

<template>
  <Breadcrumb :model="items" :home="home"/>
  <div v-if="featuresTreeNode">
    <Tree :value="featuresTreeNode" :filter="true" filterMode="lenient" filterBy="label,concatenatedTags"
          :expandedKeys="expandedKeys">
      <template #default="slotProps">
        <CucumberTags :tags="slotProps.node.data?.tags"/>
        <div class="title">
                  <span v-if="slotProps.node.feature">
                    <router-link :to="{ params: { ...$route.params, feature: slotProps.node.label } }">
                      <i class="pi pi-link"></i>
                    </router-link>
                </span>
          <b>&nbsp;{{ slotProps.node.data?.keyword }} : </b> {{ slotProps.node.label }}
        </div>
        <div class="description" v-if="slotProps.node.data?.description">
          {{ slotProps.node.data.description }}
        </div>
        <CucumberSteps v-if="slotProps.node.data?.steps" :steps="slotProps.node.data?.steps"/>
        <CucumberExamples v-if="slotProps.node.data?.examples" :examples="slotProps.node.data?.examples"/>
      </template>
    </Tree>
  </div>
  <div v-else><i class="pi pi-spin pi-spinner"></i> Chargement en cours</div>
</template>

<style scoped>
.description {
  white-space: pre-wrap;
  word-wrap: break-word;
  font-family: inherit;
  padding-top: 5px;
}
</style>
