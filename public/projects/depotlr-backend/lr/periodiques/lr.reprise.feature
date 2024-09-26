#language: fr
Fonctionnalité: Tester la reprise d'une LR périodique depuis la LR N-1

  Règle: Lors de la reprise d'une LR N-1, les données de la LR soumise sont à reprendre selon les règles ci-dessous:
  1. Les données DPI
  2. Le référentiel des lieux de travail
  3. Le référentiel des personnes, moins celles sorties durant l'année précédente (date de fin d'activité inférieure à l'année concernée),
  3.1 Les périodes d'activités inactives sont supprimées
  4. Les prestations imposables ne sont pas reprises (vide)

    Contexte:
      Etant donné que l´année fiscale en cours est 2021
      Etant donné que la date du jour est 28.02.2021
      Etant donné que le DPI suivant est sélectionné:
        | numeroDpi | numeroReferencePersonne | typeDpi  | nom            | adresse |
        | 9999      | 12345678                | SALARIES | Etat de Genève | OCSIN   |
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné que les lieux de travail suivants sont ajoutés au référentiel des lieux de travail:
        | pays | nomLieu | rue | commune | npa  | localite | canton |
        | CH   | nom     | rue | 6621    | 1000 | Genève   | GE     |

    Scénario: Création d´une LR pour l'année 2022 avec reprise des données d'une LR soumise 2021 avec un salarié actif en 2022
      Etant donné que l'utilisateur ajoute un salarié à cette LR avec une période d'activité du 01.01.2021 au 28.02.2022
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
        | Février | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
      Etant donné que l'utilisateur ajoute un salarié à cette LR avec une période d'activité du 01.01.2021 au 28.02.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
        | Février | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
      Etant donné que l´utilisateur transmet sa LR
      Etant donné que l´année fiscale en cours est 2022
      Etant donné que la date du jour est 31.01.2022
      Quand l´utilisateur crée une nouvelle LR 2022 pour ce DPI
      Alors il existe 1 personne dans le référentiel des personnes
      Et la personne avec id 1 a le rapport de travail suivant:
        | Début      | Fin        |
        | 01.01.2021 | 28.02.2022 |
      Et il existe les retenues mensuelles suivantes pour la personne avec id 1:
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier |                      |                     |                     |            |                 |        | Non           |
        | Février |                      |                     |                     |            |                 |        | Non           |
      Et il existe les lieux de travail suivants:
        | pays | nomLieu | rue | commune | npa  | localite | canton |
        | CH   | nom     | rue | 6621    | 1000 | Genève   | GE     |
      Et il existe le DPI suivant:
        | numeroDpi | numeroReferencePersonne | typeDpi  | nom            | adresse |
        | 9999      | 12345678                | SALARIES | Etat de Genève | OCSIN   |


    Scénario: Création d´une LR pour l'année 2022 avec reprise des données d'une LR soumise 2021 sans aucun salarié actif en 2022
      Etant donné que l'utilisateur ajoute un salarié à cette LR avec une période d'activité du 01.01.2021 au 28.02.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
        | Février | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
      Etant donné que l´utilisateur transmet sa LR
      Etant donné que l´année fiscale en cours est 2022
      Etant donné que la date du jour est 31.01.2022
      Quand l´utilisateur crée une nouvelle LR 2022 pour ce DPI
      Alors il existe 0 personne dans le référentiel des personnes
      Et il existe les lieux de travail suivants:
        | pays | nomLieu | rue | commune | npa  | localite | canton |
        | CH   | nom     | rue | 6621    | 1000 | Genève   | GE     |
      Et il existe le DPI suivant:
        | numeroDpi | numeroReferencePersonne | typeDpi  | nom            | adresse |
        | 9999      | 12345678                | SALARIES | Etat de Genève | OCSIN   |

    Scénario: Création d´une LR pour l'année 2022 avec reprise des données d'une LR soumise 2021 avec un salarié actif en 2022 avec des périodes de travail inactives dont une encore active
      Etant donné que la date du jour est 17.11.2021
      Etant donné que l'utilisateur ajoute un salarié à cette LR avec une période d'activité du 01.01.2021 au 28.01.2022
      Quand l'utilisateur modifie les périodes d'activité de ce salarié:
        | Début      | Fin        |
        | 01.01.2021 | 25.01.2021 |
        | 15.02.2021 | 22.02.2021 |
        | 15.03.2021 |            |
      Etant donné que l´utilisateur transmet sa LR
      Etant donné que l´année fiscale en cours est 2022
      Etant donné que la date du jour est 31.01.2022
      Quand l´utilisateur crée une nouvelle LR 2022 pour ce DPI
      Alors il existe 1 personne dans le référentiel des personnes
      Et la personne avec id 1 a le rapport de travail suivant:
        | Début      | Fin        |
        | 15.03.2021 |            |
      Et il existe les lieux de travail suivants:
        | pays | nomLieu | rue | commune | npa  | localite | canton |
        | CH   | nom     | rue | 6621    | 1000 | Genève   | GE     |
      Et il existe le DPI suivant:
        | numeroDpi | numeroReferencePersonne | typeDpi  | nom            | adresse |
        | 9999      | 12345678                | SALARIES | Etat de Genève | OCSIN   |

    Scénario: Création d´une LR pour l'année 2022 avec reprise des données d'une LR soumise 2021 avec un salarié actif en 2022 avec une période de travail active 
      Etant donné que la date du jour est 17.11.2021
      Etant donné que l'utilisateur ajoute un salarié à cette LR avec une période d'activité du 01.01.2021 au 28.01.2022
      Quand l'utilisateur modifie les périodes d'activité de ce salarié:
        | Début      | Fin        |
        | 15.03.2021 |            |
      Etant donné que l´utilisateur transmet sa LR
      Etant donné que l´année fiscale en cours est 2022
      Etant donné que la date du jour est 31.01.2022
      Quand l´utilisateur crée une nouvelle LR 2022 pour ce DPI
      Alors il existe 1 personne dans le référentiel des personnes
      Et la personne avec id 1 a le rapport de travail suivant:
        | Début      | Fin        |
        | 15.03.2021 |            |
      Et il existe les lieux de travail suivants:
        | pays | nomLieu | rue | commune | npa  | localite | canton |
        | CH   | nom     | rue | 6621    | 1000 | Genève   | GE     |
      Et il existe le DPI suivant:
        | numeroDpi | numeroReferencePersonne | typeDpi  | nom            | adresse |
        | 9999      | 12345678                | SALARIES | Etat de Genève | OCSIN   |

    Scénario: Création d´une LR pour l'année 2022 avec reprise des données d'une LR soumise 2021 avec un salarié inactif en 2022
      Etant donné que la date du jour est 17.11.2021
      Etant donné que l'utilisateur ajoute un salarié à cette LR avec une période d'activité du 01.01.2021 au 28.01.2022
      Quand l'utilisateur modifie les périodes d'activité de ce salarié:
        | Début      | Fin        |
        | 01.01.2021 | 25.01.2021 |
        | 15.02.2021 | 22.02.2021 |
      Etant donné que l´utilisateur transmet sa LR
      Etant donné que l´année fiscale en cours est 2022
      Etant donné que la date du jour est 31.01.2022
      Quand l´utilisateur crée une nouvelle LR 2022 pour ce DPI
      Alors il existe 0 personne dans le référentiel des personnes
      Et il existe les lieux de travail suivants:
        | pays | nomLieu | rue | commune | npa  | localite | canton |
        | CH   | nom     | rue | 6621    | 1000 | Genève   | GE     |
      Et il existe le DPI suivant:
        | numeroDpi | numeroReferencePersonne | typeDpi  | nom            | adresse |
        | 9999      | 12345678                | SALARIES | Etat de Genève | OCSIN   |

    Scénario: Création d´une LR pour l'année 2022 avec reprise des données d'une LR soumise 2021 avec un salarié actif avec date de fin de période en 2022 
      Etant donné que la date du jour est 17.11.2021
      Etant donné que l'utilisateur ajoute un salarié à cette LR avec une période d'activité du 01.01.2021 au 28.01.2022
      Quand l'utilisateur modifie les périodes d'activité de ce salarié:
        | Début      | Fin        |
        | 15.02.2021 | 22.02.2022 |
      Etant donné que l´utilisateur transmet sa LR
      Etant donné que l´année fiscale en cours est 2022
      Etant donné que la date du jour est 31.01.2022
      Quand l´utilisateur crée une nouvelle LR 2022 pour ce DPI
      Alors il existe 1 personne dans le référentiel des personnes
      Et la personne avec id 1 a le rapport de travail suivant:
        | Début      | Fin        |
        | 15.02.2021 | 22.02.2022 |
      Et il existe les lieux de travail suivants:
        | pays | nomLieu | rue | commune | npa  | localite | canton |
        | CH   | nom     | rue | 6621    | 1000 | Genève   | GE     |
      Et il existe le DPI suivant:
        | numeroDpi | numeroReferencePersonne | typeDpi  | nom            | adresse |
        | 9999      | 12345678                | SALARIES | Etat de Genève | OCSIN   |

    Scénario: Création d´une LR pour l'année 2022 avec reprise des données d'une LR soumise 2021 avec un salarié actif avec uniquement la date de fin de période en 2022
      Etant donné que la date du jour est 17.11.2021
      Etant donné que l'utilisateur ajoute un salarié à cette LR avec une période d'activité du 01.01.2021 au 28.01.2022
      Quand l'utilisateur modifie les périodes d'activité de ce salarié:
        | Début      | Fin        |
        |            | 22.02.2022 |
      Etant donné que l´utilisateur transmet sa LR
      Etant donné que l´année fiscale en cours est 2022
      Etant donné que la date du jour est 31.01.2022
      Quand l´utilisateur crée une nouvelle LR 2022 pour ce DPI
      Alors il existe 1 personne dans le référentiel des personnes
      Et la personne avec id 1 a le rapport de travail suivant:
        | Début      | Fin        |
        |            | 22.02.2022 |
      Et il existe les lieux de travail suivants:
        | pays | nomLieu | rue | commune | npa  | localite | canton |
        | CH   | nom     | rue | 6621    | 1000 | Genève   | GE     |
      Et il existe le DPI suivant:
        | numeroDpi | numeroReferencePersonne | typeDpi  | nom            | adresse |
        | 9999      | 12345678                | SALARIES | Etat de Genève | OCSIN   |  