#language: fr
Fonctionnalité: prévisualisation batiment

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
              valeurBatiments: [{identifier: 16-16-vb, prix: 40000}]
    """
    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

  Scénario: Ajout d'une valeur batiment

    Etant donnée l'ajout d'une valeur batiment sur la part 16-16-pp de valeur estimée 10 000 le 01.01.2015


    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - personne: Currie Marie
        valeurBatiments:
        - prix: 40000.0
        - prix: 10000.0
    """

  Scénario: Suppression d'une valeur batiment

    Etant donnée la suppression d'une valeur batiment 16-16-vb

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - personne: Currie Marie
        valeurBatiments: []
    """

  Scénario: Modification d'une valeur batiment

    Etant donnée la modification de la valeur batiment 16-16-vb avec valeur estimée 2 000 le 01.01.2018

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - personne: Currie Marie
        valeurBatiments:
        - prix: 2000.0
    """