#language: fr
Fonctionnalité: Suppression d'une construction présente sous d'autres objets

  Scénario: Supression d'une construction présente également sous un EL. L'EL est supprimé également

    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Currie, prenom: Marie }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        constructions: [{ identifier: 16-16-construction, no: A1 }]
        parts:
          - identifier: 16-16-pp
            personne: *personne_1
            valeurEtatLocatifs:
              - identifier: 16-16-vel
                construction: { identifier: 16-16-construction, no: A1 }
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

    Etant donnée la suppression de la construction 16-16-construction

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier : 16-16
      constructions : []
      parts:
        - identifier: 16-16-pp
          valeurEtatLocatifs: []
    """


  Scénario: Supression d'une construction présente sous une valeur batiment avec une seule construction. La valeur batiment est supprimé également

    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Currie, prenom: Marie }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        constructions: [{ identifier: 16-16-construction, no: A1 }]
        parts:
          - identifier: 16-16-pp
            personne: *personne_1
            valeurBatiments:
              - identifier: 16-16-vb
                constructions: [{ identifier: 16-16-construction, no: A1 }]
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

    Etant donnée la suppression de la construction 16-16-construction

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier : 16-16
      constructions : []
      parts:
        - identifier: 16-16-pp
          valeurBatiments: []
    """


  Scénario: Supression d'une construction présente sous une valeur batiment ayant plusieurs constructions. La valeur batiment n'est donc pas supprimé

    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Currie, prenom: Marie }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        constructions: [{ identifier: 16-16-construction, no: A1 }, { identifier: 16-16-construction2, no: B2 }]
        parts:
          - identifier: 16-16-pp
            personne: *personne_1
            valeurBatiments: [{ identifier: 16-16-vb, constructions: [{ identifier: 16-16-construction, no: A1 }, { identifier: 16-16-construction2, no: B2 }]}]
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

    Etant donnée la suppression de la construction 16-16-construction

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier : 16-16
      constructions : [{identifier: 16-16-construction2}]
      parts:
        - identifier: 16-16-pp
          valeurBatiments: [{constructions: [{identifier: 16-16-construction2}]}]
    """


  Scénario: Supression d'une construction présente sous un questionnaire. Le questionnaire est donc supprimé

    Etant donné le reférentiel
    """yaml
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        constructions: [{ identifier: 16-16-construction, no: A1 }]
    """

    Etant donné un Questionnaire détaillé 16-16-qd1 sur la parcelle 16-16 : construction 16-16-construction, surface habitable 50
    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

    Etant donnée la suppression de la construction 16-16-construction

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier : 16-16
      constructions : []
      questionnaires: []
    """