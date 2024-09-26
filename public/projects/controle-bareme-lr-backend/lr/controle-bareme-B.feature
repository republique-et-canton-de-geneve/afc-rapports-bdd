#language: fr

Fonctionnalité: Validation des barèmes B

  Règle: Pour que le barème B0 soit valide, la personne doit être en situation maritale (marié, partenariat enreg) et le conjoint ne doit pas avoir de revenu.

    Plan du Scénario: Validation Barème B0 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option choisie pour les revenus du conjoint est : <conjoint avec revenu>
      Et que l'option de vie en union libre choisie est : <union libre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année 2021
      Et que la retenue a le barème B0
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | etat civil             | conjoint avec revenu | union libre | date naissance enfants | resultat | Observation                                              |
        | 1    | MARIE                  | NON                  | NON         |                        | valide   | Barème B0 - marié et conjoint sans revenu                |
        | 2    | PARTENARIAT_ENREGISTRE | NON                  | NON         |                        | valide   | Barème B0 - partenariat enreg et conjoint sans revenu    |
        | 3    | MARIE                  | OUI                  | NON         |                        | invalide | Barème B0 - marié et conjoint avec revenu                |
        | 4    | MARIE                  | NON                  | NON         | 01.01.2004             | valide   | Barème B0 - avec enfants (valide car en faveur de l'AFC) |
        | 5    | CELIBATAIRE            | NON                  | NON         |                        | invalide | Barème B0 - célibataire                                  |
        | 6    | CELIBATAIRE            | NON                  | OUI         |                        | invalide | Barème B0 - célibataire en union libre                   |
        | 7    | DIVORCE                | NON                  | NON         |                        | invalide | Barème B0 - Divorcé                                      |
        | 8    | SEPARE                 | NON                  | NON         |                        | invalide | Barème B0 - Séparé                                       |
        | 9    | VEUF                   | NON                  | NON         |                        | invalide | Barème B0 - Veuf                                         |
        | 10   | PARTENARIAT_DISSOUS    | NON                  | NON         |                        | invalide | Barème B0 - Partenariat dissous                          |


  Règle: Pour que les barèmes B1-B5 soient valides, la personne doit être en situation maritale, son conjoint ne doit pas avoir des revenus
  et le nombre d'enfants avec moins de 18 ans(RM 2021) ou 25 ans(RM 2023) le dernier jour du mois précédent de la retenue doit être égale ou supérieur à "x" pour un barème Bx

    Plan du Scénario: Validation Barème B1 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option choisie pour les revenus du conjoint est : <conjAvecRevenu>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année <annee>
      Et que la retenue a le barème B1
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | annee | etat civil | conjAvecRevenu | unionLibre | date naissance enfants | resultat | Observation                                                         |
        | 14   | 2023  | MARIE      | NON            | NON        | 01.01.1999             | valide   | RM age enfant 2023 - Barème B1 - Marié 1 Enfant avec 24 ans         |
        | 15   | 2023  | MARIE      | NON            | NON        |                        | invalide | RM age enfant 2023 - Barème B1 - Sans enfants                       |
        | 16   | 2023  | MARIE      | NON            | NON        | 30.11.1998             | invalide | RM age enfant 2023 - Barème B1 - Enfant avec 25 ans                 |
        | 17   | 2023  | MARIE      | NON            | NON        | 29.11.2004, 02.05.2005 | valide   | RM age enfant 2023 - Barème B1 - 2 Enfants moins de 25 ans          |
        | 18   | 2023  | MARIE      | NON            | NON        | 30.11.1998, 02.05.2005 | valide   | RM age enfant 2023 - Barème B1 - 2 Enfants, un avec moins de 25 ans |

    Plan du Scénario: Validation Barème B2 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option choisie pour les revenus du conjoint est : <conjAvecRevenu>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année <annee>
      Et que la retenue a le barème B2
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | annee | etat civil             | conjAvecRevenu | unionLibre | date naissance enfants             | resultat | Observation                                                                        |
        | 1    | 2021  | MARIE                  | NON            | NON        | 01.01.2004, 02.05.2005             | valide   | RM age enfant 2021 - Barème B2 - 2 Enfants moins de 18 ans                         |
        | 2    | 2021  | MARIE                  | NON            | NON        | 01.01.2004, 02.05.2000, 02.05.2005 | valide   | RM age enfant 2021 - Barème B2 - 3 Enfants - 2 moins de 18 ans et un plus de 18    |
        | 3    | 2021  | MARIE                  | NON            | NON        | 01.01.2004, 01.01.2002             | invalide | RM age enfant 2021 - Barème B2 - 2 Enfants - un moins de 18 ans et un plus de 18   |
        | 4    | 2021  | MARIE                  | NON            | NON        | 01.01.2004                         | invalide | RM age enfant 2021 - Barème B2 - 1 Enfant moins de 18 ans                          |
        | 5    | 2021  | MARIE                  | NON            | NON        | 01.01.2004, 02.05.2006, 02.05.2005 | valide   | RM age enfant 2021 - Barème B2 - 3 Enfants moins de 18 ans                         |
        | 6    | 2021  | MARIE                  | OUI            | NON        | 01.01.2004, 02.05.2006             | invalide | RM age enfant 2021 - Barème B2 - 2 Enfants moins de 18 ans et conjoint avec revenu |
        | 7    | 2021  | PARTENARIAT_ENREGISTRE | NON            | NON        | 02.05.2004, 02.05.2005             | valide   | Barème B2 - Partenariat enregistré                                                 |
        | 8    | 2021  | CELIBATAIRE            | NON            | NON        | 02.05.2004                         | invalide | Barème B2 - Célibataire                                                            |
        | 9    | 2021  | CELIBATAIRE            | NON            | OUI        | 02.05.2004                         | invalide | Barème B2 - Célibataire en union libre                                             |
        | 10   | 2021  | DIVORCE                | NON            | NON        | 02.05.2004                         | invalide | Barème B2 - Divorcé                                                                |
        | 11   | 2021  | VEUF                   | NON            | NON        | 02.05.2004                         | invalide | Barème B2 - Veuf                                                                   |
        | 12   | 2021  | SEPARE                 | NON            | NON        | 02.05.2004                         | invalide | Barème B2 - Séparé                                                                 |
        | 13   | 2021  | PARTENARIAT_DISSOUS    | NON            | NON        | 02.05.2004                         | invalide | Barème B2 - Partenariat Dissous                                                    |
        | 14   | 2023  | MARIE                  | NON            | NON        | 01.01.2004, 02.05.2005             | valide   | RM age enfant 2023 - Barème B2 - 2 Enfants moins de 25 ans                         |
        | 15   | 2023  | MARIE                  | NON            | NON        | 01.01.2004, 02.05.1998, 02.05.2005 | valide   | RM age enfant 2023 - Barème B2 - 3 Enfants - 2 moins de 25 ans et un plus de 25    |
        | 16   | 2023  | MARIE                  | NON            | NON        | 01.01.1998, 01.01.2002             | invalide | RM age enfant 2023 - Barème B2 - 2 Enfants - un moins de 25 ans et un plus de 25   |
        | 17   | 2023  | MARIE                  | NON            | NON        | 01.01.1999                         | invalide | RM age enfant 2023 - Barème B2 - 1 Enfant moins de 25 ans                          |
        | 18   | 2023  | MARIE                  | NON            | NON        | 01.01.2004, 02.05.2006, 02.05.2005 | valide   | RM age enfant 2023 - Barème B2 - 3 Enfants moins de 25 ans                         |
        | 19   | 2023  | MARIE                  | OUI            | NON        | 01.01.2004, 02.05.2006             | invalide | RM age enfant 2023 -Barème B2 - 2 Enfants moins de 25 ans et conjoint avec revenu  |

    Plan du Scénario: Validation Barème B3 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option choisie pour les revenus du conjoint est : <conjAvecRevenu>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année <annee>
      Et que la retenue a le barème B3
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | annee | etat civil             | conjAvecRevenu | unionLibre | date naissance enfants                         | resultat | Observation                                                                               |
        | 1    | 2021  | MARIE                  | NON            | NON        | 01.01.2004, 02.05.2006, 02.05.2005             | valide   | RM age enfant 2021 - Barème B3 - 3 Enfants moins de 18 ans                                |
        | 2    | 2021  | MARIE                  | NON            | NON        | 01.01.2004, 02.05.2006, 02.05.2005, 02.05.2007 | valide   | RM age enfant 2021 - Barème B3 - 4 Enfants moins de 18 ans                                |
        | 3    | 2021  | MARIE                  | NON            | NON        | 30.11.2003, 02.05.2006, 02.05.2005             | invalide | RM age enfant 2021 - Barème B3 - 3 Enfants - 2 moins de 18 ans et un avec 18              |
        | 4    | 2021  | MARIE                  | NON            | NON        | 02.05.2006, 02.05.2005                         | invalide | RM age enfant 2021 - Barème B3 - 2 Enfants moins de 18 ans                                |
        | 5    | 2021  | MARIE                  | NON            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008 | valide   | RM age enfant 2021 - Barème B3 - 4 Enfants moins de 18 ans                                |
        | 6    | 2021  | MARIE                  | OUI            | NON        | 01.01.2004, 02.05.2006                         | invalide | RM age enfant 2021 - Barème B3 - 2 Enfants moins de 18 ans et conjoint avec revenu        |
        | 7    | 2021  | PARTENARIAT_ENREGISTRE | NON            | NON        | 02.05.2004, 02.05.2005, 02.05.2006             | valide   | RM age enfant 2021 - Barème B3 - Partenariat enregistré avec 3 enfants mineurs            |
        | 8    | 2021  | CELIBATAIRE            | NON            | NON        | 02.05.2004                                     | invalide | RM age enfant 2021 - Barème B3 - Célibataire                                              |
        | 9    | 2021  | CELIBATAIRE            | NON            | OUI        | 02.05.2004                                     | invalide | RM age enfant 2021 - Barème B3 - Célibataire en union libre                               |
        | 10   | 2021  | DIVORCE                | NON            | NON        | 02.05.2004                                     | invalide | RM age enfant 2021 - Barème B3 - Divorcé                                                  |
        | 11   | 2021  | VEUF                   | NON            | NON        | 02.05.2004                                     | invalide | RM age enfant 2021 - Barème B3 - Veuf                                                     |
        | 12   | 2021  | SEPARE                 | NON            | NON        | 02.05.2004                                     | invalide | RM age enfant 2021 - Barème B3 - Séparé                                                   |
        | 13   | 2021  | PARTENARIAT_DISSOUS    | NON            | NON        | 02.05.2004                                     | invalide | RM age enfant 2021 - Barème B3 - Partenariat Dissous                                      |
        | 14   | 2023  | MARIE                  | NON            | NON        | 01.01.1999, 02.05.2000, 02.05.2001             | valide   | RM age enfant 2023 - Barème B3 - 3 Enfants moins de 25 ans                                |
        | 15   | 2023  | MARIE                  | NON            | NON        | 01.01.1999, 02.05.2000, 02.05.2001, 02.05.1998 | valide   | RM age enfant 2023 - Barème B3 - 4 Enfants moins de 25 ans                                |
        | 16   | 2023  | MARIE                  | NON            | NON        | 30.11.1998, 02.05.2000, 02.05.2001             | invalide | RM age enfant 2023 - Barème B3 - 3 Enfants - 2 moins de 25 ans et un avec 25              |
        | 17   | 2023  | MARIE                  | NON            | NON        | 02.05.1999, 02.05.2000                         | invalide | RM age enfant 2023 - Barème B3 - 2 Enfants moins de 25 ans                                |
        | 18   | 2023  | MARIE                  | NON            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002 | valide   | RM age enfant 2023 - Barème B3 - 4 Enfants moins de 25 ans                                |
        | 19   | 2023  | MARIE                  | OUI            | NON        | 01.01.1999, 02.05.2000                         | invalide | RM age enfant 2023 - Barème B3 - 2 Enfants moins de 25 ans et conjoint avec revenu        |
        | 20   | 2023  | PARTENARIAT_ENREGISTRE | NON            | NON        | 02.05.1999, 02.05.2000, 02.05.2001             | valide   | RM age enfant 2023 - Barème B3 - Partenariat enregistré avec 3 enfants de moins de 25 ans |

    Plan du Scénario: Validation Barème B4 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option choisie pour les revenus du conjoint est : <conjAvecRevenu>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année <annee>
      Et que la retenue a le barème B4
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | annee | etat civil             | conjAvecRevenu | unionLibre | date naissance enfants                                     | resultat | Observation                                                                               |
        | 1    | 2021  | MARIE                  | NON            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008             | valide   | RM age enfant 2021 - Barème B4 - 4 Enfants moins de 18 ans                                |
        | 2    | 2021  | MARIE                  | NON            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008, 02.05.2000 | valide   | RM age enfant 2021 - Barème B4 - 5 Enfants - 4 moins de 18 ans et un plus de 18           |
        | 3    | 2021  | MARIE                  | NON            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 30.11.2003             | invalide | RM age enfant 2021 - Barème B4 - 4 Enfants - 3 moins de 18 ans et un plus de 18           |
        | 4    | 2021  | MARIE                  | NON            | NON        | 02.05.2006, 02.05.2005, 02.05.2004                         | invalide | RM age enfant 2021 - Barème B4 - 3 Enfants moins de 18 ans                                |
        | 5    | 2021  | MARIE                  | NON            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008, 02.05.2010 | valide   | RM age enfant 2021 - Barème B4 - 5 Enfants moins de 18 ans                                |
        | 6    | 2021  | MARIE                  | OUI            | NON        | 01.01.2004, 02.05.2006                                     | invalide | RM age enfant 2021 - Barème B4 - 2 Enfants moins de 18 ans et conjoint avec revenu        |
        | 7    | 2021  | PARTENARIAT_ENREGISTRE | NON            | NON        | 02.05.2004, 02.05.2005, 02.05.2006, 02.05.2007             | valide   | RM age enfant 2021 - Barème B4 - Partenariat enregistré avec 4 enfants mineurs            |
        | 8    | 2021  | CELIBATAIRE            | NON            | NON        | 02.05.2004                                                 | invalide | Barème B4 - Célibataire                                                                   |
        | 9    | 2021  | CELIBATAIRE            | NON            | OUI        | 02.05.2004                                                 | invalide | Barème B4 - Célibataire en union libre                                                    |
        | 10   | 2021  | DIVORCE                | NON            | NON        | 02.05.2004                                                 | invalide | Barème B4 - Divorcé                                                                       |
        | 11   | 2021  | VEUF                   | NON            | NON        | 02.05.2004                                                 | invalide | Barème B4 - Veuf                                                                          |
        | 12   | 2021  | SEPARE                 | NON            | NON        | 02.05.2004                                                 | invalide | Barème B4 - Séparé                                                                        |
        | 13   | 2021  | PARTENARIAT_DISSOUS    | NON            | NON        | 02.05.2004                                                 | invalide | Barème B4 - Partenariat Dissous                                                           |
        | 14   | 2023  | MARIE                  | NON            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002             | valide   | RM age enfant 2023 - Barème B4 - 4 Enfants moins de 25 ans                                |
        | 15   | 2023  | MARIE                  | NON            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002, 02.05.1998 | valide   | RM age enfant 2023 - Barème B4 - 5 Enfants - 4 moins de 25 ans et un plus de 25           |
        | 16   | 2023  | MARIE                  | NON            | NON        | 02.05.2001, 02.05.2000, 02.05.1999, 30.11.1998             | invalide | RM age enfant 2023 - Barème B4 - 4 Enfants - 3 moins de 25 ans et un plus de 25           |
        | 17   | 2023  | MARIE                  | NON            | NON        | 02.05.1999, 02.05.2000, 02.05.2001                         | invalide | RM age enfant 2023 - Barème B4 - 3 Enfants moins de 25 ans                                |
        | 18   | 2023  | MARIE                  | NON            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002, 02.05.2003 | valide   | RM age enfant 2023 - Barème B4 - 5 Enfants moins de 25 ans                                |
        | 19   | 2023  | MARIE                  | OUI            | NON        | 01.01.1999, 02.05.2000                                     | invalide | RM age enfant 2023 - Barème B4 - 2 Enfants moins de 25 ans et conjoint avec revenu        |
        | 20   | 2023  | PARTENARIAT_ENREGISTRE | NON            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002             | valide   | RM age enfant 2023 - Barème B4 - Partenariat enregistré avec 4 enfants de moins de 25 ans |


    Plan du Scénario: Validation Barème B5 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option choisie pour les revenus du conjoint est : <conjAvecRevenu>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année <annee>
      Et que la retenue a le barème B5
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | annee | etat civil             | conjAvecRevenu | unionLibre | date naissance enfants                                                 | resultat | Observation                                                                               |
        | 1    | 2021  | MARIE                  | NON            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008, 02.05.2010             | valide   | RM age enfant 2021 - Barème B5- 5 Enfants moins de 18 ans                                 |
        | 2    | 2021  | MARIE                  | NON            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008, 02.05.2010, 01.12.2000 | valide   | RM age enfant 2021 - Barème B5- 6 Enfants - 4 moins de 18 ans et un plus de 18            |
        | 3    | 2021  | MARIE                  | NON            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008, 01.12.2000             | invalide | RM age enfant 2021 - Barème B5- 5 Enfants - 4 moins de 18 ans et un plus de 18            |
        | 4    | 2021  | MARIE                  | NON            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008                         | invalide | RM age enfant 2021 - Barème B5- 4 Enfants moins de 18 ans                                 |
        | 5    | 2021  | MARIE                  | NON            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008, 02.05.2008, 02.05.2010 | valide   | RM age enfant 2021 - Barème B5- 6 Enfants moins de 18 ans                                 |
        | 6    | 2021  | MARIE                  | OUI            | NON        | 01.01.2004, 02.05.2006                                                 | invalide | RM age enfant 2021 - Barème B5 - 2 Enfants moins de 18 ans et conjoint avec revenu        |
        | 7    | 2021  | PARTENARIAT_ENREGISTRE | NON            | NON        | 02.05.2004, 02.05.2005, 02.05.2006, 02.05.2007, 02.05.2008             | valide   | RM age enfant 2021 - Barème B5 - Partenariat enregistré avec 5 enfants mineurs            |
        | 8    | 2021  | CELIBATAIRE            | NON            | NON        | 02.05.2004                                                             | invalide | RM age enfant 2021 - Barème B5 - Célibataire                                              |
        | 9    | 2021  | CELIBATAIRE            | NON            | OUI        | 02.05.2004                                                             | invalide | RM age enfant 2021 - Barème B5 - Célibataire en union libre                               |
        | 10   | 2021  | DIVORCE                | NON            | NON        | 02.05.2004                                                             | invalide | RM age enfant 2021 - Barème B5 - Divorcé                                                  |
        | 11   | 2021  | VEUF                   | NON            | NON        | 02.05.2004                                                             | invalide | RM age enfant 2021 - Barème B5 - Veuf                                                     |
        | 12   | 2021  | SEPARE                 | NON            | NON        | 02.05.2004                                                             | invalide | RM age enfant 2021 - Barème B5 - Séparé                                                   |
        | 13   | 2021  | PARTENARIAT_DISSOUS    | NON            | NON        | 02.05.2004                                                             | invalide | RM age enfant 2021 - Barème B5 - Partenariat Dissous                                      |
        | 14   | 2023  | MARIE                  | NON            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002, 02.05.2003             | valide   | RM age enfant 2023 - Barème B5- 5 Enfants moins de 25 ans                                 |
        | 15   | 2023  | MARIE                  | NON            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002, 02.05.2003, 01.12.1998 | valide   | RM age enfant 2023 - Barème B5- 6 Enfants - 4 moins de 25 ans et un plus de 25            |
        | 16   | 2023  | MARIE                  | NON            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002, 01.12.1997             | invalide | RM age enfant 2023 - Barème B5- 5 Enfants - 4 moins de 25 ans et un plus de 25            |
        | 17   | 2023  | MARIE                  | NON            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002                         | invalide | RM age enfant 2023 - Barème B5- 4 Enfants moins de 25 ans                                 |
        | 18   | 2023  | MARIE                  | NON            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002, 02.05.2003, 02.05.2004 | valide   | RM age enfant 2023 - Barème B5- 6 Enfants moins de 25 ans                                 |
        | 19   | 2023  | MARIE                  | OUI            | NON        | 01.01.1999, 02.05.2000                                                 | invalide | RM age enfant 2023 - Barème B5 - 2 Enfants moins de 25 ans et conjoint avec revenu        |
        | 20   | 2023  | PARTENARIAT_ENREGISTRE | NON            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002, 02.05.2003             | valide   | RM age enfant 2023 - Barème B5 - Partenariat enregistré avec 5 enfants de moins de 25 ans |

  Règle: Pour un barème B0-B5, si c'est une barème ajusté alors aucun contrôle n'est effectué et du coup on considère comme valide

    Plan du Scénario: Validation Barème B0-B5 avec barème ajusté - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option choisie pour les revenus du conjoint est : <conjAvecRevenu>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a 0 enfant(s)
      Et une retenue pour Décembre et année 2021
      Et que la retenue a le barème <barème>
      Et que la retenue a un barème ajusté
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | etat civil  | conjAvecRevenu | unionLibre | barème | resultat | Observation               |
        | 1    | CELIBATAIRE | NON            | NON        | B0     | valide   | Barème B0 - Barème ajusté |
        | 2    | CELIBATAIRE | NON            | NON        | B1     | valide   | Barème B1 - Barème ajusté |
        | 3    | CELIBATAIRE | NON            | NON        | B2     | valide   | Barème B2 - Barème ajusté |
        | 4    | CELIBATAIRE | NON            | NON        | B3     | valide   | Barème B3 - Barème ajusté |
        | 5    | CELIBATAIRE | NON            | NON        | B4     | valide   | Barème B4 - Barème ajusté |
        | 6    | CELIBATAIRE | NON            | NON        | B5     | valide   | Barème B5 - Barème ajusté |
