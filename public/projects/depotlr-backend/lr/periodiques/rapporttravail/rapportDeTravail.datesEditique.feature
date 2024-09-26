#language: fr
Fonctionnalité: Tester que les dates de début/fin d'une attestation quittance sont correctement déduites pour un mois donné étant donné des périodes d'activité

  Règle: Les dates de début et fin d'une attestation quittance pour un mois donné correspondent respectivement 
  au premier jour actif et au dernier jour actif dans le mois.
  Par exemple, si la personne est active tout le mois alors la date de début sera le 1er du mois et la date de fin le dernier jour du mois.

    Plan du scénario: Obtenir les dates de début et fin pour l'attestation quittance pour un mois donnée selon les périodes d'activités définies (<Test> -> <Observation>)
      Etant donné que la date du jour est 13.06.2021
      Et l´année fiscale de la déclaration est 2021
      Et un rapport de travail avec les périodes d'activité dans l'ordre suivant :
        | Début      | Fin        |
        | 10.01.2021 | 15.06.2021 |
      Quand l'utilisateur demande les dates de début et fin pour l'attestation quittance pour le mois <mois>
      Alors l'attestation quittance affiche les dates du <Début> au <Fin> pour ce mois
      Exemples:
        | Test | mois    | Début      | Fin        | Observation                                                                            |
        | 1    | Janvier | 10.01.2021 | 31.01.2021 | Mois de Janvier : Date de début reprise et date de fin calculé au dernier jour du mois |
        | 2    | Février | 01.02.2021 | 28.02.2021 | Mois de Février : Les dates de début/fin sont au premier/dernier jour du mois          |
        | 3    | Mars    | 01.03.2021 | 31.03.2021 | Mois de Mars : Les dates de début/fin sont au premier/dernier jour du mois             |
        | 4    | Avril   | 01.04.2021 | 30.04.2021 | Mois de Avril :Les dates de début/fin sont au premier/dernier jour du mois             |
        | 5    | Mai     | 01.05.2021 | 31.05.2021 | Mois de Mai : Les dates de début/fin sont au premier/dernier jour du mois              |
        | 6    | Juin    | 01.06.2021 | 15.06.2021 | Mois de Juin : La date de début est mise au 1 et la da de fin est reprise              |
      
    Plan du scénario: Obtenir les dates de début et fin pour l'attestation quittance pour un mois donnée selon les périodes d'activités définies pour une année bissextile (<Test> -> <Observation>)
      Etant donné que la date du jour est 20.08.2024
      Et l´année fiscale de la déclaration est 2024
      Et un rapport de travail avec les périodes d'activité dans l'ordre suivant :
        | Début      | Fin        |
        | 10.01.2024 | 15.03.2024 |
      Quand l'utilisateur demande les dates de début et fin pour l'attestation quittance pour le mois <mois>
      Alors l'attestation quittance affiche les dates du <Début> au <Fin> pour ce mois
      Exemples:
        | Test | mois    | Début      | Fin        | Observation                                                                            |
        | 1    | Janvier | 10.01.2024 | 31.01.2024 | Mois de Janvier : Date de début reprise et date de fin calculé au dernier jour du mois |
        | 2    | Février | 01.02.2024 | 29.02.2024 | Mois de Février : avec 29 jours                                                        |
        | 3    | Mars    | 01.03.2024 | 15.03.2024 | Mois de Mars : Date de début mise au premier du mois, date fin reprise                 |

    Plan du scénario: Obtenir les dates de début et fin pour un mois donnée selon les périodes d'activités définies (<Test> -> <Observation>)
      Etant donné que la date du jour est 20.08.2021
      Et l´année fiscale de la déclaration est 2021
      Et un rapport de travail avec les périodes d'activité dans l'ordre suivant :
        | Début      | Fin        |
        | 05.12.2020 | 14.01.2021 |
        | 15.01.2021 | 22.01.2021 |
        | 18.02.2021 | 23.02.2021 |
        | 02.02.2021 | 04.02.2021 |
        | 05.02.2021 | 09.02.2021 |
        | 05.03.2021 | 31.03.2021 |
        | 02.03.2021 | 03.03.2021 |

      Quand l'utilisateur demande les dates de début et fin pour l'attestation quittance pour le mois <mois>
      Alors l'attestation quittance affiche les dates du <Début> au <Fin> pour ce mois
      Exemples:
        | Test | mois    | Début      | Fin        | Observation                                                                                                               |
        | 1    | Janvier | 01.01.2021 | 22.01.2021 | Mois de Janvier : Date de début avant année fiscale + une autre date de début en Janvier, date de début mise au 1 Janvier |
        | 2    | Février | 02.02.2021 | 23.02.2021 | Mois de Février : La da de début la plus petite est reprise, la date de fin la plus grande est reprise                    |
        | 3    | Mars    | 02.03.2021 | 31.03.2021 | Mois de Mars : La date de début la plus petite est reprise, la date de fin la plus grande est reprise                     |

    Plan du scénario: Obtenir les dates de début et fin pour un mois donnée sans aucune période d'activité définie (<Test> -> <Observation>)
      Etant donné que la date du jour est 20.08.2021
      Et l´année fiscale de la déclaration est 2021
      Et un rapport de travail avec les périodes d'activité dans l'ordre suivant :
        | Début | Fin |
      Quand l'utilisateur demande les dates de début et fin pour l'attestation quittance pour le mois <mois>
      Alors l'attestation quittance affiche les dates du <Début> au <Fin> pour ce mois
      Exemples:
        | Test | mois    | Début      | Fin        | Observation                                               |
        | 1    | Janvier | 01.01.2021 | 31.01.2021 | Mois de Janvier: Les dates sont au 1er et dernier du mois |
        | 2    | Février | 01.02.2021 | 28.02.2021 | Mois de Février: Les dates sont au 1er et dernier du mois |

    Plan du scénario: Obtenir les dates de début et fin pour un mois donnée avec une seule période d'activité qui démarre l'année fiscale - 1 (<Test> -> <Observation>)
      Etant donné que la date du jour est 20.08.2021
      Et l´année fiscale de la déclaration est 2021
      Et un rapport de travail avec les périodes d'activité dans l'ordre suivant :
        | Début      | Fin |
        | 01.11.2020 |     |
      Quand l'utilisateur demande les dates de début et fin pour l'attestation quittance pour le mois <mois>
      Alors l'attestation quittance affiche les dates du <Début> au <Fin> pour ce mois
      Exemples:
        | Test | mois    | Début      | Fin        | Observation                                               |
        | 1    | Janvier | 01.01.2021 | 31.01.2021 | Mois de Janvier: Les dates sont au 1er et dernier du mois |
        | 2    | Février | 01.02.2021 | 28.02.2021 | Mois de Février: Les dates sont au 1er et dernier du mois |
    
  
