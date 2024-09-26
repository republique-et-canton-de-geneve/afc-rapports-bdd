#language: fr
Fonctionnalité: suppression questionnaire standard

  Contexte:
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        surface: 1000
        constructions:
          - &construction1 { identifier: 16-16-cst1, no: cst1 }
        parts:
          - identifier: 16-16-pp1
            personne: *personne_1
            valeurTerrains:
              - identifier: 16-16-vt1
                prix: 20000
            valeurBatiments:
              - identifier: 16-16-vb1
                constructions: [ *construction1 ]
                prix: 1000
    """
    Etant donné un Questionnaire détaillé 16-16-qd1 sur la parcelle 16-16 : construction 16-16-construction, surface habitable 50

  Scénario: cas nominal
    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de suppression de questionnaire standard à la date 01.01.2020
    Etant donné que le questionnaire 16-16-qd1 est concernée par la suppression de questionnaire standard

    Alors il y a 0 message d'erreur sur l'opération
    Quand l'opération de suppression de questionnaire standard est previsualisée

    Alors sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      questionnaires: []
    """

    Alors il y a 0 message d'erreur sur l'opération
    Quand l'opération de suppression de questionnaire standard est validée
    Alors il n'y a pas d'erreur lors de la publication de la session