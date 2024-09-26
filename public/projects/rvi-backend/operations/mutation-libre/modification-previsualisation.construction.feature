#language: fr
Fonctionnalité: prévisualisation construction

  Contexte:
    Etant donné le reférentiel
    """yaml
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        constructions: [{ identifier: 16-16-construction, no: A1 }]
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

  Scénario: Ajout d'une construction

    Etant donnée la création d'une construction depuis l'objet Parcelle 16-16 : numéro de construction "A2"

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier : 16-16
      constructions : [ { numConstruction: A1},{numConstruction: A2}]
    """


  Scénario: modification d'une construction

    Etant donnée la modification de la construction 16-16-construction : numéro de construction "B1"

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier : 16-16
      constructions : [ { numConstruction: B1}]
    """

  Scénario: Supression d'un construction

    Etant donnée la suppression de la construction 16-16-construction

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier : 16-16
      constructions : []
    """


