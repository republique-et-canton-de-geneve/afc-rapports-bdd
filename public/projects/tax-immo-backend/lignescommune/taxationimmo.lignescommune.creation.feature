#language: fr

Fonctionnalité: F24 - Lignes commune

  Règle: R1 - Si aucune valeur immobilière n'existe pour un assuj donné, alors aucune ligne commune n'est créée.

    @creation-ligne-commune @PP @PM
    Plan du Scénario: Créer une taxation immo pour un contribuable seul sans valeur immobilière (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable <type>
      Etant donné que il n'existe aucune valeur immobilière pour cet assujettissement
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière ne contient aucune ligne commune
      Exemples:
        | Test | type | Observation                   |
        | 1    | PP   | Aucune valeur immo pour un PP |
        | 2    | PM   | Aucune valeur immo pour un PM |

  Règle: R2 - Les lignes commune sont regroupées et triées selon les clés suivantes :
  - Le code de taxation
  - Le code commune casdastral

    @creation-ligne-commune @PP
    Scénario: Les lignes commune sont agrégées par code de taxation et code commune cadastrale à partir de lignes agrégées
      Etant donné les lignes agrégées suivantes :
        | Code taxation | Id OC    | Taux abattement |
        | 15.10         | 22-150-7 | 10%             |
        | 15.10         | 22-150-7 | 20%             |
        | 15.20         | 22-150-7 |                 |
        | 15.10         | 22-150-8 | 10%             |
        | 15.40         | 22-150-7 | 10%             |
        | 15.40         | 22-150-7 | 20%             |
        | 15.50         | 22-150-7 |                 |
        | 15.10         | 23-150-7 |                 |
      Quand l'utilisateur demande de créer les lignes commune pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes commune suivantes :
        | Code taxation | Code commune | Nb lignes agrégées |
        | 15.10         | 22           | 3                  |
        | 15.20         | 22           | 1                  |
        | 15.40         | 22           | 2                  |
        | 15.50         | 22           | 1                  |
        | 15.10         | 23           | 1                  |

    @creation-ligne-commune @PP
    Scénario: Les lignes commune sont triées par code de taxation et code commune cadastrale
      Etant donné les lignes agrégées suivantes :
        | Code taxation | Id OC    |
        | 15.10         | 23-150-7 |
        | 15.10         | 22-150-7 |
        | 15.10         | 22-150-7 |
        | 15.20         | 22-150-7 |
        | 15.10         | 22-150-8 |
        | 15.40         | 22-150-7 |
        | 15.50         | 22-150-7 |
        | 15.40         | 22-150-7 |
      Quand l'utilisateur demande de créer les lignes commune pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes commune suivantes dans l'ordre :
        | Code taxation | Code commune |
        | 15.10         | 22           |
        | 15.10         | 23           |
        | 15.20         | 22           |
        | 15.40         | 22           |
        | 15.50         | 22           |

    @creation-ligne-commune @PM
    Scénario: Les lignes commune sont agrégées par code de taxation et code commune cadastrale à partir de lignes agrégées
      Etant donné les lignes agrégées suivantes :
        | Code taxation | Id OC    | Taux IIC |
        | 3.1           | 22-150-7 | 1        |
        | 3.1           | 22-150-7 | 3        |
        | 3.2           | 22-150-7 | 2        |
        | 3.2           | 22-150-7 | 2        |
        | 3.1           | 23-150-7 | 3        |
      Quand l'utilisateur demande de créer les lignes commune pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes commune suivantes :
        | Code taxation | Code commune | Nb lignes agrégées |
        | 3.1           | 22           | 2                  |
        | 3.2           | 22           | 2                  |
        | 3.1           | 23           | 1                  |

    @creation-ligne-commune @PM
    Scénario: Les lignes commune sont triées par code de taxation et code commune cadastrale
      Etant donné les lignes agrégées suivantes :
        | Code taxation | Id OC    |
        | 3.1           | 23-150-7 |
        | 3.1           | 22-150-7 |
        | 3.2           | 22-150-7 |
        | 3.1           | 22-150-7 |
        | 3.2           | 22-150-7 |
      Quand l'utilisateur demande de créer les lignes commune pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes commune suivantes dans l'ordre :
        | Code taxation | Code commune |
        | 3.1           | 22           |
        | 3.1           | 23           |
        | 3.2           | 22           |
