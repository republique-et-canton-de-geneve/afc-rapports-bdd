#language: fr
Fonctionnalité: Reunion Division de parcelle (Cas aux limites)

  Scénario: Une parcelle selectionnée dans la session est
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

    Alors la parcelle 16-71 à la date valeur 01.01.2020 existe

    Etant donnée que la session concerne la/les parcelles
      | 16-70 |
      | 16-71 |
    Etant donnée une opération de réunion division à la date valeur 01.01.2020
    Etant donné que l'opération de réunion division concerne la parcelle 16-70
    Etant donné que l'opération de réunion division constitue la parcelle de numero 72 et de surface 610
    Etant donné que l'ancienne parcelle 16-70 est répartie sur la nouvelle parcelle 72 à hauteur de 1/1
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
        prix: 40000.0
    """

    Quand l'opération de réunion division est prévisualisée
    Alors l'opération est en état prévisualisé
    Et il y a 0 message d'erreur sur l'opération
    Quand l'opération de réunion division est validée
    Alors il n'y a pas d'erreur lors de la publication de la session
    Et la parcelle 16-70 à la date valeur 01.01.2020 n'existe pas
    Et la parcelle 16-71 à la date valeur 01.01.2020 existe
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
      - valeurEstimee: 40000.0
        surface: 610
    """
