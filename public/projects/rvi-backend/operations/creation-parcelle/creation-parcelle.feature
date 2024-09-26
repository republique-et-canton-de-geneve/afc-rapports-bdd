#language: fr
Fonctionnalité: Création de parcelle

  Contexte:
    Etant donné le reférentiel
    """yaml
    personnes:
      - { id: 1, ref: 100.000.001, nom: Currie, prenom: Marie }
      - { id: 2, ref: 100.000.002, nom: Newton, prenom: Isaac }
    """

  Scénario: Création
    Etant donnée une opération de création de parcelle à la date 01.01.2020
    Etant donnée la création de parcelle concerne la commune 16 et a pour no 18
    Etant donnée la construction "a123" est créée lors de la création de parcelle
    Etant donnée une part pour la personne 1 à hauteur de 1/3 est créée lors de la création de parcelle
    Etant donnée une part pour la personne 2 à hauteur de 2/3 est créée lors de la création de parcelle

    Quand l'opération de création de parcelle est consolidée
    Alors l'opération est en état consolidation
    Alors sur la consolidation de la création de parcelle les objets sont
    """yaml
    surfaceParcelle: 3000
    constructions: [{numConstruction: a123}]
    valeursTerrains: [{surface: 3000, identifier: 16-18-valeurTerrain-1}]
    """

    Etant donné la modification, en consolidation, de la valeur terrain 16-18-valeurTerrain-1 avec la surface 3000 et la valeur estimée 10 000 le 01.01.2015

    Alors sur la consolidation de la création de parcelle les objets sont
    """yaml
    surfaceParcelle: 3000
    constructions: [{ numConstruction: a123 }]
    valeursTerrains: [{ prix: 10000.0, unite: estimé }]
    """

    Quand l'opération de création de parcelle est previsualisée
    Alors l'opération est en état prévisualisé

    Alors sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-18
      constructions: [{numConstruction: a123}]
      parts:
      - fraction: 1/3
        personne: Currie Marie
        valeurTerrains: [{prixEstime: 3333.0, unite: estimé}]
      - fraction: 2/3
        personne: Newton Isaac
        valeurTerrains: [{prixEstime: 6667.0, unite: estimé}]
    """

    Alors il y a 0 message d'erreur sur l'opération

    Quand l'opération de création de parcelle est validée
    Alors il n'y a pas d'erreur lors de la publication de la session
