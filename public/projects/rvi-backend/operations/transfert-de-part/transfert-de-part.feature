#language: fr
Fonctionnalité: Transfert de parts Au moins une part de propriété passe d'une personne à une autre. Exemple dans le cadre d'un achat/vente, d'une donation, ou d'une sucession.
  A la fin la date d'hitorisation de la part est égale à la date d'estimation.

  Scénario: 1 Acquéreur 1 part 1 terrain
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Carpentier, prenom: Emmanuelle }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        parts:
        - identifier: 16-16-pp
          personne: *personne_1
          valeurTerrains:
          - identifier: 16-16-vt
            prix: 50000
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de part à la date d'estimation 01.02.2020
    Etant donnée une part cédée 16-16-pp à hauteur de 1/1
    Etant donnée un montant global de 100 000
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1

    Quand l'opération est consolidée

    Alors l'opération est en état consolidation

    Et sur la consolidation, les objets sont
    """yaml
    - montantTerrainCede: 50000.0
      valeursTerrains:
      - prix: 100000.0
    """

    Quand l'opération est prévisualisée

    Alors l'opération est en état prévisualisé

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - fraction: 1/1
        personne: Carpentier Emmanuelle
        valeurTerrains:
        - valeurEstimee: 100000.0
      questionnaires: []
    """

  Scénario: 1 Acquéreur 2 part vendue partiellement 1 terrain
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Carpentier, prenom: Emmanuelle }
      - &personne_3 { id: 3, ref: 100.000.003, nom: Jancovici, prenom: Jean Marc }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        parts:
        - identifier: 16-16-pp1
          fraction: 1/3
          personne: *personne_1
          valeurTerrains:
          - identifier: 16-16-vt
            prix: 20000
        - identifier: 16-16-pp2
          fraction: 2/3
          personne: *personne_2
          valeurTerrains:
          - identifier: 16-16-vt
            prix: 40000
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de part à la date d'estimation 01.02.2020
    Etant donnée une part cédée 16-16-pp1 à hauteur de 1/2
    Etant donnée une part cédée 16-16-pp2 à hauteur de 1/4
    Etant donnée un montant global de 100 000
    Etant donnée une part acquise par la personne 3 à hauteur de 1/1

    Quand l'opération est consolidée

    Alors l'opération est en état consolidation

    Et sur la consolidation, les objets sont
    """yaml
    - montantTerrainCede: 20000.0
      valeursTerrains:
      - prix: 100000.0
    """

    Quand l'opération est prévisualisée

    Alors l'opération est en état prévisualisé

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - fraction: 1/2
        personne: Carpentier Emmanuelle
        valeurTerrains:
        - valeurEstimee: 30000.0
      - fraction: 1/6
        personne: Marie Currie
        valeurTerrains:
        - valeurEstimee: 10000.0
      - fraction: 1/3
        personne: Jancovici Jean Marc
        valeurTerrains:
        - valeurEstimee: 100000.0
    """


  Scénario: Multiple parcelles vendues

    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Carpentier, prenom: Emmanuelle }
      - &personne_3 { id: 3, ref: 100.000.003, nom: Jancovici, prenom: Jean Marc }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        parts:
        - identifier: 16-16-pp
          personne: *personne_1
          valeurTerrains:
          - identifier: 16-16-vt
            prix: 50000
      - identifier: 16-17
        mutationDebut: *mut_01_01_2010
        parts:
        - identifier: 16-17-pp
          personne: *personne_2
          valeurTerrains:
          - identifier: 16-17-vt
            prix: 100000
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
      | 16-17 |
    Etant donnée une opération de type transfert de part à la date d'estimation 01.02.2020
    Etant donnée une part cédée 16-16-pp à hauteur de 1/2
    Etant donnée une part cédée 16-17-pp à hauteur de 1/1

    Etant donnée un montant global de 100 000
    Etant donnée une part acquise par la personne 3 à hauteur de 1/1

    Quand l'opération est consolidée

    Alors l'opération est en état consolidation

    Et sur la consolidation, les objets sont
    """yaml
    - identifierParcelle: 16-16
      montantTerrainCede: 25000.0
      valeursTerrains:
      - prix: 20000.0
    - identifierParcelle: 16-17
      montantTerrainCede: 100000.0
      valeursTerrains:
      - prix: 80000.0
    """

    Quand l'opération est prévisualisée

    Alors l'opération est en état prévisualisé

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - fraction: 1/2
        personne: Marie Currie
        valeurTerrains:
        - valeurEstimee: 25000.0
      - fraction: 1/2
        personne: Jancovici Jean Marc
        personneId: 3
        valeurTerrains:
        - valeurEstimee: 20000.0
    - identifier: 16-17
      parts:
      - fraction: 1/1
        personne: Jancovici Jean Marc
        valeurTerrains:
        - valeurEstimee: 80000.0
    """

  Scénario: 1 parcelle avec 2 valeurs de valeur 0 vendue avec une montant global de 50000

    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Carpentier, prenom: Emmanuelle }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        parts:
        - identifier: 16-16-pp
          personne: *personne_1
          valeurTerrains:
          - identifier: 16-16-vt
            prix: 0
          valeurBatiments:
          - identifier: 16-16-vb
            prix: 0
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de part à la date d'estimation 01.02.2020
    Etant donnée une part cédée 16-16-pp à hauteur de 1/1

    Etant donnée un montant global de 50 000
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1

    Quand l'opération est consolidée

    Alors l'opération est en état consolidation

    Et sur la consolidation, les objets sont
    """yaml
    - identifierParcelle: 16-16
      valeursBatiments:
      - prix: 0.0
      valeursTerrains:
      - prix: 0.0
    """

  Scénario: Transfert de part sur bien ayant des valeurs de montant 0
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Carpentier, prenom: Emmanuelle }
      - &personne_3 { id: 3, ref: 100.000.003, nom: Jancovici, prenom: Jean Marc }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        parts:
          - identifier: 16-16-pp
            personne: *personne_1
            valeurTerrains:
              - identifier: 16-16-vt
                prix: 100000
      - identifier: 16-17
        mutationDebut: *mut_01_01_2010
        constructions:
          - &construction1 { identifier: 16-17-construction, no: cst1 }
        parts:
          - identifier: 16-17-pp
            personne: *personne_1
            valeurTerrains:
              - identifier: 16-17-vt
                prix: 0
            valeurBatiments:
              - prix: 0
                constructions: [ *construction1 ]
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
      | 16-17 |
    Etant donnée une opération de type transfert de part à la date d'estimation 01.02.2020
    Etant donnée une part cédée 16-16-pp à hauteur de 1/1
    Etant donnée une part cédée 16-17-pp à hauteur de 1/1
    Etant donnée un montant global de 100 000
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1

    Quand l'opération est consolidée

    Alors l'opération est en état consolidation

    Et sur la consolidation, les objets sont
    """yaml
    - identifierParcelle: 16-16
      montantTerrainCede: 100000.0
      valeursTerrains:
      - prix: 100000.0
    - identifierParcelle: 16-17
      valeursBatiments:
      - prix: 0.0
      valeursTerrains:
      - prix: 0.0
    """

    Quand l'opération est prévisualisée

    Alors l'opération est en état prévisualisé

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - personne: Carpentier Emmanuelle
        valeurTerrains:
        - valeurEstimee: 100000.0
    - identifier: 16-17
      parts:
      - personne: Carpentier Emmanuelle
        valeurBatiments:
        - valeurEstimee: 0.0
        valeurTerrains:
        - valeurEstimee: 0.0
    """
