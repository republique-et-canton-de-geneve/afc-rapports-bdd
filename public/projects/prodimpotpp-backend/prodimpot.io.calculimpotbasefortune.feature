#language: fr

Fonctionnalité: F2 - Calculer les impôts ICC sur la fortune

  Règle: R1 - Calculer l'impôt de base sur la fortune ICC
  - Pour un contribuable célibataire ou un couple marié avec ou sans charges de famille
  -- L'impôt de base, dû pour une année fiscale est calculé en se basant sur le barème Impôt de base sur la fortune
  -- L'impôt se détermine sur la tranche de fortune immédiatement inférieure à la fortune déterminante puis sur la différence entre la fortune déterminante et la fortune de la tranche immédiatement inférieure.

  - Mnt Impôt = Impôt de base de la tranche inférieure + Impôt de la différence (arrondi au 5 centimes les plus proches)
  -- Pour déterminer l'impôt sur la différence, il faut :
  ---- Établir la différence entre la fortune déterminante et la tranche inférieure
  Différence de la tranche = fortune déterminante - Tranche inférieure
  ---- Calculer l'impôt pour la différence en appliquant le taux de la tranche de la fortune déterminante
  Impôt de la différence = Différence de la tranche * Taux de la tranche / 100 (arrondi au 5 centimes les plus proches)
  - Pour le cas d'une fortune déterminante égal a la fortune imposable
  - Impôt de base sur la fortune = Mnt Impôt
  - Pour le cas d'une fortune déterminante différente de la fortune imposable
  - La fortune déterminante permet, comme décrit précédemment, de déterminer un montant d'impôt qui sera porté selon une règle de trois au prorata de la fortune imposable.
  Impôt de base sur la fortune = Mnt Impôt / Fortune déterminante * Fortune Imposable (arrondi au 5 centimes les plus proches)

  - L'impôt de base sur la fortune doit être calculé au prorata du nombre de jours
  -- Impôt de base net sur la fortune = Impôt de base sur la fortune / 360 * Nbr de jours assujettissement (arrondi au 5 centimes les plus proches)

    @BarèmeFortune @IBF @Seul @Couple
    Plan du Scénario: Le calcul de l'IBF dépend de l'assiette fortune du contribuable et du nombre de jours de l'assujettissement
      Etant donné une assiette pour un contribuable <situation> pour <periode fiscale>
      Et que le nombre de jours de l'assujettissement est de <nb jours assuj>
      Et que le montant imposable de l'assiette est <fortune imposable>
      Et que le montant déterminant pour le taux de l'assiette est <fortune déterminante>
      Quand l'application ProdImpot calcule l'impôt cantonal sur la fortune pour <periode fiscale>
      Alors l'impôt IBF contient le montant <IBF>
      Exemples:
        | Test | periode fiscale | situation | fortune imposable | fortune déterminante | nb jours assuj | IBF     | Observations                                                           |
        | 1    | 2022            | seul      | 1543              | 1543                 | 360            | 2.70    | Assuj sur 360 jours avec une fortune imposable = fortune déterminante  |
        | 2    | 2022            | seul      | 1012849           | 4186334              | 100            | 1145.25 | Assuj sur 100 jours avec une fortune imposable =! fortune déterminante |
        | 3    | 2022            | marié     | 27236             | 27236                | 360            | 47.65   | Assuj sur 360 jours avec une fortune imposable = fortune déterminante  |
        | 4    | 2022            | marié     | 1012849           | 4186334              | 360            | 4122.90 | Assuj sur 360 jours avec une fortune imposable =! fortune déterminante |

  Règle: R2 - Calculer l'impôt de base sur la fortune avec le taux max
  -- Lorsqu'on demande à appliquer le barème au taux max :
  --- L'impôt IBF est calculé en appliquant le barème de l'impôt de base sur la fortune

    @TauxMax @IBF @Seul @Couple
    Plan du Scénario: Le calcul de l'IBF au taux max dépend de l'assiette fortune du contribuable et de la période fiscale
      Etant donné une assiette pour un contribuable <situation> pour <periode fiscale>
      Et que le montant imposable de l'assiette est <fortune imposable>
      Et que le montant déterminant pour le taux de l'assiette est <fortune déterminante>
      Et qu'on souhaite appliquer le barème au taux max
      Quand l'application ProdImpot calcule l'impôt cantonal sur la fortune pour <periode fiscale>
      Alors l'impôt IBF contient le montant <IBF>
      Et l'impôt IBF contient le taux effectif <taux effectif>
      Exemples:
        | Test | periode fiscale | situation | fortune imposable | fortune déterminante | IBF     | taux effectif | Observations                                        |
        | 1    | 2022            | seul      | 1543              | 1543                 | 2.70    | 0.00175       | taux max n'est pas appliqué pour le calcul de l'IBF |
        | 2    | 2022            | marié     | 27236             | 27236                | 47.65   | 0.00175       | taux max n'est pas appliqué pour le calcul de l'IBF |
        | 3    | 2022            | marié     | 1012849           | 4186334              | 4122.90 | 0.00407       | taux max n'est pas appliqué pour le calcul de l'IBF |

  Règle: R3 - Calculer l'impôt supplémentaire sur la fortune avec le taux max
  -- Lorsqu'on demande à appliquer le barème au taux max :
  --- L'impôt ISF est calculé en appliquant le barème de l'impôt supplémentaire sur la fortune

    @TauxMax @ISF @Seul @Couple
    Plan du Scénario: Le calcul de l'ISF au taux max dépend de l'assiette fortune du contribuable et de la période fiscale
      Etant donné une assiette pour un contribuable <situation> pour <periode fiscale>
      Et que le montant imposable de l'assiette est <fortune imposable>
      Et que le montant déterminant pour le taux de l'assiette est <fortune déterminante>
      Et qu'on souhaite appliquer le barème au taux max
      Quand l'application ProdImpot calcule l'impôt cantonal sur la fortune pour <periode fiscale>
      Alors l'impôt ISF contient le montant <ISF>
      Et l'impôt ISF contient le taux effectif <taux effectif>
      Exemples:
        | Test | periode fiscale | situation | fortune imposable | fortune déterminante | ISF    | taux effectif | Observations                                        |
        | 1    | 2022            | seul      | 1543              | 1543                 | 0      | 0             | taux max n'est pas appliqué pour le calcul de l'ISF |
        | 2    | 2022            | marié     | 27236             | 27236                | 0      | 0             | taux max n'est pas appliqué pour le calcul de l'ISF |
        | 3    | 2022            | marié     | 1012849           | 4186334              | 929.70 | 0.00092       | taux max n'est pas appliqué pour le calcul de l'ISF |
