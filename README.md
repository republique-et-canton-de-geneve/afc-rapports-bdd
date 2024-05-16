# Rapports BDD

## Description

Ce projet a été réalisé dans le cadre de la pratique dev :
[AFCPQDEV-313](https://prod.etat-ge.ch/csbugtrack/browse/AFCPQDEV-313).

L'objectif est d'exposer au métier une table des matières qui aggrège les liens l'ensemble des rapports de tests BDD
actuels.

Ce projet est déployé à l'adresse suivante :
[Rapports BDD](https://rapports-bdd-app-11422-afcoutils-dev-01.apps.soca.lbdev.etat-ge.ch/).

## Environnement

Le projet est déployé sur un environnement OpenShift de DEV.
Les membres de l'UO UO2897.DEVELOPPEURS-AFC ont les droits pour administrer l'environnement
[en cliquant ici](https://console-openshift-console.apps.soca.lbdev.etat-ge.ch/k8s/cluster/projects/app-11422-afcoutils-dev-01).

## Architecture

### Table des matières

La table des matières se trouve dans le fichier `src/index.html`.
Pour ajouter/supprimer une entrée dans la table, il faut modifier manuellement le fichier `index.html`.

### Rapports BDD

Les rapports se trouvent dans le dossier `src/projets/NOM_PROJET.html`. Ce sont des fichiers html mis à jour
automatiquement par les différents projets contenant des tests BDD.
Ces rapports sont commités sur ce repository par le job `deploy-bdd` lors du build des branches master.

## Docker

L'image docker est construite à partir d'un nginx. Les fichiers contenus dans `src/` sont copiés dans l'image.

## CI/CD

Un pipeline GitLab est déclenché à chaque build de la branche master.

### build

Cette étape construit l'image docker et la publie sur nexus sous le nom complet :
`oci-snapshot.devops.etat-ge.ch/ch/ge/afc/rapports-bdd:latest`

### deploy

Cette étape est facultative car OpenShift vérifie déjà toutes les 15 minutes si l'image nexus a été modifiée et la redéploie le cas échéant.

Cette étape permet juste de déclencher tout de suite le rafraichissement si on ne souhaite pas attendre les 15 minutes.
