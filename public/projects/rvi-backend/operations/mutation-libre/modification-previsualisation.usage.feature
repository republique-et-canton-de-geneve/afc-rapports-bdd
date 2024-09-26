#language: fr
Fonctionnalité: prévisualisation usage

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
                  usages:
                   - identifier: 16-16-u
    """


    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

  Scénario: Ajout d'un usage

    Etant donnée la création d'un usage 1/2 de type loué sur la valeur terrain 16-16-vt

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - valeurTerrains:
        - identifier: 16-16-vt
          usages:
          - {identifier: 16-16-u, fraction: 1/1, type: Loué}
          - {fraction: 1/2, type: Loué}
    """


  Scénario: modification d'un usage

    Etant donnée la modification de l'usage 16-16-u : 1/2 type loué

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - valeurTerrains:
        - identifier: 16-16-vt
          usages:
          - {identifier: 16-16-u, fraction: 1/2, type: Loué}
    """


  Scénario: Supression d'un usage

    Etant donnée la suppression d'un usage 16-16-u

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - valeurTerrains:
        - usages: []
    """

