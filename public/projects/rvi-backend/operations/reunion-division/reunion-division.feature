#language: fr
Fonctionnalité: Reunion Division de parcelle


  Scénario: Division sans btl/ddp/ppe
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
    mutations:
      - &mut_01_01_2020 { dateValeur: 01.01.2020 }
    parcelles:
      - identifier: 16-70
        mutationDebut: *mut_01_01_2020
        surface: 500
        constructions:
        - &construction1 { identifier: 16-70-cst1, no: cst1, surface: 1}
        parts:
        - fraction: 1/1
          personne: *personne_1
          valeurBatiments:
          - prix: 50000
            constructions: [ *construction1 ]
          valeurTerrains:
          - prix: 40000
            surface: 500

    """

    Etant donnée que la session concerne la/les parcelles
      | 16-70 |
    Etant donnée une opération de réunion division à la date valeur 01.01.2020
    Etant donné que l'opération de réunion division concerne la parcelle 16-70
    Etant donné que l'opération de réunion division constitue la parcelle de numero 72 et de surface 200
    Etant donné que l'opération de réunion division constitue la parcelle de numero 73 et de surface 300
    Etant donné que l'ancienne parcelle 16-70 est répartie sur la nouvelle parcelle 72 à hauteur de 200/500
    Etant donné que l'ancienne parcelle 16-70 est répartie sur la nouvelle parcelle 73 à hauteur de 300/500
    Etant donné que la construction cst1 est reportée sur la parcelle 72

    Quand l'opération de réunion division est consolidée
    Alors l'opération est en état consolidation
    Et sur la consolidation de la réunion division les objets sont
    """yaml
    - identifierParcelle: 16-72
      surfaceParcelle: 200
      constructions:
      - numConstruction: cst1
      valeursBatiments:
      - prix: 50000.0
        constructions:
        - 16-72-construction-1
      valeursTerrains:
      - surface: 200
        prix: 16000.0

    - identifierParcelle: 16-73
      surfaceParcelle: 300
      valeursBatiments: []
      valeursTerrains:
      - surface: 300
        prix: 24000.0
    """

    Quand l'opération de réunion division est prévisualisée
    Alors l'opération est en état prévisualisé
    Et il y a 0 message d'erreur sur l'opération
    Quand l'opération de réunion division est validée
    Alors il n'y a pas d'erreur lors de la publication de la session
    Et la parcelle 16-72 à la date valeur 01.01.2020 est
    """yaml
    identifier: 16-72
    surface: 200
    constructions:
    - numConstruction: cst1
    parts:
    - personne: Marie Currie
      fraction: 1/1
      valeurBatiments:
      - valeurEstimee: 50000.0
        constructions:
        - numConstruction: cst1
      valeurTerrains:
      - valeurEstimee: 16000.0
        surface: 200
    """

    Et la parcelle 16-73 à la date valeur 01.01.2020 est
    """yaml
    identifier: 16-73
    surface: 300
    constructions: []
    parts:
    - personne: Marie Currie
      fraction: 1/1
      valeurBatiments: []
      valeurTerrains:
      - valeurEstimee: 24000.0
        surface: 300
    """

  Scénario: Réunion Sans DDP/BTL/PPE
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
    mutations:
      - &mut_01_01_2020 { dateValeur: 01.01.2020 }
    parcelles:
      - identifier: 16-70
        mutationDebut: *mut_01_01_2020
        surface: 500
        constructions:
        - &construction1 { identifier: 16-70-cst1, no: cst1, surface: 1}
        parts:
        - fraction: 1/1
          personne: *personne_1
          valeurBatiments:
          - prix: 50000
            constructions: [ *construction1 ]
          valeurTerrains:
          - prix: 40000
            surface: 500

      - identifier: 16-71
        mutationDebut: *mut_01_01_2020
        surface: 100
        parts:
          - fraction: 1/1
            personne: *personne_1
            valeurTerrains:
              - prix: 40000
                surface: 100
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-70 |
      | 16-71 |
    Etant donnée une opération de réunion division à la date valeur 01.01.2020
    Etant donné que l'opération de réunion division concerne la parcelle 16-70
    Etant donné que l'opération de réunion division concerne la parcelle 16-71
    Etant donné que l'opération de réunion division constitue la parcelle de numero 72 et de surface 610
    Etant donné que l'ancienne parcelle 16-70 est répartie sur la nouvelle parcelle 72 à hauteur de 1/1
    Etant donné que l'ancienne parcelle 16-71 est répartie sur la nouvelle parcelle 72 à hauteur de 1/1
    Etant donné que la construction cst1 est reportée sur la parcelle 72

    Quand l'opération de réunion division est consolidée
    Alors l'opération est en état consolidation
    Et sur la consolidation de la réunion division les objets sont
    """yaml
    - identifierParcelle: 16-72
      surfaceParcelle: 610
      constructions:
      - numConstruction: cst1
      valeursBatiments:
      - prix: 50000.0
      valeursTerrains:
      - surface: 610
        prix: 80000.0
    """

    Quand l'opération de réunion division est prévisualisée
    Alors l'opération est en état prévisualisé
    Et il y a 0 message d'erreur sur l'opération
    Quand l'opération de réunion division est validée
    Alors il n'y a pas d'erreur lors de la publication de la session
    Et la parcelle 16-72 à la date valeur 01.01.2020 est
    """yaml
    identifier: 16-72
    surface: 610
    constructions:
    - numConstruction: cst1
    parts:
    - personne: Marie Currie
      fraction: 1/1
      valeurBatiments:
      - valeurEstimee: 50000.0
        constructions:
        - numConstruction: cst1
      valeurTerrains:
      - valeurEstimee: 80000.0
        surface: 610
    """


  Scénario: Changement de numero parcelle et repartition resp multi part
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Bross, prenom: Mario }
      - &personne_3 { id: 3, ref: 100.000.003, nom: Bross, prenom: Luigi }
    mutations:
      - &mut_01_01_2020 { dateValeur: 01.01.2020 }
    parcelles:
      - identifier: 16-70
        mutationDebut: *mut_01_01_2020
        surface: 1100
        parts:
        - fraction: 1/3
          personne: *personne_2
          responsabilites:
            - personne: *personne_1
              fraction: 1/2
          valeurTerrains:
          - prix: 40000
            surface: 500

        - fraction: 2/3
          personne: *personne_3
          responsabilites:
            - personne: *personne_1
              fraction: 1/2
          valeurTerrains:
          - prix: 50000
            surface: 600
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-70 |
    Etant donnée une opération de réunion division à la date valeur 01.01.2020
    Etant donné que l'opération de réunion division concerne la parcelle 16-70
    Etant donné que l'opération de réunion division constitue la parcelle de numero 72 et de surface 1100
    Etant donné que l'ancienne parcelle 16-70 est répartie sur la nouvelle parcelle 72 à hauteur de 1/1

    Quand l'opération de réunion division est consolidée
    Alors l'opération est en état consolidation
    Et sur la consolidation de la réunion division les objets sont
    """yaml
    - identifierParcelle: 16-72
      surfaceParcelle: 1100
      responsabilites:
      - personneRef: 100.000.001
        fraction: 1/2
      valeursTerrains:
      - surface: 1100
        prix: 90000.0
        responsabilites: []
        unite: estimé
    """

    Quand l'opération de réunion division est prévisualisée
    Alors l'opération est en état prévisualisé
    Et il y a 0 message d'erreur sur l'opération
    Quand l'opération de réunion division est validée
    Alors il n'y a pas d'erreur lors de la publication de la session
    Et la parcelle 16-72 à la date valeur 01.01.2020 est
    """yaml
    identifier: 16-72
    surface: 1100
    parts:
    - personne: Bross Luigi
      fraction: 2/3
      valeurTerrains:
      - surface: 1100
        valeurEstimee: 60000.0
      responsabilites:
      - fraction: 1/2
        personne: Marie Currie
    - personne: Bross Mario
      fraction: 1/3
      valeurTerrains:
      - surface: 1100
        valeurEstimee: 30000.0
      responsabilites:
      - fraction: 1/2
        personne: Marie Currie
    """

  Scénario: avec PPE
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Maynard Keynes, prenom: John }
    mutations:
      - &mut_01_01_2020 { dateValeur: 01.01.2020 }
    parcelles:
    - identifier: 16-80
      mutationDebut: *mut_01_01_2020
      surface: 500
      constructions:
      - &construction1 { identifier: 16-80-cst1, no: cst1, surface: 1 }
      ppes:
      - identifier: 16-80-1
        parts:
        - personne: *personne_2
          valeurBatiments:
          - prix: 50000
            constructions: [ *construction1 ]
          valeurTerrains:
          - identifier: 16-80-vt
            prix: 40000
            surface: 500
        lotrfs:
        - identifier: 16-80-lot-rf
          numero: 1

    - identifier: 16-81
      mutationDebut: *mut_01_01_2020
      surface: 100
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-80 |
      | 16-81 |
    Etant donnée une opération de réunion division à la date valeur 01.01.2020
    Etant donné que l'opération de réunion division concerne la parcelle 16-80
    Etant donné que l'opération de réunion division concerne la parcelle 16-81
    Etant donné que l'opération de réunion division constitue la parcelle de numero 82 et de surface 610
    Etant donné que l'ancienne parcelle 16-80 est répartie sur la nouvelle parcelle 82 à hauteur de 1/1
    Etant donné que l'ancienne parcelle 16-81 est répartie sur la nouvelle parcelle 82 à hauteur de 1/1
    Etant donné que les ppes sous la parcelle 16-80 sont reportés sur la parcelle 82
    Etant donné que la construction cst1 est reportée sur la parcelle 82

    Quand l'opération de réunion division est consolidée
    Alors l'opération est en état consolidation
    Et sur la consolidation de la réunion division les objets sont
    """yaml
    - identifierParcelle: 16-82
      surfaceParcelle: 610
      constructions:
      - numConstruction: cst1
      valeursBatiments: []
      valeursTerrains: []
    """

    Quand l'opération de réunion division est prévisualisée
    Alors l'opération est en état prévisualisé
    Quand la modification de la valeur terrain 16-82-vt avec la surface 610 et la valeur estimée 40 000 le 01.01.2020
    Et il y a 0 message d'erreur sur l'opération
    Quand l'opération de réunion division est validée
    Alors il n'y a pas d'erreur lors de la publication de la session
    Et la parcelle 16-82 à la date valeur 01.01.2020 est
    """yaml
    identifier: 16-82
    surface: 610
    constructions:
    - numConstruction: cst1
    ppes:
    - identifier: 16-82-1
      parts:
      - fraction: 1/1
        personne: Maynard Keynes John
        valeurBatiments:
        - prix: 50000.0
          constructions:
          - numConstruction: cst1
        valeurTerrains:
        - debutValidite: 2020-01-01
          identifier: 16-82-vt
          surface: 610
          prixEstime: 40000.0
      lotRF:
      - numeroLot: 1
        identifier: 16-82-lot-rf
    """


  Scénario: Sous DDP
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Maynard Keynes, prenom: John }
    mutations:
      - &mut_01_01_2020 { dateValeur: 01.01.2020 }
    parcelles:
    - identifier: 16-80
      mutationDebut: *mut_01_01_2020
      surface: 500
      constructions:
      - &construction1 { identifier: 16-80-cst1, no: cst1, surface: 1 }
      ddps:
      - identifier: 16-80-1
        parts:
        - personne: *personne_2
          valeurBatiments:
          - prix: 50000
            constructions: [ *construction1 ]

    - identifier: 16-81
      mutationDebut: *mut_01_01_2020
      surface: 100
      parts:
      - fraction: 1/1
        personne: *personne_1
        valeurTerrains:
        - prix: 40000
          surface: 100
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-80 |
      | 16-81 |
    Etant donnée une opération de réunion division à la date valeur 01.01.2020
    Etant donné que l'opération de réunion division concerne la parcelle 16-80
    Etant donné que l'opération de réunion division concerne la parcelle 16-81
    Etant donné que l'opération de réunion division constitue la parcelle de numero 82 et de surface 610
    Etant donné que l'ancienne parcelle 16-80 est répartie sur la nouvelle parcelle 82 à hauteur de 1/1
    Etant donné que l'ancienne parcelle 16-81 est répartie sur la nouvelle parcelle 82 à hauteur de 1/1
    Etant donné que le ddp 16-80-1 est reporté sur la parcelle 82
    Etant donné que la construction cst1 est reportée sur la parcelle 82

    Quand l'opération de réunion division est consolidée
    Alors l'opération est en état consolidation
    Et sur la consolidation de la réunion division les objets sont
    """yaml
    - identifierParcelle: 16-82
      surfaceParcelle: 610
      constructions:
      - numConstruction: cst1
      valeursBatiments: []
      valeursTerrains:
      - surface: 610
        prix: 40000.0
    """

    Quand l'opération de réunion division est prévisualisée
    Alors l'opération est en état prévisualisé
    Et il y a 0 message d'erreur sur l'opération
    Quand l'opération de réunion division est validée
    Alors il n'y a pas d'erreur lors de la publication de la session
    Et la parcelle 16-82 à la date valeur 01.01.2020 est
    """yaml
    identifier: 16-82
    surface: 610
    constructions: [{numConstruction: cst1}]
    ddps:
    - identifier: 16-82-1
      parts:
      - personne: Maynard Keynes John
        valeurBatiments:
        - valeurEstimee: 50000.0
          constructions: [{numConstruction: cst1}]
    parts:
    - personne: Marie Currie
      valeurBatiments: []
      valeurTerrains: [{valeurEstimee: 40000.0}]
    """


  Scénario: Sous BTL
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Maynard Keynes, prenom: John }
    mutations:
      - &mut_01_01_2020 { dateValeur: 01.01.2020 }
    parcelles:
    - identifier: 16-80
      mutationDebut: *mut_01_01_2020
      surface: 500
      constructions:
      - &construction1 { identifier: 16-80-cst1, no: cst1, surface: 1 }
      btls:
      - identifier: 16-80-1
        parts:
        - personne: *personne_2
          valeurBatiments:
          - prix: 50000
            constructions: [ *construction1 ]

    - identifier: 16-81
      mutationDebut: *mut_01_01_2020
      surface: 100
      parts:
      - fraction: 1/1
        personne: *personne_1
        valeurTerrains:
        - prix: 40000
          surface: 100
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-80 |
      | 16-81 |
    Etant donnée une opération de réunion division à la date valeur 01.01.2020
    Etant donné que l'opération de réunion division concerne la parcelle 16-80
    Etant donné que l'opération de réunion division concerne la parcelle 16-81
    Etant donné que l'opération de réunion division constitue la parcelle de numero 82 et de surface 610
    Etant donné que l'ancienne parcelle 16-80 est répartie sur la nouvelle parcelle 82 à hauteur de 1/1
    Etant donné que l'ancienne parcelle 16-81 est répartie sur la nouvelle parcelle 82 à hauteur de 1/1
    Etant donné que le btl 16-80-1 est reporté sur la parcelle 82
    Etant donné que la construction cst1 est reportée sur la parcelle 82

    Quand l'opération de réunion division est consolidée
    Alors l'opération est en état consolidation
    Et sur la consolidation de la réunion division les objets sont
    """yaml
    - identifierParcelle: 16-82
      surfaceParcelle: 610
      constructions:
      - numConstruction: cst1
      valeursBatiments: []
      valeursTerrains:
      - surface: 610
        prix: 40000.0
    """

    Quand l'opération de réunion division est prévisualisée
    Alors l'opération est en état prévisualisé
    Et il y a 0 message d'erreur sur l'opération
    Quand l'opération de réunion division est validée
    Alors il n'y a pas d'erreur lors de la publication de la session
    Et la parcelle 16-82 à la date valeur 01.01.2020 est
    """yaml
    identifier: 16-82
    surface: 610
    constructions: [{numConstruction: cst1}]
    btls:
    - identifier: 16-82-1
      parts:
      - personne: Maynard Keynes John
        valeurBatiments:
        - valeurEstimee: 50000.0
          constructions: [{numConstruction: cst1}]
    parts:
    - personne: Marie Currie
      valeurBatiments: []
      valeurTerrains: [{valeurEstimee: 40000.0}]
    """

  Scénario: Cas de merge des responsabilités identiques sous des parcelles différents
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Bross, prenom: Mario }
    mutations:
      - &mut_01_01_2020 { dateValeur: 01.01.2020 }
    parcelles:
      - identifier: 16-70
        mutationDebut: *mut_01_01_2020
        surface: 1100
        parts:
        - fraction: 1/1
          personne: *personne_2
          responsabilites:
            - personne: *personne_1
              fraction: 1/1
          valeurTerrains:
          - prix: 40000
            surface: 500
      - identifier: 16-71
        mutationDebut: *mut_01_01_2020
        surface: 1100
        parts:
        - fraction: 1/1
          personne: *personne_2
          responsabilites:
            - personne: *personne_1
              fraction: 1/1
          valeurTerrains:
          - prix: 50000
            surface: 600
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-70 |
      | 16-71 |
    Etant donnée une opération de réunion division à la date valeur 01.01.2020
    Etant donné que l'opération de réunion division concerne la parcelle 16-70
    Etant donné que l'opération de réunion division concerne la parcelle 16-71
    Etant donné que l'opération de réunion division constitue la parcelle de numero 72 et de surface 1100
    Etant donné que l'ancienne parcelle 16-70 est répartie sur la nouvelle parcelle 72 à hauteur de 1/1
    Etant donné que l'ancienne parcelle 16-71 est répartie sur la nouvelle parcelle 72 à hauteur de 1/1

    Quand l'opération de réunion division est consolidée
    Alors l'opération est en état consolidation
    Et sur la consolidation de la réunion division les objets sont
    """yaml
    - identifierParcelle: 16-72
      surfaceParcelle: 1100
      responsabilites:
      - personneRef: 100.000.001
        fraction: 1/1
      valeursTerrains:
      - surface: 1100
        prix: 90000.0
        responsabilites: []
        unite: estimé
    """

    Quand l'opération de réunion division est prévisualisée
    Alors l'opération est en état prévisualisé
    Et il y a 0 message d'erreur sur l'opération
    Quand l'opération de réunion division est validée
    Alors il n'y a pas d'erreur lors de la publication de la session
    Et la parcelle 16-72 à la date valeur 01.01.2020 est
    """yaml
    identifier: 16-72
    surface: 1100
    parts:
    - personne: Bross Mario
      fraction: 1/1
      valeurTerrains:
      - surface: 1100
        valeurEstimee: 90000.0
      responsabilites:
      - fraction: 1/1
        personne: Marie Currie
    """