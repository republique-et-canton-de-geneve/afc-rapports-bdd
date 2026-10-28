import type * as Messages from '@cucumber/messages'

export default interface FeatureTreeNode {
  key: string
  label: string
  children?: FeatureTreeNode[]
  leaf?: boolean
  data?: Messages.Feature | Messages.Rule | Messages.Scenario | Messages.Background
  fullText?: unknown
  concatenatedTags?: string
  allTags?: string
  feature?: boolean
  type?: string
  keyword?: string
  content?: string
}
