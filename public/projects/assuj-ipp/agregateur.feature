#language: fr
Fonctionnalité: Agrégateur des données pour les critères des assuj IPP

  Règle: Récupérer le critère 'majorité' à partir du 31 Décembre de l'année fiscale en cours

    Plan du Scénario: Agréger la majorité - <Test> -> <Observation>
      Etant donné que la date du jour est le <Date du jour>
      Et que le registre fiscal contient la personne avec le NumeroR 1
      Et que sa date de naissance est le <Date de naissance>
      Lorsque le système des Assuj IPP agrège les données pour la personne de NumeroR 1 à la date du jour
      Alors les critères d'entrée pour calculer l'assujettissement sont : NumeroR = 1
      Et majorité = <Majorité>
      Exemples:
        | Test | Date du jour | Date de naissance | Majorité | Observation                          |
        | 1    | 01.02.2022   | 21.01.1984        | MAJEUR   | Personne majeure                     |
        | 2    | 01.02.2022   | 21.01.2005        | MINEUR   | Personne mineure                     |
        | 3    | 01.02.2022   |                   | INCONNU  | Personne sans date de naissance      |
        | 4    | 01.01.2018   | 10.07.2000        | MAJEUR   | Personne majeure à la fin de l'année |

  Règle: Récupérer le critère 'type de résidence'
  - ETRANGER : Résidence du RF = ETRANGER
  - GENEVE_SEJOUR : Résidence du RF = GENEVE et Permis du RF = SEJOUR
  - GENEVE_ETABLI : Résidence du RF = GENEVE et Permis du RF = ETABLI
  - SUISSE_HORS_GENEVE : Résidence du RF = SUISSE_HORS_GENEVE
  - INCONNU : Dans les autres cas

    Plan du Scénario: Agréger le type de résidence - <Test> -> <Observation>
      Etant donné que la date du jour est le 15.04.2021
      Et que le registre fiscal contient la personne avec le NumeroR 1
      Et que sa résidence est <Résidence du RF>
      Et que son permis est <Permis du RF>
      Lorsque le système des Assuj IPP agrège les données pour la personne de NumeroR 1 à la date du jour
      Alors les critères d'entrée pour calculer l'assujettissement sont : NumeroR = 1
      Et type de résidence = <Type de residence attendu>
      Exemples:
        | Test | Résidence du RF    | Permis du RF | Type de residence attendu | Observation                                    |
        | 1    | ETRANGER           | AUTRE        | ETRANGER                  | Personne avec une résidence ETRANGER           |
        | 2    | GENEVE             | SEJOUR       | GENEVE_SEJOUR             | Personne avec une résidence GENEVE_SEJOUR      |
        | 3    | GENEVE             | ETABLI       | GENEVE_ETABLI             | Personne avec une résidence GENEVE_ETABLI      |
        | 4    | SUISSE_HORS_GENEVE | ETABLI       | SUISSE_HORS_GENEVE        | Personne avec une résidence SUISSE_HORS_GENEVE |
        | 5    | INCONNU            | ETABLI       | INCONNU                   | Personne avec une résidence INCONNU            |
        | 6    | GENEVE             | INCONNU      | INCONNU                   | Personne avec une résidence INCONNU            |

  Règle: Récupérer le critere 'EtatVital'

    Plan du Scénario: Agréger le critère état vital - <Test> -> <Observation>
      Etant donné que la date du jour est le 15.04.2021
      Et que le registre fiscal contient la personne avec le NumeroR 1
      Et que son état vital est <Etat vital du RF>
      Lorsque le système des Assuj IPP agrège les données pour la personne de NumeroR 1 à la date du jour
      Alors les critères d'entrée pour calculer l'assujettissement sont : NumeroR = 1
      Et vivante = <Vivant attendu>
      Exemples:
        | Test | Etat vital du RF | Vivant attendu | Observation                 |
        | 1    | VIVANT           | VIVANT         | Personne vivante dans le RF |
        | 2    | DECEDE           | DECEDE         | Personne décédée dans le RF |

  Règle: Récupérer le critère 'sources de revenus'
  - ACTIVITE_DEPENDANTE : Activité du RF = AVEC et Statut indépendant du RF est AUCUN
  - AUTRE : Activité du RF = AVEC et Statut indépendant du RF est parmis (INDEPENDANT, ASSOCIE, MARAICHER, PROMOTEUR_IMMOBILIER)
  - AUTRE : Staut propriétaire du RF = PROPRIETAIRE

    Plan du Scénario: Agréger le critère sources de revenus - <Test> -> <Observation>
      Etant donné que la date du jour est le 15.04.2021
      Et que le registre fiscal contient la personne avec le NumeroR 1
      Et que son activite est <Activite du RF>
      Et que son statut indépendant est <Statut independant du RF>
      Et que son statut propriétaire est <Statut proprietaire du RF>
      Lorsque le système des Assuj IPP agrège les données pour la personne de NumeroR 1 à la date du jour
      Alors les critères d'entrée pour calculer l'assujettissement sont : NumeroR = 1
      Et sources de revenus = <Sources de revenus attendues>
      Exemples:
        | Test | Activite du RF | Statut independant du RF | Statut proprietaire du RF | Sources de revenus attendues | Observation                                                         |
        | 1    | SANS           | AUCUN                    | NON_PROPRIETAIRE          | AUCUNE                       | Personne sans source de revenus                                     |
        | 2    | AVEC           | INDEPENDANT              | NON_PROPRIETAIRE          | ACTIVITE_DEPENDANTE, AUTRE   | Personne avec une activité dépendante et indépendante               |
        | 3    | AVEC           | AUCUN                    | NON_PROPRIETAIRE          | ACTIVITE_DEPENDANTE          | Personne avec une activité dépendante                               |
        | 4    | AVEC           | AUCUN                    | PROPRIETAIRE              | ACTIVITE_DEPENDANTE, AUTRE   | Personne propriétaire avec une activité dépendante                  |
        | 5    | AVEC           | INDEPENDANT              | PROPRIETAIRE              | ACTIVITE_DEPENDANTE, AUTRE   | Personne propriétaire avec une activité dépendante et indépendante  |
        | 6    | ETUDIANT       | AUCUN                    | PROPRIETAIRE              | ACTIVITE_DEPENDANTE, AUTRE   | Personne propriétaire avec une activité dépendante                  |
        | 7    | AVEC           | INCONNU                  | PROPRIETAIRE              | ACTIVITE_DEPENDANTE, AUTRE   | Personne propriétaire avec une activité dépendante                  |
        | 8    | AVEC           | INCONNU                  | NON_PROPRIETAIRE          | ACTIVITE_DEPENDANTE          | Personne avec une activité dépendante                               |

  Règle: Récupérer le critère 'revenu'

    Plan du Scénario: Agréger le critère revenu - <Test> -> <Observation>
      Etant donné que la date du jour est le 15.04.2021
      Et que la personne avec le NumeroR 1 existe dans RIS
      Et que son revenu est de <Revenus de RIS>
      Lorsque le système des Assuj IPP agrège les données pour la personne de NumeroR 1 à la date du jour
      Alors les critères d'entrée pour calculer l'assujettissement sont : NumeroR = 1
      Et revenu = <Revenu attendus>
      Exemples:
        | Test | Revenus de RIS | Revenu attendus | Observation                       |
        | 1    | 110000         | 110000          | Personne avec un revenu de 110000 |
        | 2    | 120000         | 120000          | Personne avec un revenu de 120000 |
        | 3    | 0              | 0               | Personne avec un revenu de 0      |

  Règle: Récupérer le critère 'demande TOU'

    Plan du Scénario: Agréger le critère demande TOU - <Test> -> <Observation>
      Etant donné que la date du jour est le 15.04.2021
      Et que la personne avec le NumeroR 1 existe dans RIS
      Et que la demande TOU dans ris est <Demande TOU de RIS>
      Lorsque le système des Assuj IPP agrège les données pour la personne de NumeroR 1 à la date du jour
      Alors les critères d'entrée pour calculer l'assujettissement sont : NumeroR = 1
      Et Demande tou = <Demande TOU attendus>
      Exemples:
        | Test | Demande TOU de RIS | Demande TOU attendus | Observation                   |
        | 1    | AUCUNE             | AUCUNE               | Personne avec une demande TOU |
        | 2    | ROLEORDINAIRE      | ROLEORDINAIRE        | Personne sans demande TOU     |

    Scénario: Récupérer le conjoint

      Etant donné que la date du jour est le 15.04.2021
      Et que la personne avec le NumeroR 1 existe dans RIS
      Et que la personne avec le NumeroR 2 existe dans RIS
      Lorsque le système des Assuj IPP agrège les données pour la personne de NumeroR 1 et de conjoint de NumeroR 2 à la date du jour
      Alors les critères d'entrée pour calculer l'assujettissement sont : NumeroR = 1 et conjoint NumeroR = 2
