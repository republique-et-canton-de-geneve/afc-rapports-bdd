#language: fr
Fonctionnalité: Ajout valeurs

  Contexte:
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Newton, prenom: Isaac }
      - &personne_3 { id: 3, ref: 100.000.003, nom: Robesse, prenom: Pierre }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        surface: 1000
        constructions:
          - &construction1 { identifier: 16-16-cst1, no: cst1 }
        parts:
          - identifier: 16-16-pp1
            fraction: 1/4
            personne: *personne_1
            valeurTerrains: [ { identifier: 16-16-vt1, prix: 10000, surface: 1000 } ]
            valeurBatiments: [ { identifier: 16-16-vb1, prix: 40000, constructions: [ *construction1 ] } ]
            valeurEtatLocatifs: [ { identifier: 16-16-vel1, montant: 20000, codeAffectation: 1, annee: 2010, construction: *construction1 } ]
          - identifier: 16-16-pp2
            fraction: 1/2
            personne: *personne_2
            valeurTerrains: [ { identifier: 16-16-vt2, prix: 20000, surface: 1000 } ]
            valeurBatiments: [ { identifier: 16-16-vb2, prix: 80000 , constructions: [ *construction1 ] } ]
            valeurEtatLocatifs: [ { identifier: 16-16-vel2, montant: 40000, codeAffectation: 1, annee: 2010, construction: *construction1 } ]
          - identifier: 16-16-pp3
            fraction: 1/4
            personne: *personne_3
            valeurTerrains: [ { identifier: 16-16-vt3, prix: 10000, surface: 1000 } ]
            valeurBatiments: [ { identifier: 16-16-vb3, prix: 40000 , constructions: [ *construction1 ] } ]
            valeurEtatLocatifs: [ { identifier: 16-16-vel3, montant: 20000, codeAffectation: 1, annee: 2010, construction: *construction1 } ]
    """

  Scénario: cas nominal
    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération d'ajout de valeurs à la date 01.01.2020
    Etant donné que la part 16-16-pp1 est concernée par l'ajout de valeurs
    Etant donné que la part 16-16-pp2 est concernée par l'ajout de valeurs
    Etant donné que la part 16-16-pp3 est concernée par l'ajout de valeurs

    Quand l'opération d'ajout de valeurs est consolidée
    Alors l'opération est en état consolidation
    Alors sur la consolidation de l'ajout de valeurs les objets sont

    """yaml
    identifierParcelle: "16-16"
    constructions: []
    responsabilites: []
    valeursBatiments: []
    valeursEtatLocatifs: []
    valeursTerrains: []
    """

    Etant donnée l'ajout, en consolidation, d'une valeur terrain sur l'objet cadastral 16-16 de surface 0 et de valeur estimée 10 000 le 01.01.2015
    Etant donnée l'ajout, en consolidation, d'une valeur batiment sur l'objet cadastral 16-16 de valeur estimée 10 000 le 01.01.2015

    Alors sur la consolidation de l'ajout de valeurs les objets sont
    """yaml
    identifierParcelle: "16-16"
    valeursTerrains:
      - prix: 10000.0
    valeursBatiments:
      - prix: 10000.0
    valeursEtatLocatifs: []
    """

    Quand l'opération d'ajout de valeurs est previsualisée
    Alors l'opération est en état prévisualisé

    Alors sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: "16-16"
      parts:
        - identifier: "16-16-pp1"
          valeurBatiments:
            - prix: 40000.0
            - prix: 2500.0
          valeurTerrains:
            - prixEstime: 10000.0
            - prixEstime: 2500.0
          valeurEtatLocatifs:
            - montant: 20000.0
        - identifier: "16-16-pp2"
          valeurBatiments:
            - prix: 80000.0
            - prix: 5000.0
          valeurTerrains:
            - prixEstime: 20000.0
            - prixEstime: 5000.0
          valeurEtatLocatifs:
            - montant: 40000.0
        - identifier: "16-16-pp3"
          valeurBatiments:
            - prix: 40000.0
            - prix: 2500.0
          valeurTerrains:
            - prixEstime: 10000.0
            - prixEstime: 2500.0
          valeurEtatLocatifs:
            - montant: 20000.0
    """

    Alors il y a 0 message d'erreur sur l'opération

    Quand l'opération de création de parcelle est validée
    Alors il n'y a pas d'erreur lors de la publication de la session

  Scénario: cas ou l'opération ne concerne pas la totalité des parts
    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération d'ajout de valeurs à la date 01.01.2020
    Etant donné que la part 16-16-pp1 est concernée par l'ajout de valeurs
    Etant donné que la part 16-16-pp2 est concernée par l'ajout de valeurs

    Quand l'opération d'ajout de valeurs est consolidée
    Alors l'opération est en état consolidation
    Alors sur la consolidation de l'ajout de valeurs les objets sont

    """yaml
    identifierParcelle: "16-16"
    constructions: []
    responsabilites: []
    valeursBatiments: []
    valeursEtatLocatifs: []
    valeursTerrains: []
    """

    Etant donnée l'ajout, en consolidation, d'une valeur terrain sur l'objet cadastral 16-16 de surface 0 et de valeur estimée 10 000 le 01.01.2015
    Etant donnée l'ajout, en consolidation, d'une valeur batiment sur l'objet cadastral 16-16 de valeur estimée 10 000 le 01.01.2015

    Alors sur la consolidation de l'ajout de valeurs les objets sont
    """yaml
    identifierParcelle: "16-16"
    valeursTerrains:
      - prix: 10000.0
    valeursBatiments:
      - prix: 10000.0
    valeursEtatLocatifs: []
    """

    Quand l'opération d'ajout de valeurs est previsualisée
    Alors l'opération est en état prévisualisé

    Alors sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: "16-16"
      parts:
        - identifier: "16-16-pp1"
          valeurBatiments:
            - prix: 40000.0
            - prix: 3333.0
          valeurTerrains:
            - prixEstime: 10000.0
            - prixEstime: 3333.0
          valeurEtatLocatifs:
            - montant: 20000.0
        - identifier: "16-16-pp2"
          valeurBatiments:
            - prix: 80000.0
            - prix: 6667.0
          valeurTerrains:
            - prixEstime: 20000.0
            - prixEstime: 6667.0
          valeurEtatLocatifs:
            - montant: 40000.0
        - identifier: "16-16-pp3"
          valeurBatiments:
            - prix: 40000.0
          valeurTerrains:
            - prixEstime: 10000.0
          valeurEtatLocatifs:
            - montant: 20000.0
    """

    Alors il y a 0 message d'erreur sur l'opération

    Quand l'opération de création de parcelle est validée
    Alors il n'y a pas d'erreur lors de la publication de la session