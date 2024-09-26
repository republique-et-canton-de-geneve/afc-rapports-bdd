#language: fr
Fonctionnalité: prévisualisation exonération

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
                  exonerations: [{ identifier: 16-16-exo, typeExoneration: 1 }]
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

  Scénario: Ajout d'une exonération

    Etant donnée la création d'une exonération sur la valeur terrain 16-16-vt 2 2000-2010 tx fortune 10% tx IIC 20% tx Revenu 30%

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - valeurTerrains:
        - exos:
          - typeExoneration: Exo non transmissible 1
          - typeExoneration: Exo non transmissible 2
    """

  Scénario: modification d'une exonération

    Etant donnée la modification de l'exonération 16-16-exo 2 2000-2010 tx fortune 10% tx IIC 20% tx Revenu 30%

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - valeurTerrains:
        - exos:
          - typeExoneration: Exo non transmissible 2
    """


  Scénario: Suppression d'une exonération

    Etant donnée la suppression de l'exonération 16-16-exo

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - fraction: 1/1
        personne: Currie Marie
        valeurTerrains:
        - valeurEstimee: 10000.0
          exos: []
    """

