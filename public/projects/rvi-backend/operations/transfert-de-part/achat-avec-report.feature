#language: fr
Fonctionnalité: Transfert de parts achat avec report - test de la consolidation

  Contexte:
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Newton, prenom: Isaac }
      - &personne_3 { id: 3, ref: 100.000.003, nom: Carpentier, prenom: Emmanuelle }
      - &personne_4 { id: 4, ref: 100.000.004, nom: Barré-Sinoussi, prenom: Françoise }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        surface: 3000
        constructions:
          - &construction1 { identifier: 16-16-construction, no: cst1 }
        parts:
        - identifier: 16-16-pp1
          personne: *personne_1
          fraction: 1/2
          responsabilites:
          - { personne: *personne_4, fraction: 1/2, type: USUFRUIT }
          - { personne: *personne_4, fraction: 1/2, type: PORTE_PAR_ANTICIPATION }
          valeurTerrains:
          - surface: 600
            prix: 20000
            exonerations:
            - {typeExoneration: 1}
            - {typeExoneration: 2}
            - {typeExoneration: 3}
            responsabilites:
            - { personne: *personne_4, fraction: 1/2, type: USUFRUIT }
            - { personne: *personne_4, fraction: 1/2, type: PORTE_PAR_ANTICIPATION }
            usages:
            - { fraction: 1/2, type: loué}
            - { fraction: 1/2, type: professionnel}

        - identifier: 16-16-pp2
          personne: *personne_2
          fraction: 1/2
          valeurTerrains:
          - surface: 300
            prix: 20000
            exonerations:
              - { typeExoneration: 2}
            responsabilites:
              - { personne: *personne_4, fraction: 1/2, type: USUFRUIT }
            usages:
              - { fraction: 1/2, type: loué}
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de part à la date d'estimation 01.02.2020
    Etant donnée une part cédée 16-16-pp1 à hauteur de 1/1
    Etant donnée une part cédée 16-16-pp2 à hauteur de 1/1
    Etant donnée une part acquise par la personne 3 à hauteur de 1/1


  Scénario: Tout est reporté
    Etant donnée il s'agit d'un achat avec report de montant 2000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée l'opération est consolidée

    Alors l'opération est en état consolidation

    Et sur la consolidation, les objets sont
    """yaml
    - montantTerrainCede: 40000.0
      responsabilites:
      - {fraction: 1/2, type: PPA}
      - {fraction: 1/2, type: Usufruit}
      valeursTerrains:
      - prix: 2000.0
        usages:
        - {fraction: 1/2, type: Loué}
        - {fraction: 1/2, type: Professionnel}
        exonerations:
        - typeExoneration: Exo non transmissible 2
        - typeExoneration: Exo non transmissible 1
        - typeExoneration: Exo transmissible
        responsabilites:
        - {fraction: 1/2, type: PPA}
        - {fraction: 1/2, type: Usufruit}
    """

  Scénario: Rien n'est reporté
    Etant donnée il s'agit d'un achat avec report de montant 2000 usage non reporté responsabilite non reporté QVL non reporté éxoneration non reporté
    Etant donnée l'opération est consolidée

    Alors l'opération est en état consolidation

    Et sur la consolidation, les objets sont
    """yaml
    - montantTerrainCede: 40000.0
      responsabilites: []
      valeursTerrains:
      - prix: 2000.0
        usages: []
        exonerations:
        - typeExoneration: Exo transmissible
        responsabilites: []
    """
