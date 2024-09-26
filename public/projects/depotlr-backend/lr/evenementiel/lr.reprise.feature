#language: fr
Fonctionnalité: Tester la reprise des LR Evenementiels

  Règle: Pour une LR ASC initialisé depuis une LR année N-1, les données suivantes sont repris :
  - les données DPI
  - le référentiel des lieux de travail

    Scénario: Création d´une LR événementiel ASC pour l'année 2022 avec reprise des données d'une LR soumise 2021
      Etant donné que l´année fiscale en cours est 2021
      Etant donné que la date du jour est 28.02.2021
      Etant donné que le DPI suivant est sélectionné:
        | numeroDpi | numeroReferencePersonne | typeDpi | nom            | adresse |
        | 9999      | 12345678                | ASC     | Etat de Genève | OCSIN   |
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Etant donné que l´utilisateur transmet sa LR
      Etant donné que l´année fiscale en cours est 2022
      Etant donné que la date du jour est 31.01.2022
      Quand l´utilisateur crée une nouvelle LR 2022 pour ce DPI
      Alors il existe le DPI suivant:
        | numeroDpi | numeroReferencePersonne | typeDpi | nom            | adresse |
        | 9999      | 12345678                | ASC     | Etat de Genève | OCSIN   |
      Et il existe aucune retenue événementiel dans la LR
      Et il existe les lieux de travail suivants:
        | id | pays | nomLieu | rue | commune | npa  | localite | canton | casePostale | idPadr    | logeur | numero |
        | 1  | CH   | NomLieu | rue | 6645    | 1211 | Geneve   | GE     | casePostale | 123456789 | logeur | numero |

  Règle: Pour une LR Prestations en capital initialisé depuis une LR année N-1, les données suivantes sont repris :
  - les données DPI

    Scénario: Création d´une LR événementiel PRESTATIONS_EN_CAPITAL pour l'année 2022 avec reprise des données d'une LR soumise 2021
      Etant donné que l´année fiscale en cours est 2021
      Etant donné que la date du jour est 28.02.2021
      Etant donné que le DPI suivant est sélectionné:
        | numeroDpi | numeroReferencePersonne | typeDpi                | nom            | adresse |
        | 9999      | 12345678                | PRESTATIONS_EN_CAPITAL | Etat de Genève | OCSIN   |
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Etant donné que l´utilisateur transmet sa LR
      Etant donné que l´année fiscale en cours est 2022
      Etant donné que la date du jour est 31.01.2022
      Quand l´utilisateur crée une nouvelle LR 2022 pour ce DPI
      Alors il existe le DPI suivant:
        | numeroDpi | numeroReferencePersonne | typeDpi                | nom            | adresse |
        | 9999      | 12345678                | PRESTATIONS_EN_CAPITAL | Etat de Genève | OCSIN   |
      Et il existe aucune retenue événementiel dans la LR


  Règle: Pour une LR ASC initialisé depuis une LR même année fiscale, les données suivantes sont repris :
  - les données DPI
  - le référentiel des lieux de travail
  - les retenues événementiels

    Scénario: Création d´une LR événementiel ASC pour l'année 2022 avec reprise des données d'une LR soumise 2022
      Etant donné que l´année fiscale en cours est 2022
      Etant donné que la date du jour est 28.02.2022
      Etant donné que le DPI suivant est sélectionné:
        | numeroDpi | numeroReferencePersonne | typeDpi | nom            | adresse |
        | 9999      | 12345678                | ASC     | Etat de Genève | OCSIN   |
      Etant donné qu'il existe une LR Brouillon complète en 2022 pour ce DPI
      Etant donné que l´utilisateur transmet sa LR
      Etant donné que la date du jour est 31.03.2022
      Quand l´utilisateur crée une nouvelle LR 2022 pour ce DPI
      Alors il existe le DPI suivant:
        | numeroDpi | numeroReferencePersonne | typeDpi | nom            | adresse |
        | 9999      | 12345678                | ASC     | Etat de Genève | OCSIN   |
      Et il existe 1 retenue événementiel dans la LR
      Et il existe les lieux de travail suivants:
        | id | pays | nomLieu | rue | commune | npa  | localite | canton | casePostale | idPadr    | logeur | numero |
        | 1  | CH   | NomLieu | rue | 6645    | 1211 | Geneve   | GE     | casePostale | 123456789 | logeur | numero |

  Règle: Pour une LR Prestations en Capital initialisé depuis une LR même année fiscale, les données suivantes sont repris :
  - les données DPI
  - les retenues événementiels

    Scénario: Création d´une LR événementiel Prestations en Capital pour l'année 2022 avec reprise des données d'une LR soumise 2022
      Etant donné que l´année fiscale en cours est 2022
      Etant donné que la date du jour est 28.02.2022
      Etant donné que le DPI suivant est sélectionné:
        | numeroDpi | numeroReferencePersonne | typeDpi                | nom            | adresse |
        | 9999      | 12345678                | PRESTATIONS_EN_CAPITAL | Etat de Genève | OCSIN   |
      Etant donné qu'il existe une LR Brouillon complète en 2022 pour ce DPI
      Etant donné que l´utilisateur transmet sa LR
      Etant donné que la date du jour est 31.03.2022
      Quand l´utilisateur crée une nouvelle LR 2022 pour ce DPI
      Alors il existe le DPI suivant:
        | numeroDpi | numeroReferencePersonne | typeDpi                | nom            | adresse |
        | 9999      | 12345678                | PRESTATIONS_EN_CAPITAL | Etat de Genève | OCSIN   |
      Et il existe 1 retenue événementiel dans la LR

