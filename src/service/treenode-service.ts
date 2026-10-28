
import type FeatureTreeNode from '@/models/feature-tree-node'

export const NODE_TYPE_DIRECTORY = "directory";
export const NODE_TYPE_FEATURE = "feature";
export const NODE_TYPE_RULE = "rule";
export const NODE_TYPE_SCENARIO = "scenario";
export const NODE_TYPE_BACKGROUND = "background";

export const findNodeByKey = (nodes: FeatureTreeNode[], key: string): FeatureTreeNode | undefined => {
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
  currentLevel: FeatureTreeNode[],
  part: string,
  index: number,
  parts: string[],
  featureNode: FeatureTreeNode
): FeatureTreeNode => {
  let existingNode = currentLevel.find((node) => node.label === part);
  if (!existingNode) {
    existingNode = createNode(part, index, parts, featureNode);
    currentLevel.push(existingNode);
    currentLevel.sort(compareFeatureTreeNodes);
  }
  return existingNode;
};


// Fonction pour créer un nœud
export const createNode = (
  part: string,
  index: number,
  parts: string[],
  featureNode: FeatureTreeNode
): FeatureTreeNode => {
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
export const compareFeatureTreeNodes = (a: FeatureTreeNode, b: FeatureTreeNode): number => {
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


/**
 * Retourne une liste de tag indexable par le composant recherche
 *
 * Par exemple :
 *  Input "@ABC @XYZ"
 *
 * Retourne le tableau suivant :
 *  [
 *    "@ABC",
 *    "@XYZ",
 *    "@ABC @XYZ",
 *    "@XYZ @ABC"
 *  ]
 *
 * @param listeTagBdd Liste des tag de scénario bdd
 */
export function generateCombinationString (listeTagBdd: string): string {
  const tags = listeTagBdd.split(" ").filter(Boolean);
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
