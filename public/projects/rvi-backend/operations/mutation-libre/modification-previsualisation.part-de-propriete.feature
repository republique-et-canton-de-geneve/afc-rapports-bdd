#language: fr
Fonctionnalité: prévisualisation part de propriété

  Contexte:

    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Newton, prenom: Isaac }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        parts:
          - identifier: 16-16-pp
            personne: *personne_1
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

  Scénario: Ajout d'une part de propriété

    Etant donnée la création d'une Part de propriété sur l'objet Parcelle 16-16 : part 1/1 pour la personne 100.000.002

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
        - {fraction: 1/1, personne: Marie Currie}
        - {fraction: 1/1, personne: Newton Isaac}
    """

  Scénario: modification d'une part de propriété

    Etant donnée la modification d'une Part de propriété 16-16-pp : part 1/1, nouvelle personne 100.000.002

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
        - {fraction: 1/1, personne: Newton Isaac}
    """

  Scénario: Supression d'une part de propriété

    Etant donnée la suppression d'une Part de propriété 16-16-pp

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts: []
    """
