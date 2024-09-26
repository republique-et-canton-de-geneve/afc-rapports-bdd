#language: fr
Fonctionnalité: Modification de la consolidation pour la partie exoneration

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
            exonerations:
            - typeExoneration: 2
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de part à la date d'estimation 01.02.2020
    Etant donnée une part cédée 16-16-pp à hauteur de 1/1
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1
    Etant donnée il s'agit d'un achat avec report de montant 2000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée l'opération est consolidée

  Scénario: Ajout d'une exonération

    Etant donnée la création, en consolidation, d'une exonération sur la valeur 16-16-valeurTerrain-1 1 2000-2010 tx fortune 10% tx IIC 20% tx Revenu 30%

    Alors sur la consolidation, les objets sont
    """yaml
    - valeursTerrains:
      - exonerations:
        - typeExoneration: Exo non transmissible 1
        - typeExoneration: Exo non transmissible 2
    """

  Scénario: modification d'une exonération

    Etant donnée la modification, en consolidation, de l'exonération 16-16-exoneration-1 3 2000-2010 tx fortune 10% tx IIC 20% tx Revenu 30%

    Alors sur la consolidation, les objets sont
    """yaml
    - valeursTerrains:
      - exonerations:
        - typeExoneration: Exo transmissible
    """

  Scénario: Ajout d'une exonération

    Etant donnée la suppression, en consolidation, de l'exonération 16-16-exoneration-1

    Alors sur la consolidation, les objets sont
    """yaml
    - valeursTerrains:
      - exonerations: []
    """
