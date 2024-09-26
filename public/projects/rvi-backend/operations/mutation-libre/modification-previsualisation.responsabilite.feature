#language: fr
Fonctionnalité: prévisualisation responsabilité

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
        parts:
          - identifier: 16-16-pp
            personne: *personne_1
            valeurTerrains:
              - identifier: 16-16-vt
                responsabilites : [{identifier: 16-16-rp, fraction: 1/2, personne: *personne_2,  type: USUFRUIT}]
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

  Scénario: Ajout d'une responsabilité sur le terrain

    Etant donnée la création d'une responsabilité 1/3 de type Droit d'habitation pour la personne 100.000.002 sur l'objet Terrain 16-16-vt

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - valeurTerrains:
        - identifier: 16-16-vt
          responsabilites:
          - {fraction: 1/2, personne: Newton Isaac, type: Usufruit}
          - {fraction: 1/3, personne: Newton Isaac, type: Droit d'hab}
    """

  Scénario: Ajout d'une responsabilité sur la Part

    Etant donnée la création d'une responsabilité 1/3 de type Usufruit pour la personne 100.000.002 sur l'objet Part 16-16-pp

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
        - responsabilites:
            - {fraction: 1/3, personne: Newton Isaac, type: Usufruit}
          valeurTerrains:
            - identifier: 16-16-vt
              responsabilites:
                - {fraction: 1/2, personne: Newton Isaac, type: Usufruit}
    """


  Scénario: modification d'une responsabilité

    Etant donnée la modification de la responsabilité 16-16-rp : 1/4 type Porté par anticipation

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - valeurTerrains:
        - identifier: 16-16-vt
          responsabilites:
          - {fraction: 1/4, personne: Newton Isaac, type: PPA}
    """


  Scénario: Supression d'une Responsabilité

    Etant donnée la suppression d'une responsabilité 16-16-rp

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - valeurTerrains:
        - identifier: 16-16-vt
          responsabilites: []
    """

