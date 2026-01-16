import * as Messages from '@cucumber/messages'

export default interface FeatureTreeNodeData {
  keyword: string,
  tags: Messages.Tag[];
  rule: Messages.Feature,
  originalGherkin: string
}
