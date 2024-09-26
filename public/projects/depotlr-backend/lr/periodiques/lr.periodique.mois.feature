#language: fr
Fonctionnalité: Calcul du dernier mois actif

  Contexte:
    Etant donné qu'un DPI SALARIES est sélectionné

  Règle: le dernier mois actif est :
  - le mois courant si le jour du mois est supérieur à 21
  - mois precedent si le jour du mois est avant ou égale à 21
  - Décembre si l'année courante est supérieure à l'année fiscale
    Plan du Scénario: Calculer du dernier mois actif - <Test> -> <Observation>
      Etant donné que la date du jour est <Jour>
      Quand l´utilisateur crée une nouvelle LR 2021 pour ce DPI
      Alors le dernier mois actif est <Dernier mois actif>
      Exemples:
        | Test | Jour       | Dernier mois actif | Observation                                                           |
        | 1    | 01.12.2021 | Novembre           | Mois Décembre avant le 21, dernier mois actif = Novembre              |
        | 2    | 30.03.2021 | Mars               | Mois Mars après le 21, dernier mois actif = Mars                      |
        | 3    | 21.03.2021 | Février            | Mois de Mars le 21, dernier mois actif = Février                      |
        | 4    | 22.03.2021 | Mars               | Mois de Mars le 22, dernier mois actif = Mars                         |
        | 5    | 21.03.2022 | Décembre           | Année fiscale 2021 mais on est en 2022, dernier mois actif = Décembre |
