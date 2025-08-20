#language: fr

Fonctionnalité: F6 - Calcul des barèmes d'impôt ICC

  Règle: R1 - Calcul des barèmes d'impôt ICC

    @PP @Barème @ICC @Revenu
    Scénario: Calcul des barèmes d'impôt sur le revenu ICC
      Quand l'application ProdImpot calcule les barèmes d'impôt pour la période fiscale 2024
      Alors le barème sur le revenu ICC calculé est le suivant :
        | entre   | et      | Taux de la tranche % | Impôt max. de la tranche | Impôt total (cumul des tranches) |
        | 0       | 18'479  | 0.00                 | 0.00                     | 0.00                             |
        | 18'480  | 22'264  | 8.00                 | 302.80                   | 302.80                           |
        | 22'265  | 24'491  | 9.00                 | 200.45                   | 503.25                           |
        | 24'492  | 26'717  | 10.00                | 222.60                   | 725.85                           |
        | 26'718  | 28'943  | 11.00                | 244.85                   | 970.70                           |
        | 28'944  | 34'509  | 12.00                | 667.90                   | 1'638.60                         |
        | 34'510  | 38'962  | 13.00                | 578.90                   | 2'217.50                         |
        | 38'963  | 43'416  | 14.00                | 623.55                   | 2'841.05                         |
        | 43'417  | 47'868  | 14.50                | 645.55                   | 3'486.60                         |
        | 47'869  | 76'811  | 15.00                | 4'341.45                 | 7'828.05                         |
        | 76'812  | 125'793 | 15.50                | 7'592.20                 | 15'420.25                        |
        | 125'794 | 169'208 | 16.00                | 6'946.40                 | 22'366.65                        |
        | 169'209 | 191'473 | 16.50                | 3'673.75                 | 26'040.40                        |
        | 191'474 | 273'850 | 17.00                | 14'004.10                | 40'044.50                        |
        | 273'851 | 291'661 | 17.50                | 3'116.95                 | 43'161.45                        |
        | 291'662 | 410'775 | 18.00                | 21'440.50                | 64'601.95                        |
        | 410'776 | 643'435 | 18.50                | 43'042.10                | 107'644.05                       |
        | 643'436 |         | 19.00                |                          |                                  |

    @PP @Barème @ICC @Revenu
    Scénario: Calcul des barèmes d'impôt sur le revenu ICC en 2025
      Quand l'application ProdImpot calcule les barèmes d'impôt pour la période fiscale 2025
      Alors le barème sur le revenu ICC calculé est le suivant :
        | entre   | et      | Taux de la tranche % | Impôt max. de la tranche | Impôt total (cumul des tranches) |
        | 0       | 18'649  | 0.00                 | 0.00                     | 0.00                             |
        | 18'650  | 22'469  | 7.30                 | 278.85                   | 278.85                           |
        | 22'470  | 24'716  | 8.20                 | 184.25                   | 463.10                           |
        | 24'717  | 26'962  | 9.10                 | 204.40                   | 667.50                           |
        | 26'963  | 29'210  | 10.00                | 224.80                   | 892.30                           |
        | 29'211  | 34'827  | 10.90                | 612.25                   | 1'504.55                         |
        | 34'828  | 39'320  | 11.30                | 507.70                   | 2'012.25                         |
        | 39'321  | 43'815  | 12.30                | 552.90                   | 2'565.15                         |
        | 43'816  | 48'309  | 12.80                | 575.25                   | 3'140.40                         |
        | 48'310  | 77'518  | 13.20                | 3'855.60                 | 6'996.00                         |
        | 77'519  | 126'950 | 14.20                | 7'019.35                 | 14'015.35                        |
        | 126'951 | 170'764 | 15.00                | 6'572.10                 | 20'587.45                        |
        | 170'765 | 193'234 | 15.60                | 3'505.30                 | 24'092.75                        |
        | 193'235 | 276'369 | 15.80                | 13'135.35                | 37'228.10                        |
        | 276'370 | 294'345 | 16.00                | 2'876.15                 | 40'104.25                        |
        | 294'346 | 414'554 | 16.80                | 20'195.10                | 60'299.35                        |
        | 414'555 | 649'355 | 17.60                | 41'325.00                | 101'624.35                       |
        | 649'356 |         | 18.00                |                          |                                  |

    @PP @Barème @ICC @Fortune
    Scénario: Calcul des barèmes d'impôt sur le fortune ICC
      Quand l'application ProdImpot calcule les barèmes d'impôt pour la période fiscale 2024
      Alors le barème sur la fortune ICC calculé est le suivant :
        | entre     | et        | Taux de la tranche ‰ | Impôt max. de la tranche | Impôt total (cumul des tranches) |
        | 0         | 117'319   | 1.75                 | 205.30                   | 205.30                           |
        | 117'320   | 234'637   | 2.25                 | 263.95                   | 469.25                           |
        | 234'638   | 351'956   | 2.75                 | 322.65                   | 791.90                           |
        | 351'957   | 469'273   | 3.00                 | 351.95                   | 1'143.85                         |
        | 469'274   | 703'911   | 3.25                 | 762.55                   | 1'906.40                         |
        | 703'912   | 938'548   | 3.50                 | 821.25                   | 2'727.65                         |
        | 938'549   | 1'173'185 | 3.75                 | 879.90                   | 3'607.55                         |
        | 1'173'186 | 1'407'821 | 4.00                 | 938.55                   | 4'546.10                         |
        | 1'407'822 | 1'759'777 | 4.25                 | 1'495.80                 | 6'041.90                         |
        | 1'759'778 |           | 4.50                 |                          |                                  |

    @PP @Barème @ICC @FortuneSupplémentaire
    Scénario: Calcul des barèmes d'impôt sur le fortune supplémentaire ICC
      Quand l'application ProdImpot calcule les barèmes d'impôt pour la période fiscale 2024
      Alors le barème sur la fortune supplémentaire ICC calculé est le suivant :
        | entre     | et        | Taux de la tranche ‰ | Impôt max. de la tranche | Impôt total (cumul des tranches) |
        | 0         | 117'319   | 0.0000               | 0.00                     | 0.00                             |
        | 117'320   | 234'637   | 0.1125               | 13.20                    | 13.20                            |
        | 234'638   | 351'956   | 0.1375               | 16.15                    | 29.35                            |
        | 351'957   | 469'273   | 0.3000               | 35.20                    | 64.55                            |
        | 469'274   | 703'911   | 0.3250               | 76.25                    | 140.80                           |
        | 703'912   | 938'548   | 0.5250               | 123.20                   | 264.00                           |
        | 938'549   | 1'173'185 | 0.5625               | 132.00                   | 396.00                           |
        | 1'173'186 | 1'407'821 | 0.8000               | 187.70                   | 583.70                           |
        | 1'407'822 | 1'759'777 | 0.8500               | 299.15                   | 882.85                           |
        | 1'759'778 | 3'519'554 | 1.1250               | 1'979.75                 | 2'862.60                         |
        | 3'519'555 |           | 1.3500               |                          |                                  |

    @PP @Barème @ICC @CentimesAdditionnels
    Scénario: Calcul des centimes additionnels et la part privilégiée pour les impôts ICC
      Quand l'application ProdImpot calcule les barèmes d'impôt pour la période fiscale 2024
      Alors les centimes additionnels et la part privilégiée ICC calculé est le suivant :
        | numeroOFS | commune            | centimes additionnels | part privilégiée |
        | 6601      | Aire-la-Ville      | 50                    | 80               |
        | 6602      | Anières            | 31                    | 20               |
        | 6603      | Avully             | 51                    | 80               |
        | 6604      | Avusy              | 50                    | 80               |
        | 6605      | Bardonnex          | 43                    | 76               |
        | 6606      | Bellevue           | 41                    | 46               |
        | 6607      | Bernex             | 48                    | 80               |
        | 6608      | Carouge (GE)       | 40                    | 27               |
        | 6609      | Cartigny           | 42                    | 71               |
        | 6610      | Céligny            | 33                    | 20               |
        | 6611      | Chancy             | 51                    | 80               |
        | 6612      | Chêne-Bougeries    | 32                    | 20               |
        | 6613      | Chêne-Bourg        | 46                    | 76               |
        | 6614      | Choulex            | 40                    | 44               |
        | 6615      | Collex-Bossy       | 46                    | 80               |
        | 6616      | Collonge-Bellerive | 28                    | 20               |
        | 6617      | Cologny            | 27                    | 20               |
        | 6618      | Confignon          | 46                    | 77               |
        | 6619      | Corsier (GE)       | 32                    | 21               |
        | 6620      | Dardagny           | 48                    | 80               |
        | 6621      | Genève             | 45.49                 | 28               |
        | 6622      | Genthod            | 25                    | 20               |
        | 6623      | Le Grand-Saconnex  | 44                    | 52               |
        | 6624      | Gy                 | 46                    | 59               |
        | 6625      | Hermance           | 42                    | 49               |
        | 6626      | Jussy              | 41                    | 38               |
        | 6627      | Laconnex           | 44                    | 75               |
        | 6628      | Lancy              | 47                    | 45               |
        | 6629      | Meinier            | 42                    | 75               |
        | 6630      | Meyrin             | 44                    | 35               |
        | 6631      | Onex               | 50.50                 | 80               |
        | 6632      | Perly-Certoux      | 43                    | 74               |
        | 6633      | Plan-les-Ouates    | 35                    | 20               |
        | 6634      | Pregny-Chambésy    | 32                    | 26               |
        | 6635      | Presinge           | 40                    | 30               |
        | 6636      | Puplinge           | 48                    | 80               |
        | 6637      | Russin             | 39                    | 37               |
        | 6638      | Satigny            | 39                    | 28               |
        | 6639      | Soral              | 44                    | 79               |
        | 6640      | Thônex             | 44                    | 75               |
        | 6641      | Troinex            | 40                    | 49               |
        | 6642      | Vandoeuvres        | 29                    | 20               |
        | 6643      | Vernier            | 50                    | 80               |
        | 6644      | Versoix            | 45.50                 | 76               |
        | 6645      | Veyrier            | 37                    | 47               |
