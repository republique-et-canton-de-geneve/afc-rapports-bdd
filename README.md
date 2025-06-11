# Rapports BDD

## Description

L'objectif est d'exposer au métier une table des matières qui aggrège les liens l'ensemble des rapports de tests BDD
actuels.

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
