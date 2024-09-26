#language: fr
Fonctionnalité: prévisualisation terrain

  Contexte:
    Etant donné le reférentiel
    """yaml
      personnes:
        - &personne_1 { id: 1, ref: 100.000.001, nom: Currie, prenom: Marie }
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
                  surface: 1000
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

  Scénario: Ajout d'une valeur terrain
    Etant donnée l'ajout d'une valeur terrain sur la part 16-16-pp de surface 20 et de valeur estimée 10 000 le 01.01.2015
    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - valeurTerrains:
        - surface: 1000
        - surface: 20
    """


  Scénario: Suppression d'une valeur terrain

    Etant donnée la suppression d'une valeur terrain 16-16-vt

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - valeurTerrains: []
    """


  Scénario: Modification d'une valeur terrain

    Etant donnée la modification de la valeur terrain 16-16-vt avec la surface 300 et la valeur estimée 2 000 le 01.01.2018

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - valeurTerrains:
        - surface: 300
    """
