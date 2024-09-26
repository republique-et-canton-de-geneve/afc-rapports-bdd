#language: fr
Fonctionnalité: Modification de la consolidation pour la partie responsabilité

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
          - prix: 3000
            responsabilites:
            - personne: *personne_2
              fraction: 1/2
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de part à la date d'estimation 01.02.2020
    Etant donnée une part cédée 16-16-pp à hauteur de 1/1
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1
    Etant donnée il s'agit d'un achat avec report de montant 2000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée l'opération est consolidée

  Scénario: Ajout d'une responsabilité sur le terrain

    Etant donnée la création, en consolidation, d'une responsabilité 1/3 de type Droit d'habitation pour la personne 100.000.002 sur l'objet 16-16-valeurTerrain-1
    Alors sur la consolidation, les objets sont
    """yaml
    - montantTerrainCede: 3000.0
      valeursTerrains:
      - surface: 1000
        responsabilites:
        - fraction: 1/2
          type: Usufruit
        - fraction: 1/3
          type: Droit d'hab
    """

  Scénario: Ajout d'une responsabilité sur la Part

    Etant donnée la création, en consolidation, d'une responsabilité 1/3 de type Usufruit pour la personne 100.000.002 sur l'objet 16-16
    Alors sur la consolidation, les objets sont
    """yaml
    - montantTerrainCede: 3000.0
      responsabilites:
      - fraction: 1/3
        type: Usufruit
      valeursTerrains:
      - surface: 1000
        responsabilites:
        - fraction: 1/2
          type: Usufruit
    """

  Scénario: modification d'une responsabilité

    Etant donnée la modification, en consolidation, de la responsabilité 16-16-responsabilite-1 : 1/4 type Porté par anticipation
    Alors sur la consolidation, les objets sont
    """yaml
    - responsabilites: []
      valeursTerrains:
      - surface: 1000
        responsabilites:
        - fraction: 1/4
          type: PPA
    """

  Scénario: Supression d'une Responsabilité

    Etant donnée la suppression, en consolidation, d'une responsabilité 16-16-responsabilite-1
    Alors sur la consolidation, les objets sont
    """yaml
    - responsabilites: []
      valeursTerrains:
      - surface: 1000
        responsabilites: []
    """
