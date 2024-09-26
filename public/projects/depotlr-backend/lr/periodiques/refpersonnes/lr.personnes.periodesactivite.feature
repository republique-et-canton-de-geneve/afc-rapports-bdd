#language: fr
Fonctionnalité: Vérification si personne est active pour un mois donné selon ses périodes d'activités

  Contexte:
    Etant donné que l´année fiscale de la déclaration est 2021
    Etant donné qu'un salarié complet est initialisé

  Plan du scénario: Vérification si personne est active pour un mois donné selon ses périodes d'activités (seulement date de début renseignés)  <Test> -> <Observation> => <Etat>
    Et que la personne est en activité du <Début> au <Fin>
    Quand je vérifie si la personne est active le mois de <Mois>
    Alors je constate qu'elle est <Etat>
    Exemples:
      | Test | Début      | Fin | Mois     | Etat     | Observation                                         |
      | 1    | 01.02.2021 |     | Février  | Active   | Au moins un jour de période d'activité pour le mois |
      | 2    | 28.02.2021 |     | Février  | Active   | Au moins un jour de période d'activité pour le mois |
      | 3    | 01.03.2021 |     | Février  | Inactive | Mois avant date de début de période d'activité      |
      | 4    | 01.02.2022 |     | Février  | Inactive | Date de début pas dans la même année fiscale        |
      | 5    | 01.02.2021 |     | Décembre | Active   | Mois après date de début sans date de fin           |

  Plan du scénario: Vérification si personne est active pour un mois donné selon ses périodes d'activités (seulement date de fin renseignée)  <Test> -> <Observation> => <Etat>
    Et que la personne est en activité du <Début> au <Fin>
    Quand je vérifie si la personne est active le mois de <Mois>
    Alors je constate qu'elle est <Etat>
    Exemples:
      | Test | Début | Fin        | Mois    | Etat     | Observation                                         |
      | 1    |       | 31.01.2021 | Janvier | Active   | Au moins un jour de période d'activité pour le mois |
      | 2    |       | 31.01.2021 | Février | Inactive | Aucun jour de période d'activité pour le mois       |
      | 3    |       | 31.12.2021 | Février | Active   | Au moins un jour de période d'activité pour le mois |
      | 4    |       | 01.02.2021 | Février | Active   | Au moins un jour de période d'activité pour le mois |


  Plan du scénario: Vérification si personne est active pour un mois donné selon ses périodes d'activités (avec date de début et fin renseignées ou aucune renseigné)  <Test> -> <Observation> => <Etat>
    Et que la personne est en activité du <Début> au <Fin>
    Quand je vérifie si la personne est active le mois de <Mois>
    Alors je constate qu'elle est <Etat>
    Exemples:
      | Test | Début      | Fin        | Mois    | Etat     | Observation                                         |
      | 1    | 01.01.2021 | 31.01.2021 | Janvier | Active   | Au moins un jour de période d'activité pour le mois |
      | 2    | 01.01.2021 | 31.01.2021 | Février | Inactive | Aucun jour de période d'activité pour le mois       |
      | 3    | 01.01.2021 | 31.12.2021 | Février | Active   | Au moins un jour de période d'activité pour le mois |
      | 4    | 01.01.2020 | 31.12.2021 | Février | Active   | Au moins un jour de période d'activité pour le mois |
      | 5    |            |            | Février | Active   | Aucune date renseignée                              |
      | 6    | 02.01.2021 | 20.01.2021 | Janvier | Active   | Au moins un jour de période d'activité pour le mois |
      | 7    | 02.01.2020 | 01.01.2021 | Janvier | Active   | Au moins un jour de période d'activité pour le mois |
      | 8    | 02.01.2021 | 02.01.2021 | Janvier | Active   | Un jour de période d'activité pour le mois          |
      | 9    | 31.01.2021 | 31.01.2021 | Janvier | Active   | Un jour de période d'activité pour le mois          |
      | 10   | 01.01.2021 | 01.01.2021 | Janvier | Active   | Un jour de période d'activité pour le mois          |
      | 11   | 01.01.2022 | 01.01.2022 | Janvier | Inactive | Année fiscale dans le futur                         |

  Scénario: Vérification si personne est active pour un mois donné quand aucunne période d'activité a été renseignée
    Et que la personne a un rapport de travail sans période d'activité
    Quand je vérifie si la personne est active le mois de Juin
    Alors je constate qu'elle est Active
