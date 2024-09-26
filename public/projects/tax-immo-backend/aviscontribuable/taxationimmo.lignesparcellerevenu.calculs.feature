#language: fr

Fonctionnalité: F34 - Calcul des montants des lignes parcelle revenu

  Règle: R1 - Le revenu IFD d'une ligne parcelle revenu est égal à la somme des revenus IFD pour toutes ses lignes détail

    @revenuIFD @lignesParcelleRevenu
    Scénario: Calcul du revenu IFD pour une ligne parcelle revenu à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation | Id OC    | Type          | Taux abattement | Revenu IFD |
        | 15.10         |          | BATIMENT      | 10%             |            |
        | 15.20         |          | TERRAIN       | 20%             |            |
        | 15.10         | 22-150-7 | REVENU_OCCUPE | 30%             | 1000       |
        | 15.10         | 22-150-7 | REVENU_OCCUPE | 30%             | 2500       |
        | 15.10         | 22-150-7 | REVENU_OCCUPE | 30%             | 1234       |
      Quand l'utilisateur demande de créer les lignes parcelle revenu pour cet avis au contribuable
      Alors cet avis au contribuable contient une ligne parcelle revenu avec le montant revenu IFD suivant : 4734

  Règle: R2 - L'entretien IFD d'une ligne parcelle revenu est égal à la somme des entretiens IFD pour toutes ses lignes détail

    @entretienIFD @lignesParcelleRevenu
    Scénario: Calcul de l'entretien IFD pour une ligne parcelle référentiel à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation | Id OC    | Type          | Taux abattement | Entretien IFD |
        | 15.10         |          | BATIMENT      | 10%             |               |
        | 15.20         |          | TERRAIN       | 20%             |               |
        | 15.10         | 22-150-7 | REVENU_OCCUPE | 30%             | 1000          |
        | 15.10         | 22-150-7 | REVENU_OCCUPE | 30%             | 2500          |
        | 15.10         | 22-150-7 | REVENU_OCCUPE | 30%             | 1234          |
      Quand l'utilisateur demande de créer les lignes parcelle revenu pour cet avis au contribuable
      Alors cet avis au contribuable contient une ligne parcelle revenu avec le montant entretien IFD suivant : 4734

  Règle: R3 - Le revenu ICC d'une ligne parcelle revenu est égal à la somme des revenus ICC pour toutes ses lignes détail

    @revenuICC @lignesParcelleRevenu
    Scénario: Calcul du revenu ICC pour une ligne parcelle référentiel à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation | Id OC    | Type          | Taux abattement | Revenu ICC |
        | 15.10         |          | BATIMENT      | 10%             |            |
        | 15.20         |          | TERRAIN       | 20%             |            |
        | 15.10         | 22-150-7 | REVENU_OCCUPE | 30%             | 1000       |
        | 15.10         | 22-150-7 | REVENU_OCCUPE | 30%             | 2500       |
        | 15.10         | 22-150-7 | REVENU_OCCUPE | 30%             | 1234       |

      Quand l'utilisateur demande de créer les lignes parcelle revenu pour cet avis au contribuable
      Alors cet avis au contribuable contient une ligne parcelle revenu avec le montant revenu ICC suivant : 4734

  Règle: R4 - L'entretien ICC d'une ligne parcelle revenu est égal à la somme des entretiens ICC pour toutes ses lignes détail

    @entretienICC @lignesParcelleRevenu
    Scénario: Calcul de l'entretien ICC pour une ligne parcelle référentiel à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation | Id OC    | Type          | Taux abattement | Entretien ICC |
        | 15.10         |          | BATIMENT      | 10%             |               |
        | 15.20         |          | TERRAIN       | 20%             |               |
        | 15.10         | 22-150-7 | REVENU_OCCUPE | 30%             | 1000          |
        | 15.10         | 22-150-7 | REVENU_OCCUPE | 30%             | 2500          |
        | 15.10         | 22-150-7 | REVENU_OCCUPE | 30%             | 1234          |
      Quand l'utilisateur demande de créer les lignes parcelle revenu pour cet avis au contribuable
      Alors cet avis au contribuable contient une ligne parcelle revenu avec le montant entretien ICC suivant : 4734


