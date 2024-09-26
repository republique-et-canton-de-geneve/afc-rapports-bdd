#language: fr
Fonctionnalité: Valider le rapport de travail pour un salarié

  Scénario: Valider un rapport de travail vide
    Etant donné un rapport de travail vide
    Quand l'utilisateur fait valider ce rapport de travail
    Alors on lui indique que ce rapport de travail est valide

  Plan du scénario: <Test> : valider un rapport de travail avec un taux d'activité (<Observation>)
    Etant donné un rapport de travail avec un taux d'activité de <Taux>%
    Quand l'utilisateur fait valider ce rapport de travail
    Alors on lui indique que ce rapport de travail est <Résultat>

    Exemples:
      | Test | Taux   | Résultat | Observation             |
      | 1    | 10     | valide   | limite basse            |
      | 2    | 100    | valide   | limite haute            |
      | 3    | 33.33  | valide   | cas avec 2 décimales    |
      | 4    | -1     | invalide | Taux négatif            |
      | 5    | 9      | invalide | Taux inférieur à 10     |
      | 6    | 100.10 | invalide | Taux supérieur à 100    |
      | 7    | 101    | invalide | Taux supérieur à 100    |
      | 8    | 33.333 | invalide | Pas plus de 2 décimales |

  Scénario: Valider un rapport de travail avec des périodes valides, dont la première et la dernière avec une seule borne
    Etant donné que la date du jour est 05.08.2021
    Et l´année fiscale de la déclaration est 2021
    Et un rapport de travail avec les périodes d'activité dans l'ordre suivant :
      | Début      | Fin        |
      | 03.04.2021 |            |
      | 01.02.2021 | 28.02.2021 |
      |            | 25.01.2021 |
    Quand l'utilisateur fait valider ce rapport de travail
    Alors on lui indique que ce rapport de travail est valide

  Scénario: Valider un rapport de travail avec des périodes valides, dont la plus récente est dans le futur mais sur le mois en cours
    Etant donné que la date du jour est 22.08.2022
    Et l´année fiscale de la déclaration est 2022
    Et un rapport de travail avec les périodes d'activité dans l'ordre suivant :
      | Début      | Fin        |
      | 07.08.2022 | 31.08.2022 |
      | 03.03.2022 | 03.03.2022 |
      | 15.02.2022 | 22.02.2022 |
      |            | 31.01.2022 |
    Quand l'utilisateur fait valider ce rapport de travail
    Alors on lui indique que ce rapport de travail est valide

  Scénario: Valider un rapport de travail avec des périodes valides, dont la plus récente est dans le futur mais pas sur le mois en cours
    Etant donné que la date du jour est 22.08.2022
    Et l´année fiscale de la déclaration est 2022
    Et un rapport de travail avec les périodes d'activité dans l'ordre suivant :
      | Début      | Fin        |
      | 07.08.2022 | 31.10.2022 |
      | 03.03.2022 | 03.03.2022 |
      | 15.02.2022 | 22.02.2022 |
      |            | 31.01.2022 |
    Quand l'utilisateur fait valider ce rapport de travail
    Alors on lui indique que ce rapport de travail est valide


  Scénario: Valider un rapport de travail dont la seule période de travail n'a pas de date de début et fini dans le futur
    Etant donné que la date du jour est 22.08.2022
    Et l´année fiscale de la déclaration est 2021
    Et un rapport de travail avec les périodes d'activité dans l'ordre suivant :
      | Début | Fin        |
      |       | 31.12.2022 |
    Quand l'utilisateur fait valider ce rapport de travail
    Alors on lui indique que ce rapport de travail est valide

  Plan du scénario: Valider un rapport de travail avec une période d'activité invalide (<Test> -> <Observation>)
    Etant donné que la date du jour est 22.08.2022
    Et l´année fiscale de la déclaration est 2022
    Et un rapport de travail avec une période d'activité du <Début> au <Fin>
    Quand l'utilisateur fait valider ce rapport de travail
    Alors on lui indique qu'il ne peut pas renseigner <Erreur>
    Exemples:
      | Test | Début      | Fin        | Erreur                                                | Observation                              |
      | 1    | 06.10.2022 |            | une date après la fin du mois                         | Date de début dans le futur              |
      | 2    | 01.09.2022 |            | une date après la fin du mois                         | Date de début dans le futur (cas limite) |
      | 3    |            |            | une période vide                                      | Il faut au moins une date                |
      | 4    | 31.08.2022 | 07.08.2022 | une date début postérieure à la date de fin           | Il faut début <= fin                     |
      | 5    | 01.11.2021 | 31.12.2021 | une date de fin antérieure à l'année fiscale de la LR | Il faut fin >= année fiscale LR          |

  Plan du scénario: Valider un rapport de travai avec une période d'activité invalide pour LR 2021 saisie en 2022  (<Test> -> <Observation>)
    Etant donné que la date du jour est 22.08.2022
    Et l´année fiscale de la déclaration est 2021
    Et un rapport de travail avec une période d'activité du <Début> au <Fin>
    Quand l'utilisateur fait valider ce rapport de travail
    Alors on lui indique qu'il ne peut pas renseigner une date de début supérieure à l'année fiscale de la LR
    Exemples:
      | Test | Début      | Fin        | Erreur                                                  | Observation                              |
      | 1    | 01.07.2022 |            | une date de début supérieure à l'année fiscale de la LR | Il faut debut <= année fiscale LR        |

  Plan du scénario: Valider un rapport de travail avec des périodes qui se recoupent (<Test>)
    Etant donné que la date du jour est 05.08.2021
    Et l´année fiscale de la déclaration est 2021
    Et un rapport de travail avec une période d'activité du <Début1> au <Fin1>
    Et ce rapport de travail avec une période d'activité du <Début2> au <Fin2>
    Et ce rapport de travail avec une période d'activité du <Début3> au <Fin3>
    Quand l'utilisateur fait valider ce rapport de travail
    Alors on lui indique que les périodes <Périodes en erreur> se recoupent

    Exemples:
      | Test | Début1     | Fin1       | Début2     | Fin2       | Début3     | Fin3       | Périodes en erreur |
      | 1    | 01.03.2021 | 31.03.2021 | 01.02.2021 |            | 01.01.2021 | 28.02.2021 | 1, 2 et 3          |
      | 2    | 01.03.2021 | 31.03.2021 | 02.02.2021 | 28.02.2021 | 01.02.2021 |            | 1, 2 et 3          |
      | 3    | 02.02.2021 | 31.03.2021 | 02.02.2021 | 28.02.2021 | 01.02.2021 |            | 1, 2 et 3          |
      | 4    | 01.03.2021 | 31.03.2021 | 01.02.2021 |            | 01.01.2021 | 31.01.2021 | 1 et 2             |
      | 5    | 01.03.2021 | 31.03.2021 | 01.01.2021 |            |            | 31.01.2021 | 1, 2 et 3          |
      | 6    | 01.03.2021 | 31.03.2021 | 01.01.2021 | 15.01.2021 |            | 31.01.2021 | 2 et 3             |

  Plan du scénario: Valider un rapport de travail avec une période d'activité dont la date du jour est avant le 22 du
  mois courant et la date de début est dans le mois courant (<Test> -> <Observation>)
    Etant donné que la date du jour est <Date du jour>
    Et l´année fiscale de la déclaration est 2021
    Et un rapport de travail avec une période d'activité du <Début> au <Fin>
    Quand l'utilisateur fait valider ce rapport de travail
    Alors on lui indique qu'il ne peut pas renseigner <Erreur>
    Exemples:
      | Test | Date du jour | Début      | Fin | Erreur                                                          | Observation                                                          |
      | 1    | 10.02.2021   | 02.02.2021 |     | une date dans le mois courant tant que celui-ci n'est pas actif | Date du jour avant le 22 donc Février pas encore actif.              |
      | 2    | 21.02.2021   | 23.02.2021 |     | une date dans le mois courant tant que celui-ci n'est pas actif | Date du jour avant le 22 donc Février pas encore actif (cas limite). |

  Plan du scénario: Valider un rapport de travail avec une période d'activité dont la date du jour est après le 21 du
  mois courant et la date de début est dans le mois courant(<Test> -> <Observation>)
    Etant donné que la date du jour est <Date du jour>
    Et l´année fiscale de la déclaration est 2021
    Et un rapport de travail avec une période d'activité du <Début> au <Fin>
    Quand l'utilisateur fait valider ce rapport de travail
    Alors on lui indique que ce rapport de travail est valide
    Exemples:
      | Test | Date du jour | Début      | Fin | Observation                                  |
      | 1    | 22.02.2021   | 02.02.2021 |     | Date du jour le 22 donc Février actif.       |
      | 2    | 28.02.2021   | 23.02.2021 |     | Date du jour après le 22 donc Février actif. |
