#language: fr
Fonctionnalité: prévisualisation questionnaire agricole

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

  Scénario: Ajout d'un questionnaire agricole
    Etant donné la création d'un Questionnaire agricole sur l'objet Parcelle 16-16 : construction 16-16-c1

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      questionnaires:
      - typeQuestionnaire: Agricole
        identifierConstruction: 16-16-c1
    """

  Scénario: modification d'un questionnaire agricole
    Etant donné la création d'un Questionnaire agricole sur l'objet Parcelle 16-16 : construction 16-16-c1
    Etant donné la modification d'un Questionnaire agricole 16-16-questionnaire-1 : construction 16-16-c2

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      questionnaires:
      - typeQuestionnaire: Agricole
        identifierConstruction: 16-16-c2
    """


  Scénario: Suppression d'un questionnaire agricole
    Etant donné la création d'un Questionnaire agricole sur l'objet Parcelle 16-16 : construction 16-16-c1
    Etant donné la suppression d'un Questionnaire agricole 16-16-questionnaire-1

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      questionnaires: []
    """

