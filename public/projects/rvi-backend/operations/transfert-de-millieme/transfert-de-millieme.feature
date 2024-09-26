#language: fr
Fonctionnalité: Transfert de millieme

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
                  - {  surface: 3000, prix: 10000 }
                valeurBatiments:
                  - {  constructions: [ *construction1 ], prix: 30000 }
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de millième à la date d'estimation 01.02.2020
    Etant donnée un montant global de 100 000

  Scénario: creation d'un nouveau lot ppe sans supression des anciens par une seule personne
    Etant donnée un ppe cédé 16-16-1 sur 100 millième
    Etant donnée un ppe cédé 16-16-2 sur 200 millième
    Etant donnée une part acquise par la personne 3 à hauteur de 1/1

    Quand l'opération est consolidée

    Alors l'opération est en état consolidation

    Et sur la consolidation, les objets sont
    """yaml
    responsabilites: []
    valeursBatiments:
    - {prix: 72222.0}
    valeursTerrains:
    - {prix: 27778.0}
    """

    Quand l'opération est prévisualisée

    Alors l'opération est en état prévisualisé

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      ppes:
        - numeroLot: 1
          millieme: 300.0
          parts:
            - personne: Marie Currie
              valeurBatiments: [ { prix: 75000.0 } ]
              valeurTerrains: [ { prixEstime: 37500.0 } ]
        - numeroLot: 2
          millieme: 400.0
          parts:
            - personne: Newton Isaac
              valeurBatiments: [ { prix: 20000.0 } ]
              valeurTerrains: [ { prixEstime: 6667.0 } ]
        - numeroLot: 3
          millieme: 300.0
          parts:
            - personne: Carpentier Emmanuelle
              valeurBatiments: [ { prix: 72222.0 } ]
              valeurTerrains: [ { prixEstime: 27778.0 } ]
    """

    Et il y a 1 message d'erreur sur l'opération
    Et il existe un message d'erreur "Un lot PPE ne contient pas de lot RF" sur l'opération

    Quand l'opération de transfert est validée
    Alors il n'y a pas d'erreur lors de la publication de la session


  Scénario: creation d'un nouveau lot ppe avec supression des anciens par une seule personne
    Etant donnée un ppe cédé 16-16-1 sur 400 millième
    Etant donnée un ppe cédé 16-16-2 sur 600 millième
    Etant donnée une part acquise par la personne 3 à hauteur de 1/1

    Quand l'opération est consolidée

    Alors l'opération est en état consolidation

    Et sur la consolidation, les objets sont
    """yaml
    responsabilites: []
    valeursBatiments:
    - {prix: 71667.0}
    valeursTerrains:
    - {prix: 28333.0}
    """

    Quand l'opération est prévisualisée

    Alors l'opération est en état prévisualisé

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      ppes:
        - numeroLot: 3
          parts:
            - fraction: 1/1
              personne: Carpentier Emmanuelle
              valeurBatiments:
                - prix: 71667.0
              valeurTerrains:
                - prixEstime: 28333.0
    """

    Et il y a 1 message d'erreur sur l'opération
    Et il existe un message d'erreur "Un lot PPE ne contient pas de lot RF" sur l'opération

    Quand l'opération de transfert est validée
    Alors il n'y a pas d'erreur lors de la publication de la session

  Scénario: creation d'un nouveau lot ppe avec supression partielle des anciens par deux personnes
    Etant donnée un ppe cédé 16-16-1 sur 400 millième
    Etant donnée un ppe cédé 16-16-2 sur 300 millième
    Etant donnée une part acquise par la personne 3 à hauteur de 1/4
    Etant donnée une part acquise par la personne 4 à hauteur de 3/4

    Quand l'opération est consolidée

    Alors l'opération est en état consolidation

    Et sur la consolidation, les objets sont
    """yaml
    responsabilites: []
    valeursBatiments:
    - {prix: 70238.0}
    valeursTerrains:
    - {prix: 29762.0}
    """

    Quand l'opération est prévisualisée

    Alors l'opération est en état prévisualisé

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      ppes:
        - numeroLot: 2
          millieme: 300.0
          parts:
            - personne: Newton Isaac
              valeurBatiments: [{ prix: 15000.0}]
              valeurTerrains: [{prixEstime: 5000.0}]
        - numeroLot: 3
          millieme: 700.0
          parts:
            - fraction: 1/4
              personne: Carpentier Emmanuelle
              valeurBatiments: [{prix: 17560.0}]
              valeurTerrains: [{prixEstime: 7441.0}]
            - fraction: 3/4
              personne: Rawls John
              valeurBatiments: [{prix: 52679.0}]
              valeurTerrains: [{prixEstime: 22322.0}]
    """

    Et il y a 1 message d'erreur sur l'opération
    Et il existe un message d'erreur "Un lot PPE ne contient pas de lot RF" sur l'opération

    Quand l'opération de transfert est validée
    Alors il n'y a pas d'erreur lors de la publication de la session
