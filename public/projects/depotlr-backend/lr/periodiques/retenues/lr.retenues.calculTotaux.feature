#language: fr
Fonctionnalité: Calcul des totaux des retenues périodiques

  Scénario: Calculer les totaux avec tous les valeurs renseignées pour une personne salarié
    Etant donné qu'un DPI SALARIES est sélectionné
    Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
    Etant donné que la date du jour est 31.03.2021
    Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.03.2021
    Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
      | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
      | Janvier | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
      | Février | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
      | Mars    | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
    Quand l'utilisateur demande le calcul des totaux
    Alors les totaux par personne sont :
      | Personne Id | Prestations soumises | Montant apériodique | Retenue IS |
      | 1           | 30000                | 1500                | 7201.59    |
    Et les totaux de toutes les personnes sont :
      | Prestations soumises | Montant apériodique | Retenue IS |
      | 30000                | 1500                | 7201.59    |

  Scénario: Calculer les totaux avec tous les valeurs renseignées pour 2 personnes salariés
    Etant donné qu'un DPI SALARIES est sélectionné
    Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
    Etant donné que la date du jour est 31.03.2021
    Etant donné que l'utilisateur ajoute un salarié à cette LR avec une période d'activité du 01.01.2021 au 31.03.2021
    Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
      | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
      | Janvier | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
      | Février | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
      | Mars    | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
    Etant donné que l'utilisateur ajoute un salarié à cette LR avec une période d'activité du 01.01.2021 au 31.03.2021
    Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
      | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
      | Janvier | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
      | Février | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
      | Mars    | 20000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
    Quand l'utilisateur demande le calcul des totaux
    Alors les totaux par personne sont :
      | Personne Id | Prestations soumises | Montant apériodique | Retenue IS |
      | 1           | 30000                | 1500                | 7201.59    |
      | 2           | 40000                | 1500                | 7201.59    |
    Et les totaux de toutes les personnes sont :
      | Prestations soumises | Montant apériodique | Retenue IS |
      | 70000                | 3000                | 14403.18   |

  Scénario: Calculer les totaux avec certains valeurs non renseignées pour 2 personnes salariés
    Etant donné qu'un DPI SALARIES est sélectionné
    Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
    Etant donné que la date du jour est 31.03.2021
    Etant donné que l'utilisateur ajoute un salarié à cette LR avec une période d'activité du 01.01.2021 au 31.03.2021
    Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
      | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
      | Janvier | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
      | Février |                      | 500                 | 600                 |            | Acacias         | A0     | Non           |
      | Mars    | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
    Etant donné que l'utilisateur ajoute un salarié à cette LR avec une période d'activité du 01.01.2021 au 31.03.2021
    Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
      | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
      | Janvier | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
      | Février |                      |                     | 600                 | 2400.53    | Acacias         | A0     | Non           |
      | Mars    | 20000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
    Quand l'utilisateur demande le calcul des totaux
    Alors les totaux par personne sont :
      | Personne Id | Prestations soumises | Montant apériodique | Retenue IS |
      | 1           | 20000                | 1500                | 4801.06    |
      | 2           | 30000                | 1000                | 7201.59    |
    Et les totaux de toutes les personnes sont :
      | Prestations soumises | Montant apériodique | Retenue IS |
      | 50000                | 2500                | 12002.65   |


  Scénario: Calculer les totaux avec certains valeurs non renseignées pour 2 personnes revenus en compensation
    Etant donné qu'un DPI CAISSE_COMPENSATION est sélectionné
    Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
    Etant donné que la date du jour est 31.03.2021
    Etant donné que l'utilisateur ajoute une personne caisse compensation à cette LR avec une période d'activité du 01.01.2021 au 30.04.2021
    Etant donné que cette personne de type CAISSE_COMPENSATION a les retenues mensuelles suivantes :
      | Mois    | Prestations soumises | Montant déterminant | Retenue IS | Barème | Barème ajusté |
      | Janvier | 10000                | 600                 | 2400.53    | C0     | Non           |
      | Février | 9000                 | 700                 |            | C1     | Oui           |
      | Mars    |                      |                     |            |        |               |
      | Avril   | 6000                 | 100                 | 2200       | C1     | Oui           |
    Etant donné que l'utilisateur ajoute une personne caisse compensation à cette LR avec une période d'activité du 01.01.2021 au 30.04.2021
    Etant donné que cette personne de type CAISSE_COMPENSATION a les retenues mensuelles suivantes :
      | Mois    | Prestations soumises | Montant déterminant | Retenue IS | Barème | Barème ajusté |
      | Janvier | 10000                | 600                 | 2400.53    | C0     | Non           |
      | Février | 9000                 | 700                 |            | C1     | Oui           |
      | Mars    |                      |                     |            |        |               |
      | Avril   | 6000                 | 100                 | 2200       | C1     | Oui           |
    Quand l'utilisateur demande le calcul des totaux
    Alors les totaux par personne sont :
      | Personne Id | Prestations soumises | Montant apériodique | Retenue IS |
      | 1           | 25000                | 0                   | 4600.53    |
      | 2           | 25000                | 0                   | 4600.53    |
    Et les totaux de toutes les personnes sont :
      | Prestations soumises | Montant apériodique | Retenue IS |
      | 50000                | 0                   | 9201.06    |

  Scénario: Calculer les totaux avec certains valeurs non renseignées pour 2 personnes bénéficiaires de rentes
    Etant donné qu'un DPI BENEFICIAIRE_RENTE est sélectionné
    Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
    Etant donné que la date du jour est 31.03.2021
    Etant donné que l'utilisateur ajoute une personne beneficiaire de rente à cette LR avec une période d'activité du 01.01.2021 au 30.04.2021
    Etant donné que cette personne de type BENEFICIAIRE_RENTE a les retenues mensuelles suivantes :
      | Mois    | Prestations soumises | Retenue IS | Barème | Barème ajusté |
      | Janvier | 10000                | 2400.53    | C0     | Non           |
      | Février | 9000                 |            | C1     | Oui           |
      | Mars    |                      |            |        |               |
      | Avril   | 6000                 | 2200       | C1     | Oui           |
    Etant donné que l'utilisateur ajoute une personne beneficiaire de rente à cette LR avec une période d'activité du 01.01.2021 au 30.04.2021
    Etant donné que cette personne de type BENEFICIAIRE_RENTE a les retenues mensuelles suivantes :
      | Mois    | Prestations soumises | Retenue IS | Barème | Barème ajusté |
      | Janvier | 10000                | 2400.53    | C0     | Non           |
      | Février | 9000                 |            | C1     | Oui           |
      | Mars    |                      |            |        |               |
      | Avril   | 6000                 | 2200       | C1     | Oui           |
    Quand l'utilisateur demande le calcul des totaux
    Alors les totaux par personne sont :
      | Personne Id | Prestations soumises | Retenue IS |
      | 1           | 25000                | 4600.53    |
      | 2           | 25000                | 4600.53    |
    Et les totaux de toutes les personnes sont :
      | Prestations soumises | Montant apériodique | Retenue IS |
      | 50000                |                     | 9201.06    |
