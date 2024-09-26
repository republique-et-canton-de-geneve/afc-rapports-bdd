#language: fr
Fonctionnalité: Transfert de parts propagation batiment (valeur rendement)

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
        surface: 3000
        constructions:
        - &construction1 { identifier: 16-16-construction, no: cst1 }
        parts:
        - identifier: 16-16-pp
          personne: *personne_1
          valeurBatiments:
          - { identifier: 16-16-valeurBatiment-1, constructions: [ *construction1 ], prix: 40000, unite: VALEUR_DE_RENDEMENT }
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de part à la date d'estimation 01.02.2020

  Scénario: Transfert de part de nature à la valeur de rendement. Part cédée : 1/2

    Etant donnée une part cédée 16-16-pp à hauteur de 1/2
    Etant donnée il s'agit d'un achat à la valeur de rendement
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1
    Etant donnée l'opération est consolidée
    Etant donnée l'opération est prévisualisée
    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - fraction: 1/2
        personne: Newton Isaac
        valeurBatiments:
        - prix: 20000.0
      - fraction: 1/2
        personne: Currie Marie
        valeurBatiments:
        - prix: 20000.0
    """

  Scénario: Transfert de part de nature à la valeur de rendement. Part cédée : 1/1

    Etant donnée une part cédée 16-16-pp à hauteur de 1/1
    Etant donnée il s'agit d'un achat à la valeur de rendement
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1
    Etant donnée l'opération est consolidée
    Etant donnée l'opération est prévisualisée
    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - fraction: 1/1
        personne: Newton Isaac
        valeurBatiments:
        - prix: 40000.0
    """

  Scénario: Transfert de part de nature: Ne pas appliquer les règles de l'achat. Part cédée : 1/2

    Etant donnée une part cédée 16-16-pp à hauteur de 1/2
    Etant donnée il s'agit d'un transfert sans regle de l'achat avec report de montant 40000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1
    Etant donnée l'opération est consolidée
    Etant donnée l'opération est prévisualisée
    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - fraction: 1/2
        personne: Newton Isaac
        valeurBatiments:
        - prix: 20000.0
      - fraction: 1/2
        personne: Currie Marie
        valeurBatiments:
        - prix: 20000.0
    """

  Scénario: Transfert de part de nature: Ne pas appliquer les règles de l'achat. Part cédée : 1/1

    Etant donnée une part cédée 16-16-pp à hauteur de 1/1
    Etant donnée il s'agit d'un transfert sans regle de l'achat avec report de montant 40000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1
    Etant donnée l'opération est consolidée
    Etant donnée l'opération est prévisualisée
    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - fraction: 1/1
        personne: Newton Isaac
        valeurBatiments:
        - prix: 40000.0
    """
