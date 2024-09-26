#language: fr

Fonctionnalité: F18 - Calcul des montants des lignes parcelle référentiel

  Règle: R1 - Le capital selon estimation d'une ligne parcelle référentiel est égal à la somme des capitaux selon estimations pour toutes ses lignes détail

    @capitalSelonEstimation @lignesParcelleReferentiel
    Scénario: Calcul du capital selon estimation pour une ligne parcelle référentiel à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | Capital selon estimation |
        | BATIMENT      | 1000                     |
        | TERRAIN       | 2102                     |
        | BATIMENT      | 2390                     |
        | REVENU_OCCUPE |                          |
        | REVENU_OCCUPE |                          |
      Quand l'utilisateur demande de créer les lignes parcelle pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes parcelle suivantes :
        | Capital selon estimation |
        | 5492                     |

  Règle: R2 - Le capital après abattement d'une ligne parcelle référentiel est égal à la somme des capitaux après abattement pour toutes ses lignes détail

    @capitalApresAbattement @lignesParcelleReferentiel
    Scénario: Calcul du capital après abattement pour une ligne parcelle référentiel à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | Capital après abattement |
        | BATIMENT      | 1000                     |
        | TERRAIN       | 2000                     |
        | BATIMENT      | 300                      |
        | REVENU_OCCUPE |                          |
        | REVENU_OCCUPE |                          |
      Quand l'utilisateur demande de créer les lignes parcelle pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes parcelle suivantes :
        | Capital après abattement |
        | 3300                     |

  Règle: R3 - Le revenu IFD d'une ligne parcelle référentiel est égal à la somme des revenus IFD pour toutes ses lignes détail

    @revenuIFD @lignesParcelleReferentiel
    Scénario: Calcul du revenu IFD pour une ligne parcelle référentiel à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | Revenu IFD |
        | BATIMENT      |            |
        | TERRAIN       |            |
        | REVENU_OCCUPE | 1000       |
        | REVENU_OCCUPE | 2500       |
        | REVENU_OCCUPE | 1234       |
      Quand l'utilisateur demande de créer les lignes parcelle pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes parcelle suivantes :
        | Revenu IFD |
        | 4734       |

  Règle: R4 - L'entretien IFD d'une ligne parcelle référentiel est égal à la somme des entretiens IFD pour toutes ses lignes détail

    @entretienIFD @lignesParcelleReferentiel
    Scénario: Calcul de l'entretien IFD pour une ligne parcelle référentiel à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | Entretien IFD |
        | BATIMENT      |               |
        | TERRAIN       |               |
        | REVENU_OCCUPE | 1000          |
        | REVENU_OCCUPE | 2500          |
        | REVENU_OCCUPE | 1234          |
      Quand l'utilisateur demande de créer les lignes parcelle pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes parcelle suivantes :
        | Entretien IFD |
        | 4734          |

  Règle: R5 - Le revenu ICC d'une ligne parcelle référentiel est égal à la somme des revenus ICC pour toutes ses lignes détail

    @revenuICC @lignesParcelleReferentiel
    Scénario: Calcul du revenu IFD pour une ligne parcelle référentiel à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | Revenu ICC |
        | BATIMENT      |            |
        | TERRAIN       |            |
        | REVENU_OCCUPE | 1000       |
        | REVENU_OCCUPE | 2500       |
        | REVENU_OCCUPE | 1234       |
      Quand l'utilisateur demande de créer les lignes parcelle pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes parcelle suivantes :
        | Revenu ICC |
        | 4734       |

  Règle: R6 - L'entretien IFD d'une ligne parcelle référentiel est égal à la somme des entretiens IFD pour toutes ses lignes détail

    @entretienICC @lignesParcelleReferentiel
    Scénario: Calcul de l'entretien ICC pour une ligne parcelle référentiel à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | Entretien ICC |
        | BATIMENT      |               |
        | TERRAIN       |               |
        | REVENU_OCCUPE | 1000          |
        | REVENU_OCCUPE | 2500          |
        | REVENU_OCCUPE | 1234          |
      Quand l'utilisateur demande de créer les lignes parcelle pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes parcelle suivantes :
        | Entretien ICC |
        | 4734          |

  Règle: R7 - L'IIC NET d'une ligne parcelle référentiel est égal à la somme des IIC net pour toutes ses lignes détail

    @montantIIC @lignesParcelleReferentiel
    Scénario: Calcul de l'IIC net pour une ligne parcelle référentiel à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | Montant IIC |
        | BATIMENT      | 1000        |
        | TERRAIN       | 500         |
        | BATIMENT      | 300         |
        | REVENU_OCCUPE |             |
        | REVENU_OCCUPE |             |
      Quand l'utilisateur demande de créer les lignes parcelle pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes parcelle suivantes :
        | IIC net |
        | 1800    |
