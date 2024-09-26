#language: fr

Fonctionnalité: F4 - Calculer l'impôt de base sur la part du bénéfice de liquidation

  Règle: R1 - Calculer l'impôt de base sur la part du bénéfice de liquidation ICC (Prévoyance)
  - l'impôt de base sur la part du bénéfice de liquidation est calculé à partir du montant de l'impôt de base
  - l'impôt de base sur la part du bénéfice de liquidation = montant de l'impôt de base / 5 (arrondi au 5 cts les plus proches)

    @ImpotBasePartBL @BL @ICC @Prevoyance
    Plan du Scénario: l'impôt de base ICC sur la part du bénéfice de liquidation est calculé à partir du montant de l'impôt de base
      Etant donné une assiette pour un contribuable <situation> pour <periode fiscale>
      Et que le montant imposable de l'assiette est <revenu>
      Quand l'application ProdImpot produit l'ICC sur la part du bénéfice de liquidation pour <periode fiscale>
      Alors l'impôt IBR contient le montant <ImpotBaseICCPartBL>
      Exemples:
        | Test | periode fiscale | situation                             | revenu | ImpotBaseICCPartBL | Observations                            |
        | 1    | 2023            | seul                                  | 100000 | 2303.25            | Barème célibataire                      |
        | 2    | 2023            | marié                                 | 100000 | 1556.55            | Barème marié                            |
        | 3    | 2024            | seul avec un enfant en garde alternée | 100000 | 1670.40            | Barème célibataire au splitting partiel |

  Règle: R2 - Calculer l'impôt de base sur la part du bénéfice de liquidation IFD (Prévoyance)
  - l'impôt de base sur la part du bénéfice de liquidation est calculé à partir du montant de l'impôt de base
  - l'impôt de base sur la part du bénéfice de liquidation = montant de l'impôt de base / 5 (arrondi au 5 cts les plus proches)

    @ImpotBasePartBL @BL @IFD @Prevoyance
    Plan du Scénario: l'impôt de base IFD sur la part du bénéfice de liquidation est calculé à partir du montant de l'impôt de base
      Etant donné une assiette pour un contribuable <situation> pour <periode fiscale>
      Et que le montant imposable de l'assiette est <revenu>
      Quand l'application ProdImpot produit l'IFD sur la part du bénéfice de liquidation pour <periode fiscale>
      Alors l'impôt IBR contient le montant <ImpotBaseIFDPartBL>
      Exemples:
        | Test | periode fiscale | situation | revenu | ImpotBaseIFDPartBL | Observations       |
        | 1    | 2023            | seul      | 100000 | 560.40             | Barème célibataire |
        | 2    | 2023            | marié     | 100000 | 382.60             | Barème marié       |

  Règle: R3 - Calculer l'impôt de base sur le solde du bénéfice de liquidation ICC (Solde)
  - l'impôt de base ICC sur le solde du bénéfice de liquidation est calculé selon le barème ICC PP
  -- Le montant déterminant pour le taux à considérer est le 1/5 de la somme de tous les revenus "Solde du bénéfice de liquidation" (arrondi au franc inférieur) déclarés
  -- L'impôt de base est porté selon une règle de trois au prorata du revenu imposable
  --- Impôt de base IFD sur le solde BL = (Montant de l'impôt / montant déterminant pour le taux) * Revenu

    @ImpotBaseSoldeBL @BL @ICC @Solde
    Plan du Scénario: l'impôt de base ICC sur le solde du bénéfice de liquidation est calculé selon le barème ICC PP
      Etant donné une assiette pour un contribuable <situation> pour <periode fiscale>
      Et que le montant imposable de l'assiette est <revenu>
      Quand l'application ProdImpot produit l'ICC sur le solde du bénéfice de liquidation pour <periode fiscale>
      Alors l'impôt IBR contient le montant <ImpotBaseICCSoldeBL>
      Exemples:
        | Test | periode fiscale | situation                             | revenu | ImpotBaseICCSoldeBL | Observations                            |
        | 1    | 2023            | seul                                  | 100000 | 778.50              | Barème célibataire                      |
        | 2    | 2023            | marié                                 | 250000 | 5989                | Barème marié                            |
        | 3    | 2024            | seul avec un enfant en garde alternée | 400000 | 26914.15            | Barème célibataire au splitting partiel |

  Règle: R4 - Calculer l'impôt de base sur le solde du bénéfice de liquidation IFD (Solde)
  - l'impôt de base IFD sur le solde du bénéfice de liquidation est calculé selon le barème IFD PP
  -- Le montant déterminant pour le taux à considérer est le 1/5 de la somme de tous les revenus "Solde du bénéfice de liquidation" (arrondi au franc inférieur) déclarés
  -- L'impôt de base est porté selon une règle de trois au prorata du revenu imposable
  --- Impôt de base IFD sur le solde BL = (Montant de l'impôt / montant déterminant pour le taux) * Revenu
  -- Si l'impôt de base IFD sur le solde BL calculé est inférieur à 2% du revenu admis (somme de tous les revenus "Solde du bénéfice de liquidation") alors on fixe cet impôt à 2 % de ce revenu admis.
  ---	Impôt de base IFD sur le solde BL = max(2% revenu admis; Impôt de base IFD sur le solde BL calculé)


    @ImpotBaseSoldeBL @BL @IFD @Solde
    Plan du Scénario: l'impôt de base IFD sur le solde du bénéfice de liquidation est calculé selon le barème IFD PP
      Etant donné une assiette pour un contribuable <situation> pour <periode fiscale>
      Et que le montant imposable de l'assiette est <revenu>
      Quand l'application ProdImpot produit l'IFD sur le solde du bénéfice de liquidation pour <periode fiscale>
      Alors l'impôt IBR contient le montant <ImpotBaseIFDSoldeBL>
      Exemples:
        | Test | periode fiscale | situation | revenu  | ImpotBaseIFDSoldeBL | Observations                                                                              |
        | 1    | 2023            | seul      | 100000  | 2000                | Barème célibataire, Impôt de base IFD sur le solde BL calculé inférieur à 2% revenu admis |
        | 2    | 2023            | marié     | 100000  | 2000                | Barème marié, Impôt de base IFD sur le solde BL calculé inférieur à 2% revenu admis       |
        | 3    | 2024            | marié     | 4000000 | 450350              | Barème marié, Impôt de base IFD sur le solde BL calculé supérieur à 2% revenu admis       |
