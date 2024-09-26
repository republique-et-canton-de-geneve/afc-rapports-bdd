#language: fr
Fonctionnalité: suppression ppe

  Scénario: suppression sur parcelle
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Newton, prenom: Isaac }
      - &personne_3 { id: 3, ref: 100.000.003, nom: Carpentier, prenom: Emmanuelle }
      - &personne_4 { id: 4, ref: 100.000.004, nom: Rawls, prenom: John }
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
            millieme: 400
            parts:
              - identifier: 16-16-pp1
                personne: *personne_1
                valeurTerrains:
                  - {  surface: 3000, prix: 50000 }
                valeurBatiments:
                  - { constructions: [ *construction1 ], prix: 100000 }
          - identifier: 16-16-2
            millieme: 600
            parts:
              - identifier: 16-16-pp2
                personne: *personne_2
                valeurTerrains:
                  - surface: 3000
                    prix: 10000
                    usages : [{identifier: 16-16-u, fraction: 1/1, type: loué}]
                    exonerations : [{identifier: 16-16-exo, typeExoneration: 1 }]
                    responsabilites : [{identifier: 16-16-rp, fraction: 1/2, personne: *personne_3,  type: USUFRUIT}]
                valeurBatiments:
                  - {  constructions: [ *construction1 ], prix: 30000 }
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de suppression PPE à la date valeur 01.02.2020
    Etant donné l'objet 16-16 est selectionné pour suppression de PPE
    Alors l'opération est en état prévisualisé

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      surface: 3000
      debutValidite: 2010-01-01
      constructions:
      - numConstruction: cst1
      ppes: []
      parts:
      - personne: Marie Currie
        fraction: 2/5
        valeurBatiments:
        - prix: 100000.0
          exos: []
          usages: []
          responsabilites: []
        valeurTerrains:
        - prixEstime: 50000.0
          exos: []
          usages: []
          responsabilites: []

      - personne: Newton Isaac
        fraction: 3/5
        debutValidite: 2020-02-01
        valeurBatiments:
        - debutValidite: 2020-02-01
          prix: 30000.0
        valeurTerrains:
        - debutValidite: 2020-02-01
          surface: 3000
          prixEstime: 10000.0
          exos:
          - typeExoneration: Exo non transmissible 1
          usages:
          - fraction: 1/1
            type: Loué
          responsabilites:
          - fraction: 1/2
            personne: Carpentier Emmanuelle
    """
