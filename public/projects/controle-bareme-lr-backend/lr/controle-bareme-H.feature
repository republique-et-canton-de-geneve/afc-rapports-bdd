#language: fr

Fonctionnalité: Validation des barèmes H

  Règle: Pour que les barèmes H1-H5 soient valides, la personne ne doit pas être en situation maritale,
  ni être dans une union libre et le nombre d'enfants avec moins de 18 ans(RM 2021) ou 25 ans(RM 2023) le dernier jour du mois précédent
  de la retenue doit être égale ou supérieur à "x" pour un barème Hx

    Plan du Scénario: Validation Barème H1 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année <annee>
      Et que la retenue a le barème H1
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | annee | etat civil             | unionLibre | date naissance enfants | resultat | Observation                                                                                               |
        | 1    | 2021  | CELIBATAIRE            | NON        | 02.02.2018             | valide   | Barème H1 - Célibataire ayant 1 enfant et pas en union libre                                              |
        | 2    | 2021  | SEPARE                 | NON        | 02.02.2018             | valide   | Barème H1 - Séparé ayant 1 enfant et pas en union libre                                                   |
        | 3    | 2021  | DIVORCE                | NON        | 02.02.2018             | valide   | Barème H1 - Divorcé ayant 1 enfant et pas en union libre                                                  |
        | 4    | 2021  | PARTENARIAT_DISSOUS    | NON        | 02.02.2018             | valide   | Barème H1 - Partenariat dissous ayant 1 enfant et pas en union libre                                      |
        | 5    | 2021  | VEUF                   | NON        | 02.02.2018             | valide   | Barème H1 - Veuf ayant 1 enfant et pas en union libre                                                     |
        | 6    | 2021  | MARIE                  | NON        | 02.02.2018             | invalide | Barème H1 - Marié ayant 1 enfant                                                                          |
        | 7    | 2021  | PARTENARIAT_ENREGISTRE | NON        | 02.02.2018             | invalide | Barème H1 - Partenariat enregistré ayant 1 enfant                                                         |
        | 8    | 2021  | CELIBATAIRE            | NON        | 02.02.2018, 02.02.2019 | valide   | Barème H1 - Célibataire ayant 2 enfants (valide car en faveur de l'AFC)                                   |
        | 9    | 2021  | CELIBATAIRE            | OUI        | 02.02.2018             | invalide | Barème H1 - Célibataire ayant 1 enfant en union livre                                                     |
        | 10   | 2021  | SEPARE                 | OUI        | 02.02.2018             | invalide | Barème H1 - Séparé ayant 1 enfant en union livre                                                          |
        | 11   | 2021  | DIVORCE                | OUI        | 02.02.2018             | invalide | Barème H1 - Divorcé ayant 1 enfant en union livre                                                         |
        | 12   | 2021  | PARTENARIAT_DISSOUS    | OUI        | 02.02.2018             | invalide | Barème H1 - Partenariat dissous ayant 1 enfant en union livre                                             |
        | 13   | 2021  | VEUF                   | OUI        | 02.02.2018             | invalide | Barème H1 - Veuf ayant 1 enfant en union livre                                                            |
        | 14   | 2021  | CELIBATAIRE            | NON        |                        | invalide | Barème H1 - Célibataire sans enfants                                                                      |
        | 15   | 2021  | SEPARE                 | NON        |                        | invalide | Barème H1 - Séparé sans enfants                                                                           |
        | 16   | 2021  | DIVORCE                | NON        |                        | invalide | Barème H1 - Divorcé sans enfants                                                                          |
        | 17   | 2021  | PARTENARIAT_DISSOUS    | NON        |                        | invalide | Barème H1 - Partenariat dissous sans enfants                                                              |
        | 18   | 2021  | VEUF                   | NON        |                        | invalide | Barème H1 - Veuf sans enfants                                                                             |
        | 19   | 2021  | CELIBATAIRE            | NON        | 02.02.2000             | invalide | RM age enfant 2021 - Barème H1 - Célibataire ayant 1 enfant avec plus de 18 ans et pas en union libre     |
        | 20   | 2021  | CELIBATAIRE            | NON        | 02.02.2000, 02.02.2010 | valide   | RM age enfant 2021 - Barème H1 - Célibataire ayant 2 enfants un avec plus de 18 ans et pas en union libre |
        | 21   | 2023  | CELIBATAIRE            | NON        | 02.02.1997             | invalide | RM age enfant 2023 - Barème H1 - Célibataire ayant 1 enfant avec plus de 25 ans et pas en union libre     |
        | 22   | 2023  | CELIBATAIRE            | NON        | 02.02.1999, 02.02.1997 | valide   | RM age enfant 2023 - Barème H1 - Célibataire ayant 2 enfants un avec plus de 25 ans et pas en union libre |
    Plan du Scénario: Validation Barème H2 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année <annee>
      Et que la retenue a le barème H2
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | annee | etat civil             | unionLibre | date naissance enfants             | resultat | Observation                                                                                               |
        | 1    | 2021  | CELIBATAIRE            | NON        | 02.02.2018, 02.02.2019             | valide   | Barème H2 - Célibataire ayant 2 enfants et pas en union libre                                             |
        | 2    | 2021  | SEPARE                 | NON        | 02.02.2018, 02.02.2019             | valide   | Barème H2 - Séparé ayant 2 enfants et pas en union libre                                                  |
        | 3    | 2021  | DIVORCE                | NON        | 02.02.2018, 02.02.2019             | valide   | Barème H2 - Divorcé ayant 2 enfants et pas en union libre                                                 |
        | 4    | 2021  | PARTENARIAT_DISSOUS    | NON        | 02.02.2018, 02.02.2019             | valide   | Barème H2 - Partenariat dissous ayant 2 enfants et pas en union libre                                     |
        | 5    | 2021  | VEUF                   | NON        | 02.02.2018, 02.02.2019             | valide   | Barème H2 - Veuf ayant 2 enfants et pas en union libre                                                    |
        | 6    | 2021  | MARIE                  | NON        | 02.02.2018, 02.02.2019             | invalide | Barème H2 - Marié ayant 2 enfants                                                                         |
        | 7    | 2021  | PARTENARIAT_ENREGISTRE | NON        | 02.02.2018, 02.02.2019             | invalide | Barème H2 - Partenariat enregistré ayant 2 enfants                                                        |
        | 8    | 2021  | CELIBATAIRE            | NON        | 02.02.2018, 02.02.2019, 02.02.2019 | valide   | Barème H2 - Célibataire ayant 3 enfants (valide car en faveur de l'AFC)                                   |
        | 9    | 2021  | CELIBATAIRE            | OUI        | 02.02.2018, 02.02.2019             | invalide | Barème H2 - Célibataire ayant 2 enfants en union livre                                                    |
        | 10   | 2021  | SEPARE                 | OUI        | 02.02.2018, 02.02.2019             | invalide | Barème H2 - Séparé ayant 2 enfants en union livre                                                         |
        | 11   | 2021  | DIVORCE                | OUI        | 02.02.2018, 02.02.2019             | invalide | Barème H2 - Divorcé ayant 2 enfants en union livre                                                        |
        | 12   | 2021  | PARTENARIAT_DISSOUS    | OUI        | 02.02.2018, 02.02.2019             | invalide | Barème H2 - Partenariat dissous ayant 2 enfants en union livre                                            |
        | 13   | 2021  | VEUF                   | OUI        | 02.02.2018, 02.02.2019             | invalide | Barème H2 - Veuf ayant 2 enfants en union livre                                                           |
        | 14   | 2021  | CELIBATAIRE            | NON        |                                    | invalide | Barème H2 - Célibataire sans enfants                                                                      |
        | 15   | 2021  | SEPARE                 | NON        |                                    | invalide | Barème H2 - Séparé sans enfants                                                                           |
        | 16   | 2021  | DIVORCE                | NON        |                                    | invalide | Barème H2 - Divorcé sans enfants                                                                          |
        | 17   | 2021  | PARTENARIAT_DISSOUS    | NON        |                                    | invalide | Barème H2 - Partenariat dissous sans enfants                                                              |
        | 18   | 2021  | VEUF                   | NON        |                                    | invalide | Barème H2 - Veuf sans enfants                                                                             |
        | 19   | 2021  | CELIBATAIRE            | NON        | 02.02.2018                         | invalide | Barème H2 - Célibataire ayant 1 seul enfant                                                               |
        | 20   | 2021  | SEPARE                 | NON        | 02.02.2018                         | invalide | Barème H2 - Séparé ayant 1 seul enfant                                                                    |
        | 21   | 2021  | DIVORCE                | NON        | 02.02.2018                         | invalide | Barème H2 - Divorcé ayant 1 seul enfant                                                                   |
        | 22   | 2021  | PARTENARIAT_DISSOUS    | NON        | 02.02.2018                         | invalide | Barème H2 - Partenariat dissous ayant 1 seul enfant                                                       |
        | 23   | 2021  | VEUF                   | NON        | 02.02.2018                         | invalide | Barème H2 - Veuf ayant 1 seul enfant                                                                      |
        | 24   | 2021  | CELIBATAIRE            | NON        | 02.02.2000, 02.02.2001             | invalide | RM age enfant 2021 - Barème H2 - Célibataire ayant 2 enfants avec plus de 18 ans et pas en union libre    |
        | 25   | 2021  | CELIBATAIRE            | NON        | 02.02.2000, 02.02.2010, 02.02.2010 | valide   | RM age enfant 2021 - Barème H2 - Célibataire ayant 3 enfants un avec plus de 18 ans et pas en union libre |
        | 26   | 2023  | CELIBATAIRE            | NON        | 02.02.1999, 02.02.1997             | invalide | RM age enfant 2023 - Barème H2 - Célibataire ayant 2 enfants avec plus de 25 ans et pas en union libre    |
        | 27   | 2023  | CELIBATAIRE            | NON        | 02.02.1999, 02.02.2000, 02.02.1997 | valide   | RM age enfant 2023 - Barème H2 - Célibataire ayant 3 enfants un avec plus de 25 ans et pas en union libre |

    Plan du Scénario: Validation Barème H3 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année <annee>
      Et que la retenue a le barème H3
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | annee | etat civil             | unionLibre | date naissance enfants                         | resultat | Observation                                                                                               |
        | 1    | 2021  | CELIBATAIRE            | NON        | 02.02.2018, 02.02.2019, 02.02.2019             | valide   | Barème H3 - Célibataire ayant 3 enfants et pas en union libre                                             |
        | 2    | 2021  | SEPARE                 | NON        | 02.02.2018, 02.02.2019, 02.02.2019             | valide   | Barème H3 - Séparé ayant 3 enfants et pas en union libre                                                  |
        | 3    | 2021  | DIVORCE                | NON        | 02.02.2018, 02.02.2019, 02.02.2019             | valide   | Barème H3 - Divorcé ayant 3 enfants et pas en union libre                                                 |
        | 4    | 2021  | PARTENARIAT_DISSOUS    | NON        | 02.02.2018, 02.02.2019, 02.02.2019             | valide   | Barème H3 - Partenariat dissous ayant 3 enfants et pas en union libre                                     |
        | 5    | 2021  | VEUF                   | NON        | 02.02.2018, 02.02.2019, 02.02.2019             | valide   | Barème H3 - Veuf ayant 3 enfants et pas en union libre                                                    |
        | 6    | 2021  | MARIE                  | NON        | 02.02.2018, 02.02.2019, 02.02.2019             | invalide | Barème H3 - Marié ayant 3 enfants                                                                         |
        | 7    | 2021  | PARTENARIAT_ENREGISTRE | NON        | 02.02.2018, 02.02.2019, 02.02.2019             | invalide | Barème H3 - Partenariat enregistré ayant 3 enfants                                                        |
        | 8    | 2021  | CELIBATAIRE            | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019 | valide   | Barème H3 - Célibataire ayant 4 enfants (valide car en faveur de l'AFC)                                   |
        | 9    | 2021  | CELIBATAIRE            | OUI        | 02.02.2018, 02.02.2019, 02.02.2019             | invalide | Barème H3 - Célibataire ayant 3 enfants en union livre                                                    |
        | 10   | 2021  | SEPARE                 | OUI        | 02.02.2018, 02.02.2019, 02.02.2019             | invalide | Barème H3 - Séparé ayant 3 enfants en union livre                                                         |
        | 11   | 2021  | DIVORCE                | OUI        | 02.02.2018, 02.02.2019, 02.02.2019             | invalide | Barème H3 - Divorcé ayant 3 enfants en union livre                                                        |
        | 12   | 2021  | PARTENARIAT_DISSOUS    | OUI        | 02.02.2018, 02.02.2019, 02.02.2019             | invalide | Barème H3 - Partenariat dissous ayant 3 enfants en union livre                                            |
        | 13   | 2021  | VEUF                   | OUI        | 02.02.2018, 02.02.2019, 02.02.2019             | invalide | Barème H3 - Veuf ayant 3 enfants en union livre                                                           |
        | 14   | 2021  | CELIBATAIRE            | NON        |                                                | invalide | Barème H3 - Célibataire sans enfants                                                                      |
        | 15   | 2021  | SEPARE                 | NON        |                                                | invalide | Barème H3 - Séparé sans enfants                                                                           |
        | 16   | 2021  | DIVORCE                | NON        |                                                | invalide | Barème H3 - Divorcé sans enfants                                                                          |
        | 17   | 2021  | PARTENARIAT_DISSOUS    | NON        |                                                | invalide | Barème H3 - Partenariat dissous sans enfants                                                              |
        | 18   | 2021  | VEUF                   | NON        |                                                | invalide | Barème H3 - Veuf sans enfants                                                                             |
        | 19   | 2021  | CELIBATAIRE            | NON        | 02.02.2018                                     | invalide | Barème H3 - Célibataire ayant 1 seul enfant                                                               |
        | 20   | 2021  | SEPARE                 | NON        | 02.02.2018                                     | invalide | Barème H3 - Séparé ayant 1 seul enfant                                                                    |
        | 21   | 2021  | DIVORCE                | NON        | 02.02.2018                                     | invalide | Barème H3 - Divorcé ayant 1 seul enfant                                                                   |
        | 22   | 2021  | PARTENARIAT_DISSOUS    | NON        | 02.02.2018                                     | invalide | Barème H3 - Partenariat dissous ayant 1 seul enfant                                                       |
        | 23   | 2021  | VEUF                   | NON        | 02.02.2018                                     | invalide | Barème H3 - Veuf ayant 1 seul enfant                                                                      |
        | 24   | 2021  | CELIBATAIRE            | NON        | 02.02.2018, 02.02.2019                         | invalide | Barème H3 - Célibataire ayant seulement 2 enfants                                                         |
        | 25   | 2021  | SEPARE                 | NON        | 02.02.2018, 02.02.2019                         | invalide | Barème H3 - Séparé ayant seulement 2 enfants                                                              |
        | 26   | 2021  | DIVORCE                | NON        | 02.02.2018, 02.02.2019                         | invalide | Barème H3 - Divorcé ayant seulement 2 enfants                                                             |
        | 27   | 2021  | PARTENARIAT_DISSOUS    | NON        | 02.02.2018, 02.02.2019                         | invalide | Barème H3 - Partenariat dissous ayant seulement 2 enfants                                                 |
        | 28   | 2021  | VEUF                   | NON        | 02.02.2018, 02.02.2019                         | invalide | Barème H3 - Veuf ayant seulement 2 enfants                                                                |
        | 28   | 2021  | CELIBATAIRE            | NON        | 02.02.2000, 02.02.2001, 02.02.2002             | invalide | RM age enfant 2021 - Barème H3 - Célibataire ayant 3 enfants avec plus de 18 ans et pas en union libre    |
        | 29   | 2021  | CELIBATAIRE            | NON        | 02.02.2000, 02.02.2010, 02.02.2013, 02.02.2012 | valide   | RM age enfant 2021 - Barème H3 - Célibataire ayant 4 enfants un avec plus de 18 ans et pas en union libre |
        | 30   | 2023  | CELIBATAIRE            | NON        | 02.02.1999, 02.02.2000, 02.02.1997             | invalide | RM age enfant 2023 - Barème H3 - Célibataire ayant 3 enfants avec plus de 25 ans et pas en union libre    |
        | 31   | 2023  | CELIBATAIRE            | NON        | 02.02.1999, 02.02.2000, 02.02.2001, 02.02.1997 | valide   | RM age enfant 2023 - Barème H3 - Célibataire ayant 4 enfants un avec plus de 25 ans et pas en union libre |


    Plan du Scénario: Validation Barème H4 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année <annee>
      Et que la retenue a le barème H4
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | annee | etat civil             | unionLibre | date naissance enfants                                     | resultat | Observation                                                                                               |
        | 1    | 2021  | CELIBATAIRE            | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019             | valide   | Barème H4 - Célibataire ayant 4 enfants et pas en union libre                                             |
        | 2    | 2021  | SEPARE                 | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019             | valide   | Barème H4 - Séparé ayant 4 enfants et pas en union libre                                                  |
        | 3    | 2021  | DIVORCE                | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019             | valide   | Barème H4 - Divorcé ayant 4 enfants et pas en union libre                                                 |
        | 4    | 2021  | PARTENARIAT_DISSOUS    | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019             | valide   | Barème H4 - Partenariat dissous ayant 4 enfants et pas en union libre                                     |
        | 5    | 2021  | VEUF                   | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019             | valide   | Barème H4 - Veuf ayant 4 enfants et pas en union libre                                                    |
        | 6    | 2021  | MARIE                  | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019             | invalide | Barème H4 - Marié ayant 4 enfants                                                                         |
        | 7    | 2021  | PARTENARIAT_ENREGISTRE | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019             | invalide | Barème H4 - Partenariat enregistré ayant 4 enfants                                                        |
        | 8    | 2021  | CELIBATAIRE            | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019, 02.02.2020 | valide   | Barème H4 - Célibataire ayant 5 enfants (valide car en faveur de l'AFC)                                   |
        | 9    | 2021  | CELIBATAIRE            | OUI        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019             | invalide | Barème H4 - Célibataire ayant 4 enfants en union livre                                                    |
        | 10   | 2021  | SEPARE                 | OUI        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019             | invalide | Barème H4 - Séparé ayant 4 enfants en union livre                                                         |
        | 11   | 2021  | DIVORCE                | OUI        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019             | invalide | Barème H4 - Divorcé ayant 4 enfants en union livre                                                        |
        | 12   | 2021  | PARTENARIAT_DISSOUS    | OUI        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019             | invalide | Barème H4 - Partenariat dissous ayant 4 enfants en union livre                                            |
        | 13   | 2021  | VEUF                   | OUI        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019             | invalide | Barème H4 - Veuf ayant 4 enfants en union livre                                                           |
        | 14   | 2021  | CELIBATAIRE            | NON        |                                                            | invalide | Barème H4 - Célibataire sans enfants                                                                      |
        | 15   | 2021  | SEPARE                 | NON        |                                                            | invalide | Barème H4 - Séparé sans enfants                                                                           |
        | 16   | 2021  | DIVORCE                | NON        |                                                            | invalide | Barème H4 - Divorcé sans enfants                                                                          |
        | 17   | 2021  | PARTENARIAT_DISSOUS    | NON        |                                                            | invalide | Barème H4 - Partenariat dissous sans enfants                                                              |
        | 18   | 2021  | VEUF                   | NON        |                                                            | invalide | Barème H4 - Veuf sans enfants                                                                             |
        | 19   | 2021  | CELIBATAIRE            | NON        | 02.02.2018                                                 | invalide | Barème H4 - Célibataire ayant 1 seul enfant                                                               |
        | 20   | 2021  | SEPARE                 | NON        | 02.02.2018                                                 | invalide | Barème H4 - Séparé ayant 1 seul enfant                                                                    |
        | 21   | 2021  | DIVORCE                | NON        | 02.02.2018                                                 | invalide | Barème H4 - Divorcé ayant 1 seul enfant                                                                   |
        | 22   | 2021  | PARTENARIAT_DISSOUS    | NON        | 02.02.2018                                                 | invalide | Barème H4 - Partenariat dissous ayant 1 seul enfant                                                       |
        | 23   | 2021  | VEUF                   | NON        | 02.02.2018                                                 | invalide | Barème H4 - Veuf ayant 1 seul enfant                                                                      |
        | 24   | 2021  | CELIBATAIRE            | NON        | 02.02.2018, 02.02.2019                                     | invalide | Barème H4 - Célibataire ayant seulement 2 enfants                                                         |
        | 25   | 2021  | SEPARE                 | NON        | 02.02.2018, 02.02.2019                                     | invalide | Barème H4 - Séparé ayant seulement 2 enfants                                                              |
        | 26   | 2021  | DIVORCE                | NON        | 02.02.2018, 02.02.2019                                     | invalide | Barème H4 - Divorcé ayant seulement 2 enfants                                                             |
        | 27   | 2021  | PARTENARIAT_DISSOUS    | NON        | 02.02.2018, 02.02.2019                                     | invalide | Barème H4 - Partenariat dissous ayant seulement 2 enfants                                                 |
        | 28   | 2021  | VEUF                   | NON        | 02.02.2018, 02.02.2019                                     | invalide | Barème H4 - Veuf ayant seulement 2 enfants                                                                |
        | 29   | 2021  | CELIBATAIRE            | NON        | 02.02.2018, 02.02.2019, 02.02.2020                         | invalide | Barème H4 - Célibataire ayant seulement 3 enfants                                                         |
        | 30   | 2021  | SEPARE                 | NON        | 02.02.2018, 02.02.2019, 02.02.2020                         | invalide | Barème H4 - Séparé ayant seulement 3 enfants                                                              |
        | 31   | 2021  | DIVORCE                | NON        | 02.02.2018, 02.02.2019, 02.02.2020                         | invalide | Barème H4 - Divorcé ayant seulement 3 enfants                                                             |
        | 32   | 2021  | PARTENARIAT_DISSOUS    | NON        | 02.02.2018, 02.02.2019, 02.02.2020                         | invalide | Barème H4 - Partenariat dissous ayant seulement 3 enfants                                                 |
        | 33   | 2021  | VEUF                   | NON        | 02.02.2018, 02.02.2019, 02.02.2020                         | invalide | Barème H4 - Veuf ayant seulement 3 enfants                                                                |
        | 34   | 2021  | CELIBATAIRE            | NON        | 02.02.2000, 02.02.2001, 02.02.2002, 02.02.2003             | invalide | RM age enfant 2021 - Barème H4 - Célibataire ayant 4 enfants avec plus de 18 ans et pas en union libre    |
        | 35   | 2021  | CELIBATAIRE            | NON        | 02.02.2000, 02.02.2010, 02.02.2013, 02.02.2012, 02.02.2013 | valide   | RM age enfant 2021 - Barème H4 - Célibataire ayant 5 enfants un avec plus de 18 ans et pas en union libre |
        | 36   | 2023  | CELIBATAIRE            | NON        | 02.02.1999, 02.02.2000, 02.02.2001, 02.02.1997             | invalide | RM age enfant 2023 - Barème H4 - Célibataire ayant 4 enfants avec plus de 25 ans et pas en union libre    |
        | 37   | 2023  | CELIBATAIRE            | NON        | 02.02.1999, 02.02.2000, 02.02.2001, 02.02.2002, 02.02.1997 | valide   | RM age enfant 2023 - Barème H4 - Célibataire ayant 5 enfants un avec plus de 25 ans et pas en union libre |


    Plan du Scénario: Validation Barème H5 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année <annee>
      Et que la retenue a le barème H5
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | annee | etat civil             | unionLibre | date naissance enfants                                                 | resultat | Observation                                                                                               |
        | 1    | 2021  | CELIBATAIRE            | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019, 02.02.2020             | valide   | Barème H5 - Célibataire ayant 5 enfants et pas en union libre                                             |
        | 2    | 2021  | SEPARE                 | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019, 02.02.2020             | valide   | Barème H5 - Séparé ayant 5 enfants et pas en union libre                                                  |
        | 3    | 2021  | DIVORCE                | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019, 02.02.2020             | valide   | Barème H5 - Divorcé ayant 5 enfants et pas en union libre                                                 |
        | 4    | 2021  | PARTENARIAT_DISSOUS    | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019, 02.02.2020             | valide   | Barème H5 - Partenariat dissous ayant 5 enfants et pas en union libre                                     |
        | 5    | 2021  | VEUF                   | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019, 02.02.2020             | valide   | Barème H5 - Veuf ayant 5 enfants et pas en union libre                                                    |
        | 6    | 2021  | MARIE                  | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019, 02.02.2020             | invalide | Barème H5 - Marié ayant 5 enfants                                                                         |
        | 7    | 2021  | PARTENARIAT_ENREGISTRE | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019, 02.02.2020             | invalide | Barème H5 - Partenariat enregistré ayant 5 enfants                                                        |
        | 8    | 2021  | CELIBATAIRE            | NON        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019, 02.02.2020, 01.01.2021 | valide   | Barème H5 - Célibataire ayant 6 enfants (valide car en faveur de l'AFC)                                   |
        | 9    | 2021  | CELIBATAIRE            | OUI        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019, 02.02.2020             | invalide | Barème H5 - Célibataire ayant 5 enfants en union livre                                                    |
        | 10   | 2021  | SEPARE                 | OUI        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019, 02.02.2020             | invalide | Barème H5 - Séparé ayant 5 enfants en union livre                                                         |
        | 11   | 2021  | DIVORCE                | OUI        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019, 02.02.2020             | invalide | Barème H5 - Divorcé ayant 5 enfants en union livre                                                        |
        | 12   | 2021  | PARTENARIAT_DISSOUS    | OUI        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019, 02.02.2020             | invalide | Barème H5 - Partenariat dissous ayant 6 enfants en union livre                                            |
        | 13   | 2021  | VEUF                   | OUI        | 02.02.2018, 02.02.2019, 02.02.2019, 02.02.2019, 02.02.2020             | invalide | Barème H5 - Veuf ayant 5 enfants en union livre                                                           |
        | 14   | 2021  | CELIBATAIRE            | NON        |                                                                        | invalide | Barème H5 - Célibataire sans enfants                                                                      |
        | 15   | 2021  | SEPARE                 | NON        |                                                                        | invalide | Barème H5 - Séparé sans enfants                                                                           |
        | 16   | 2021  | DIVORCE                | NON        |                                                                        | invalide | Barème H5 - Divorcé sans enfants                                                                          |
        | 17   | 2021  | PARTENARIAT_DISSOUS    | NON        |                                                                        | invalide | Barème H5 - Partenariat dissous sans enfants                                                              |
        | 18   | 2021  | VEUF                   | NON        |                                                                        | invalide | Barème H5 - Veuf sans enfants                                                                             |
        | 19   | 2021  | CELIBATAIRE            | NON        | 02.02.2018                                                             | invalide | Barème H5 - Célibataire ayant 1 seul enfant                                                               |
        | 20   | 2021  | SEPARE                 | NON        | 02.02.2018                                                             | invalide | Barème H5 - Séparé ayant 1 seul enfant                                                                    |
        | 21   | 2021  | DIVORCE                | NON        | 02.02.2018                                                             | invalide | Barème H5 - Divorcé ayant 1 seul enfant                                                                   |
        | 22   | 2021  | PARTENARIAT_DISSOUS    | NON        | 02.02.2018                                                             | invalide | Barème H5 - Partenariat dissous ayant 1 seul enfant                                                       |
        | 23   | 2021  | VEUF                   | NON        | 02.02.2018                                                             | invalide | Barème H5 - Veuf ayant 1 seul enfant                                                                      |
        | 24   | 2021  | CELIBATAIRE            | NON        | 02.02.2018, 02.02.2019                                                 | invalide | Barème H5 - Célibataire ayant seulement 2 enfants                                                         |
        | 25   | 2021  | SEPARE                 | NON        | 02.02.2018, 02.02.2019                                                 | invalide | Barème H5 - Séparé ayant seulement 2 enfants                                                              |
        | 26   | 2021  | DIVORCE                | NON        | 02.02.2018, 02.02.2019                                                 | invalide | Barème H5 - Divorcé ayant seulement 2 enfants                                                             |
        | 27   | 2021  | PARTENARIAT_DISSOUS    | NON        | 02.02.2018, 02.02.2019                                                 | invalide | Barème H5 - Partenariat dissous ayant seulement 2 enfants                                                 |
        | 28   | 2021  | VEUF                   | NON        | 02.02.2018, 02.02.2019                                                 | invalide | Barème H5 - Veuf ayant seulement 2 enfants                                                                |
        | 29   | 2021  | CELIBATAIRE            | NON        | 02.02.2018, 02.02.2019, 02.02.2020                                     | invalide | Barème H5 - Célibataire ayant seulement 3 enfants                                                         |
        | 30   | 2021  | SEPARE                 | NON        | 02.02.2018, 02.02.2019, 02.02.2020                                     | invalide | Barème H5 - Séparé ayant seulement 3 enfants                                                              |
        | 31   | 2021  | DIVORCE                | NON        | 02.02.2018, 02.02.2019, 02.02.2020                                     | invalide | Barème H5 - Divorcé ayant seulement 3 enfants                                                             |
        | 32   | 2021  | PARTENARIAT_DISSOUS    | NON        | 02.02.2018, 02.02.2019, 02.02.2020                                     | invalide | Barème H5 - Partenariat dissous ayant seulement 3 enfants                                                 |
        | 33   | 2021  | VEUF                   | NON        | 02.02.2018, 02.02.2019, 02.02.2020                                     | invalide | Barème H5 - Veuf ayant seulement 3 enfants                                                                |
        | 34   | 2021  | CELIBATAIRE            | NON        | 02.02.2018, 02.02.2019, 02.02.2020, 01.01.2021                         | invalide | Barème H5 - Célibataire ayant seulement 4 enfants                                                         |
        | 35   | 2021  | SEPARE                 | NON        | 02.02.2018, 02.02.2019, 02.02.2020, 01.01.2021                         | invalide | Barème H5 - Séparé ayant seulement 4 enfants                                                              |
        | 36   | 2021  | DIVORCE                | NON        | 02.02.2018, 02.02.2019, 02.02.2020, 01.01.2021                         | invalide | Barème H5 - Divorcé ayant seulement 4 enfants                                                             |
        | 37   | 2021  | PARTENARIAT_DISSOUS    | NON        | 02.02.2018, 02.02.2019, 02.02.2020, 01.01.2021                         | invalide | Barème H5 - Partenariat dissous ayant seulement 4 enfants                                                 |
        | 38   | 2021  | VEUF                   | NON        | 02.02.2018, 02.02.2019, 02.02.2020, 01.01.2021                         | invalide | Barème H5 - Veuf ayant seulement 4 enfants                                                                |
        | 39   | 2021  | CELIBATAIRE            | NON        | 02.02.2000, 02.02.2001, 02.02.2002, 02.02.2003, 02.02.1999             | invalide | RM age enfant 2021 - Barème H5 - Célibataire ayant 5 enfants avec plus de 18 ans et pas en union libre    |
        | 40   | 2021  | CELIBATAIRE            | NON        | 02.02.2000, 02.02.2010, 02.02.2013, 02.02.2012, 02.02.2013, 02.02.2013 | valide   | RM age enfant 2021 - Barème H5 - Célibataire ayant 6 enfants un avec plus de 18 ans et pas en union libre |
        | 41   | 2023  | CELIBATAIRE            | NON        | 02.02.1999, 02.02.2000, 02.02.2001, 02.02.2002, 02.02.1997             | invalide | RM age enfant 2023 - Barème H5 - Célibataire ayant 5 enfants avec plus de 25 ans et pas en union libre    |
        | 42   | 2023  | CELIBATAIRE            | NON        | 02.02.1999, 02.02.2000, 02.02.2001, 02.02.2002, 02.02.2003, 02.02.1997 | valide   | RM age enfant 2023 - Barème H5 - Célibataire ayant 6 enfants un avec plus de 25 ans et pas en union libre |

  Règle: Pour un barème H1-H5, si c'est une barème ajusté alors aucun contrôle n'est effectué et du coup on considère comme valide

    Plan du Scénario: Validation Barème H1-H5 avec barème ajusté - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a 0 enfant(s)
      Et une retenue pour Décembre et année 2021
      Et que la retenue a le barème <barème>
      Et que la retenue a un barème ajusté
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | etat civil | unionLibre | barème | resultat | Observation               |
        | 1    | MARIE      | NON        | H1     | valide   | Barème H1 - Barème ajusté |
        | 2    | MARIE      | NON        | H2     | valide   | Barème H2 - Barème ajusté |
        | 3    | MARIE      | NON        | H3     | valide   | Barème H3 - Barème ajusté |
        | 4    | MARIE      | NON        | H4     | valide   | Barème H4 - Barème ajusté |
        | 5    | MARIE      | NON        | H5     | valide   | Barème H5 - Barème ajusté |
