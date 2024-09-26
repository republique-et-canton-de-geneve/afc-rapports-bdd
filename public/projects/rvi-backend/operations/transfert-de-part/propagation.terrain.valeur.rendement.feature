#language: fr
Fonctionnalité: Transfert de parts propagation d'un terrain à la valeur de rendement

  Contexte:
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
        constructions:
        - &construction1 { identifier: 16-16-construction, no: cst1 }
        parts:
        - identifier: 16-16-pp
          personne: *personne_1
          valeurTerrains:
          - identifier: 16-16-vt
            prix: 1000
            unite: VALEUR_DE_RENDEMENT
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
        personne: Carpentier Emmanuelle
        valeurTerrains:
        - prixEstime: 500.0
      - fraction: 1/2
        personne: Marie Currie
        valeurTerrains:
        - prixEstime: 500.0
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
        personne: Carpentier Emmanuelle
        valeurTerrains:
        - prixEstime: 1000.0
    """

  Scénario: Transfert de part de nature: Ne pas appliquer les règles de l'achat. Part cédée : 1/2

    Etant donnée une part cédée 16-16-pp à hauteur de 1/2
    Etant donnée il s'agit d'un transfert sans regle de l'achat avec report de montant 1000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1
    Etant donnée l'opération est consolidée
    Etant donnée l'opération est prévisualisée
    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - fraction: 1/2
        personne: Carpentier Emmanuelle
        valeurTerrains:
        - prixEstime: 500.0
      - fraction: 1/2
        personne: Marie Currie
        valeurTerrains:
        - prixEstime: 500.0
    """

  Scénario: Transfert de part de nature: Ne pas appliquer les règles de l'achat. Part cédée : 1/1

    Etant donnée une part cédée 16-16-pp à hauteur de 1/1
    Etant donnée il s'agit d'un transfert sans regle de l'achat avec report de montant 1000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1
    Etant donnée l'opération est consolidée
    Etant donnée l'opération est prévisualisée
    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - fraction: 1/1
        personne: Carpentier Emmanuelle
        valeurTerrains:
        - prixEstime: 1000.0
    """
