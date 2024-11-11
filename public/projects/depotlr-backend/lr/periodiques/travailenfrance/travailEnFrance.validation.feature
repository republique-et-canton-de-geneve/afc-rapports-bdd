#language: fr
Fonctionnalité: Valider le travail en France pour un salarié
  Plan du scénario: <Test> : valider un travail en France avec un taux de travail en France (<Observation>)
    Etant donné un travail en France avec un taux de travail en France de <Taux>%
    Quand l'utilisateur fait valider ce travail en France
    Alors on lui indique que ce travail en France est <Résultat>

    Exemples:
      | Test | Taux   | Résultat | Observation             |
      | 1    | 0      | valide   | limite basse            |
      | 2    | 100    | valide   | limite haute            |
      | 3    | 33.33  | valide   | cas avec 2 décimales    |
      | 4    | -1     | invalide | Taux négatif            |
      | 5    | 100.10 | invalide | Taux supérieur à 100    |
      | 6    | 101    | invalide | Taux supérieur à 100    |
      | 7    | 33.333 | invalide | Pas plus de 2 décimales |
