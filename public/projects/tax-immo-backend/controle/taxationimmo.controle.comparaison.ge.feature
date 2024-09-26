#language: fr

Fonctionnalité: F21 - Comparaison entre taxation immo référentiel et contribuable PP

  Règle: R1 - Comparer l'existence des lignes parcelle entre contribuable et référentiel
  - Les lignes parcelle sont comparées via la clé : code taxation, type de ligne parcelle, code commune, numéro parcelle et taux abattement
  - Si la ligne parcelle est présente dans la liste contribuable et absente de la liste référentiel
  - Alors l'utilisateur verra le message suivant "TaxImmo xx-xx-xx (clé) est manquante"
  - Si la ligne parcelle est présente dans la liste référentiel et absente de la liste contribuable
  - Alors l'utilisateur verra le message suivant "RTAX xx-xx-xx (clé) est manquante"
  - Exception : on ignore les lignes 15.30, 15.40, 15.50.

    @PP @comparaison
    Scénario: Les lignes parcelle contribuable et référentiel ont des clés identiques
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Etant donnée la taxation immobilière référentiel contient les lignes parcelle suivantes :
        | Code taxation | Code commune | Numéro parcelle | Taux abattement | Type ligne parcelle |
        | 15.10         | 22           | 150             | 10%             | BTR                 |
        | 15.10         | 22           | 150             | 40%             | BTR                 |
        | 15.20         | 22           | 210             |                 | L                   |
        | 15.30         | 22           | 210             |                 | BTR                 |
        | 15.40         | 22           | 210             |                 | BTR                 |
        | 15.50         | 22           | 150             |                 | L                   |
      Et que la taxation immobilière contribuable contient les lignes parcelle suivantes :
        | Code taxation | Code commune | Numéro parcelle | Taux abattement | Type ligne parcelle |
        | 15.10         | 22           | 150             | 10%             | BTR                 |
        | 15.10         | 22           | 150             | 40%             | BTR                 |
        | 15.20         | 22           | 210             |                 | L                   |
        | 15.30         | 22           | 210             |                 | BTR                 |
        | 15.40         | 22           | 210             |                 | BTR                 |
        | 15.50         | 22           | 150             |                 | L                   |
      Quand l'utilisateur compare la taxation immobilière entre le référentiel et le contribuable
      Alors le résultat de la comparaison n'affiche aucune différence

    @PP @comparaison
    Scénario: Les lignes parcelle contribuable et référentiel ont une ligne manquante chacune
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Etant donné que la taxation immobilière référentiel contient les lignes parcelle suivantes :
        | Code taxation | Code commune | Numéro parcelle | Taux abattement | Type ligne parcelle |
        | 15.10         | 22           | 150             | 10%             | BTR                 |
        | 15.10         | 22           | 150             | 40%             | BTR                 |
        | 15.20         | 22           | 210             |                 | L                   |
        | 15.20         | 21           | 150             |                 | BTR                 |
        | 15.40         | 22           | 150             |                 | BTR                 |
        | 15.50         | 22           | 150             | 10%             | L                   |
      Et que la taxation immobilière contribuable contient les lignes parcelle suivantes :
        | Code taxation | Code commune | Numéro parcelle | Taux abattement | Type ligne parcelle |
        | 15.10         | 21           | 150             | 40%             | BTR                 |
        | 15.10         | 22           | 150             | 10%             | BTR                 |
        | 15.10         | 22           | 150             | 40%             | BTR                 |
        | 15.20         | 22           | 210             |                 | L                   |
        | 15.50         | 22           | 150             |                 | BTR                 |
      Quand l'utilisateur compare la taxation immobilière entre le référentiel et le contribuable
      Alors le résultat de la comparaison affiche les messages suivants :
        | TaxImmo 15.20-21-150-BTR est manquante ou différente dans RTAX     |
        | RTAX 15.10-21-150-BTR-40% est manquante ou différente dans TaxImmo |

  Règle: R2 - Comparer les montants (fortune ou revenu IFD ou revenu ICC ou montant IIC) des lignes parcelle entre contribuable et référentiel
  - Les montants fortune ne sont comparés que pour les 15.10 BTR ou 15.20
  - Les montants revenus ne sont comparés que pour les 15.10
  - Les montants IIC ne sont comparés que pour les 15.10 et 15.20
  - Deux lignes parcelle avec la même clé sont comparées avec les règles suivantes :
  -- Si le montant des deux lignes est inexistant, alors aucun message de contrôle n'est généré
  -- Si le montant est inexistant pour un seul, alors un message de contrôle est généré
  -- Si les montants existent pour les deux lignes, alors ces montants sont comparés :
  --- par rapport au plafond paramétré en fonction du type de montant, du code de taxation et de l'année fiscale :
  ---- Si ValeurAbsolue (Montant contribuable - Montant référentiel) > Plafond alors un message de contrôle est généré
  --- par rapport à la tolérance paramétrée en fonction du type de montant, du code de taxation et de l'année fiscale :
  ---- Si (ValeurAbsolue (Montant contribuable - Montant référentiel)) / Montant contribuable > Tolérance alors un message de contrôle est généré
  - Si un message de contrôle a été généré, alors il est le suivant :
  -- "RTAX et TaxImmo xx-xx-xx ont une différence sur Fortune, Revenu"
  - Si le plafond ou la toérance ne sont pas paramétrés, la comparaison renvoie une erreur

    @PP @comparaison @fortune @revenuIFD @revenuICC @montantIIC
    Plan du Scénario: Comparer la fortune, le revenu IFD et le revenu ICC des lignes parcelle entre contribuable et référentiel (<Test> - <Observation>)
      Etant donné un assujettissement pour toute l'année fiscale 2020 pour un contribuable seul PP
      Etant donné que le plafond de contrôle pour <type montant> est paramétré à 200 pour l'année 2020, le code taxation <code taxation> et le type GE
      Et que la tolérance de contrôle pour <type montant> est paramétrée à 50% pour l'année 2020, le code taxation <code taxation> et le type GE
      Etant donné que la taxation immobilière référentiel pour cet assuj contient la ligne parcelle <code taxation> <type ligne> avec le montant <type montant> <montant ref>
      Et que la taxation immobilière contribuable pour cet assuj contient la ligne parcelle <code taxation> <type ligne> avec le montant <type montant> <montant ct>
      Quand l'utilisateur compare la taxation immobilière entre le référentiel et le contribuable
      Alors un message de contrôle est généré : <résultat>
      Exemples:
        | Test | code taxation | type ligne | type montant | montant ref | montant ct | résultat | Observation                                                               |
        | 1    | 15.10         | BTR        | FORTUNE      | 1000        | 700        | oui      | Plafond fortune dépassé pour un 15.10 BTR                                 |
        | 2    | 15.10         | BTR        | FORTUNE      | 200         | 100        | oui      | Ratio fortune dépassé pour un 15.10 BTR                                   |
        | 3    | 15.10         | BTR        | FORTUNE      | 100         | 200        | non      | Ratio fortune de 50% et ne dépasse pas la tolérance pour un 15.10 BTR     |
        | 4    | 15.10         | BTR        | FORTUNE      | 300         | 300        | non      | Même fortune pour 15.10 BTR                                               |
        | 5    | 15.10         | BTR        | FORTUNE      | 300         | 299        | non      | Presque même fortune pour 15.10 BTR                                       |
        | 6    | 15.10         | BTR        | FORTUNE      | 1           |            | oui      | Le revenu ref est positif mais pas celui du contribuable                  |
        | 7    | 15.10         | BTR        | FORTUNE      |             | 1          | oui      | Le revenu contribuable est positif mais pas celui du ref                  |
        | 8    | 15.10         | BTR        | FORTUNE      |             | 0          | non      | Un des montants est inexistant et l'autre égal à zéro                     |
        | 9    | 15.10         | BTR        | FORTUNE      |             |            | non      | Les deux montants sont inexistants                                        |
        | 10   | 15.20         | L          | FORTUNE      | 1500        | 1100       | oui      | Plafond fortune dépassé pour un 15.20 L                                   |
        | 11   | 15.20         | BTR        | FORTUNE      | 8900        | 8000       | oui      | Plafond fortune dépassé pour un 15.20 BTR                                 |
        | 12   | 15.30         | BTR        | FORTUNE      | 900         | 100        | non      | Montant fortune 15.30 pas comparé                                         |
        | 13   | 15.40         | BTR        | FORTUNE      | 900         | 100        | non      | Montant fortune 15.40 pas comparé                                         |
        | 14   | 15.50         | BTR        | FORTUNE      | 900         | 100        | non      | Montant fortune 15.50 pas comparé                                         |
        | 15   | 15.10         | BTR        | REVENU_IFD   | 2000        | 2000       | non      | Même revenu IFD pour 15.10 BTR                                            |
        | 16   | 15.10         | BTR        | REVENU_IFD   | 800         | 1000       | non      | Presque même revenu IFD pour 15.10 BTR                                    |
        | 17   | 15.20         | BTR        | REVENU_IFD   | 2000        | 500        | non      | Montant revenu IFD 15.20 pas comparé                                      |
        | 18   | 15.30         | BTR        | REVENU_IFD   | 2000        | 500        | non      | Montant revenu IFD 15.30 pas comparé                                      |
        | 19   | 15.40         | BTR        | REVENU_IFD   | 2000        | 500        | non      | Montant revenu IFD 15.40 pas comparé                                      |
        | 20   | 15.50         | BTR        | REVENU_IFD   | 2000        | 500        | non      | Montant revenu IFD 15.50 pas comparé                                      |
        | 21   | 15.10         | BTR        | REVENU_IFD   | 7000        | 6000       | oui      | Plafond revenu IFD dépassé pour un 15.10 BTR                              |
        | 22   | 15.10         | BTR        | REVENU_IFD   | 200         | 100        | oui      | Ratio revenu IFD dépassé pour un 15.10 BTR                                |
        | 23   | 15.10         | BTR        | REVENU_IFD   | 1           |            | oui      | Le revenu IFD ref est positif mais pas celui du contribuable              |
        | 24   | 15.10         | BTR        | REVENU_IFD   |             | 1          | oui      | Le revenu IFD contribuable est positif mais celui du ref                  |
        | 25   | 15.10         | BTR        | REVENU_ICC   | 2000        | 2000       | non      | Même revenu ICC pour 15.10 BTR                                            |
        | 26   | 15.10         | BTR        | REVENU_ICC   | 800         | 1000       | non      | Presque même revenu ICC pour 15.10 BTR                                    |
        | 27   | 15.20         | L          | REVENU_ICC   | 2000        | 500        | non      | Montant revenu ICC 15.20 pas comparé                                      |
        | 28   | 15.30         | BTR        | REVENU_ICC   | 2000        | 500        | non      | Montant revenu ICC 15.30 pas comparé                                      |
        | 29   | 15.40         | BTR        | REVENU_ICC   | 2000        | 500        | non      | Montant revenu ICC 15.40 pas comparé                                      |
        | 30   | 15.50         | BTR        | REVENU_ICC   | 2000        | 500        | non      | Montant revenu ICC 15.50 pas comparé                                      |
        | 31   | 15.10         | BTR        | REVENU_ICC   | 7000        | 6000       | oui      | Plafond revenu ICC dépassé pour un 15.10 BTR                              |
        | 32   | 15.10         | BTR        | REVENU_ICC   | 1           |            | oui      | Le revenu ICC ref est positif mais pas celui du contribuable              |
        | 33   | 15.10         | BTR        | REVENU_IFD   |             | 1          | oui      | Le revenu ICC contribuable est positif mais celui du ref                  |
        | 34   | 15.10         | BTR        | MONTANT_IIC  | 1000        | 700        | oui      | Plafond montant IIC dépassé pour un 15.10 BTR                             |
        | 35   | 15.10         | BTR        | MONTANT_IIC  | 200         | 100        | oui      | Ratio montant IIC dépassé pour un 15.10 BTR                               |
        | 36   | 15.10         | BTR        | MONTANT_IIC  | 100         | 200        | non      | Ratio montant IIC de 50% et ne dépasse pas la tolérance pour un 15.10 BTR |
        | 37   | 15.10         | BTR        | MONTANT_IIC  | 300         | 300        | non      | Même montant IIC pour 15.10 BTR                                           |
        | 38   | 15.10         | BTR        | MONTANT_IIC  | 300         | 299        | non      | Presque même montant IIC pour 15.10 BTR                                   |
        | 39   | 15.10         | BTR        | MONTANT_IIC  | 1           |            | oui      | Le montant IIC ref est positif mais pas celui du contribuable             |
        | 40   | 15.10         | BTR        | MONTANT_IIC  |             | 1          | oui      | Le montant IIC contribuable est positif mais pas celui du ref             |
        | 41   | 15.10         | BTR        | MONTANT_IIC  |             | 0          | non      | Un des montant IIC est inexistant et l'autre égal à zéro                  |
        | 42   | 15.10         | BTR        | MONTANT_IIC  |             |            | non      | Les deux montant IIC sont inexistants                                     |
        | 43   | 15.20         | L          | MONTANT_IIC  | 1500        | 1100       | oui      | Plafond montant IIC dépassé pour un 15.20 L                               |
        | 44   | 15.30         | BTR        | MONTANT_IIC  | 2000        | 500        | non      | Montant IIC 15.30 pas comparé                                             |
        | 45   | 15.40         | BTR        | MONTANT_IIC  | 2000        | 500        | non      | Montant IIC 15.40 pas comparé                                             |
        | 46   | 15.50         | BTR        | MONTANT_IIC  | 2000        | 500        | non      | Montant IIC 15.50 pas comparé                                             |

    # TODO AFCTAXIMMO-1081 plan de scénario à supprimer
    @PP @comparaison @fortune @revenuIFD @revenuICC @montantIIC @parametres
    Plan du Scénario: Comparer les lignes parcelle entre contribuable et référentiel en faisant varier les paramètres (<Test> - <Observation>)
      Etant donné un assujettissement pour toute l'année fiscale <année fiscale> pour un contribuable seul PP
      Etant donné que le paramétrage de contrôle suivant:
        | Types montant                                | Codes taxation | Année | Plafond | Tolérance | Type paramètre |
        | FORTUNE, REVENU_ICC, REVENU_IFD, MONTANT_IIC | 15.10          | 2021  | 500     | 50%       | GE             |
        | FORTUNE, REVENU_ICC, REVENU_IFD, MONTANT_IIC | 15.10          | 2022  | 200     | 10%       | GE             |
        | FORTUNE, MONTANT_IIC                         | 15.20          | 2021  | 500     | 50%       | GE             |
        | FORTUNE, MONTANT_IIC                         | 15.20          | 2022  | 200     | 10%       | GE             |
      Etant donné que les autres paramètres de contrôle ne sont pas renseignés
      Etant donné que la taxation immobilière référentiel pour cet assuj contient la ligne parcelle <code taxation> BTR avec le montant <type montant> 1000
      Et que la taxation immobilière contribuable pour cet assuj contient la ligne parcelle <code taxation> BTR avec le montant <type montant> 700
      Quand l'utilisateur compare la taxation immobilière entre le référentiel et le contribuable
      Alors un message de comparaison est généré : <résultat>
      Exemples:
        #TODO AFCTAXIMMO-446 ajouter et vérifier colonnes intermédiaires : plafond appliqué et tolérance appliquée & trouver un moyen de réduire
        | Test | code taxation | année fiscale | type montant | résultat | Observation                              |
        | 1    | 15.10         | 2021          | FORTUNE      | non      | Pas de dépassement Plafond 15.10 en 2021 |
        | 2    | 15.10         | 2022          | FORTUNE      | oui      | Plafond et tolérance 15.10 2022 dépassés |
        | 3    | 15.10         | 2023          | FORTUNE      | erreur   | Plafond 15.10 et tolérance absents       |
        | 4    | 15.10         | 2021          | REVENU_ICC   | non      | Pas de dépassement Plafond 15.10 en 2021 |
        | 5    | 15.10         | 2022          | REVENU_ICC   | oui      | Plafond et tolérance 15.10 2022 dépassés |
        | 6    | 15.10         | 2023          | REVENU_ICC   | erreur   | Plafond 15.10 et tolérance absents       |
        | 7    | 15.10         | 2021          | REVENU_IFD   | non      | Pas de dépassement Plafond 15.10 en 2021 |
        | 8    | 15.10         | 2022          | REVENU_IFD   | oui      | Plafond et tolérance 15.10 2022 dépassés |
        | 9    | 15.10         | 2023          | REVENU_IFD   | erreur   | Plafond 15.10 et tolérance absents       |
        | 10   | 15.20         | 2021          | FORTUNE      | non      | Pas de dépassement Plafond 15.20 en 2021 |
        | 11   | 15.20         | 2022          | FORTUNE      | oui      | Plafond et tolérance 15.20 2022 dépassés |
        | 12   | 15.20         | 2023          | FORTUNE      | erreur   | Plafond 15.20 et tolérance absents       |

    @PP @comparaison @fortune @revenuIFD @revenuICC
    Scénario: Comparer la fortune, le revenu IFD et le revenu ICC des lignes parcelle entre contribuable et référentiel en vérifiant le contenu des messages
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Etant donné que les plafonds de contrôle sont paramétrés par défaut à 200
      Etant donné que les tolérances de contrôle sont paramétrées par défaut à 50%
      Etant donné la taxation immobilière référentiel pour cet assuj contient les lignes parcelle suivantes :
        | Code taxation | Code commune | Numéro parcelle | Type ligne parcelle | Fortune | Revenu IFD | Revenu ICC | Montant IIC |
        | 15.10         | 22           | 150             | BTR                 | 1000    | 2000       | 1000       | 1000        |
        | 15.10         | 22           | 151             | BTR                 |         | 799        | 40         | 799         |
        | 15.10         | 22           | 152             | L                   |         | 799        | 40         | 799         |
        | 15.20         | 22           | 152             | BTR                 |         | 799        | 40         | 799         |
      Et que la taxation immobilière contribuable contient les lignes parcelle suivantes :
        | Code taxation | Code commune | Numéro parcelle | Type ligne parcelle | Fortune | Revenu IFD | Revenu ICC | Montant IIC |
        | 15.10         | 22           | 150             | BTR                 | 900     | 2000       | 1000       | 1000        |
        | 15.10         | 22           | 151             | BTR                 | 1       | 1000       | 100        | 1000        |
        | 15.10         | 22           | 152             | L                   | 1       | 1000       | 100        | 1000        |
        | 15.20         | 22           | 152             | BTR                 | 1       | 1000       | 100        | 1000        |
      Quand l'utilisateur compare la taxation immobilière entre le référentiel et le contribuable
      Alors le résultat de la comparaison affiche les messages suivants :
        | RTAX et TaxImmo 15.10-22-151-BTR ont une différence sur Fortune, Revenu, IIC Net |
        | RTAX et TaxImmo 15.10-22-152-L ont une différence sur Revenu, IIC Net            |
        | RTAX et TaxImmo 15.20-22-152-BTR ont une différence sur Fortune, IIC Net         |
