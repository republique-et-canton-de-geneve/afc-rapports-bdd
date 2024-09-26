#language: fr

Fonctionnalité: F3 - Calculer l'impôt de base sur le revenu pour les prestations en capital

  Règle: R1 - Calculer le montant de base pour le calcul du barème ICC pour les prestations en capital
  - Pour un contribuable célibataire sans charges de famille
  -- Le montant de base pour le calcul du barème = le revenu imposable
  - Pour un couple marié ou un contribuable célibataire avec des charges de famille
  -- Le montant de base pour le calcul du barème = le revenu imposable * 50%
  - Pour un célibataire au splitting partiel avec enfants en garde alterné
  -- Le montant de base pour le calcul du barème = le revenu imposable * 55.56%

    @BarèmePersonneSeule @BarèmeMarié @RevenuCalculTauxICC @IPC
    Plan du Scénario: Le calcul du revenu pour le calcul du taux dépend de la situation familiale et de l'assiette revenu du contribuable
      Etant donné une assiette pour un contribuable <situation> pour <periode fiscale>
      Et que le montant imposable de l'assiette est <revenu imposable>
      Quand l'application ProdImpot produit l'ICC sur les prestations en capital pour <periode fiscale>
      Alors le montant de base pour le calcul du barème est <base calcul barème>
      Exemples:
        | Test | periode fiscale | situation                             | revenu imposable | base calcul barème | Observations                                                                                   |
        | 1    | 2024            | seul                                  | 600000           |                    | Barème célibataire pour 2024, revenu pour le calcul du taux = revenu imposable                 |
        | 2    | 2023            | seul                                  | 600000           |                    | Barème célibataire pour 2023, revenu pour le calcul du taux = revenu imposable                 |
        | 3    | 2024            | marié                                 | 600000           | 300000             | Barème marié pour 2024, revenu pour le calcul du taux = revenu imposable  * 0.50               |
        | 4    | 2022            | marié                                 | 600000           | 300000             | Barème marié pour 2023, revenu pour le calcul du taux = revenu imposable  * 0.50               |
        | 5    | 2024            | seul avec un enfant en garde alternée | 600000           | 333360             | Barème splitting partiel pour 2024, revenu pour le calcul du taux = revenu imposable  * 0.5556 |

  Règle: R2 - Calculer le 1/5eme de l'impôt ICC pour les préstations en capital
  - Le 1/5eme de l'impôt est calculé à partir du montant de l'impôt de base
  -- 1/5eme de l'impôt = montant de l'impôt de base / 5 (arrondi au 5 cts les plus proches)

    @1/5emeImpot @IPC @ICC
    Plan du Scénario: Le 1/5eme de l'impôt est calculé à partir du montant de l'impôt de base
      Etant donné une assiette pour un contribuable <situation> pour <periode fiscale>
      Et que le montant imposable de l'assiette est <revenu imposable>
      Quand l'application ProdImpot produit l'ICC sur les prestations en capital pour <periode fiscale>
      Alors l'impôt IBR contient le montant <UnCinquiemeImpot>
      Et le montant de base pour le calcul du barème est <base calcul barème>
      Exemples:
        | Test | periode fiscale | situation                             | revenu imposable | base calcul barème | UnCinquiemeImpot | Observations                            |
        | 1    | 2024            | seul                                  | 75801            |                    | 1535.30          | Barème célibataire                      |
        | 2    | 2024            | marié                                 | 51992            | 25996              | 261.50           | Barème marié                            |
        | 3    | 2024            | seul avec un enfant en garde alternée | 252881           | 140500             | 6397.95          | Barème célibataire au splitting partiel |

  Règle: R3 - Calculer le 1/5eme de l'impôt IFD pour les préstations en capital
  - Le 1/5eme de l'impôt est calculé à partir du montant de l'impôt de base
  -- 1/5eme de l'impôt = montant de l'impôt de base / 5 (arrondi au 5 cts les plus proches)

    @1/5emeImpot @IPC @IFD
    Plan du Scénario: Le 1/5eme de l'impôt est calculé à partir du montant de l'impôt de base
      Etant donné une assiette pour un contribuable <situation> pour <periode fiscale>
      Et que le montant imposable de l'assiette est <revenu imposable>
      Quand l'application ProdImpot produit l'IFD sur les prestations en capital pour <periode fiscale>
      Alors l'impôt IBR contient le montant <UnCinquiemeImpot>
      Exemples:
        | Test | periode fiscale | situation | revenu imposable | UnCinquiemeImpot | Observations       |
        | 1    | 2024            | seul      | 75801            | 234.70           | Barème célibataire |
        | 2    | 2024            | marié     | 539433           | 11238.40         | Barème marié       |
