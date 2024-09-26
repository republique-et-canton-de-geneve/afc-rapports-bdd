#language: fr

Fonctionnalité: Validation des barèmes C

  Règle: Pour que le barème C0 soit valide, la personne doit être en situation maritale (marié, partenariat enreg) et le conjoint doit avoir des revenus.

    Plan du Scénario: Validation Barème C0 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option choisie pour les revenus du conjoint est : <conjoint avec revenu>
      Et que l'option de vie en union libre choisie est : <union libre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année 2021
      Et que la retenue a le barème C0
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | etat civil             | conjoint avec revenu | union libre | date naissance enfants | resultat | Observation                                              |
        | 1    | MARIE                  | OUI                  | NON         |                        | valide   | Barème C0 - marié et conjoint avec revenu                |
        | 2    | PARTENARIAT_ENREGISTRE | OUI                  | NON         |                        | valide   | Barème C0 - partenariat enreg et conjoint avec revenu    |
        | 3    | MARIE                  | NON                  | NON         |                        | invalide | Barème C0 - marié et conjoint sans revenu                |
        | 4    | MARIE                  | OUI                  | NON         | 01.01.2004             | valide   | Barème C0 - avec enfants (valide car en faveur de l'AFC) |
        | 5    | CELIBATAIRE            | OUI                  | NON         |                        | invalide | Barème C0 - célibataire                                  |
        | 6    | CELIBATAIRE            | OUI                  | OUI         |                        | invalide | Barème C0 - célibataire en union libre                   |
        | 7    | DIVORCE                | OUI                  | NON         |                        | invalide | Barème C0 - Divorcé                                      |
        | 8    | SEPARE                 | OUI                  | NON         |                        | invalide | Barème C0 - Séparé                                       |
        | 9    | VEUF                   | OUI                  | NON         |                        | invalide | Barème C0 - Veuf                                         |
        | 10   | PARTENARIAT_DISSOUS    | OUI                  | NON         |                        | invalide | Barème C0 - Partenariat dissous                          |


  Règle: Pour que les barèmes C1-C5 soient valides, la personne doit être en situation maritale, son conjoint doit avoir des revenus
  et le nombre d'enfants avec moins de 18 ans(RM 2021) ou 25 ans(RM 2023) le dernier jour du mois précédent de la retenue doit être égale ou supérieur à "x" pour un barème Cx

    Plan du Scénario: Validation Barème C1 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option choisie pour les revenus du conjoint est : <conjAvecRevenu>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année <annee>
      Et que la retenue a le barème C1
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | annee | etat civil             | conjAvecRevenu | unionLibre | date naissance enfants | resultat | Observation                                                          |
        | 1    | 2021  | MARIE                  | OUI            | NON        | 01.01.2004             | valide   | RM age enfant 2021 - Barème C1 - Marié 1 Enfant ayant 17 ans         |
        | 2    | 2021  | MARIE                  | OUI            | NON        |                        | invalide | RM age enfant 2021 - Barème C1 - Sans enfants                        |
        | 3    | 2021  | MARIE                  | OUI            | NON        | 30.11.2003             | invalide | RM age enfant 2021 - Barème C1 - Enfant ayant 18 ans                 |
        | 4    | 2021  | MARIE                  | OUI            | NON        | 29.11.2004, 02.05.2005 | valide   | RM age enfant 2021 -  Barème C1 - 2 Enfants ayant moins de 18 ans    |
        | 5    | 2021  | MARIE                  | OUI            | NON        | 30.11.2000, 02.05.2005 | valide   | RM age enfant 2021 - Barème C1 - 2 Enfants, un ayant moins de 18 ans |
        | 6    | 2021  | PARTENARIAT_ENREGISTRE | OUI            | NON        | 02.05.2004             | valide   | Barème C1 - Partenariat enregistré                                   |
        | 7    | 2021  | MARIE                  | NON            | NON        | 02.05.2004             | invalide | Barème C1 - Partenaire sans revenue                                  |
        | 8    | 2021  | CELIBATAIRE            | OUI            | NON        | 02.05.2004             | invalide | Barème C1 - Célibataire                                              |
        | 9    | 2021  | CELIBATAIRE            | OUI            | OUI        | 02.05.2004             | invalide | Barème C1 - Célibataire en union libre                               |
        | 10   | 2021  | DIVORCE                | OUI            | NON        | 02.05.2004             | invalide | Barème C1 - Divorcé                                                  |
        | 11   | 2021  | VEUF                   | OUI            | NON        | 02.05.2004             | invalide | Barème C1 - Veuf                                                     |
        | 12   | 2021  | SEPARE                 | OUI            | NON        | 02.05.2004             | invalide | Barème C1 - Séparé                                                   |
        | 13   | 2021  | PARTENARIAT_DISSOUS    | OUI            | NON        | 02.05.2004             | invalide | Barème C1 - Partenariat Dissous                                      |
        | 14   | 2023  | MARIE                  | OUI            | NON        | 01.01.1999             | valide   | RM age enfant 2023 - Barème C1 - Marié 1 Enfant ayant 24 ans         |
        | 15   | 2023  | MARIE                  | OUI            | NON        |                        | invalide | RM age enfant 2023 - Barème C1 - Sans enfants                        |
        | 16   | 2023  | MARIE                  | OUI            | NON        | 30.11.1998             | invalide | RM age enfant 2023 - Barème C1 - Enfant ayant 25 ans                 |
        | 17   | 2023  | MARIE                  | OUI            | NON        | 29.11.1999, 02.05.2000 | valide   | RM age enfant 2023 - Barème C1 - 2 Enfants ayant moins de 25 ans     |
        | 18   | 2023  | MARIE                  | OUI            | NON        | 30.11.1998, 02.05.1999 | valide   | RM age enfant 2023 - Barème C1 - 2 Enfants, un ayant moins de 25 ans |

    Plan du Scénario: Validation Barème C2 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option choisie pour les revenus du conjoint est : <conjAvecRevenu>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année <annee>
      Et que la retenue a le barème C2
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | annee | etat civil             | conjAvecRevenu | unionLibre | date naissance enfants             | resultat | Observation                                                                                  |
        | 1    | 2021  | MARIE                  | OUI            | NON        | 01.01.2004, 02.05.2005             | valide   | RM age enfant 2021 - Barème C2 - 2 Enfants ayant moins de 18 ans                             |
        | 2    | 2021  | MARIE                  | OUI            | NON        | 01.01.2004, 02.05.2000, 02.05.2005 | valide   | RM age enfant 2021 - Barème C2 - 3 Enfants - 2 ayant moins de 18 ans et un ayant plus de 18  |
        | 3    | 2021  | MARIE                  | OUI            | NON        | 01.01.2004, 01.01.2002             | invalide | RM age enfant 2021 - Barème C2 - 2 Enfants - un ayant moins de 18 ans et un ayant plus de 18 |
        | 4    | 2021  | MARIE                  | OUI            | NON        | 01.01.2004                         | invalide | RM age enfant 2021 - Barème C2 - 1 Enfant ayant moins de 18 ans                              |
        | 5    | 2021  | MARIE                  | OUI            | NON        | 01.01.2004, 02.05.2006, 02.05.2005 | valide   | RM age enfant 2021 - Barème C2 - 3 Enfants ayant moins de 18 ans                             |
        | 6    | 2021  | MARIE                  | NON            | NON        | 01.01.2004, 02.05.2006             | invalide | RM age enfant 2021 - Barème C2 - 2 Enfants ayant moins de 18 ans et conjoint sans revenu     |
        | 7    | 2021  | PARTENARIAT_ENREGISTRE | OUI            | NON        | 02.05.2004, 02.05.2005             | valide   | Barème C2 - Partenariat enregistré                                                           |
        | 8    | 2021  | CELIBATAIRE            | OUI            | NON        | 02.05.2004                         | invalide | Barème C2 - Célibataire                                                                      |
        | 9    | 2021  | CELIBATAIRE            | OUI            | OUI        | 02.05.2004                         | invalide | Barème C2 - Célibataire en union libre                                                       |
        | 10   | 2021  | DIVORCE                | OUI            | NON        | 02.05.2004                         | invalide | Barème C2 - Divorcé                                                                          |
        | 11   | 2021  | VEUF                   | OUI            | NON        | 02.05.2004                         | invalide | Barème C2 - Veuf                                                                             |
        | 12   | 2021  | SEPARE                 | OUI            | NON        | 02.05.2004                         | invalide | Barème C2 - Séparé                                                                           |
        | 13   | 2021  | PARTENARIAT_DISSOUS    | OUI            | NON        | 02.05.2004                         | invalide | Barème C2 - Partenariat Dissous                                                              |
        | 14   | 2023  | MARIE                  | OUI            | NON        | 01.01.1999, 02.05.2000             | valide   | RM age enfant 2023 - Barème C2 - 2 Enfants ayant moins de 25 ans                             |
        | 15   | 2023  | MARIE                  | OUI            | NON        | 01.01.1997, 02.05.1999, 02.05.2000 | valide   | RM age enfant 2023 - Barème C2 - 3 Enfants - 2 ayant moins de 25 ans et un ayant plus de 25  |
        | 16   | 2023  | MARIE                  | OUI            | NON        | 01.01.1997, 01.01.1999             | invalide | RM age enfant 2023 - Barème C2 - 2 Enfants - un ayant moins de 25 ans et un ayant plus de 25 |
        | 17   | 2023  | MARIE                  | OUI            | NON        | 01.01.1999                         | invalide | RM age enfant 2023 - Barème C2 - 1 Enfant ayant moins de 25 ans                              |
        | 18   | 2023  | MARIE                  | OUI            | NON        | 01.01.1999, 02.05.2000, 02.05.2001 | valide   | RM age enfant 2023 - Barème C2 - 3 Enfants ayant moins de 25 ans                             |
        | 19   | 2023  | MARIE                  | NON            | NON        | 01.01.1999, 02.05.2000             | invalide | RM age enfant 2023 - Barème C2 - 2 Enfants ayant moins de 25 ans et conjoint sans revenu     |
    Plan du Scénario: Validation Barème C3 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option choisie pour les revenus du conjoint est : <conjAvecRevenu>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année <annee>
      Et que la retenue a le barème C3
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | annee | etat civil             | conjAvecRevenu | unionLibre | date naissance enfants                         | resultat | Observation                                                                               |
        | 1    | 2021  | MARIE                  | OUI            | NON        | 01.01.2004, 02.05.2006, 02.05.2005             | valide   | RM age enfant 2021 - Barème C3 - 3 Enfants ayant moins de 18 ans                          |
        | 2    | 2021  | MARIE                  | OUI            | NON        | 01.01.2004, 02.05.2006, 02.05.2005, 02.05.2007 | valide   | RM age enfant 2021 - Barème C3 - 4 Enfants ayant moins de 18 ans                          |
        | 3    | 2021  | MARIE                  | OUI            | NON        | 30.11.2003, 02.05.2006, 02.05.2005             | invalide | RM age enfant 2021 - Barème C3 - 3 Enfants - 2 ayant moins de 18 ans et un ayant 18       |
        | 4    | 2021  | MARIE                  | OUI            | NON        | 02.05.2006, 02.05.2005                         | invalide | RM age enfant 2021 - Barème C3 - 2 Enfants ayant moins de 18 ans                          |
        | 5    | 2021  | MARIE                  | OUI            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008 | valide   | RM age enfant 2021 - Barème C3 - 4 Enfants ayant moins de 18 ans                          |
        | 6    | 2021  | MARIE                  | NON            | NON        | 01.01.2004, 02.05.2006                         | invalide | RM age enfant 2021 - Barème C3 - 2 Enfants ayant moins de 18 ans et conjoint sans revenu  |
        | 7    | 2021  | PARTENARIAT_ENREGISTRE | OUI            | NON        | 02.05.2004, 02.05.2005, 02.05.2006             | valide   | RM age enfant 2021 - Barème C3 - Partenariat enregistré avec 3 enfants mineurs            |
        | 8    | 2021  | CELIBATAIRE            | OUI            | NON        | 02.05.2004                                     | invalide | Barème C3 - Célibataire                                                                   |
        | 9    | 2021  | CELIBATAIRE            | OUI            | OUI        | 02.05.2004                                     | invalide | Barème C3 - Célibataire en union libre                                                    |
        | 10   | 2021  | DIVORCE                | OUI            | NON        | 02.05.2004                                     | invalide | Barème C3 - Divorcé                                                                       |
        | 11   | 2021  | VEUF                   | OUI            | NON        | 02.05.2004                                     | invalide | Barème C3 - Veuf                                                                          |
        | 12   | 2021  | SEPARE                 | OUI            | NON        | 02.05.2004                                     | invalide | Barème C3 - Séparé                                                                        |
        | 13   | 2021  | PARTENARIAT_DISSOUS    | OUI            | NON        | 02.05.2004                                     | invalide | Barème C3 - Partenariat Dissous                                                           |
        | 14   | 2023  | MARIE                  | OUI            | NON        | 01.01.1999, 02.05.2000, 02.05.2001             | valide   | RM age enfant 2023 - Barème C3 - 3 Enfants ayant moins de 25 ans                          |
        | 15   | 2023  | MARIE                  | OUI            | NON        | 01.01.1999, 02.05.2000, 02.05.2001, 02.05.2002 | valide   | RM age enfant 2023 - Barème C3 - 4 Enfants ayant moins de 25 ans                          |
        | 16   | 2023  | MARIE                  | OUI            | NON        | 30.11.1999, 02.05.2000, 02.05.1998             | invalide | RM age enfant 2023 - Barème C3 - 3 Enfants - 2 ayant moins de 25 ans et un ayant 25       |
        | 17   | 2023  | MARIE                  | OUI            | NON        | 02.05.1999, 02.05.2000                         | invalide | RM age enfant 2023 - Barème C3 - 2 Enfants ayant moins de 25 ans                          |
        | 18   | 2023  | MARIE                  | OUI            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002 | valide   | RM age enfant 2023 - Barème C3 - 4 Enfants ayant moins de 25 ans                          |
        | 19   | 2023  | MARIE                  | NON            | NON        | 01.01.1999, 02.05.2000                         | invalide | RM age enfant 2023 - Barème C3 - 2 Enfants ayant moins de 25 ans et conjoint sans revenu  |
        | 20   | 2023  | PARTENARIAT_ENREGISTRE | OUI            | NON        | 02.05.1999, 02.05.2000, 02.05.2001             | valide   | RM age enfant 2023 - Barème C3 - Partenariat enregistré avec 3 enfants de moins de 25 ans |

    Plan du Scénario: Validation Barème C4 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option choisie pour les revenus du conjoint est : <conjAvecRevenu>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année <annee>
      Et que la retenue a le barème C4
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | annee | etat civil             | conjAvecRevenu | unionLibre | date naissance enfants                                     | resultat | Observation                                                                                 |
        | 1    | 2021  | MARIE                  | OUI            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008             | valide   | RM age enfant 2021 - Barème C4 - 4 Enfants ayant moins de 18 ans                            |
        | 2    | 2021  | MARIE                  | OUI            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008, 02.05.2000 | valide   | RM age enfant 2021 - Barème C4 - 5 Enfants - 4 ayant moins de 18 ans et un ayant plus de 18 |
        | 3    | 2021  | MARIE                  | OUI            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 30.11.2003             | invalide | RM age enfant 2021 - Barème C4 - 4 Enfants - 3 ayant moins de 18 ans et un ayant plus de 18 |
        | 4    | 2021  | MARIE                  | OUI            | NON        | 02.05.2006, 02.05.2005, 02.05.2004                         | invalide | RM age enfant 2021 - Barème C4 - 3 Enfants ayant moins de 18 ans                            |
        | 5    | 2021  | MARIE                  | OUI            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008, 02.05.2010 | valide   | RM age enfant 2021 - Barème C4 - 5 Enfants ayant moins de 18 ans                            |
        | 6    | 2021  | MARIE                  | NON            | NON        | 01.01.2004, 02.05.2006                                     | invalide | RM age enfant 2021 - Barème C4 - 2 Enfants ayant moins de 18 ans et conjoint sans revenu    |
        | 7    | 2021  | PARTENARIAT_ENREGISTRE | OUI            | NON        | 02.05.2004, 02.05.2005, 02.05.2006, 02.05.2007             | valide   | Barème C4 - Partenariat enregistré avec 4 enfants mineurs                                   |
        | 8    | 2021  | CELIBATAIRE            | OUI            | NON        | 02.05.2004                                                 | invalide | Barème C4 - Célibataire                                                                     |
        | 9    | 2021  | CELIBATAIRE            | OUI            | OUI        | 02.05.2004                                                 | invalide | Barème C4 - Célibataire en union libre                                                      |
        | 10   | 2021  | DIVORCE                | OUI            | NON        | 02.05.2004                                                 | invalide | Barème C4 - Divorcé                                                                         |
        | 11   | 2021  | VEUF                   | OUI            | NON        | 02.05.2004                                                 | invalide | Barème C4 - Veuf                                                                            |
        | 12   | 2021  | SEPARE                 | OUI            | NON        | 02.05.2004                                                 | invalide | Barème C4 - Séparé                                                                          |
        | 13   | 2021  | PARTENARIAT_DISSOUS    | OUI            | NON        | 02.05.2004                                                 | invalide | Barème C4 - Partenariat Dissous                                                             |
        | 14   | 2023  | MARIE                  | OUI            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002             | valide   | RM age enfant 2023 - Barème C4 - 4 Enfants ayant moins de 25 ans                            |
        | 15   | 2023  | MARIE                  | OUI            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002, 02.05.1997 | valide   | RM age enfant 2023 - Barème C4 - 5 Enfants - 4 ayant moins de 25 ans et un ayant plus de 25 |
        | 16   | 2023  | MARIE                  | OUI            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 30.11.1997             | invalide | RM age enfant 2023 - Barème C4 - 4 Enfants - 3 ayant moins de 25 ans et un ayant plus de 25 |
        | 17   | 2023  | MARIE                  | OUI            | NON        | 02.05.1999, 02.05.2000, 02.05.2001                         | invalide | RM age enfant 2023 - Barème C4 - 3 Enfants ayant moins de 25 ans                            |
        | 18   | 2023  | MARIE                  | OUI            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002, 02.05.2003 | valide   | RM age enfant 2023 - Barème C4 - 5 Enfants ayant moins de 25 ans                            |
        | 19   | 2023  | MARIE                  | NON            | NON        | 01.01.1999, 02.05.2000                                     | invalide | RM age enfant 2023 - Barème C4 - 2 Enfants ayant moins de 25 ans et conjoint sans revenu    |
        | 20   | 2023  | PARTENARIAT_ENREGISTRE | OUI            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002             | valide   | RM age enfant 2023 - Barème C4 - Partenariat enregistré avec 4 enfants de moins de 25 ans   |

    Plan du Scénario: Validation Barème C5 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option choisie pour les revenus du conjoint est : <conjAvecRevenu>
      Et que l'option de vie en union libre choisie est : <unionLibre>
      Et que la personne a des enfants nés le : <date naissance enfants>
      Et une retenue pour Décembre et année <annee>
      Et que la retenue a le barème C5
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est <resultat>
      Exemples:
        | Test | annee | etat civil             | conjAvecRevenu | unionLibre | date naissance enfants                                                 | resultat | Observation                                                                                |
        | 1    | 2021  | MARIE                  | OUI            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008, 02.05.2010             | valide   | RM age enfant 2021 - Barème C5- 5 Enfants ayant moins de 18 ans                            |
        | 2    | 2021  | MARIE                  | OUI            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008, 02.05.2010, 01.12.2000 | valide   | RM age enfant 2021 - Barème C5- 6 Enfants - 4 ayant moins de 18 ans et un ayant plus de 18 |
        | 3    | 2021  | MARIE                  | OUI            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008, 01.12.2000             | invalide | RM age enfant 2021 - Barème C5- 5 Enfants - 4 ayant moins de 18 ans et un ayant plus de 18 |
        | 4    | 2021  | MARIE                  | OUI            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008                         | invalide | RM age enfant 2021 - Barème C5- 4 Enfants ayant moins de 18 ans                            |
        | 5    | 2021  | MARIE                  | OUI            | NON        | 02.05.2006, 02.05.2005, 02.05.2004, 02.05.2008, 02.05.2008, 02.05.2010 | valide   | RM age enfant 2021 - Barème C5- 6 Enfants ayant moins de 18 ans                            |
        | 6    | 2021  | MARIE                  | NON            | NON        | 01.01.2004, 02.05.2006                                                 | invalide | RM age enfant 2021 - Barème C5 - 2 Enfants ayant moins de 18 ans et conjoint sans revenu   |
        | 7    | 2021  | PARTENARIAT_ENREGISTRE | OUI            | NON        | 02.05.2004, 02.05.2005, 02.05.2006, 02.05.2007, 02.05.2008             | valide   | RM age enfant 2021 - Barème C5 - Partenariat enregistré avec 5 enfants mineurs             |
        | 8    | 2021  | CELIBATAIRE            | OUI            | NON        | 02.05.2004                                                             | invalide | Barème C5 - Célibataire                                                                    |
        | 9    | 2021  | CELIBATAIRE            | OUI            | OUI        | 02.05.2004                                                             | invalide | Barème C5 - Célibataire en union libre                                                     |
        | 10   | 2021  | DIVORCE                | OUI            | NON        | 02.05.2004                                                             | invalide | Barème C5 - Divorcé                                                                        |
        | 11   | 2021  | VEUF                   | OUI            | NON        | 02.05.2004                                                             | invalide | Barème C5 - Veuf                                                                           |
        | 12   | 2021  | SEPARE                 | OUI            | NON        | 02.05.2004                                                             | invalide | Barème C5 - Séparé                                                                         |
        | 13   | 2021  | PARTENARIAT_DISSOUS    | OUI            | NON        | 02.05.2004                                                             | invalide | Barème C5 - Partenariat Dissous                                                            |
        | 14   | 2023  | MARIE                  | OUI            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002, 02.05.2003             | valide   | RM age enfant 2023 - Barème C5- 5 Enfants ayant moins de 25 ans                            |
        | 15   | 2023  | MARIE                  | OUI            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002, 02.05.2003, 01.12.1997 | valide   | RM age enfant 2023 - Barème C5- 6 Enfants - 4 ayant moins de 25 ans et un ayant plus de 25 |
        | 16   | 2023  | MARIE                  | OUI            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002, 01.12.1997             | invalide | RM age enfant 2023 - Barème C5- 5 Enfants - 4 ayant moins de 25 ans et un ayant plus de 25 |
        | 17   | 2023  | MARIE                  | OUI            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002                         | invalide | RM age enfant 2023 - Barème C5- 4 Enfants ayant moins de 25 ans                            |
        | 18   | 2023  | MARIE                  | OUI            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002, 02.05.2003, 02.05.2004 | valide   | RM age enfant 2023 - Barème C5- 6 Enfants ayant moins de 25 ans                            |
        | 19   | 2023  | MARIE                  | NON            | NON        | 01.01.1999, 02.05.2000                                                 | invalide | RM age enfant 2023 - Barème C5 - 2 Enfants ayant moins de 25 ans et conjoint sans revenu   |
        | 20   | 2023  | PARTENARIAT_ENREGISTRE | OUI            | NON        | 02.05.1999, 02.05.2000, 02.05.2001, 02.05.2002, 02.05.2003             | valide   | RM age enfant 2023 - Barème C5 - Partenariat enregistré avec 5 enfants de moins de 25 ans  |

  Règle: Pour un barème C0-C5, si c'est une barème ajusté alors aucun contrôle n'est effectué et du coup on considère comme valide

    Plan du Scénario: Validation Barème C0-C5 avec barème ajusté - <Test> -> <Observation>
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
        | 1    | CELIBATAIRE | OUI            | NON        | C0     | valide   | Barème C0 - Barème ajusté |
        | 2    | CELIBATAIRE | OUI            | NON        | C1     | valide   | Barème C1 - Barème ajusté |
        | 3    | CELIBATAIRE | OUI            | NON        | C2     | valide   | Barème C2 - Barème ajusté |
        | 4    | CELIBATAIRE | OUI            | NON        | C3     | valide   | Barème C3 - Barème ajusté |
        | 5    | CELIBATAIRE | OUI            | NON        | C4     | valide   | Barème C4 - Barème ajusté |
        | 6    | CELIBATAIRE | OUI            | NON        | C5     | valide   | Barème C5 - Barème ajusté |
