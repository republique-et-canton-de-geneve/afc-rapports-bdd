#language: fr
Fonctionnalité: prévisualisation lot rf

  Contexte:
    Etant donné le reférentiel
    """yaml
      mutations:
        - &mut_01_01_2010 { dateValeur: 01.01.2010 }
      parcelles:
        - identifier: 16-16
          mutationDebut: *mut_01_01_2010
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

  Scénario: Ajout d'un lot rf

    Etant donnée la création d'un Ppe sur l'objet Parcelle 16-16 : millieme 1000.0
    Etant donnée la création d'un lot Rf sur le ppe 16-16-1 : numéro de lot Rf 1

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      ppes:
      - identifier: 16-16-1
        lotRF: [{identifier: 16-16-lotRf-1}]
    """


  Scénario: modification d'un lot rf

    Etant donnée la création d'un Ppe sur l'objet Parcelle 16-16 : millieme 1000.0
    Etant donnée la création d'un lot Rf sur le ppe 16-16-1 : numéro de lot Rf 1
    Etant donnée la modification d'un lot Rf 16-16-lotRf-1 : numéro de lot Rf 10


    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      ppes:
      - identifier: 16-16-1
        lotRF:
          - identifier: 16-16-lotRf-1
            numeroLot: 10
    """


  Scénario: Supression d'un lot rf

    Etant donnée la création d'un Ppe sur l'objet Parcelle 16-16 : millieme 1000.0
    Etant donnée la création d'un lot Rf sur le ppe 16-16-1 : numéro de lot Rf 1
    Etant donnée la suppression d'un lot Rf 16-16-lotRf-1


    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      ppes:
      - identifier: 16-16-1
        lotRF: []
    """

