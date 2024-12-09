# language: fr

Fonctionnalité: Ordonnancement des tâches

  Règle: R1 - Au sein d'un groupe de tâches d'une même nature, les tâches sont ordonnées par date d'échéance croissante.

  Règle: R2 - Si elle est affichée, la tâche payer des montants est toujours en première position.
  Les autres types de tâches sont ordonnés par date d'échéance croissante.


  Règle: R4 - A date d'échéance identique, les tâches sont affichées selon la priorité suivante :
    - Payer des montants
    - DDR
    - Déclarations

    @validation
    Plan du scénario: Validation de l'ordonnancement des tâches à date d'échéance égale
      Etant donné que l´utilisateur a des tâches [Mes comptes :<mescomptes> , DDR: <ddr> à échéance du <ddr_echeance>, Décla PP: <declapp> à échéance du <declapp_echeance>]
      Quand le système recherche les tâches en attente du contribuable PP
      Alors le système renvoie la liste de tâches ordonnées : <ordre_type_prestation_attendu>
      Exemples:
        | mescomptes | ddr     | declapp   | ddr_echeance   | declapp_echeance    | ordre_type_prestation_attendu           |
        | 'true'    | 'true'  | 'true'     | '2025-12-31'   | '2025-12-31'       | '[MES_COMPTES, AFC.DDR, DEPOT_DECLA_PP]' |
        | 'true'    | 'false' | 'true'     | '2025-12-31'   | '2025-12-31'       | '[MES_COMPTES, DEPOT_DECLA_PP]'          |
        | 'true'    | 'true'  | 'false'    | '2025-12-31'   | '2025-12-31'       | '[MES_COMPTES, AFC.DDR]'                 |
        | 'false'   | 'true'  | 'true'     | '2025-12-31'   | '2025-12-31'       | '[AFC.DDR, DEPOT_DECLA_PP]'              |
        | 'true'    | 'false' | 'false'    | '2025-12-31'   | '2025-12-31'       | '[MES_COMPTES]'                          |
        | 'false'   | 'true'  | 'false'    | '2025-12-31'   | '2025-12-31'       | '[AFC.DDR]'                              |
        | 'false'   | 'false' | 'true'     | '2025-12-31'   | '2025-12-31'       | '[DEPOT_DECLA_PP]'                       |
        | 'false'   | 'false' | 'false'    | '2025-12-31'   | '2025-12-31'       | '[]'                                     |

    @validation
    Plan du scénario: Validation de l'ordonnancement des tâches à date d'échéance différente
      Etant donné que l´utilisateur a des tâches [Mes comptes :<mescomptes> , DDR: <ddr> à échéance du <ddr_echeance>, Décla PP: <declapp> à échéance du <declapp_echeance>]
      Quand le système recherche les tâches en attente du contribuable PP
      Alors le système renvoie la liste de tâches ordonnées : <ordre_type_prestation_attendu>
      Exemples:
        | mescomptes | ddr    | declapp | ddr_echeance | declapp_echeance | ordre_type_prestation_attendu            |
        | 'true'     | 'true' | 'true'  | '2025-01-01' | '2025-12-31'     | '[MES_COMPTES, AFC.DDR, DEPOT_DECLA_PP]' |
        | 'false'    | 'true' | 'true'  | '2025-01-01' | '2025-12-31'     | '[AFC.DDR, DEPOT_DECLA_PP]'              |
        | 'true'     | 'true' | 'true'  | '2025-12-31' | '2025-01-01'     | '[MES_COMPTES, DEPOT_DECLA_PP, AFC.DDR]' |
        | 'false'    | 'true' | 'true'  | '2025-12-31' | '2025-01-01'     | '[DEPOT_DECLA_PP, AFC.DDR]'              |


  Règle: R3 - Si plusieurs tâches existent pour un même type, la date d'échéance la plus petite est retenue pour le tri.

    @validation
    Plan du scénario: R3 - Validation de l'ordonnancement des tâches <scenario>
      Etant donné que l´utilisateur a des tâches DDR aux échéances <ddr_echeance>,<ddr_echeance2>
      Et que l´utilisateur a des tâches décla PP aux échéances <declapp_echeance>,<declapp_echeance2>
      Quand le système recherche les tâches en attente du contribuable PP
      Alors le système renvoie la liste de tâches ordonnées : <ordre_type_prestation_attendu>
      Exemples:
        | ddr_echeance | ddr_echeance2 | declapp_echeance | declapp_echeance2 | ordre_type_prestation_attendu | scenario        |
        | '2025-01-15' | '2025-01-25'  | '2025-01-10'     | '2025-01-20'      | '[DEPOT_DECLA_PP, AFC.DDR]'   | 'C < A < D < B' |
