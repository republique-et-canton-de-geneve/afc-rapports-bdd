#language: fr
Fonctionnalité: Modification de la consolidation pour la partie valeur batiment

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
        surface: 3000
        constructions:
        - &construction1 { identifier: 16-16-construction, no: cst1 }
        parts:
        - identifier: 16-16-pp
          personne: *personne_1
          valeurBatiments:
          - { identifier: 16-16-valeurBatiment-1, constructions: [ *construction1 ], prix: 40000 }
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de part à la date d'estimation 01.02.2020
    Etant donnée une part cédée 16-16-pp à hauteur de 1/1
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1
    Etant donnée il s'agit d'un achat avec report de montant 2000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée l'opération est consolidée

  Scénario: Ajout d'une valeur batiment

    Etant donnée l'ajout, en consolidation, d'une valeur batiment sur l'objet cadastral 16-16 de valeur estimée 10 000 le 01.01.2015

    Alors sur la consolidation, les objets sont
    """yaml
    - valeursBatiments:
      - prix: 2000.0
      - prix: 10000.0
    """

  Scénario: Suppression d'une valeur batiment

    Etant donnée la suppression, en consolidation, d'une valeur batiment 16-16-valeurBatiment-1

    Alors sur la consolidation, les objets sont
    """yaml
    - valeursBatiments: []
    """

  Scénario: Modification d'une valeur batiment

    Etant donnée la modification, en consolidation, de la valeur batiment 16-16-valeurBatiment-1 avec valeur estimée 3 000 le 01.01.2018

    Alors sur la consolidation, les objets sont
    """yaml
    - valeursBatiments:
      - { prix: 3000.0, unite: estimé}
    """

