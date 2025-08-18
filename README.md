# Rapports BDD

## Description

L'objectif est d'exposer au métier une table des matières qui aggrège les liens l'ensemble des rapports de tests BDD
actuels.

## Utilisation comme dépendance npm

Installez le paquet puis générez les rapports à partir de vos fichiers `.feature` :

```sh
npm install rapports-bdd --save-dev
npx rapports-bdd --features ./chemin/vers/mes/features --out ./dist
```

L'option `--features` indique le dossier contenant les fichiers BDD, tandis que `--out` définit le dossier de sortie. Une option `--base` permet d'ajuster le chemin de base si nécessaire.

## Guide pas à pas

1. Copiez le dossier `template` de ce dépôt et renommez-le selon votre projet.
2. Dans ce nouveau dossier, éditez `package.json` pour adapter le champ `name`.
3. Ajoutez vos fichiers `.feature` dans le dossier `features/`.
4. Installez les dépendances :
   ```sh
   npm install
   ```
5. Générez les rapports :
   ```sh
   npm run build
   ```
   Les rapports seront disponibles dans le dossier `dist/`.

## Architecture

### Table des matières

La table des matières se trouve dans le fichier `src/index.html`.
Pour ajouter/supprimer une entrée dans la table, il faut modifier manuellement le fichier `index.html`.

### Rapports BDD

Les rapports se trouvent dans le dossier `src/projets/NOM_PROJET.html`. Ce sont des fichiers html mis à jour
automatiquement par les différents projets contenant des tests BDD.

## Docker

L'image docker est construite à partir d'un nginx. Les fichiers contenus dans `src/` sont copiés dans l'image.

## Type Support for `.vue` Imports in TS

TypeScript cannot handle type information for `.vue` imports by default, so we replace the `tsc` CLI with `vue-tsc` for type checking. In editors, we need [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar) to make the TypeScript language service aware of `.vue` types.

## Customize configuration

See [Vite Configuration Reference](https://vitejs.dev/config/).

## Project Setup

Tested with latest node version this day (06 dec 2024): 23.3.0

```sh
npm install
```

### Type-Check, Compile and Minify for Production

```sh
npm run build
```

### Run and Hot-Reload for Development

```sh
npm run dev
```

### Lint with [ESLint](https://eslint.org/)

```sh
npm run lint
```
## Déploiement sur GitHub Pages

Un workflow GitHub Actions (`.github/workflows/pages.yml`) construit automatiquement l'application et la publie sur GitHub Pages à chaque push sur `main`.
Activez GitHub Pages dans les paramètres du dépôt pour rendre l'application accessible à l'URL fournie par l'action.

## Publication sur npm

Un workflow GitHub Actions (`.github/workflows/release.yml`) exécute `npm run lint` et s'assure que la construction du paquet réussit à chaque push. Il permet également une publication manuelle sur npm via l'évènement `workflow_dispatch`. Assurez-vous de définir le secret `NPM_TOKEN` pour autoriser `npm publish`.
