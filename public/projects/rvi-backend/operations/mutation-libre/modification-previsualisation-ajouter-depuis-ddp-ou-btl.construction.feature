#language: fr
Fonctionnalité: prévisualisation ajout une construction depuit un ddp ou un btl

  Contexte:
    Etant donné le reférentiel
    """yaml
      personnes:
        - &personne_1 { id: 1, ref: 100.000.001, nom: Currie, prenom: Marie }
        - &personne_2 { id: 2, ref: 100.000.002, nom: Newton, prenom: Isaac }
      mutations:
        - &mut_01_01_2010 { dateValeur: 01.01.2010 }
      parcelles:
        - identifier: 16-16
          mutationDebut: *mut_01_01_2010
          parts: [{identifier: 16-16-pp, personne: *personne_1}]
          ddps:
            - identifier: 16-16-ddp1
              parts:
                - identifier: 16-16-pp1
                  fraction: 1/2
                  personne: *personne_1
                  valeurTerrains: [ { identifier: 16-16-vt1, prix: 10000, surface: 1000 } ]
                - identifier: 16-16-pp2
                  fraction: 1/2
                  personne: *personne_2
                  valeurTerrains: [ { identifier: 16-16-vt2, prix: 20000, surface: 1000 } ]
          btls:
            - identifier: 16-16-btl1
              parts:
                - identifier: 16-16-pp3
                  fraction: 1/2
                  personne: *personne_1
                  valeurTerrains: [ { identifier: 16-16-vt3, prix: 10000, surface: 1000 } ]
                - identifier: 16-16-pp4
                  fraction: 1/2
                  personne: *personne_2
                  valeurTerrains: [ { identifier: 16-16-vt4, prix: 20000, surface: 1000 } ]
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

  Scénario: Ajout une construction depuis le btl

    Etant donnée la création d'une construction depuis l'objet Btl 16-16-btl1 : numéro de construction "A2"

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      btls:
        - identifier: 16-16-btl1
          parts:
            - identifier: 16-16-pp3
              valeurBatiments:
                - constructions: [ { numConstruction: A2}]
            - identifier: 16-16-pp4
              valeurBatiments:
                - constructions: [ { numConstruction: A2}]
    """

  Scénario: Ajout une construction depuis le ddp

    Etant donnée la création d'une construction depuis l'objet Ddp 16-16-ddp1 : numéro de construction "A2"

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      ddps:
        - identifier: 16-16-ddp1
          parts:
            - identifier: 16-16-pp1
              valeurBatiments:
                - constructions: [ { numConstruction: A2}]
            - identifier: 16-16-pp2
              valeurBatiments:
                - constructions: [ { numConstruction: A2}]
    """