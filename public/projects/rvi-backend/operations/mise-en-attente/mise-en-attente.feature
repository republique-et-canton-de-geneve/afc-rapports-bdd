#language: fr
Fonctionnalité: mise en attente

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
        surface: 1000
        parts:
          - identifier: 16-16-pp
            fraction: 1/1
            personne: *personne_1
            valeurTerrains: [ { identifier: 16-16-vt, prix: 20000, surface: 1000 } ]
    """

  Scénario: creation d'une mise en attente
    Etant donnée une mise en attente pour la personne d'id 1, le numero de volume par defaut et la date d'acte 01.01.2020
    Alors les mises en attente pour la personne 100.000.001 et la date 01.01.2020 sont
      | 01.01.2020 | N2010/1/1 | utilisateur |
    Alors les mises en attente pour la personne 100.000.001 et la date 02.01.2020 sont
      | 01.01.2020 | N2010/1/1 | utilisateur |
    Et il n'existe pas de mise en attente pour la personne 100.000.001 et la date 01.01.2019

  Scénario: suppression apres pulication d'une mise en attente
    Etant donnée une mise en attente pour la personne d'id 1, le numero de volume par defaut et la date d'acte 01.01.2020

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération mutation libre à la date d'estimation 01.06.2020
    Alors il y a 0 message d'erreur sur l'opération

    Etant donné que l'opération de mutation libre est validée
    Alors il n'y a pas d'erreur lors de la publication de la session
    Alors il n'existe pas de mise en attente pour la personne 100.000.001 et la date 01.01.2020
    Alors il existe un evenement de fin de mise en attente pour la personne 1

