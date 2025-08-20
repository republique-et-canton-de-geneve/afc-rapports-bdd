#language: fr

Fonctionnalité: F7 - Calcul des barèmes d'impôt IFD

  Règle: R1 - Calcul des barèmes d'impôt IFD

    @PP @Barème @IFD @Revenu
    Scénario: Calcul des barèmes d'impôt sur le revenu célibataire IFD
      Quand l'application ProdImpot calcule les barèmes d'impôt pour la période fiscale 2024
      Alors le barème sur le revenu célibataire IFD calculé est le suivant :
        | revenu  | impôt                    | impôt par 100chf en plus |
        | 15000   | 0.00                     | 0.77                     |
        | 32800   | 137.05                   | 0.88                     |
        | 42900   | 225.90                   | 2.64                     |
        | 57200   | 603.40                   | 2.97                     |
        | 75200   | 1138.00                  | 5.94                     |
        | 81000   | 1482.50                  | 6.60                     |
        | 107400  | 3224.90                  | 8.80                     |
        | 139600  | 6058.50                  | 11.00                    |
        | 182600  | 10788.50                 | 13.20                    |
        | 783200  | 90067.70                 |                          |
        | 783300  | 90079.50                 | 11.50                    |

    @PP @Barème @IFD @Marié
    Scénario: Calcul des barèmes d'impôt sur le revenu marié IFD
      Quand l'application ProdImpot calcule les barèmes d'impôt pour la période fiscale 2024
      Alors le barème sur le revenu marié IFD calculé est le suivant :
        | revenu | impôt                    | impôt par 100chf en plus |
        | 29300  | 0.00                     |  1.00                    |
        | 52700  | 234.00                   |  2.00                    |
        | 60500  | 390.00                   |  3.00                    |
        | 78100  | 918.00                   |  4.00                    |
        | 93600  | 1538.00                  |  5.00                    |
        | 107200 | 2218.00                  |  6.00                    |
        | 119000 | 2926.00                  |  7.00                    |
        | 128800 | 3612.00                  |  8.00                    |
        | 136600 | 4236.00                  |  9.00                    |
        | 142300 | 4749.00                  |  10.00                   |
        | 146300 | 5149.00                  |  11.00                   |
        | 148300 | 5369.00                  |  12.00                   |
        | 150300 | 5609.00                  |  13.00                   |
        | 928600 | 106788.00                |                          |
        | 928700 | 106800.50                |  11.50                   |

  Règle: R2 - Réduction parentale par enfant et par personne nécessiteuse
  La réduction parental est determinée pour chaque période fiscale

    @PP @ReductionParental @IFD
    Scénario: Réduction parentale par enfant et par personne nécessiteuse
      Quand l'application ProdImpot calcule la réduction parentale pour la période fiscale 2024
      Alors la valeur de la réduction est de 259 par enfant et par personne nécessiteuse

