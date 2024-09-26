#language: fr
Fonctionnalité: Transfert de milliéme propagation batiment et terrain à la valeur de rendement

  Contexte:
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Newton, prenom: Isaac }
      - &personne_3 { id: 3, ref: 100.000.003, nom: Carpentier, prenom: Emmanuelle }
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
            millieme: 500
            parts:
              - identifier: 16-16-pp1
                personne: *personne_1
                valeurTerrains:
                  - {  surface: 3000, prix: 10000, unite: VALEUR_DE_RENDEMENT }
                valeurBatiments:
                  - { constructions: [ *construction1 ], prix: 100000, unite: VALEUR_DE_RENDEMENT }
          - identifier: 16-16-2
            millieme: 500
            parts:
              - identifier: 16-16-pp2
                personne: *personne_2
                valeurTerrains:
                  - {  surface: 3000, prix: 10000 }
                valeurBatiments:
                  - {  constructions: [ *construction1 ], prix: 100000 }
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de millième à la date d'estimation 01.02.2020

  Scénario: Transfert de part de nature à la valeur de rendement. millième cédée : 100

    Etant donnée un ppe cédé 16-16-1 sur 100 millième
    Etant donnée il s'agit d'un achat à la valeur de rendement
    Etant donnée une part acquise par la personne 3 à hauteur de 1/1
    Etant donnée l'opération est consolidée
    Etant donnée l'opération est prévisualisée
    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      ppes:
        - numeroLot: 1
          millieme: 400.0
          parts:
            - personne: Marie Currie
              valeurBatiments: [ { prix: 80000.0 } ]
              valeurTerrains: [ { prixEstime: 8000.0 } ]
        - numeroLot: 2
          millieme: 500.0
          parts:
            - personne: Newton Isaac
              valeurBatiments: [ { prix: 100000.0 } ]
              valeurTerrains: [ { prixEstime: 10000.0 } ]
        - numeroLot: 3
          millieme: 100.0
          parts:
            - personne: Carpentier Emmanuelle
              valeurBatiments: [ { prix: 20000.0 } ]
              valeurTerrains: [ { prixEstime: 2000.0 } ]
    """

  Scénario: Transfert de part de nature à la valeur de rendement. millième cédée : 500

    Etant donnée un ppe cédé 16-16-1 sur 500 millième
    Etant donnée il s'agit d'un achat à la valeur de rendement
    Etant donnée une part acquise par la personne 3 à hauteur de 1/1
    Etant donnée l'opération est consolidée
    Etant donnée l'opération est prévisualisée
    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      ppes:
        - numeroLot: 2
          millieme: 500.0
          parts:
            - personne: Newton Isaac
              valeurBatiments: [ { prix: 100000.0 } ]
              valeurTerrains: [ { prixEstime: 10000.0 } ]
        - numeroLot: 3
          millieme: 500.0
          parts:
            - personne: Carpentier Emmanuelle
              valeurBatiments: [ { prix: 100000.0 } ]
              valeurTerrains: [ { prixEstime: 10000.0 } ]
    """

  Scénario: Transfert de part de nature: Ne pas appliquer les règles de l'achat. millième cédée : 100

    Etant donnée un ppe cédé 16-16-1 sur 100 millième
    Etant donnée il s'agit d'un transfert sans regle de l'achat avec report de montant 110000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée une part acquise par la personne 3 à hauteur de 1/1
    Etant donnée l'opération est consolidée
    Etant donnée l'opération est prévisualisée
    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      ppes:
        - numeroLot: 1
          millieme: 400.0
          parts:
            - personne: Marie Currie
              valeurBatiments: [ { prix: 80000.0 } ]
              valeurTerrains: [ { prixEstime: 8000.0 } ]
        - numeroLot: 2
          millieme: 500.0
          parts:
            - personne: Newton Isaac
              valeurBatiments: [ { prix: 100000.0 } ]
              valeurTerrains: [ { prixEstime: 10000.0 } ]
        - numeroLot: 3
          millieme: 100.0
          parts:
            - personne: Carpentier Emmanuelle
              valeurBatiments: [ { prix: 20000.0 } ]
              valeurTerrains: [ { prixEstime: 2000.0 } ]
    """

  Scénario: Transfert de part de nature: Ne pas appliquer les règles de l'achat. millième cédée : 500

    Etant donnée un ppe cédé 16-16-1 sur 500 millième
    Etant donnée il s'agit d'un transfert sans regle de l'achat avec report de montant 110000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée une part acquise par la personne 3 à hauteur de 1/1
    Etant donnée l'opération est consolidée
    Etant donnée l'opération est prévisualisée
    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      ppes:
        - numeroLot: 2
          millieme: 500.0
          parts:
            - personne: Newton Isaac
              valeurBatiments: [ { prix: 100000.0 } ]
              valeurTerrains: [ { prixEstime: 10000.0 } ]
        - numeroLot: 3
          millieme: 500.0
          parts:
            - personne: Carpentier Emmanuelle
              valeurBatiments: [ { prix: 100000.0 } ]
              valeurTerrains: [ { prixEstime: 10000.0 } ]
    """