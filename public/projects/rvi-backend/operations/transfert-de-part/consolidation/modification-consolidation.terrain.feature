#language: fr
Fonctionnalité: Modification de la consolidation pour la partie valeur terrain

  Contexte:
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Carpentier, prenom: Emmanuelle }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        constructions:
        - &construction1 { identifier: 16-16-construction, no: cst1 }
        parts:
        - identifier: 16-16-pp
          personne: *personne_1
          valeurTerrains:
          - identifier: 16-16-vt
            prix: 3000
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de part à la date d'estimation 01.02.2020
    Etant donnée une part cédée 16-16-pp à hauteur de 1/1
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1
    Etant donnée il s'agit d'un achat avec report de montant 2000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée l'opération est consolidée

  Scénario: Ajout d'une valeur terrain

    Etant donnée l'ajout, en consolidation, d'une valeur terrain sur l'objet cadastral 16-16 de surface 20 et de valeur estimée 10 000 le 01.01.2015

    Alors sur la consolidation, les objets sont
    """yaml
    - valeursTerrains:
      - surface: 1000
        prix: 2000.0
      - surface: 20
        prix: 10000.0
    """

  Scénario: Suppression d'une valeur terrain

    Etant donnée la suppression, en consolidation, d'une valeur terrain 16-16-valeurTerrain-1


    Alors sur la consolidation, les objets sont
    """yaml
    - valeursTerrains: []
    """

  Scénario: Modification d'une valeur terrain

    Etant donnée la modification, en consolidation, de la valeur terrain 16-16-valeurTerrain-1 avec la surface 300 et la valeur estimée 5 000 le 01.01.2018


    Alors sur la consolidation, les objets sont
    """yaml
    - valeursTerrains:
      - surface: 300
        prix: 5000.0
    """
