
// Fonction pour trouver un nœud dans l'arbre par sa clé (pour le fil d'ariane)
import type { TreeNode } from 'primevue/treenode'

export const NODE_TYPE_DIRECTORY = "directory";
export const NODE_TYPE_FEATURE = "feature";
export const NODE_TYPE_RULE = "rule";
export const NODE_TYPE_SCENARIO = "scenario";
export const NODE_TYPE_BACKGROUND = "background";

export const findNodeByKey = (nodes: TreeNode[], key: string): TreeNode | undefined => {
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


// Fonction pour trouver ou créer un nœud existant
export const findOrCreateNode = (
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
export const createNode = (
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
    allTags: index === parts.length - 1 ? featureNode.allTags : undefined,
    type: index === parts.length - 1 ? 'feature' : 'directory'
  };
};


// Fonction de comparaison pour trier les nœuds de l'arbre
export const compareTreeNodes = (a: TreeNode, b: TreeNode): number => {
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
export const extractFeatureNumber = (label: string): number | null => {
  const match = label.match(/F(\d+)/)
  if (match && match[1]) {
    return parseInt(match[1], 10)
  }
  return null
}


export function generateCombinationString (input: string): string {
  const tags = input.split(" ").filter(Boolean);
  const results: string[] = [];

  // Génération des permutations
  const permute = (arr: string[], start: number) => {
    if (start === arr.length - 1) {
      results.push(arr.join(" "));
      return;
    }
    for (let i = start; i < arr.length; i++) {
      [arr[start], arr[i]] = [arr[i], arr[start]];
      permute(arr, start + 1);
      [arr[start], arr[i]] = [arr[i], arr[start]]; // backtrack
    }
  };

  // Génération de toutes les combinaisons
  const combine = (start: number, path: string[]) => {
    if (path.length > 0) {
      permute([...path], 0);
    }

    for (let i = start; i < tags.length; i++) {
      path.push(tags[i]);
      combine(i + 1, path);
      path.pop();
    }
  };

  combine(0, []);

  return results.join(" ");
}