#        | '2025-01-15' | '2025-01-20'  | '2025-01-10'     | '2025-01-25'      | '[DEPOT_DECLA_PP, AFC.DDR]'   | 'C < A < B < D' |
#        | '2025-01-20' | '2025-01-25'  | '2025-01-10'     | '2025-01-15'      | '[DEPOT_DECLA_PP, AFC.DDR]'   | 'C < A < D < B' |
#        | '2025-01-10' | '2025-01-15'  | '2025-01-20'     | '2025-01-25'      | '[AFC.DDR, DEPOT_DECLA_PP]'   | 'A < B < C < D' |
#        | '2025-01-10' | '2025-01-20'  | '2025-01-15'     | '2025-01-25'      | '[AFC.DDR, DEPOT_DECLA_PP]'   | 'A < C < B < D' |
#        | '2025-01-10' | '2025-01-25'  | '2025-01-15'     | '2025-01-20'      | '[AFC.DDR, DEPOT_DECLA_PP]'   | 'A < C < D < B' |



    @validation
    Plan du scénario: R3 - Validation de l'ordonnancement des tâches d'une même prestation
      Etant donné que l´utilisateur a des tâches de type <type> aux échéances E1 <echeance_E1> et E2 <echeance_E2>
      Quand le système recherche les tâches en attente du contribuable PP
      Alors le système retourne une tâche de type <type> : <est_retournee>
      Et Ordonne les tâches de la façon suivant : <description> -> <ordre_des_taches>
      Exemples:
        | type             | echeance_E1     | echeance_E2  | description      | est_retournee | ordre_des_taches |
        | 'AFC.DDR'        | '2025-01-10'    | '2025-01-15' | 'E1 prioritaire' | 'true'        | '[E1, E2]'       |
        | 'AFC.DDR'        | '2025-01-10'    | ''           | 'E1 uniquement'  | 'true'        | '[E1]'           |
        | 'AFC.DDR'        | ''              | ''           | 'Pas de tâche'   | 'false'       | '[]'             |
        | 'DEPOT_DECLA_PP' | '2025-01-10'    | '2025-01-15' | 'E1 prioritaire' | 'true'        | '[E1, E2]'       |
        | 'DEPOT_DECLA_PP' | '2025-01-10'    | ''           | 'E1 uniquement'  | 'true'        | '[E1]'           |
        | 'DEPOT_DECLA_PP' | ''              | ''           | 'Pas de tâche'   | 'false'       | '[]'             |
        | 'MES_COMPTES'    | ''              | ''           | 'Pas de tâche'   | 'true'        | '[]'             |

  Règle: R5 - Si aucune tâche en attente n'est trouvée sur l'ensemble des catégories, le libellé suivant est affiché "Vous n'avez aucune tâche en attente."

#      | Test | echanche_1 | echanche_2 | ordre_e1 | ordre_e2 |
#      | Test | aucun      | aucun      |  -1 | -1 |
#      | Test | P5D        | aucun      |  1 | -1 |
#      | Test | P10D       | P15D       |  1 | 2 |
#      | Test | P15D       | P10D       |  2 | 1 |

