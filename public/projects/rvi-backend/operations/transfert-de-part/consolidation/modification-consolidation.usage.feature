#language: fr
Fonctionnalité: Modification de la consolidation pour la partie usage

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
        parts:
        - identifier: 16-16-pp
          personne: *personne_1
          valeurTerrains:
          - identifier: 16-16-vt
            prix: 3000
            usages:
            - fraction: 1/1
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de part à la date d'estimation 01.02.2020
    Etant donnée une part cédée 16-16-pp à hauteur de 1/1
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1
    Etant donnée il s'agit d'un achat avec report de montant 2000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée l'opération est consolidée

  Scénario: Ajout d'un usage

    Etant donnée la création, en consolidation, d'un usage 1/2 de type loué sur la valeur 16-16-valeurTerrain-1
    Alors sur la consolidation, les objets sont
    """yaml
    - valeursTerrains:
      - usages:
        - fraction: 1/1
        - fraction: 1/2
    """

  Scénario: modification d'un usage

    Etant donnée la modification, en consolidation, de l'usage 16-16-usage-1 : 1/2 type loué
    Alors sur la consolidation, les objets sont
    """yaml
    - valeursTerrains:
      - usages:
        - fraction: 1/2
    """

  Scénario: Supression d'un usage

    Etant donnée la suppression, en consolidation, d'un usage 16-16-usage-1
    Alors sur la consolidation, les objets sont
    """yaml
    - valeursTerrains:
      - usages: []
    """
