#language: fr

Fonctionnalité: F20 - Calcul des montants des lignes parcelles contribuable PP

  Règle: R1 - Le revenu IFD d'une ligne parcelle contribuable est égale à la somme des montants revenu IFD des lignes contribuables PP regroupées

    @revenuIFD @ligne-parcelle-contribuable @PP
    Scénario: Calcul du revenu IFD d'une ligne parcelle contribuable à partir des lignes contribuables PP
      Etant donné un assujettissement pour un contribuable PP
      Etant donné les lignes contribuable PP genevoises suivantes pour le dossier de taxation de cet assuj :
        | Code taxation | Revenu IFD |
        | 15.10         | 1500       |
        | 15.10         | 1200       |
      Quand le système crée les lignes parcelle contribuable PP pour cet assuj
      Alors cette taxation immobilière contribuable PP contient les lignes parcelle genevoises suivantes :
        | Code taxation | Revenu IFD |
        | 15.10         | 2700       |

  Règle: R2 - L’entretien IFD d'une ligne parcelle contribuable est égale à la somme des montant d’entretien IFD des lignes contribuables PP regroupées

    @revenuICC @ligne-parcelle-contribuable @PP
    Scénario: Calcul de l’entretien IFD d'une ligne parcelle contribuable à partir des lignes contribuables PP
      Etant donné un assujettissement pour un contribuable PP
      Etant donné les lignes contribuable PP genevoises suivantes pour le dossier de taxation de cet assuj :
        | Code taxation | Entretien IFD |
        | 15.10         | 1500          |
        | 15.10         | 1200          |
      Quand le système crée les lignes parcelle contribuable PP pour cet assuj
      Alors cette taxation immobilière contribuable PP contient les lignes parcelle genevoises suivantes :
        | Code taxation | Entretien IFD |
        | 15.10         | 2700          |

  Règle: R3 - Le revenu ICC d'une ligne parcelle contribuable est égale à la somme des montants revenu ICC des lignes contribuables PP regroupées

    @revenuICC @ligne-parcelle-contribuable @PP
    Scénario: Calcul du revenu ICC d'une ligne parcelle contribuable à partir des lignes contribuables PP
      Etant donné un assujettissement pour un contribuable PP
      Etant donné les lignes contribuable PP genevoises suivantes pour le dossier de taxation de cet assuj :
        | Code taxation | Revenu ICC |
        | 15.10         | 1500       |
        | 15.10         | 1200       |
      Quand le système crée les lignes parcelle contribuable PP pour cet assuj
      Alors cette taxation immobilière contribuable PP contient les lignes parcelle genevoises suivantes :
        | Code taxation | Revenu ICC |
        | 15.10         | 2700       |

  Règle: R4 - L’entretien ICC d'une ligne parcelle contribuable est égale à la somme des montant d’entretien ICC des lignes contribuables PP regroupées

    @revenuICC @ligne-parcelle-contribuable @PP
    Scénario: Calcul de l’entretien ICC d'une ligne parcelle contribuable à partir des lignes contribuables PP
      Etant donné un assujettissement pour un contribuable PP
      Etant donné les lignes contribuable PP genevoises suivantes pour le dossier de taxation de cet assuj :
        | Code taxation | Entretien ICC |
        | 15.10         | 1500          |
        | 15.10         | 1200          |
      Quand le système crée les lignes parcelle contribuable PP pour cet assuj
      Alors cette taxation immobilière contribuable PP contient les lignes parcelle genevoises suivantes :
        | Code taxation | Entretien ICC |
        | 15.10         | 2700          |

  Règle: R5 - La fortune d'une ligne parcelle contribuable est égale à la somme des fortune des lignes contribuables PP regroupées

    @revenuICC @ligne-parcelle-contribuable @PP
    Scénario: Calcul de la fortune d'une ligne parcelle contribuable à partir des lignes contribuables PP
      Etant donné un assujettissement pour un contribuable PP
      Etant donné les lignes contribuable PP genevoises suivantes pour le dossier de taxation de cet assuj :
        | Code taxation | Fortune |
        | 15.10         | 1500    |
        | 15.10         | 1200    |
      Quand le système crée les lignes parcelle contribuable PP pour cet assuj
      Alors cette taxation immobilière contribuable PP contient les lignes parcelle genevoises suivantes :
        | Code taxation | Fortune |
        | 15.10         | 2700    |

  Règle: R6 - L'IIC net d'une ligne parcelle contribuable est égale à la somme des IIC net des lignes contribuables PP regroupées

    @montantIIC @ligne-parcelle-contribuable @PP
    Scénario: Calcul de l'iic net d'une ligne parcelle contribuable à partir des lignes contribuables PP
      Etant donné un assujettissement pour un contribuable PP
      Etant donné les lignes contribuable PP genevoises suivantes pour le dossier de taxation de cet assuj :
        | Codetaxation | IIC net |
        | 15.10        | 1000    |
        | 15.10        | 200     |
      Quand le système crée les lignes parcelle contribuable PP pour cet assuj
      Alors cette taxation immobilière contribuable PP contient les lignes parcelle genevoises suivantes :
        | Codetaxation | IIC net |
        | 15.10        | 1200    |
