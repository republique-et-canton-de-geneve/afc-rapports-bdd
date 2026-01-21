# Rapports BDD

Une petite webapp Vue qui liste et affiche vos fichiers `.feature` Gherkin comme des rapports consultables par le métier.

## Prérequis
- Node.js >= 18

## Utilisation (consommateur)
Générez un site statique à partir de vos features.

Sans installation préalable (recommandé pour un essai rapide):
```sh
npx @state-of-geneva/rapports-bdd@latest --features ./features --out ./dist
# Optionnel si vous hébergez sous un sous-chemin
npx @state-of-geneva/rapports-bdd@latest --features ./features --out ./dist --base /mon-sous-chemin/
```

Ou en tant que dépendance de dev:
```sh
npm i -D @state-of-geneva/rapports-bdd
npx rapports-bdd --features ./features --out ./dist
```

- `--features`: dossier source contenant vos `.feature`
- `--out`: dossier de sortie du site (ex: `dist`)
- `--base`: base URL si la webapp est servie sous un sous‑chemin

### Note importante : Avant la version 1.1.0 
Important: la librairie ne contient ni features ni configuration « projet » — fournissez toujours `--features`.

### Note importante : A partir version 1.1.0
Le répertoire public devient le paramètre features par défaut. 
Cela permet la compatibilité au module d'être executable en dev depuis la source de ce projet 

## Démarrer plus vite avec le template
Le dépôt inclut un projet client prêt à l’emploi dans `template/`.

- Guide rapide (GitHub): https://github.com/republique-et-canton-de-geneve/afc-rapports-bdd/tree/main/template
- Exemples d’arborescences et détails: https://github.com/republique-et-canton-de-geneve/afc-rapports-bdd/blob/main/template/features/README.md

Le template sépare clairement ses commandes de celles de la librairie. Exécutez ses commandes depuis le dossier `template/`.

## Démo
GitHub Pages: https://republique-et-canton-de-geneve.github.io/afc-rapports-bdd/

## Organisation des features (résumé)
Deux modes sont supportés côté client:
- Multi‑projets (recommandé): `features/projects/<slug>/**/*.feature`
- Dossier simple (slug inféré): `features/*.feature` (le slug = nom du dossier)

## Configuration (rapports-bdd.config.json)
Pour personnaliser les noms/catégories/masquages, placez un fichier dans `features/rapports-bdd.config.json` côté projet client. Référez‑vous aux exemples:
- Doc: https://github.com/republique-et-canton-de-geneve/afc-rapports-bdd/blob/main/template/features/README.md
- Exemple de config: https://github.com/republique-et-canton-de-geneve/afc-rapports-bdd/blob/main/template/features/rapports-bdd.config.json

## Développement de la librairie (contributeurs)
Ces commandes sont pour travailler sur la librairie elle‑même (ne pas confondre avec le template):

```sh
npm install
npm run dev       # serveur Vite pour développer l’UI
npm run build     # génère le paquet (utilise scripts/generateFeatureFiles.js)
npm run lint
```

Notes:
- Sans `FEATURES_DIR` (défini par le CLI), la génération produit des listes vides. C’est normal pour la librairie.
- Pour tester la librairie en conditions réelles, utilisez le dossier `template/` et ses scripts dédiés.

A partir de la version 1.1.0 la libraire peut être testé en condition réelle en copiant/collant le contenu du répertoire template dans le répertoire `public/`


## Scripts de la librairie — à quoi servent-ils ?
- dev: démarre Vite pour développer l’UI de la librairie (contributeurs).
- build: enchaîne generate → build-only → postBuildCopy404. C’est la commande de référence utilisée par le CLI et la CI.
- build-only: lance uniquement `vite build`. Utile pour les contributeurs quand les fichiers générés existent déjà.
- generate: génère `src/generated/featureFiles.ts` et `src/generated/userConfig.ts` à partir de `FEATURES_DIR` (défini par le CLI). Sans `FEATURES_DIR`, génère des listes vides — c’est normal pour la librairie.
- preview: non fourni au niveau de la librairie (le code ne contient aucune feature). Utilisez le dossier `template/` (projet client) et son `npm run preview` pour voir un site réel.

Note: un hook `prepublishOnly` construit automatiquement le paquet avant `npm publish`.
