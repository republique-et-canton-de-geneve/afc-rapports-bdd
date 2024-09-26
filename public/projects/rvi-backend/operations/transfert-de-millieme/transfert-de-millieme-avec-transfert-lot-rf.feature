#language: fr
Fonctionnalité: Transfert de millieme avec transfert de lots RF

  Contexte:
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
            lotrfs:
              - {identifier: 16-16-1-1, numero: 1}
              - {identifier: 16-16-1-2, numero: 2}
            parts:
              - identifier: 16-16-pp1
                personne: *personne_1
                valeurTerrains:
                  - {  surface: 3000, prix: 50000 }
                valeurBatiments:
                  - { constructions: [ *construction1 ], prix: 100000 }
          - identifier: 16-16-2
            millieme: 600
            lotrfs:
              - {identifier: 16-16-2-3, numero: 3}
              - {identifier: 16-16-2-4, numero: 4}
            parts:
              - identifier: 16-16-pp2
                personne: *personne_2
                valeurTerrains:
                  - {  surface: 3000, prix: 10000 }
                valeurBatiments:
                  - {  constructions: [ *construction1 ], prix: 30000 }
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de millième à la date d'estimation 01.02.2020
    Etant donnée un montant global de 100 000

  Scénario: creation d'un nouveau lot ppe avec transfert de lots RF
    Etant donnée un ppe cédé 16-16-1 sur 100 millième
    Etant donnée un ppe cédé 16-16-2 sur 200 millième
    Etant donné un lot RF transféré 2 du ppe 16-16-1
    Etant donné un lot RF transféré 4 du ppe 16-16-2
    Etant donnée une part acquise par la personne 3 à hauteur de 1/1

    Quand l'opération est consolidée

    Alors l'opération est en état consolidation

    Et sur la consolidation, les objets sont
    """yaml
    valeursBatiments:
    - prix: 72222.0
    valeursTerrains:
    - prix: 27778.0
    """

    Quand l'opération est prévisualisée

    Alors l'opération est en état prévisualisé

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      ppes:
      - numeroLot: 1
        millieme: 300.0
        lotRF:
        - numeroLot: 1
      - numeroLot: 2
        millieme: 400.0
        lotRF:
        - numeroLot: 3
      - numeroLot: 3
        millieme: 300.0
        lotRF:
        - numeroLot: 2
        - numeroLot: 4

    """

    Et il y a 0 message d'erreur sur l'opération

    Quand l'opération de transfert est validée
    Alors il n'y a pas d'erreur lors de la publication de la session
