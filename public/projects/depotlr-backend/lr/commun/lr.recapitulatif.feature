#language: fr
Fonctionnalité: Test le calcul des montants récapitulatifs

  Contexte:
    Etant donné que la date du jour est 31.12.2021

  Règle: Les montants récapitulatifs d'une LR (sauf pour les prestations en capital) sont les suivants :
  - Montant total des retenues: Somme des retenues des prestations soumises à l’impôt d'une LR
  - Montant de la commission de perception: 2 % du montant total des retenues, arrondi au centime près
  - Montant total dû: Montant total des retenues - montant de la commission de perception

    Plan du Scénario: Calcul des montants récapitulatifs pour une LR ASC <Test> -> <Observation>
      Etant donné qu'un DPI ASC est sélectionné
      Etant donné qu'il existe une LR Brouillon en 2021 pour ce DPI
      Et qu'une personne <type_p1> a une prestation saisie avec une retenue à <mnt_retenue_p1>
      Et qu'une personne <type_p2> a une prestation saisie avec une retenue à <mnt_retenue_p2>
      Et qu'une personne <type_p3> a une prestation saisie avec une retenue à <mnt_retenue_p3>
      Quand le système calcule les montants récapitulatifs
      Alors le montant total des retenues est égal à <total_retenues>
      Et le montant de la commission de perception est égal à <mnt_commission>
      Et le montant total dû est égal à <total_du>
      Exemples:
        | Test | type_p1 | type_p2 | type_p3      | mnt_retenue_p1 | mnt_retenue_p2 | mnt_retenue_p3 | total_retenues | mnt_commission | total_du | Observation                                              |
        | 1    | ARTISTE | SPORTIF | CONFERENCIER | 2500.00        | 5000.00        | 200.00         | 7700.00        | 154.00         | 7546.00  | 3 personnes dans une LR ASC                              |
        | 2    | ARTISTE | SPORTIF | CONFERENCIER | 10000.00       | 1000.00        | 131.40         | 11131.40       | 222.63         | 10908.77 | Test arrondi au centime supérieur                        |
        | 3    | ARTISTE | SPORTIF | CONFERENCIER | 10000.00       | 1000.00        | 132.25         | 11132.25       | 222.65         | 10909.60 | Test arrondi au centime supérieur en cas de demi-centime |
        | 4    | ARTISTE | SPORTIF | CONFERENCIER | 10000.00       | 1000.00        | 132.20         | 11132.20       | 222.64         | 10909.56 | Test arrondi au centime inférieur                        |

    Plan du Scénario: Calcul des montants récapitulatifs pour une LR Périodique <Test> -> <Observation>
      Etant donné qu'un DPI <type_dpi> est sélectionné
      Etant donné qu'il existe une LR Brouillon en 2021 pour ce DPI
      Etant donné que l´utilisateur a ajouté une personne à temps plein active toute l'année
      Et que ce salarié a les retenues IS suivantes: <retenues_is_p1>
      Etant donné que l´utilisateur a ajouté une autre personne à temps plein active toute l'année
      Et que ce salarié a les retenues IS suivantes: <retenues_is_p2>
      Quand le système calcule les montants récapitulatifs
      Alors le montant total des retenues est égal à <total_retenues>
      Et le montant de la commission de perception est égal à <commission>
      Et le montant total dû est égal à <total_du>
      Exemples:
        | Test | type_dpi | retenues_is_p1 | retenues_is_p2 | total_retenues | commission | total_du | Observation                      |
        | 1    | SALARIES | 2500.00        | 5000.00        | 7500.00        | 150.00     | 7350.00  | 2 personnes dans une LR Salariés |
#TODO COULD tester avec d'autres types de LR périodique (implique d'ajouter le bon type de personne et pas un salarié)
#        | 4    | CAISSE_COMPENSATION | 4900.00      | 10000.00         | 1131.00        | 11131.00       | 222.60     | 10908.40 | 6008.40     | LrCaisseCompensation : Test arrondi aux centimes inférieur de la commission de perception |
#        | 6    | BENEFICIAIRE_RENTE  | 4900.00      | 10000.00         | 1131.00        | 11131.00       | 222.60     | 10908.40 | 6008.40     | LrBeneficaireRente : Test arrondi aux centimes inférieur de la commission de perception   |

  Règle: Les montants récapitulatifs d'une LR de prestations en capital sont les suivants :
  - Montant total des retenues: Somme des retenues des prestations soumises à l’impôt d'une LR
  - Montant de la commission de perception: 1% du montant total de la retenue de toutes les prestations en capital avec
  une commission maximum de 50 francs par prestation en capital. Le montant final est arrondi au centime près.
  - Montant total dû: Montant total des retenues - montant de la commission de perception

    Scénario: Calcul des montants récapitulatifs pour une LR de prestations en capital contenant des retenues
      Etant donné qu'un DPI PRESTATIONS_EN_CAPITAL est sélectionné
      Etant donné qu'il existe une LR Brouillon en 2021 pour ce DPI
      Etant donné que cette LR contient les retenues de prestations en capital suivantes :
        | Retenue IS | Observation                   |
        | 2408.53    | Commission de 24.0853         |
        | 1597.40    | Commission de 15.974          |
        | 9898.25    | Commission de 50.00 (plafond) |
      Quand le système calcule les montants récapitulatifs
      Alors le montant total des retenues est égal à 13904.18
      Alors le montant de la commission de perception est égal à 90.06
      Alors le montant total dû est égal à 13814.12


