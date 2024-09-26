#language: fr

Fonctionnalité: F14 - Création des lignes agrégées

  Règle: R1 - Si aucune valeur immobilière n'existe pour un assuj donné, alors aucune ligne agrégée n'est créée.

    @creation-ligne-agregee @PP @PM
    Plan du Scénario: Créer une taxation immo pour un contribuable seul sans valeur immobilière (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable <type>
      Etant donné que il n'existe aucune valeur immobilière pour cet assujettissement
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière ne contient aucune ligne agrégée
      Exemples:
        | Test | type | Observation                   |
        | 1    | PP   | Aucune valeur immo pour un PP |
        | 2    | PM   | Aucune valeur immo pour un PM |

  Règle: R2 - Les lignes agrégées pour les PP sont crées avec les règles suivantes :
  - les lignes détails non états locatifs sont agrégées selon la clé de regroupement suivante :
  -- Le code de taxation
  -- L'identifiant de l'objet cadastral
  -- Taux abattement pour les 15.10 et 15.40

    @creation-ligne-agregee @PP
    Scénario: Les lignes agrégées non états locatifs sont regroupées par code de taxation, objet cadastral et taux d'abattement à partir de lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation | Id OC    | Type     | Taux abattement |
        | 15.10         | 22-150-7 | BATIMENT | 10%             |
        | 15.10         | 22-150-7 | TERRAIN  | 20%             |
        | 15.20         | 22-150-7 | BATIMENT |                 |
        | 15.20         | 22-150-7 | TERRAIN  |                 |
        | 15.10         | 22-150-8 | BATIMENT | 10%             |
        | 15.40         | 22-150-7 | BATIMENT | 10%             |
        | 15.40         | 22-150-7 | TERRAIN  | 20%             |
        | 15.50         | 22-150-7 | BATIMENT |                 |
        | 15.50         | 22-150-7 | TERRAIN  |                 |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Code taxation | Id OC    | Nb lignes détail | Taux abattement |
        | 15.10         | 22-150-7 | 1                | 10%             |
        | 15.10         | 22-150-7 | 1                | 20%             |
        | 15.20         | 22-150-7 | 2                |                 |
        | 15.10         | 22-150-8 | 1                | 10%             |
        | 15.40         | 22-150-7 | 1                | 10%             |
        | 15.40         | 22-150-7 | 1                | 20%             |
        | 15.50         | 22-150-7 | 2                |                 |

    @creation-ligne-agregee @PP
    Scénario: Les lignes agrégées PP sont regroupées par code de taxation, objet cadastral et taux d'abattement à partir de valeurs immo
      Etant donné un assujettissement pour un contribuable PP
      Et que les valeurs immobilières pour cet assujettissement sont :
        | Type     | Id OC     | Usages       | Taux Exo Fortune |
        | TERRAIN  | 22-150-7  | OCCUPE       |                  |
        | QVL      | 22-150-7  | OCCUPE       |                  |
        | BATIMENT | 22-150-7  | OCCUPE, LOUE |                  |
        | BATIMENT | 22-150-8  | OCCUPE       |                  |
        | BATIMENT | 22-150-11 | LOUE         | 50%              |
        | BATIMENT | 22-150-11 | LOUE         | 50%              |
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Nb lignes agrégées | Code taxation | Id OC     | Nb lignes détail | Types lignes détail |
        | 1                  | 15.10         | 22-150-7  | 3                | (B, T, R)           |
        | 1                  | 15.20         | 22-150-7  | 1                | (B)                 |
        | 1                  | 15.10         | 22-150-8  | 1                | (B)                 |
        | 1                  | 15.20         | 22-150-11 | 2                | (B, B)              |
        | 1                  | 15.50         | 22-150-11 | 2                | (B, B)              |

  Règle: R3 - Les lignes agrégées pour les PM sont crées avec les règles suivantes :
  - les lignes détails non états locatifs sont agrégées selon la clé de regroupement suivante :
  -- Le code de taxation
  -- L'identifiant de l'objet cadastral
  -- Taux IIC

    @creation-ligne-agregee @PM
    Scénario: Les lignes agrégées PM non états locatifs sont regroupées par code de taxation, objet cadastral et taux IIC à partir de lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation | Id OC    | Type     | Taux IIC |
        | 3.1           | 22-150-7 | BATIMENT | 1        |
        | 3.1           | 22-150-7 | TERRAIN  | 1        |
        | 3.1           | 22-150-7 | BATIMENT | 2        |
        | 3.1           | 22-150-7 | TERRAIN  | 2        |
        | 3.2           | 22-150-7 | BATIMENT | 3        |
        | 3.2           | 22-150-7 | TERRAIN  | 3        |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Code taxation | Id OC    | Nb lignes détail | Taux IIC |
        | 3.1           | 22-150-7 | 2                | 1        |
        | 3.1           | 22-150-7 | 2                | 2        |
        | 3.2           | 22-150-7 | 2                | 3        |

    @creation-ligne-agregee @PM
    Scénario: Créer une ligne agrégée PM pour chaque ligne détail de type L à partir de valeurs immo  (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable PM
      Et que les valeurs immobilières pour cet assujettissement sont :
        | Code taxation | Id OC    | Type         |
        | 3.1           | 22-150-7 | ETAT_LOCATIF |
        | 3.1           | 22-150-7 | ETAT_LOCATIF |
        | 3.1           | 22-150-7 | ETAT_LOCATIF |
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Nb lignes agrégées | Code taxation | Id OC    | Nb lignes détail | Types lignes détail |
        | 1                  | 3.1           | 22-150-7 | 3                | (L,L,L)             |

  Règle: R4 - Les lignes agregees triées selon les clés suivantes :
  - Le code de taxation
  - Le code commune casdastral
  - Le numéro de parcelle
  - Le numéro Ppe
  - Le numéro Btl
  - Le numéro Ddp
  - Le taux d'abattement

    @creation-ligne-agregee @PP
    Scénario: Les lignes agregees sont triées par code de taxation et l'objet cadastral et taux d'abattement
      Etant donné une taxation immobilière qui contient les lignes détail injectées suivantes :
        | Code taxation | Code commune cadastrale | Numéro parcelle | Taux abattement | Type     | Numéro Btl | Numéro Ppe | Numéro Ddp |
        | 15.20         | 22                      | 1507            |                 | BATIMENT | 7          | 6          | 8          |
        | 15.10         | 22                      | 1507            | 30%             | BATIMENT | 7          | 6          | 8          |
        | 15.10         | 23                      | 1507            | 10%             | BATIMENT | 7          | 6          | 8          |
        | 15.20         | 23                      | 1535            |                 | BATIMENT | 7          | 6          | 8          |
        | 15.20         | 23                      | 1535            |                 | BATIMENT | 7          | 6          | 8          |
        | 15.20         | 23                      | 1535            |                 | BATIMENT | 1          | 6          | 8          |
        | 15.20         | 23                      | 1535            |                 | BATIMENT | 1          | 2          | 8          |
        | 15.20         | 23                      | 1535            |                 | BATIMENT | 1          | 2          | 3          |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes dans l'ordre :
        | Code taxation | Code commune cadastrale | Numéro parcelle | Taux abattement | Type     | Numéro Btl | Numéro Ppe | Numéro Ddp |
        | 15.10         | 22                      | 1507            | 30%             | BATIMENT | 7          | 6          | 8          |
        | 15.10         | 23                      | 1507            | 10%             | BATIMENT | 7          | 6          | 8          |
        | 15.20         | 22                      | 1507            |                 | BATIMENT | 7          | 6          | 8          |
        | 15.20         | 23                      | 1535            |                 | BATIMENT | 1          | 2          | 3          |
        | 15.20         | 23                      | 1535            |                 | BATIMENT | 1          | 2          | 8          |
        | 15.20         | 23                      | 1535            |                 | BATIMENT | 1          | 6          | 8          |
        | 15.20         | 23                      | 1535            |                 | BATIMENT | 7          | 6          | 8          |

  Règle: R5 - Les lignes agregees sont triées selon les clés suivantes :
  - Le code de taxation
  - Le code commune casdastral
  - Le numéro de parcelle
  - Le numéro Ppe
  - Le numéro Btl
  - Le numéro Ddp

    @creation-ligne-agregee @PM
    Scénario: Les lignes agregees sont triées par code de taxation et l'objet cadastral
      Etant donné une taxation immobilière qui contient les lignes détail injectées suivantes :
        | Code taxation | Code commune cadastrale | Numéro parcelle | Type     | Taux IIC | Numéro Btl | Numéro Ppe | Numéro Ddp |
        | 3.2           | 23                      | 1507            | BATIMENT | 1        | 7          | 6          | 8          |
        | 3.2           | 22                      | 1507            | BATIMENT | 1        | 7          | 6          | 8          |
        | 3.2           | 22                      | 1501            | BATIMENT | 1        | 7          | 6          | 8          |
        | 3.1           | 22                      | 1501            | BATIMENT | 1        | 7          | 6          | 8          |
        | 3.1           | 22                      | 1501            | BATIMENT | 1        | 7          | 6          | 8          |
        | 3.1           | 22                      | 1501            | BATIMENT | 1        | 1          | 6          | 8          |
        | 3.1           | 22                      | 1501            | BATIMENT | 1        | 1          | 2          | 8          |
        | 3.1           | 22                      | 1501            | BATIMENT | 1        | 1          | 2          | 3          |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes dans l'ordre :
        | Code taxation | Code commune cadastrale | Numéro parcelle | Type     | Taux IIC | Numéro Btl | Numéro Ppe | Numéro Ddp |
        | 3.1           | 22                      | 1501            | BATIMENT | 1        | 1          | 2          | 3          |
        | 3.1           | 22                      | 1501            | BATIMENT | 1        | 1          | 2          | 8          |
        | 3.1           | 22                      | 1501            | BATIMENT | 1        | 1          | 6          | 8          |
        | 3.1           | 22                      | 1501            | BATIMENT | 1        | 7          | 6          | 8          |
        | 3.2           | 22                      | 1501            | BATIMENT | 1        | 7          | 6          | 8          |
        | 3.2           | 22                      | 1507            | BATIMENT | 1        | 7          | 6          | 8          |
        | 3.2           | 23                      | 1507            | BATIMENT | 1        | 7          | 6          | 8          |

  Règle: R6 - Les lignes agrégées états locatifs pour les PP et PM sont crées avec les règles suivantes :
  - les lignes détails états locatifs sont agrégées selon la clé de regroupement suivante :
  -- Le code de taxation
  -- L'identifiant de l'objet cadastral
  -- Le taux de capitalisation
  -- Année EL prise en compte (si renseignée)
  -- Adresse état locatif (si renseignée)
  -- Affectation

    @creation-ligne-agregee @état-locatif @PP @PM
    Scénario: Les lignes agrégées états locatifs sont regroupées par code de taxation, objet cadastral, taux de capitalisation, adresse état locatif (si renseignée), année EL prise en compte (si renseignée) et affectation à partir de lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type         | Code taxation | Id OC   | Taux capitalisation | Adresse etat locatif     | Année EL prise en compte | Affectation |
        | ETAT_LOCATIF | 15.20         | 12-618  | 3.35                | 6 Rue de Chêne-Bougeries | 2022                     | Lgt         |
        | ETAT_LOCATIF | 15.20         | 12-618  | 3.35                | 6 Rue de Chêne-Bougeries | 2022                     | Lgt         |
        | ETAT_LOCATIF | 15.20         | 24-3006 | 3.74                | 35 Rue des Allobroges    | 2021                     | Lgt         |
        | ETAT_LOCATIF | 15.20         | 24-3006 | 3.74                | 35 Rue des Allobroges    | 2021                     | Lgt         |
        | ETAT_LOCATIF | 15.20         | 24-3006 | 3.74                |                          |                          | Lgt         |
        | ETAT_LOCATIF | 3.1           | 12-624  | 3.20                |                          |                          | Lgt         |
        | ETAT_LOCATIF | 3.1           | 12-624  | 3.20                |                          |                          | Lgt         |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Code taxation | Id OC   | Nb lignes détail | Taux capitalisation | Adresse etat locatif     | Année EL prise en compte | Affectation |
        | 15.20         | 12-618  | 2                | 3.35                | 6 Rue de Chêne-Bougeries | 2022                     | Lgt         |
        | 15.20         | 24-3006 | 2                | 3.74                | 35 Rue des Allobroges    | 2021                     | Lgt         |
        | 15.20         | 24-3006 | 1                | 3.74                |                          |                          | Lgt         |
        | 3.1           | 12-624  | 2                | 3.20                |                          |                          | Lgt         |
