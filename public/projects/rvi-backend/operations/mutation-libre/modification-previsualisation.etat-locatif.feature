#language: fr
Fonctionnalité: prévisualisation état locatif

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
              valeurEtatLocatifs:
                - identifier: 16-16-vel
    """


    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

  Scénario: Ajout d'une valeur etat locatif

    Etant donné l'ajout d'une valeur etat locatif sur la part 16-16-pp avec affectation preponderante 1 pour l'annee 2021 et de nature construction cat box prix achat 20 000

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - valeurEtatLocatifs:
        - montant: 10000.0
        - montant: 20000.0
    """

  Scénario: Modification d'une valeur etat locatif

    Etant donné la modification de la valeur etat locative 16-16-vel pour le montant 15 000 affectation 1 annee 2022 nature construction

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - valeurEtatLocatifs:
        - montant: 15000.0
    """

  Scénario: Suppression d'une valeur etat locatif

    Etant donné la supression d'une valeur etat locative 16-16-vel

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - valeurEtatLocatifs: []
    """
