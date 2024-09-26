#language: fr
Fonctionnalité: Ne pas modifier avant d'avoir créé

  Contexte:
    Etant donné le reférentiel
    """yaml
      personnes:
        - &personne_1 { id: 1, ref: 100.000.001, nom: Currie, prenom: Marie }
      mutations:
        - &mut_01_01_2010 { dateValeur: 01.01.2010 }
        - &mut_01_01_2022 { dateValeur: 01.01.2022 }
      parcelles:
        - identifier: 16-16
          mutationDebut: *mut_01_01_2010
          parts:
            - identifier: 16-16-pp
              personne: *personne_1
              valeurBatiments: [{identifier: 16-16-vb, prix: 40000, mutationDebut: *mut_01_01_2022}]
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.02.2020

  Scénario: suppression d'une valeur batiment
    Etant donnée la suppression d'une valeur batiment 16-16-vb
    Alors il existe un message d'erreur "Un objet de type valeur batiment avec début de validité (01.01.2022) ne peut être historisé le (01.02.2020)" sur l'opération
