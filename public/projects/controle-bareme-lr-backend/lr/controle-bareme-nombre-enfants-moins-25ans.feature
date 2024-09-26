#language: fr

Fonctionnalité: Validation nombre d'enfants ayant moins de 25 ans

  Règle: Un enfant est considéré comme ayant moins de 25 ans si il a moins de 25 ans par rapport à une date
  de référence

    Plan du Scénario: Validation nombre d'enfants ayant moins de 25 ans - <Test> -> <Observation>
      Etant donné que la personne a des enfants nés le : <date de naissance>
      Quand on demande le nombre d'enfants ayant moins de 25 ans au <date de référence>
      Alors le système renvoie que le nombre d'enfants ayant moins de 25 ans est <résultat>
      Exemples:
        | Test | date de naissance                                          | date de référence | résultat | Observation                                                                             |
        | 1    | 01.12.1999                                                 | 30.11.2023        | 1        | 1 Enfant ayant moins de 25 ans à la date de référence                                   |
        | 2    | 29.11.1997                                                 | 30.11.2023        | 0        | 1 Enfant ayant plus de 25 ans à la date de référence                                    |
        | 3    | 30.11.1998                                                 | 30.11.2023        | 0        | 1 Enfant ayant 25 ans à la date de référence                                            |
        | 4    | 01.12.1998, 30.11.1998                                     | 30.11.2023        | 1        | 2 Enfants, un ayant 25 ans à la date de référence                                       |
        | 5    | 01.12.1999, 02.12.2000, 02.12.2001                         | 30.11.2023        | 3        | 3 Enfants ayant moins de 25 ans à la date de référence                                  |
        | 6    |                                                            | 30.11.2023        | 0        | Aucun enfant                                                                            |
        | 7    | 01.12.2023                                                 | 30.11.2023        | 0        | 1 Enfant né après la date de référence                                                  |
        | 8    | 30.11.2023                                                 | 30.11.2023        | 1        | 1 Enfant né à la date de référence                                                      |
        | 9    | 30.11.1998, 30.11.2023                                     | 30.11.2023        | 1        | 2 Enfants - 1 ayant 25 ans à la date de référence et 1 enfant né à la date de référence |
        | 10   | 30.11.1993, 30.11.1994, 01.11.1995, 30.01.1996, 30.12.1997 | 30.11.2023        | 0        | 5 Enfants ayant plus de 25 ans à la date de référence                                   |
