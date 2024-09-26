#language: fr
Fonctionnalité: Transfert de millième achat avec report - test de la consolidation

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
        ppes:
          - identifier: 16-16-1
            millieme: 200
            parts:
              - personne: *personne_1
                fraction: 1/2
                responsabilites:
                  - { personne: *personne_4, fraction: 1/2, type: USUFRUIT }
                  - { personne: *personne_4, fraction: 1/2, type: PORTE_PAR_ANTICIPATION }
                valeurTerrains:
                  - surface: 300
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
                  - surface: 300
                    prix: 20000
                    exonerations:
                      - { typeExoneration: 2}
                    responsabilites:
                      - { personne: *personne_4, fraction: 1/2, type: USUFRUIT }
                    usages:
                      - { fraction: 1/2, type: loué}
              - identifier: 16-16-pp2
                personne: *personne_2
                fraction: 1/2
                responsabilites:
                  - { personne: *personne_4, fraction: 1/2, type: USUFRUIT }
          - identifier: 16-16-2
            millieme: 800
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de millième à la date d'estimation 01.02.2020
    Etant donnée un ppe cédé 16-16-1 sur 200 millième
    Etant donnée une part acquise par la personne 3 à hauteur de 1/1


  Scénario: Tout est reporté
    Etant donnée il s'agit d'un achat avec report de montant 2000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée l'opération est consolidée


    Alors l'opération est en état consolidation

    Et sur la consolidation, les objets sont
    """yaml
    responsabilites:
    - {fraction: 1/2, personneRef: 100.000.004, type: PPA}
    - {fraction: 1/2, personneRef: 100.000.004, type: Usufruit}
    valeursBatiments: []
    valeursEtatLocatifs: []
    valeursTerrains:
    - surface: 600
      prix: 2000.0
      usages:
      - {fraction: 1/2, type: Loué}
      - {fraction: 1/2, type: Professionnel}
      exonerations:
      - typeExoneration: Exo non transmissible 2
      - typeExoneration: Exo transmissible
      - typeExoneration: Exo non transmissible 1
      responsabilites:
        - {fraction: 1/2, personneRef: 100.000.004, type: PPA}
        - {fraction: 1/2, personneRef: 100.000.004, type: Usufruit}
    """

    Etant donnée  l'opération est prévisualisée

    Alors sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      ppes:
      - identifier: 16-16-2
        millieme: 800.0
      - identifier: 16-16-3
        millieme: 200.0
        parts:
        - personne: Carpentier Emmanuelle
          valeurTerrains:
          - surface: 600
            prixEstime: 2000.0
            exos:
            - typeExoneration: Exo transmissible
            - typeExoneration: Exo non transmissible 1
            - typeExoneration: Exo non transmissible 2
            usages:
            - { fraction: 1/2, type: Loué }
            - { fraction: 1/2, type: Professionnel }
            responsabilites:
            - {fraction: 1/2, personne: Barré-Sinoussi Françoise, type: Usufruit}
            - {fraction: 1/2, personne: Barré-Sinoussi Françoise, type: PPA}
          responsabilites:
          - {fraction: 1/2, personne: Barré-Sinoussi Françoise, type: Usufruit}
          - {fraction: 1/2, personne: Barré-Sinoussi Françoise, type: PPA}
    """


  Scénario: Rien n'est reporté
    Etant donnée il s'agit d'un achat avec report de montant 2000 usage non reporté responsabilite non reporté QVL non reporté éxoneration non reporté
    Etant donnée l'opération est consolidée


    Alors l'opération est en état consolidation

    Et sur la consolidation, les objets sont
    """yaml
    responsabilites: []
    valeursBatiments: []
    valeursEtatLocatifs: []
    valeursTerrains:
    - surface: 600
      prix: 2000.0
      usages: []
      exonerations:
        - typeExoneration: Exo transmissible
      responsabilites: []
    """
