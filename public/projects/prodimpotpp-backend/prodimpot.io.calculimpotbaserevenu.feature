#language: fr

Fonctionnalité: F1 - Calculer l'impôt de base sur le revenu

  Règle: R1 - Calculer l'impôt de base sur le revenu
  - Pour un contribuable célibataire sans charges de famille
  - L'impôt de base dû pour une année fiscale est calculé en se basant sur un barème célibataire (100% du revenu pour le taux)
  - Pour un couple marié ou un contribuable célibataire avec des charges de famille
  - L'impôt de base dû pour une année fiscale est calculé en se basant sur un barème marié (50% du revenu pour le taux, arrondi au franc inférieure)
  - L'impôt de base est multiplié par 2
  - L'impôt se détermine sur la tranche de revenu immédiatement inférieure au revenu pour le taux puis sur la différence entre le revenu pour le taux et le revenu de la tranche immédiatement inférieure.
  - Mnt Impôt = Impôt de base de la tranche inférieure + Impôt de la différence (arrondi au 5 centimes les plus proches)
  - Pour déterminer l'impôt sur la différence, il faut :
  ---- Établir la différence entre le revenu pour le taux et la tranche inférieure
  Différence de la tranche = revenu déterminant - Tranche inférieure
  ---- Calculer l'impôt pour la différence en appliquant le taux de la tranche du revenu déterminant
  Impôt de la différence = Différence de la tranche * Taux de la tranche / 100 (arrondi au 5 centimes les plus proches)
  - Pour le cas d'un revenu déterminant égal au revenu imposable
  - Impôt de base sur le revenu = Mnt Impôt
  - Pour le cas d'un revenu déterminant différent du revenu imposable
  - Le revenu déterminant permet, comme décrit précédemment, de déterminer un montant d'impôt qui sera porté selon une règle de trois au prorata du revenu imposable.
  Impôt de base sur le revenu = Mnt Impôt / Revenu déterminant * Revenu Imposable Genevois (arrondi au 5 centimes les plus proches)

    @BarèmeSeul @BarèmeMarié @IBR
    Plan du Scénario: Le calcul de l'IBR dépend de la situation familiale et de l'assiette revenu du contribuable
      Etant donné une assiette pour un contribuable <situation> pour <periode fiscale>
      Et que le montant imposable de l'assiette est <revenu imposable>
      Et que le montant déterminant pour le taux de l'assiette est <revenu déterminant>
      Quand l'application ProdImpot calcule l'impôt cantonal sur le revenu pour <periode fiscale>
      Alors l'impôt IBR contient le montant <IBR>
      Et le montant de base pour le calcul du barème est <base calcul barème>
      Exemples:
        | Test | periode fiscale | situation | revenu imposable | revenu déterminant | base calcul barème | IBR      | Observations                                                      |
        | 1    | 2022            | seul      | 37313            | 37313              |                    | 2123.65  | Barème célibataire avec un revenu imposable = revenu déterminant  |
        | 2    | 2022            | seul      | 301800           | 304254             | 304254             | 45453.70 | Barème célibataire avec un revenu imposable =! revenu déterminant |
        | 3    | 2022            | marié     | 91684            | 91684              | 45842              | 6678.10  | Barème marié avec un revenu imposable = revenu déterminant        |
        | 4    | 2022            | marié     | 7255             | 47445              | 23722              | 155.60   | Barème marié avec un revenu imposable =! revenu déterminant       |

  Règle: R2 - Calculer l'impôt de base sur le revenu avec le barème splitting partiel
  - A partir de la période fiscale 2024, pour un contribuable célibataire avec au moins un enfant en garde alternée
  - L'impôt de base dû pour une année fiscale est calculé en se basant sur un barème splitting partiel, revenu déterminant divisé par 1.8 (à peu près 55.55%) (arrondi au franc inférieur)
  - L'impôt de base est multiplié par 1.8

  - L'impôt se détermine sur la tranche de revenu immédiatement inférieure au revenu déterminant puis sur la différence entre le revenu déterminant et le revenu de la tranche immédiatement inférieure.
  - Mnt Impôt = Impôt de base de la tranche inférieure + Impôt de la différence (arrondi au 5 centimes les plus proches)
  - Pour déterminer l'impôt sur la différence, il faut :
  ---- Établir la différence entre le revenu déterminant et la tranche inférieure
  Différence de la tranche = revenu déterminant - Tranche inférieure
  ---- Calculer l'impôt pour la différence en appliquant le taux de la tranche du revenu déterminant
  Impôt de la différence = Différence de la tranche * Taux de la tranche / 100
  - Pour le cas d'un revenu déterminant égal au revenu imposable
  - Impôt de base sur le revenu = Mnt Impôt
  - Pour le cas d'un revenu déterminant différent du revenu imposable
  - Le revenu déterminant permet, comme décrit précédemment, de déterminer un montant d'impôt qui sera porté selon une règle de trois au prorata du revenu imposable.
  Impôt de base sur le revenu = Mnt Impôt / Revenu déterminant * Revenu Imposable Genevois (arrondi au 5 centimes les plus proches)

    @BarèmeSplittingPartiel @IBR
    Plan du Scénario: Le calcul de l'IBR dépend de la situation familiale, de l'assiette revenu du contribuable et de la période fiscale
      Etant donné une assiette pour un contribuable seul avec un enfant en garde alternée pour <periode fiscale>
      Et que le montant imposable de l'assiette est <revenu imposable>
      Et que le montant déterminant pour le taux de l'assiette est <revenu déterminant>
      Quand l'application ProdImpot calcule l'impôt cantonal sur le revenu pour <periode fiscale>
      Alors l'impôt IBR contient le montant <IBR>
      Et le montant de base pour le calcul du barème est <base calcul barème>
      Exemples:
        | Test | periode fiscale | revenu imposable | revenu déterminant | base calcul barème | IBR     | Observations                                                                                 |
        | 1    | 2024            | 100007           | 100007             | 55563              | 8353.00 | Barème splitting partiel pour la période 2024 avec un revenu imposable = revenu déterminant  |
        | 2    | 2024            | 1007             | 51788              | 28773              | 33.30   | Barème splitting partiel pour la période 2024 avec un revenu imposable =! revenu déterminant |
        | 3    | 2022            | 37313            | 37313              |                    | 2123.65 | Le barème splitting partiel ne s'applique pas pour la période fiscale 2022                   |

  Règle: R3 - Calculer l'impôt de base sur le revenu ICC avec le taux max
  -- Lorsqu'on demande à appliquer le barème au taux max :
  --- L'impôt IBR ICC est calculé en se basant sur le taux de la tranche maximale du barème impôt sur le revenu

    @TauxMax @IBR
    Plan du Scénario: Le calcul de l'IBR au taux max dépend de l'assiette revenu du contribuable et de la période fiscale
      Etant donné une assiette pour un contribuable <situation> pour <periode fiscale>
      Et que le montant imposable de l'assiette est <revenu imposable>
      Et qu'on souhaite appliquer le barème au taux max
      Quand l'application ProdImpot calcule l'impôt cantonal sur le revenu pour <periode fiscale>
      Alors l'impôt IBR contient le montant <IBR ICC>
      Et l'impôt IBR contient le taux effectif <taux max>
      Exemples:
        | Test | periode fiscale | situation | revenu imposable | IBR ICC  | taux max | Observations                                                                   |
        | 1    | 2024            | seul      | 100007           | 19001.35 | 0.19     | taux max appliqué pour une personne seul car le revenu déterminant est absent  |
        | 2    | 2024            | marié     | 100007           | 19001.35 | 0.19     | taux max appliqué pour une personne marié car le revenu déterminant est absent |
        | 3    | 2023            | marié     | 100007           | 19001.35 | 0.19     | taux max appliqué pour une personne marié car le revenu déterminant est absent |
        | 4    | 2021            | seul      | 100007           | 19001.35 | 0.19     | taux max appliqué pour une personne seul car le revenu déterminant est absent  |

  Règle: R4 - Calculer l'impôt de base sur le revenu IFD avec le taux max
  -- Lorsqu'on demande à appliquer le barème au taux max :
  --- L'impôt IBR IFD est calculé en se basant sur le taux de la tranche maximale du barème impôt sur le revenu

    @TauxMax @IBR @IFD
    Plan du Scénario: Le calcul de l'IBR au taux max dépend de l'assiette revenu du contribuable et de la période fiscale
      Etant donné une assiette pour un contribuable <situation> pour <periode fiscale>
      Et que le montant imposable de l'assiette est <revenu imposable>
      Et qu'on souhaite appliquer le barème au taux max
      Quand l'application ProdImpot calcule l'impôt fédéral pour <periode fiscale>
      Alors l'impôt IBR contient le montant <IBR IFD>
      Et l'impôt IBR contient le taux effectif <taux max>
      Exemples:
        | Test | periode fiscale | situation | revenu imposable | IBR IFD | taux max | Observations                                                                   |
        | 1    | 2024            | seul      | 100007           | 11500   | 0.115    | taux max appliqué pour une personne seul car le revenu déterminant est absent  |
        | 2    | 2024            | marié     | 100007           | 11500   | 0.115    | taux max appliqué pour une personne marié car le revenu déterminant est absent |
        | 3    | 2023            | marié     | 100007           | 11500   | 0.115    | taux max appliqué pour une personne marié car le revenu déterminant est absent |
        | 4    | 2021            | seul      | 100007           | 11500   | 0.115    | taux max appliqué pour une personne seul car le revenu déterminant est absent  |

  Règle: R5 - Calculer l'impôt de base sur le revenu IFD
  -- Avant la période fiscale 2024, lorsque l'impôt déterminant de l'IBR est inférieur au seuil de 25 francs
  --- L'impôt IBR est produit avec un montant à zéro

    @IBR @IFD @Seuil
    Scénario: Le calcul de l'IBR dépend de l'assiette revenu du contribuable et de la période fiscale
      Etant donné une assiette pour un contribuable seul pour 2022
      Et que le montant imposable de l'assiette est 29100
      Et que le montant déterminant pour le taux de l'assiette est 17200
      Quand l'application ProdImpot calcule l'impôt fédéral pour 2022
      Alors l'impôt IBR contient le montant 0.00

  Règle: R6 - Calculer l'impôt de base sur le revenu IFD
  -- À partir de la période fiscale 2024, lorsque l'impôt déterminant de l'IBR est inférieur au seuil de 25 francs
  --- L'impôt IBR est produit normalement sans passer son montant à zéro

    @IBR @IFD @Seuil
    Scénario: Le calcul de l'IBR dépend de l'assiette revenu du contribuable et de la période fiscale
      Etant donné une assiette pour un contribuable seul pour 2024
      Et que le montant imposable de l'assiette est 29100
      Et que le montant déterminant pour le taux de l'assiette est 17200
      Quand l'application ProdImpot calcule l'impôt fédéral pour 2024
      Alors l'impôt IBR contient le montant 28.55
