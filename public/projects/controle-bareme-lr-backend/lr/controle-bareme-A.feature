#language: fr

Fonctionnalité: Validation des barèmes A

  Règle: La validation du barème A0 est toujours Valide parce que c'est le barème qui donne la taxation la plus haute,
  donc on bloque jamais si l'utilisateur mets le barème A par erreur, parce que l'erreur serait à faveur de l'AFC.

    Plan du Scénario: Validation Barème A0 - <Test> -> <Observation>
      Etant donné que la personne a l´état civil <etat civil>
      Et que l'option de vie en union libre choisie est : <union libre>
      Et que la personne a <nombre d'enfants> enfant(s)
      Et une retenue pour <mois> et année <année>
      Et que la retenue a le barème A0
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est valide
      Exemples:
        | Test | etat civil             | union libre | nombre d'enfants | mois     | année | Observation                           |
        | 1    | CELIBATAIRE            | NON         | 0                | Décembre | 2021  | Barème A - Célibataire                |
        | 2    | CELIBATAIRE            | NON         | 1                | Décembre | 2021  | Barème A - Célibataire avec enfants   |
        | 3    | MARIE                  | NON         | 0                | Décembre | 2021  | Barème A - Marié                      |
        | 4    | PARTENARIAT_ENREGISTRE | NON         | 0                | Décembre | 2021  | Barème A - Partenariat Enregistré     |
        | 5    | CELIBATAIRE            | OUI         | 0                | Décembre | 2021  | Barème A - Célibataire en Union Libre |
        | 6    | DIVORCE                | NON         | 0                | Décembre | 2021  | Barème A - Divorcé                    |
        | 7    | SEPARE                 | NON         | 0                | Décembre | 2021  | Barème A - Séparé                     |
        | 8    | VEUF                   | NON         | 0                | Décembre | 2021  | Barème A - Veuf                       |
        | 9    | PARTENARIAT_DISSOUS    | NON         | 0                | Décembre | 2021  | Barème A - Partenariat Dissous        |

  Règle: Puisque les barèmes A1-A5 sont donnés directement par l'AFC (pour des cas particuliers) le seul contrôle
  à faire est que ce soit un barème ajusté.

    Plan du Scénario: Validation Barèmes A1-A5 avec barème ajusté - <Test> -> <Observation>
      Etant donné que la personne a l´état civil CELIBATAIRE
      Etant donné une retenue pour <mois> et année <année>
      Et que la retenue a le barème <barème>
      Et que la retenue a un barème ajusté
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est valide
      Exemples:
        | Test | barème | mois     | année | Observation                          |
        | 1    | A1     | Décembre | 2021  | Barème A1 - Valide car barème ajusté |
        | 2    | A2     | Décembre | 2021  | Barème A2 - Valide car barème ajusté |
        | 3    | A3     | Décembre | 2021  | Barème A3 - Valide car barème ajusté |
        | 4    | A4     | Décembre | 2021  | Barème A4 - Valide car barème ajusté |
        | 5    | A5     | Décembre | 2021  | Barème A5 - Valide car barème ajusté |

    Plan du Scénario: Validation Barèmes A1-A5 sans barème ajusté - <Test> -> <Observation>
      Etant donné que la personne a l´état civil CELIBATAIRE
      Etant donné que une retenue pour <mois> et année <année>
      Et que la retenue a le barème <barème>
      Et que la retenue n'a pas un barème ajusté
      Quand on demande de valider le barème
      Alors le système renvoie que le barème est invalide
      Exemples:
        | Test | barème | mois     | année | Observation                                |
        | 1    | A1     | Décembre | 2021  | Barème A1 - Invalide car pas barème ajusté |
        | 2    | A2     | Décembre | 2021  | Barème A2 - Invalide car pas barème ajusté |
        | 3    | A3     | Décembre | 2021  | Barème A3 - Invalide car pas barème ajusté |
        | 4    | A4     | Décembre | 2021  | Barème A4 - Invalide car pas barème ajusté |
        | 5    | A5     | Décembre | 2021  | Barème A5 - Invalide car pas barème ajusté |
