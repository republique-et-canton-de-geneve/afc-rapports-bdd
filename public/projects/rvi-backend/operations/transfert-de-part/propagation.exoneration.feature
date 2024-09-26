#language: fr
Fonctionnalité: Transfert de parts propagation exoneration

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
            prix: 3000
            exonerations:
            - typeExoneration: 2
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de part à la date d'estimation 01.02.2020
    Etant donnée une part cédée 16-16-pp à hauteur de 1/2
    Etant donnée un montant global de 100 000
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1
    Etant donnée l'opération est consolidée
    Etant donnée l'opération est prévisualisée

  Scénario: Conservation d'une exonération lors d'une vente partielle

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - personne: Marie Currie
        valeurTerrains:
        - valeurEstimee: 1500.0
          exos:
          - typeExoneration: Exo non transmissible 2
      - personne: Carpentier Emmanuelle
        valeurTerrains:
        - valeurEstimee: 100000.0
          exos: []
    """

