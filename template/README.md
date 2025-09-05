# Rapports BDD – Template (projet client)

Ce dossier est un exemple prêt à l’emploi pour publier une webapp Rapports BDD à partir de vos fichiers `.feature`.
Il consomme la librairie `@state-of-geneva/rapports-bdd` via son CLI – sans mélanger avec les scripts de développement de la librairie elle‑même.

Important: ce dossier `template/` n’est pas inclus dans le paquet publié sur npm. Il fait partie du dépôt GitHub. Copiez‑le depuis le repo si vous voulez démarrer rapidement.

## Liens utiles
- Paquet npm: https://www.npmjs.com/package/@state-of-geneva/rapports-bdd
- Dépôt GitHub: https://github.com/republique-et-canton-de-geneve/afc-rapports-bdd
- Démo (GitHub Pages): https://republique-et-canton-de-geneve.github.io/afc-rapports-bdd/

## Prérequis
- Node.js >= 18

## Démarrage rapide
1) Copier ce dossier `template/` hors du dépôt si besoin et renommer le répertoire selon votre projet.
2) Dans `template/package.json`, adaptez le champ `name` (facultatif).
   La dépendance `@state-of-geneva/rapports-bdd` pointe par défaut vers la racine du dépôt (`file:..`) pour les builds CI;
   remplacez-la par une version publiée sur npm lorsque vous copiez ce dossier hors du repo.
3) Placez vos fichiers `.feature` sous `template/features/` (voir Structures ci‑dessous).
4) Depuis le dossier `template/` :
   - Installation: `npm install`
   - Génération: `npm run build`
   - Prévisualisation: `npm run preview` (puis ouvrir l’URL affichée)

Par défaut, le build lit depuis `features/` et écrit la webapp dans `dist/`.

## Structures de dossiers supportées
Deux modes sont pris en charge. Des exemples sont fournis dans `template/features/`.

1) Mode multi‑projets (recommandé)
- Arborescence: `features/projects/<slug>/**/*.feature`
- Chaque dossier `projects/<slug>` est un projet.
- Voir: `template/features/projects/*`

2) Mode dossier simple (slug inféré)
- Arborescence: `features/*.feature`
- Le slug unique est inféré depuis le nom du dossier (`features` → slug `features`).
- Voir: `template/features/example.feature`

Pour plus de détails et exemples, lisez `template/features/README.md`.

## Configuration (rapports-bdd.config.json)
Placez un fichier `features/rapports-bdd.config.json` pour personnaliser l’affichage:
- `translations`: [{ slug, name, categorie }]
- `defaultCategory`: chaîne utilisée par défaut si pas de traduction
- `ignoredSlugs`: slugs à masquer

Un exemple concret est fourni dans `template/features/rapports-bdd.config.json`.

## Personnalisation des chemins
- Dossier d’entrée: modifiez le script `build` si besoin (par défaut: `--features features`).
- Dossier de sortie: `--out dist`
- Base URL (hébergement sous un sous‑chemin): ajoutez `--base /mon-sous-chemin/`

Exemple dans `template/package.json`:
```
"scripts": {
  "build": "rapports-bdd --features features --out dist --base /mon-app/",
  "preview": "vite preview --outDir dist"
}
```

## Dépannage rapide
- Aucune feature visible: vérifiez que vos `.feature` sont bien sous `features/projects/<slug>/...` ou directement sous `features/` (mode simple). Vérifiez aussi `rapports-bdd.config.json` (facultatif) et relancez `npm run build`.
- Chemins cassés en preview derrière un sous‑chemin: ajoutez `--base /votre-sous-chemin/` au script `build`.

## Remarques
- Les commandes ci‑dessus sont à exécuter dans le dossier `template/` (projet client).
- Ne pas confondre avec les scripts de développement de la librairie au niveau racine du dépôt.
