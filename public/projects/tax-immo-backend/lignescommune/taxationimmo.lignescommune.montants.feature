#language: fr

Fonctionnalité: F25 - Calcul des montants des lignes commune

  Règle: R1 - Le capital selon estimation d'une ligne commune est égal à la somme des capitaux selon estimations pour toutes ses lignes agrégées

    @capitalSelonEstimation @lignesCommune
    Scénario: Calcul du capital selon estimation pour une ligne commune à partir des lignes agrégées
      Etant donné les lignes agrégées suivantes :
        | Capital selon estimation |
        | 1000                     |
        | 2102                     |
        | 2390                     |
        |                          |
      Quand l'utilisateur demande de créer les lignes commune pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes commune suivantes :
        | Capital selon estimation |
        | 5492                     |

  Règle: R2 - Le capital après abattement d'une ligne commune est égal à la somme des capitaux après abattement pour toutes ses lignes agrégées

    @capitalApresAbattement @lignesCommune
    Scénario: Calcul du capital après abattement pour une ligne commune à partir des lignes agrégées
      Etant donné les lignes agrégées suivantes :
        | Capital après abattement |
        | 1000                     |
        | 2102                     |
        | 2390                     |
        |                          |
      Quand l'utilisateur demande de créer les lignes commune pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes commune suivantes :
        | Capital après abattement |
        | 5492                     |

    @capitalSelonEstimation @capitalApresAbattement @lignesCommune
    Scénario: Calcul du capital selon estimation et capital après abattement pour une ligne commune à partir des lignes agrégées
      Etant donné les lignes agrégées suivantes :
        | Code taxation | Id OC    | Capital selon estimation | Capital après abattement |
        | 15.10         | 22-150-7 | 2000                     | 1000                     |
        | 15.10         | 22-150-8 | 2102                     | 2102                     |
        | 15.10         | 22-150-8 | 3390                     |                          |
        | 15.10         | 22-150-9 |                          | 2390                     |
      Quand l'utilisateur demande de créer les lignes commune pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes commune suivantes :
        | Code taxation | Code commune | Capital selon estimation | Capital après abattement |
        | 15.10         | 22           | 7492                     | 5492                     |
