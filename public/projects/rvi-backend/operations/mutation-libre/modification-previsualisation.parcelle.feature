#language: fr
Fonctionnalité: prévisualisation parcelle

  Contexte:
    Etant donné le reférentiel
    """yaml
      mutations:
        - &mut_01_01_2010 { dateValeur: 01.01.2010 }
      personnes:
        - &personne_1 { id: 1, ref: 100.000.001, nom: Currie, prenom: Marie }
        - &personne_2 { id: 2, ref: 100.000.002, nom: Newton, prenom: Isaac }
      parcelles:
        - identifier: 16-16
          mutationDebut: *mut_01_01_2010
          surface: 1000
          parts:
            - identifier: 16-16-pp1
              personne: *personne_1
              valeurTerrains:
                - identifier: 16-16-vt1
                  surface: 1000
            - identifier: 16-16-pp2
              personne: *personne_2
              valeurTerrains:
                - identifier: 16-16-vt2
                  surface: 700
                - identifier: 16-16-vt3
                  surface: 300
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

  Scénario: modification d'une parcelle

    Etant donnée la modification de la parcelle 16-16 : surface 20

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      surface: 20
      parts:
        - identifier: 16-16-pp1
          valeurTerrains:
            - identifier: 16-16-vt1
              surface: 20
        - identifier: 16-16-pp2
          valeurTerrains:
            - identifier: 16-16-vt2
              surface: 700
            - identifier: 16-16-vt3
              surface: 300
    """
