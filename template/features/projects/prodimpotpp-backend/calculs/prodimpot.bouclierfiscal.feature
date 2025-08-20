#language: fr

Fonctionnalité: F8 - Calculer les réductions pour le bouclier fiscal sur la fortune

  Règle: R01 - Déterminer l'Impôt Bouclier Fiscal
  L'Impôt Bouclier Fiscal est égal à soixante pour cent du revenu déterminant pour le bouclier fiscal
  Arrondi aux 5 centimes inférieurs
  Si inférieur à Zéro, alors le résultat est rapporté à Zéro

    @PP @BF @TotalImpôtsRFMax
    Plan du Scénario: Le montant de l'Impôt Bouclier Fiscal
      Etant donné un revenu déterminant pour le bouclier fiscal <revenu bouclier fiscal>
      Quand l'application ProdImpot calcule le montant de l'impôt Bouclier Fiscal
      Alors Le montant de l'Impôt Bouclier Fiscal est <impôt BF> avec l'explication du calcul <explication calcul>
      Exemples:
        | revenu bouclier fiscal | impôt BF  | explication calcul                                                                                                                                             |
        | 55'236                 | 33'141.60 | "Impôt Bouclier Fiscal [33'141.60] = MAX(0, (60 % * Revenu déterminant Bouclier Fiscal [55'236.00])) arrondi selon convention impôt (cad, 5 cents inferieurs)" |
        | 55'236.55              | 33'141.95 | "Impôt Bouclier Fiscal [33'141.95] = MAX(0, (60 % * Revenu déterminant Bouclier Fiscal [55'236.55])) arrondi selon convention impôt (cad, 5 cents inferieurs)" |
        | -2'377.80              | 0.00      | "Impôt Bouclier Fiscal [0.00] = MAX(0, (60 % * Revenu déterminant Bouclier Fiscal [-2'377.80])) arrondi selon convention impôt (cad, 5 cents inferieurs)"      |

  Règle: R02 - Déterminer le total des impôts sur le revenu à 100%
  Le total des impôts sur le revenu à 100% est calculé à partir du total des impôts sur revenu, du revenu total admis 99.00 et du revenu imposable sur Genève
  Le total des impôts sur le revenu à 100% est égal à 0 si revenu imposable sur Genève=0
  Total impôts sur revenu pour 100% = (Total des impôts sur revenu * Revenu total admis 99.00) / Revenu imposable sur Genève

    @PP @BF @TotalImpôtsRevenu100Pour100
    Plan du Scénario: Total des impôts sur le revenu à 100%
      Etant donné un total des impôts sur le revenu <total impôts revenu>
      Et que le revenu total admis 99.00 <revenu total admis>
      Et que le revenu imposable sur Genève <revenu imposable genève>
      Quand l'application ProdImpot calcule le total des impôts sur le revenu à 100%
      Alors Le total des impôts sur le revenu à 100% est <total impôts revenu à 100%> avec l'explication du calcul <explication calcul>
      Exemples:
        | total impôts revenu | revenu total admis | revenu imposable genève | total impôts revenu à 100% | explication calcul                                                                                                                                                              |
        | 50'000              | 1'000'000          | 700'000                 | 71'428.5714285714          | Total des impôts sur revenu à 100% [71'428.57] = (Total des impôts sur revenu [50'000.00] * Revenu total admis 99.00 [1'000'000.00]) / Revenu imposable sur Genève [700'000.00] |
        | 50'000              | 1'000'000          | 0                       | 0                          | Total des impôts sur revenu à 100% [0.00] = (Total des impôts sur revenu [50'000.00] * Revenu total admis 99.00 [1'000'000.00]) / Revenu imposable sur Genève [0.00]            |
        | 50'000              | 0                  | 700'000                 | 0                          | Total des impôts sur revenu à 100% [0.00] = (Total des impôts sur revenu [50'000.00] * Revenu total admis 99.00 [0.00]) / Revenu imposable sur Genève [700'000.00]              |
        | 0                   | 1'000'000          | 700'000                 | 0                          | Total des impôts sur revenu à 100% [0.00] = (Total des impôts sur revenu [0.00] * Revenu total admis 99.00 [1'000'000.00]) / Revenu imposable sur Genève [700'000.00]           |

  Règle: R03 - Déterminer le total des impôts sur le bénéfice de liquidation (Prévoyance) à 100%
  Total impôts sur B.L (prévoyance) pour 100% = (Total des impôts sur BL (prévoyance) / Montant admis du 12.98 sur Genève * Total Montants admis du 12.98).
  Est = à 0 si montant admis sur Genève = 0.

    @PP @BF @TotalImpôtsBLPrevoyance100pour100
    Plan du Scénario: Total des impôts sur le bénéfice de liquidation (Prévoyance) à 100%
      Etant donné un total des impôts sur BL (prévoyance) <total impot BL PR>
      Et un montant admis du 12.98 sur Genève <montant admis 12.98 GE>
      Et un total montants admis du 12.98 <total montants admis 12.98>
      Quand l'application ProdImpot calcule le total des impôts sur le bénéfice de liquidation (Prévoyance) à 100%
      Alors Le montant total impôts sur B.L (prévoyance) pour 100% est <total impôts BL PR 100%> avec l'explication du calcul <explication calcul>
      Exemples:
        | montant admis 12.98 GE | total montants admis 12.98 | total impot BL PR | total impôts BL PR 100% | explication calcul                                                                                                                                                                                     |
        | 13'000                 | 23'000                     | 1'200             | 2'123.0769229000        | Total impôts sur B.L (prévoyance) pour 100% [2'123.08] = (Total des impôts sur BL (prévoyance) [1'200.00] / Montant admis du 12.98 sur Genève [13'000.00] * Total Montants admis du 12.98 [23'000.00]) |
        | 0                      | 13'000                     | 800               | 0                       | Total impôts sur B.L (prévoyance) pour 100% [0.00] = (Total des impôts sur BL (prévoyance) [800.00] / Montant admis du 12.98 sur Genève [0.00] * Total Montants admis du 12.98 [13'000.00])            |

  Règle: R04 - Déterminer le total des impôts sur le bénéfice de liquidation (Solde) à 100%
  Total impôts sur B.L (Solde) pour 100% = (Total des impôts sur BL (Solde) / Montant admis du 12.99 sur Genève * Total Montants admis du 12.99).
  Est = à 0 si montant admis sur Genève=0.

    @PP @BF @TotalImpôtsBLSolde100pour100
    Plan du Scénario: Total des impôts sur le bénéfice de liquidation (solde) à 100%
      Etant donné un total des impôts sur BL (solde) <total impot BL SL>
      Et un montant admis du 12.99 sur Genève <montant admis 12.99 GE>
      Et un total montants admis du 12.99 <total montants admis 12.99>
      Quand l'application ProdImpot calcule le total des impôts sur le bénéfice de liquidation (Solde) à 100%
      Alors Le montant total impôts sur B.L (solde) pour 100% est <total impôts BL SL 100%> avec l'explication du calcul <explication calcul>
      Exemples:
        | montant admis 12.99 GE | total montants admis 12.99 | total impot BL SL | total impôts BL SL 100% | explication calcul                                                                                                                                                                            |
        | 13'000                 | 23'000                     | 1'200             | 2'123.0769229000        | Total impôts sur B.L (solde) pour 100% [2'123.08] = (Total des impôts sur BL (solde) [1'200.00] / Montant admis du 12.99 sur Genève [13'000.00] * Total Montants admis du 12.99) [23'000.00]) |
        | 0                      | 13'000                     | 800               | 0                       | Total impôts sur B.L (solde) pour 100% [0.00] = (Total des impôts sur BL (solde) [800.00] / Montant admis du 12.99 sur Genève [0.00] * Total Montants admis du 12.99) [13'000.00])            |

  Règle: R05 - Déterminer le total des impôts sur la fortune à 100 % du taux
  Le total des impôts sur la fortune à 100 % du taux est calculé à partir du Total des impôts sur fortune, de la fortune imposable pour le taux et de la fortune imposable sur Genève
  Le total des impôts sur la fortune à 100% est égal à 0 si la fortune imposable sur Genève=0
  Total impôts sur fortune pour 100% = (Total des impôts sur fortune * Fortune imposable pour le taux ) / Fortune imposable sur Genève.

    @PP @BF @TotalImpôtsFortune100Pour100
    Plan du Scénario: Total des impôts sur la fortune à 100%
      Etant donné un total des impôts sur la fortune <total impôts fortune>
      Et Fortune imposable pour le taux <fortune pour le taux>
      Et Fortune imposable sur Genève <fortune imposable genève>
      Quand l'application ProdImpot calcule le total des impôts sur la fortune à 100%
      Alors Le total des impôts sur la fortune à 100% est <total impôts fortune à 100%> avec l'explication du calcul <explication calcul>
      Exemples:
        | total impôts fortune | fortune pour le taux | fortune imposable genève | total impôts fortune à 100% | explication calcul                                                                                                                                                                      |
        | 50'000               | 1'000'000            | 700'000                  | 71'428.5714285714           | Total impôts sur fortune pour 100% [71'428.57] = (Total des impôts sur fortune [50'000.00] * Fortune imposable pour le taux [1'000'000.00]) / Fortune imposable sur Genève [700'000.00] |
        | 50'000               | 1'000'000            | 0                        | 0                           | Total impôts sur fortune pour 100% [0.00] = (Total des impôts sur fortune [50'000.00] * Fortune imposable pour le taux [1'000'000.00]) / Fortune imposable sur Genève [0.00]            |

  Règle: R06 - Calculer le total impôts sur le revenu et la fortune à 100 % du taux
  Total impôts sur le revenu et la fortune à 100 % du taux = [
  Total impôts sur revenu pour 100% +
  Total impôts sur fortune pour 100%]
  Arrondi (5 cts inférieurs)

    @PP @BF @TotalImpôtsRevenuFortune100pour100
    Plan du Scénario: Cumuler les impôts sur le revenu et la fortune à 100%
      Etant donné un cumul des impôts sur le revenu à 100% <cumul impôts revenu>
      Et un total des impôts sur la fortune pour 100% <total impôts fortune>
      Quand l'application ProdImpot calcule le cumul des impôts sur le revenu et la fortune à 100%
      Et Le montant total impôts sur le revenu et la fortune à 100 % du taux est <montant calcul> avec l'explication du calcul <explication calcul>
      Exemples:
        | cumul impôts revenu | total impôts fortune | montant calcul | explication calcul                                                                                                                                                                                          |
        | 35                  | 15                   | 50             | "Total impôts sur le revenu et la fortune à 100% du taux [50.00] = Total impôts sur revenu pour 100% [35.00] + Total impôts sur fortune pour 100% [15.00]\nArrondi (5 cts inférieurs)"                      |
        | 350                 | 150                  | 500            | "Total impôts sur le revenu et la fortune à 100% du taux [500.00] = Total impôts sur revenu pour 100% [350.00] + Total impôts sur fortune pour 100% [150.00]\nArrondi (5 cts inférieurs)"                   |
        | 35'000              | 15'000               | 50'000         | "Total impôts sur le revenu et la fortune à 100% du taux [50'000.00] = Total impôts sur revenu pour 100% [35'000.00] + Total impôts sur fortune pour 100% [15'000.00]\nArrondi (5 cts inférieurs)"          |
        | 35'000              | 15'000.73            | 50'000.75      | "Total impôts sur le revenu et la fortune à 100% du taux [50'000.75] = Total impôts sur revenu pour 100% [35'000.00] + Total impôts sur fortune pour 100% [15'000.73]\nArrondi (5 cts inférieurs)"          |
        | 3'500'000           | 1'500'000.73         | 5'000'000.75   | "Total impôts sur le revenu et la fortune à 100% du taux [5'000'000.75] = Total impôts sur revenu pour 100% [3'500'000.00] + Total impôts sur fortune pour 100% [1'500'000.73]\nArrondi (5 cts inférieurs)" |

  Règle: R07 - Calculer le total impôts sur le revenu à 100 % du taux
  Total Impôt revenu 100 % =
  Total impôts sur revenu pour 100% +
  Total impôts sur B.L (prévoyance) pour 100% +
  Total impôts sur B.L (solde) pour 100%

    @PP @BF @TotalImpôtsRevenuFortune100pour100
    Plan du Scénario: Cumuler les impôts sur le revenu à 100%
      Etant donné un total des impôts sur le revenu <total impôts revenu>
      Et un total des impôts sur BL (prévoyance) <total impot BL PR>
      Et un total des impôts sur BL (solde) <total impot BL SL>
      Quand l'application ProdImpot calcule le cumul des impôts sur le revenu à 100%
      Alors Le montant cumulé de tous les impôts sur le revenu à 100% <montant cumul> avec l'explication du calcul <explication cumul>
      Exemples:
        | total impôts revenu | total impot BL PR | total impot BL SL | montant cumul | explication cumul                                                                                                                                                                                                |
        | 10                  | 12                | 13                | 35            | "Total Impôt revenu 100% [35.00] = Total impôts sur revenu pour 100% [10.00] + Total impôts sur B.L (prévoyance) pour 100% [12.00] + Total impôts sur B.L (solde) pour 100% [13.00]"                             |
        | 100                 | 120               | 130               | 350           | "Total Impôt revenu 100% [350.00] = Total impôts sur revenu pour 100% [100.00] + Total impôts sur B.L (prévoyance) pour 100% [120.00] + Total impôts sur B.L (solde) pour 100% [130.00]"                         |
        | 10'000              | 12'000            | 13'000            | 35'000        | "Total Impôt revenu 100% [35'000.00] = Total impôts sur revenu pour 100% [10'000.00] + Total impôts sur B.L (prévoyance) pour 100% [12'000.00] + Total impôts sur B.L (solde) pour 100% [13'000.00]"             |
        | 10'000              | 12'000            | 13'000            | 35'000        | "Total Impôt revenu 100% [35'000.00] = Total impôts sur revenu pour 100% [10'000.00] + Total impôts sur B.L (prévoyance) pour 100% [12'000.00] + Total impôts sur B.L (solde) pour 100% [13'000.00]"             |
        | 1'000'000           | 1'200'000         | 1'300'000         | 3'500'000     | "Total Impôt revenu 100% [3'500'000.00] = Total impôts sur revenu pour 100% [1'000'000.00] + Total impôts sur B.L (prévoyance) pour 100% [1'200'000.00] + Total impôts sur B.L (solde) pour 100% [1'300'000.00]" |

  Règle: R08 - Déterminer la réduction d'impôt pour 100% du taux
  Réduction d'impôt pour 100 % du taux = Max(0; Total impôts sur le revenu et la fortune à 100 % du taux - Total Impôts R/F maximum)
  Si le montant obtenu est inférieure à 0 alors la valeur de la réduction sera égale à 0

    @PP @BF @RéductionImpôt100pour100
    Plan du Scénario: Réduction d'impôt pour 100% du taux
      Etant donné un total des impôts sur le revenu et fortune à 100% à <total impôts revenu fortune 100%>
      Et un Impôt Bouclier Fiscal à <impôt BF>
      Quand l'application ProdImpot calcule la réduction d'impôt pour 100% du taux
      Alors la réduction d'impôt pour 100% du taux est de <réduction impôt 100%> avec l'explication du calcul <explication calcul>
      Exemples:
        | total impôts revenu fortune 100% | impôt BF | réduction impôt 100% | explication calcul                                                                                                                                                 |
        | 13'000                           | 3'000    | 10'000               | Réduction d'impôt pour 100 % du taux [10'000.00] = Max(0; Total impôts sur le revenu et la fortune à 100 % du taux [13'000.00] - Impôt Bouclier Fiscal [3'000.00]) |
        | 13'000                           | 14'000   | 0                    | Réduction d'impôt pour 100 % du taux [0.00] = Max(0; Total impôts sur le revenu et la fortune à 100 % du taux [13'000.00] - Impôt Bouclier Fiscal [14'000.00])     |

  Règle: R09 - Déterminer la réduction d'impôt accordée à Genève
  La réduction est plafonnée au total impôt fortune sur Genève
  Réduction d'impôt accordée = Min(total impôt fortune sur Genève,(Réduction d'impôt pour 100 % du taux * Fortune imposable sur Genève) / Fortune imposable pour le taux)
  arrondi aux 5 cts inférieurs
    @PP @BF @RéductionImpôtGenève
    Plan du Scénario: Réduction d'impôt accordée à Genève
      Etant donné un total impôt fortune sur Genève <total impôt fortune sur Genève>
      Et une réduction d'impôt pour 100 % du taux <réduction impôt 100%>
      Et Fortune imposable sur Genève <fortune genève>
      Et Fortune imposable pour le taux <fortune pour le taux>
      Quand l'application ProdImpot calcule la réduction d'impôt accordée à Genève
      Alors la réduction d'impôt accordée est de <Réduction accordée> avec l'explication du calcul <explication calcul>
      Exemples:
        | total impôt fortune sur Genève | réduction impôt 100% | fortune genève | fortune pour le taux | Réduction accordée | explication calcul                                                                                                                                                                                                                                                   |
        | 13'000                         | 15'000               | 100'000        | 150'000              | 10'000.00          | "Réduction d'impôt accordée [10'000.00] = Min(total impôt fortune sur Genève [13'000.00],(Réduction d'impôt pour 100% du taux [15'000.00] * Fortune imposable sur Genève [100'000.00]) / Fortune imposable pour le taux [150'000.00])\nArrondi aux 5 cts inférieurs" |
        | 9'000                          | 15'000               | 100'000        | 150'000              | 9'000              | "Réduction d'impôt accordée [9'000.00] = Min(total impôt fortune sur Genève [9'000.00],(Réduction d'impôt pour 100% du taux [15'000.00] * Fortune imposable sur Genève [100'000.00]) / Fortune imposable pour le taux [150'000.00])\nArrondi aux 5 cts inférieurs"   |

  Règle: R10 - On ne produit pas de réduction sur le bouclier fiscal si la fortune imposable vaut zéro

    Scénario: Avec une fortune imposable à 0
      Etant donné une fortune imposable à 0
      Quand l'application ProdImpot calcule la réduction sur le bouclier fiscal
      Alors aucune réduction sur le bouclier fiscal n'est produite

  Règle: R11 - Calcul des réductions sur la fortune pour bouclier fiscal
  La réduction d'impôt accordée est à ventiler sur les différents impôts dus sur la fortune.

  Les réductions pour bouclier fiscal possibles sont :

  RBF_RIBF : Bouclier fiscal sur l'impôt de base sur la fortune
  RBF_RCAF : Bouclier fiscal sur les centimes additionnels cantonaux
  RBF_RISF : Bouclier fiscal sur l'impôt supplémentaire sur la fortune
  RBF_RADF : Bouclier fiscal sur l'aide à domicile sur la fortune
  RBF_RCAF : Bouclier fiscal sur les centimes additionnels communaux sur la fortune
  RBF_RPPF : Bouclier fiscal sur la part privilégiée sur la fortune

  Montant réduction = [Montant de l'impôt traité * Réduction bouclier fiscal globale / somme des impôts sur la fortune]
  arrondi aux 5 cts inférieurs

  Les imprécisions d'arrondi, faites sur chaque réduction, sont absorbées par la réduction IBF de période d'imposition la plus grande

    @PP @BF @ReductionImpotFortune
    Scénario: Calculer les réductions pour bouclier fiscal sur une fortune
      Etant donné que la liste des impôts calculés sur la fortune est la suivante :
        | IBF      | CAF    | ISF    | ADF   | COF    | PPF    |
        | 1'866.70 | 886.70 | 136.85 | 18.65 | 186.70 | 746.70 |
      Et une réduction bouclier fiscal calculée à 2'285.90
      Quand l'application ProdImpot calcule les réductions sur la fortune pour le bouclier fiscal
      Alors la réduction du bouclier fiscal RBF_RIBF calculée est égale à -1'110.60 avec l'explication : Bouclier fiscal sur IBF [1'110.60] = (IBF [1'866.70] * Réduction bouclier fiscal globale [2'285.90] / somme des impôts sur la fortune [3'842.30]) (Attention : cette réduction absorbe les erreurs sur arrondi.)
      Et la réduction du bouclier fiscal RBF_RCAF calculée est égale à -527.50 avec l'explication : Bouclier fiscal sur CAF [527.50] = (CAF [886.70] * Réduction bouclier fiscal globale [2'285.90] / somme des impôts sur la fortune [3'842.30])
      Et la réduction du bouclier fiscal RBF_RISF calculée est égale à -81.40 avec l'explication : Bouclier fiscal sur ISF [81.40] = (ISF [136.85] * Réduction bouclier fiscal globale [2'285.90] / somme des impôts sur la fortune [3'842.30])
      Et la réduction du bouclier fiscal RBF_RADF calculée est égale à -11.10 avec l'explication : Bouclier fiscal sur ADF [11.10] = (ADF [18.65] * Réduction bouclier fiscal globale [2'285.90] / somme des impôts sur la fortune [3'842.30])
      Et la réduction du bouclier fiscal RBF_RCOF calculée est égale à -111.05 avec l'explication : Bouclier fiscal sur COF [111.05] = (COF [186.70] * Réduction bouclier fiscal globale [2'285.90] / somme des impôts sur la fortune [3'842.30])
      Et la réduction du bouclier fiscal RBF_RPPF calculée est égale à -444.25 avec l'explication : Bouclier fiscal sur PPF [444.25] = (PPF [746.70] * Réduction bouclier fiscal globale [2'285.90] / somme des impôts sur la fortune [3'842.30])

    @PP @BF @ReductionImpotFortune
    Scénario: Calculer les réductions pour bouclier fiscal sur plusieurs fortunes
      Etant donné que la liste des impôts calculés sur les deux fortunes est la suivante :
        | IBF       | CAF       | ISF      | ADF    | COF       | PPF      | Période d'imposition de la fortune |
        | 41'995.30 | 19'947.75 | 11'615.4 | 419.95 | 13'754.65 | 5'349.05 | Du 01.01.2024 au 15.11.2024        |
        | 13'465.10 | 6'395.90  | 3'697.05 | 134.65 | 4'410.20  | 1'715.10 | Du 16.11.2024 au 31.12.2024        |
      Et une réduction bouclier fiscal calculée à 35'900.70
      Quand l'application ProdImpot calcule les réductions sur la fortune pour le bouclier fiscal
      Alors la réduction du bouclier fiscal RBF_RIBF calculée pour la première fortune est égale à -12'267.35 avec l'explication : Bouclier fiscal sur IBF [12'267.35] = (IBF [41'995.30] * Réduction bouclier fiscal globale [35'900.70] / somme des impôts sur la fortune [122'900.10])
      Et la réduction du bouclier fiscal RBF_RCAF calculée pour la première fortune est égale à -5'827.00 avec l'explication : Bouclier fiscal sur CAF [5'827.00] = (CAF [19'947.75] * Réduction bouclier fiscal globale [35'900.70] / somme des impôts sur la fortune [122'900.10])
      Et la réduction du bouclier fiscal RBF_RISF calculée pour la première fortune est égale à -3'393.00 avec l'explication : Bouclier fiscal sur ISF [3'393.00] = (ISF [11'615.40] * Réduction bouclier fiscal globale [35'900.70] / somme des impôts sur la fortune [122'900.10])
      Et la réduction du bouclier fiscal RBF_RADF calculée pour la première fortune est égale à -122.65 avec l'explication : Bouclier fiscal sur ADF [122.65] = (ADF [419.95] * Réduction bouclier fiscal globale [35'900.70] / somme des impôts sur la fortune [122'900.10])
      Et la réduction du bouclier fiscal RBF_RCOF calculée pour la première fortune est égale à -4'017.90 avec l'explication : Bouclier fiscal sur COF [4'017.90] = (COF [13'754.65] * Réduction bouclier fiscal globale [35'900.70] / somme des impôts sur la fortune [122'900.10])
      Et la réduction du bouclier fiscal RBF_RPPF calculée pour la première fortune est égale à -1'562.55 avec l'explication : Bouclier fiscal sur PPF [1'562.55] = (PPF [5'349.05] * Réduction bouclier fiscal globale [35'900.70] / somme des impôts sur la fortune [122'900.10])
      Et la réduction du bouclier fiscal RBF_RIBF calculée sur la deuxième fortune est égale à -3'933.35 avec l'explication : Bouclier fiscal sur IBF [3'933.35] = (IBF [13'465.10] * Réduction bouclier fiscal globale [35'900.70] / somme des impôts sur la fortune [122'900.10])
      Et la réduction du bouclier fiscal RBF_RCAF calculée sur la deuxième fortune est égale à -1'868.30 avec l'explication : Bouclier fiscal sur CAF [1'868.30] = (CAF [6'395.90] * Réduction bouclier fiscal globale [35'900.70] / somme des impôts sur la fortune [122'900.10])
      Et la réduction du bouclier fiscal RBF_RISF calculée sur la deuxième fortune est égale à -1'079.95 avec l'explication : Bouclier fiscal sur ISF [1'079.95] = (ISF [3'697.05] * Réduction bouclier fiscal globale [35'900.70] / somme des impôts sur la fortune [122'900.10])
      Et la réduction du bouclier fiscal RBF_RADF calculée sur la deuxième fortune est égale à -39.35 avec l'explication : Bouclier fiscal sur ADF [39.35] = (ADF [134.65] * Réduction bouclier fiscal globale [35'900.70] / somme des impôts sur la fortune [122'900.10])
      Et la réduction du bouclier fiscal RBF_RCOF calculée sur la deuxième fortune est égale à -1'288.30 avec l'explication : Bouclier fiscal sur COF [1'288.30] = (COF [4'410.20] * Réduction bouclier fiscal globale [35'900.70] / somme des impôts sur la fortune [122'900.10])
      Et la réduction du bouclier fiscal RBF_RPPF calculée sur la deuxième fortune est égale à -501.00 avec l'explication : Bouclier fiscal sur PPF [501.00] = (PPF [1'715.10] * Réduction bouclier fiscal globale [35'900.70] / somme des impôts sur la fortune [122'900.10])

    @PP @BF @ReductionImpotFortune @imprécisionArrondi
    Scénario: Calculer les réductions pour bouclier fiscal sur une fortune avec imprécisions d'arrondi
      Etant donné que la liste des impôts calculés sur la fortune est la suivante :
        | IBF       | CAF       | ISF       | ADF    | COF       | PPF      |
        | 65'622.90 | 31'170.90 | 18'361.20 | 656.25 | 21'493.35 | 8'358.50 |
      Et une réduction bouclier fiscal calculée à 8'092.20
      Quand l'application ProdImpot calcule les réductions sur la fortune pour le bouclier fiscal
      Alors la réduction du bouclier fiscal RBF_RIBF calculée est égale à -3'645.60 avec l'explication : Bouclier fiscal sur IBF [3'645.60] = (IBF [65'622.90] * Réduction bouclier fiscal globale [8'092.20] / somme des impôts sur la fortune [145'663.10]) (Attention : cette réduction absorbe les erreurs sur arrondi.)

  Règle: R12 - Appliquer le bouclier fiscal pour un dossier de taxation
  Appliquer les règle R1-R10 sur les assiettes revenu, fortune, bénéfice de liquidation
  Produire les réductions pour bouclier fiscal

    @PP @BF @BouclierFiscal
    Scénario: Calculer les réductions pour bouclier fiscal à partir des assiettes revenu, fortune, bénéfice de liquidation
      Etant donné un contribuable célibataire pour 2024
      Et l'assiette revenu contient un revenu imposable sur Genève à 40'000, un revenu pour le taux à 40'000 et un revenu total admis 99.00 à 40'000
      Et l'assiette fortune contient une fortune imposable sur Genève à 50'000'000 et une fortune imposable pour le taux à 50'000'000
      Et l'assiette bénéfice de liquidation pour la part privilégié contient un montant admis du 12.98 sur Genève à 60'000
      Et l'assiette bénéfice de liquidation pour le solde contient un montant admis du 12.99 sur Genève à 200'000
      Et l'assiette bouclier fiscal contient un revenu déterminant pour le Bouclier Fiscal à 790'000
      Quand l'application ProdImpot calcule les impôts ICC
      Alors la réduction RBF_RIBF calculée est égale à -22'968.40 avec les explications :
        | ---                                                                                                                                                                                                                                         |
        | Impôt Bouclier Fiscal [474'000.00] = MAX(0, (60 % * Revenu déterminant Bouclier Fiscal [790'000.00])) arrondi selon convention impôt (cad, 5 cents inferieurs)                                                                              |
        | ---                                                                                                                                                                                                                                         |
        | Total des impôts sur revenu à 100% [4'165.40] = (Total des impôts sur revenu [4'165.40] * Revenu total admis 99.00 [40'000.00]) / Revenu imposable sur Genève [40'000.00]                                                                   |
        | ---                                                                                                                                                                                                                                         |
        | Total impôts sur B.L (prévoyance) pour 100% [1'870.90] = (Total des impôts sur BL (prévoyance) [1'870.90] / Montant admis du 12.98 sur Genève [60'000.00] * Total Montants admis du 12.98 [60'000.00])                                      |
        | ---                                                                                                                                                                                                                                         |
        | Total impôts sur B.L (solde) pour 100% [20'826.85] = (Total des impôts sur BL (solde) [20'826.85] / Montant admis du 12.99 sur Genève [200'000.00] * Total Montants admis du 12.99) [200'000.00])                                           |
        | ---                                                                                                                                                                                                                                         |
        | Total impôts sur fortune pour 100% [498'447.35] = (Total des impôts sur fortune [498'447.35] * Fortune imposable pour le taux [50'000'000.00]) / Fortune imposable sur Genève [50'000'000.00]                                               |
        | ---                                                                                                                                                                                                                                         |
        | Total impôts sur le revenu et la fortune à 100% du taux [525'310.50] = Total impôts sur revenu pour 100% [26'863.15] + Total impôts sur fortune pour 100% [498'447.35]                                                                      |
        | Arrondi (5 cts inférieurs)                                                                                                                                                                                                                  |
        | ---                                                                                                                                                                                                                                         |
        | Réduction d'impôt pour 100 % du taux [51'310.50] = Max(0; Total impôts sur le revenu et la fortune à 100 % du taux [525'310.50] - Impôt Bouclier Fiscal [474'000.00])                                                                       |
        | ---                                                                                                                                                                                                                                         |
        | Réduction d'impôt accordée [51'310.50] = Min(total impôt fortune sur Genève [498'447.35],(Réduction d'impôt pour 100% du taux [51'310.50] * Fortune imposable sur Genève [50'000'000.00]) / Fortune imposable pour le taux [50'000'000.00]) |
        | Arrondi aux 5 cts inférieurs                                                                                                                                                                                                                |
        | ---                                                                                                                                                                                                                                         |
        | Bouclier fiscal sur IBF [22'968.40] = (IBF [223'122.90] * Réduction bouclier fiscal globale [51'310.50] / somme des impôts sur la fortune [498'447.35])                                                                                     |
        | ---                                                                                                                                                                                                                                         |
      Et la réduction RBF_RCAF calculée est égale à -10'910.00 avec l'explication : Bouclier fiscal sur CAF [10'910.00] = (CAF [105'983.40] * Réduction bouclier fiscal globale [51'310.50] / somme des impôts sur la fortune [498'447.35])
      Et la réduction RBF_RISF calculée est égale à -6'754.05 avec l'explication : Bouclier fiscal sur ISF [6'754.05] = (ISF [65'611.20] * Réduction bouclier fiscal globale [51'310.50] / somme des impôts sur la fortune [498'447.35])
      Et la réduction RBF_RADF calculée est égale à -229.70 avec l'explication : Bouclier fiscal sur ADF [229.70] = (ADF [2'231.25] * Réduction bouclier fiscal globale [51'310.50] / somme des impôts sur la fortune [498'447.35])
      Et la réduction RBF_RCOF calculée est égale à -7'522.80 avec l'explication : Bouclier fiscal sur COF [7'522.80] = (COF [73'079.00] * Réduction bouclier fiscal globale [51'310.50] / somme des impôts sur la fortune [498'447.35])
      Et la réduction RBF_RPPF calculée est égale à -2'925.55 avec l'explication : Bouclier fiscal sur PPF [2'925.55] = (PPF [28'419.60] * Réduction bouclier fiscal globale [51'310.50] / somme des impôts sur la fortune [498'447.35])

    @PP @BF @BouclierFiscal
    Scénario: Calculer les réductions pour bouclier fiscal à partir des assiettes revenu, fortune, bénéfice de liquidation avec un revenu déterminant pour le Bouclier Fiscal à 0
      Etant donné un contribuable célibataire pour 2024
      Et l'assiette revenu contient un revenu imposable sur Genève à 0, un revenu pour le taux à 0 et un revenu total admis 99.00 à 0
      Et l'assiette fortune contient une fortune imposable sur Genève à 51'013 et une fortune imposable pour le taux à 51'013
      Et l'assiette bénéfice de liquidation pour la part privilégié contient un montant admis du 12.98 sur Genève à 0
      Et l'assiette bénéfice de liquidation pour le solde contient un montant admis du 12.99 sur Genève à 0
      Et l'assiette bouclier fiscal contient un revenu déterminant pour le Bouclier Fiscal à 0
      Quand l'application ProdImpot calcule les impôts ICC
      Alors la réduction RBF_RIBF calculée est égale à -89.25 avec les explications :
        | ---                                                                                                                                                                                                                       |
        | Impôt Bouclier Fiscal [0.00] = MAX(0, (60 % * Revenu déterminant Bouclier Fiscal [0.00])) arrondi selon convention impôt (cad, 5 cents inferieurs)                                                                        |
        | ---                                                                                                                                                                                                                       |
        | Total des impôts sur revenu à 100% [0.00] = (Total des impôts sur revenu [0.00] * Revenu total admis 99.00 [0.00]) / Revenu imposable sur Genève [0.00]                                                                   |
        | ---                                                                                                                                                                                                                       |
        | Total impôts sur B.L (prévoyance) pour 100% [0.00] = (Total des impôts sur BL (prévoyance) [0.00] / Montant admis du 12.98 sur Genève [0.00] * Total Montants admis du 12.98 [0.00])                                      |
        | ---                                                                                                                                                                                                                       |
        | Total impôts sur B.L (solde) pour 100% [0.00] = (Total des impôts sur BL (solde) [0.00] / Montant admis du 12.99 sur Genève [0.00] * Total Montants admis du 12.99) [0.00])                                               |
        | ---                                                                                                                                                                                                                       |
        | Total impôts sur fortune pour 100% [173.15] = (Total des impôts sur fortune [173.15] * Fortune imposable pour le taux [51'013.00]) / Fortune imposable sur Genève [51'013.00]                                             |
        | ---                                                                                                                                                                                                                       |
        | Total impôts sur le revenu et la fortune à 100% du taux [173.15] = Total impôts sur revenu pour 100% [0.00] + Total impôts sur fortune pour 100% [173.15]                                                                 |
        | Arrondi (5 cts inférieurs)                                                                                                                                                                                                |
        | ---                                                                                                                                                                                                                       |
        | Réduction d'impôt pour 100 % du taux [173.15] = Max(0; Total impôts sur le revenu et la fortune à 100 % du taux [173.15] - Impôt Bouclier Fiscal [0.00])                                                                  |
        | ---                                                                                                                                                                                                                       |
        | Réduction d'impôt accordée [173.15] = Min(total impôt fortune sur Genève [173.15],(Réduction d'impôt pour 100% du taux [173.15] * Fortune imposable sur Genève [51'013.00]) / Fortune imposable pour le taux [51'013.00]) |
        | Arrondi aux 5 cts inférieurs                                                                                                                                                                                              |
        | ---                                                                                                                                                                                                                       |
        | Bouclier fiscal sur IBF [89.25] = (IBF [89.25] * Réduction bouclier fiscal globale [173.15] / somme des impôts sur la fortune [173.15])                                                                                   |
        | ---                                                                                                                                                                                                                       |
      Et la réduction RBF_RCAF calculée est égale à -42.40 avec l'explication : Bouclier fiscal sur CAF [42.40] = (CAF [42.40] * Réduction bouclier fiscal globale [173.15] / somme des impôts sur la fortune [173.15])
      Et la réduction RBF_RADF calculée est égale à -0.90 avec l'explication : Bouclier fiscal sur ADF [0.90] = (ADF [0.90] * Réduction bouclier fiscal globale [173.15] / somme des impôts sur la fortune [173.15])
      Et la réduction RBF_RCOF calculée est égale à -29.25 avec l'explication : Bouclier fiscal sur COF [29.25] = (COF [29.25] * Réduction bouclier fiscal globale [173.15] / somme des impôts sur la fortune [173.15])
      Et la réduction RBF_RPPF calculée est égale à -11.35 avec l'explication : Bouclier fiscal sur PPF [11.35] = (PPF [11.35] * Réduction bouclier fiscal globale [173.15] / somme des impôts sur la fortune [173.15])
