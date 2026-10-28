# Exemples d'organisation des fichiers .feature

Ce dossier montre deux façons supportées d'organiser vos fichiers `.feature` avec `@state-of-geneva/rapports-bdd`.

## 1) Mode multi‑projets (recommandé)

Arborescence:

```
features/
  rapports-bdd.config.json
  projects/
    demo-backend/
      exemple.feature
      authentification/
        connexion.feature
    finance-backend/
      comptabilite/
        calcul_tva.feature
```

- Chaque dossier `projects/<slug>` représente un projet (slug = nom du dossier).
- Les fichiers `.feature` peuvent être à la racine du slug ou dans des sous‑dossiers.
- Le fichier `rapports-bdd.config.json` (à la racine de `features/`) permet de définir:
  - `translations`: pour donner un nom lisible et une catégorie à chaque slug.
  - `defaultCategory`: catégorie par défaut si un slug n'a pas de traduction.
  - `ignoredSlugs`: slugs à masquer de l'interface.
  - `sourcesGit`: dépôts Git à récupérer au build. Chaque entrée contient `repository`, `ref`, `slug`, et `path` ou `paths`.

Exemple de source externe:

```json
{
  "repository": "https://github.com/organisation/projet-features.git",
  "ref": "main",
  "path": "features",
  "slug": "projet-features"
}
```

Le CLI clone la révision déclarée avant le build, puis copie uniquement les `.feature` du chemin ou des chemins dans `projects/<slug>/`. Les chemins multiples sont fusionnés; une collision de noms fait échouer le build au lieu d’écraser un fichier. Les traductions et catégories du projet se définissent dans `translations`. Utilisez une ref de commit pour un résultat strictement reproductible.

Pour un dépôt privé, fournissez l’accès Git hors du fichier de configuration, via une clé SSH ou le gestionnaire d’identifiants Git de l’environnement CI. N’incluez jamais de jeton dans l’URL, le JSON ou les artefacts publiés. Le site généré reste statique et ne contacte pas Git.
Dans ce template, deux slugs d'exemple sont fournis:
- `demo-backend`
- `finance-backend`

Ils sont déjà mappés dans `rapports-bdd.config.json`.

## 2) Mode dossier simple (slug inféré)

Arborescence minimaliste:

```
features/
  rapports-bdd.config.json (optionnel)
  *.feature
```

- Placez vos `.feature` directement sous `features/` sans dossier `projects`.
- Le slug unique est inféré depuis le nom du dossier (`features` → slug `features`).
- Vous pouvez renommer le dossier pour changer le slug (ex: `features-ipp` → slug `features-ipp`).

Dans ce template, le fichier `features/example.feature` illustre ce mode. Note: si vous utilisez `features/projects/...`, ce fichier ne sera plus visible dans l'interface, car l'application listera uniquement les fichiers sous `/projects/<slug>/...`.

## Commandes

Dans le dossier `template/`:

- Générer: `npm run build`
- Prévisualiser: `npm run preview`

Par défaut, le script construit les rapports en prenant `features/` comme source et sort le site dans `dist/`.

## Astuces

- Pour regrouper des fonctionnalités par domaines, créez des sous‑dossiers sous chaque slug (ex: `authentification/`, `comptabilite/`).
- Adaptez les libellés et catégories dans `rapports-bdd.config.json` pour refléter votre contexte.
- Vous pouvez masquer un projet via `ignoredSlugs` si nécessaire.
