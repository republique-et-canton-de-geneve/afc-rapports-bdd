#language: fr
Fonctionnalité: prévisualisation btl

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
          parts: [{identifier: 16-16-pp, personne: *personne_1}]
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

  Scénario: Ajout d'un btl

    Etant donnée la création d'un btl sur la parcelle 16-16 : numéro btl "btl1"

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      btls: [{identifier: 16-16-btl1}]
      parts: [{fraction: 1/1, personne: Currie Marie}]
    """

  Scénario: modification d'un btl

    Etant donnée la création d'un btl sur la parcelle 16-16 : numéro btl "btl1"
    Etant donnée la modification du btl 16-16-btl1 : commentaire "test"

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      btls: [{identifier: 16-16-btl1, observation: test}]
      parts: [{fraction: 1/1, personne: Currie Marie}]
    """


  Scénario: Supression d'un btl

    Etant donnée la création d'un btl sur la parcelle 16-16 : numéro btl "btl1"
    Etant donnée la suppression du btl 16-16-btl1

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      btls: []
      parts: [{fraction: 1/1, personne: Currie Marie}]
    """
