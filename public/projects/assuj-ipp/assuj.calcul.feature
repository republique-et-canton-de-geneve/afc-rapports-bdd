#language: fr
Fonctionnalité: Calcul des assujettissements

  Règle: Les modes d'imposition calculés sont les suivants:
  - IO : lorsque la personne est non établie et que sa source de revenue est autre
  - IO : lorsque la résidence est GENEVE_ETABLI et que la personne est MAJEURE
  - IS : lorsque la personne réside à l'étranger et que sa source de revenue est une activité dépendante
  - IS : lorsque la résidence est GENEVE_ETABLI et qu'une source de revenus est ACTIVITE_DEPENDANTE et que la personne est MINEURE
  - AUCUN : lorsque la résidence est inconnue ou que la personne n'a aucune source de revenus

    Plan du Scénario: Calcul du mode d'imposition - <Test> -> <Observation>
      Etant donné une personne de type de résidence <type de residence>
      Et avec une demande de taxation ordinaire ultérieure <demande taxation ordinaire ultérieure>
      Et de sources de revenus <sources de revenus>
      Et de majorité <majorité>
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le mode d'imposition de l'assujettissement final est <mode imposition>
      Et le type d'assujettissement final est <type assujettissement>

      Exemples:
        | Test | type de residence  | sources de revenus  | majorité | mode imposition | demande taxation ordinaire ultérieure | type assujettissement | Observation                                                                                                  |
        | 1    | INCONNU            | AUCUNE              | INCONNU  | AUCUN           | AUCUNE                                | AUCUN                 | Personne avec une type de résidence inconnu, son mode d'imposition est aucun                                 |
        | 2    | ETRANGER           | AUCUNE              | INCONNU  | AUCUN           | AUCUNE                                | AUCUN                 | Personne sans source de revenus, son mode d'imposition est aucun                                             |
        | 3    | INCONNU            | ACTIVITE_DEPENDANTE | INCONNU  | AUCUN           | AUCUNE                                | AUCUN                 | Personne avec une type de résidence inconnu, son mode d'imposition est aucun                                 |
        | 4    | ETRANGER           | ACTIVITE_DEPENDANTE | INCONNU  | IS              | AUCUNE                                | IPP                   | Personne étrangère avec une activité dépendante, son mode d'imposition est IS                                |
        | 5    | SUISSE_HORS_GENEVE | ACTIVITE_DEPENDANTE | INCONNU  | AUCUN           | AUCUNE                                | AUCUN                 | Personne non étrangère avec une activité dépendante, son mode d'imposition est aucun                         |
        | 6    | GENEVE_SEJOUR      | ACTIVITE_DEPENDANTE | INCONNU  | IS              | AUCUNE                                | IPP                   | Personne en séjour avec une activité dépendante, son mode d'imposition est IS                                |
        | 7    | GENEVE_ETABLI      | AUCUNE              | MAJEUR   | IO              | AUCUNE                                | IPP_RO                | Personne majeure et établie, son mode d'imposition est IO                                                    |
        | 8    | GENEVE_ETABLI      | ACTIVITE_DEPENDANTE | MINEUR   | IS              | AUCUNE                                | IPP                   | Personne mineure, établie et avec une activité dépendante, son mode d'imposition est IS                      |
        | 9    | INCONNU            | AUTRE               | INCONNU  | AUCUN           | AUCUNE                                | AUCUN                 | Personne non établie avec une source de revenus autre, son mode d'imposition est IO                          |
        | 10   | ETRANGER           | AUTRE               | INCONNU  | IO              | AUCUNE                                | IPP_RO                | Personne non établie avec une source de revenus autre, son mode d'imposition est IO                          |
        | 11   | SUISSE_HORS_GENEVE | AUTRE               | INCONNU  | IO              | AUCUNE                                | IPP_RO                | Personne non établie avec une source de revenus autre, son mode d'imposition est IO                          |
        | 12   | GENEVE_SEJOUR      | AUTRE               | INCONNU  | IO              | AUCUNE                                | IPP_RO                | Personne non établie avec une source de revenus autre, son mode d'imposition est IO                          |
        | 13   | GENEVE_ETABLI      | AUTRE               | INCONNU  | AUCUN           | AUCUNE                                | AUCUN                 | Personne établie avec une source de revenus autre, son mode d'imposition est aucun                           |
        | 14   | GENEVE_SEJOUR      | AUCUNE              | MAJEUR   | IO              | ROLEORDINAIRE                         | IPP_RO                | Personne avec une demande de TOU validée et résidence = GENEVE_SEJOUR, son type d'assujetissement est IPP_RO |
        | 15   | INCONNU            | AUCUNE              | INCONNU  | AUCUN           | ROLEORDINAIRE                         | AUCUN                 | Personne avec une demande de TOU validée et résidence != GENEVE_SEJOUR, son type d'assujetissement est IPP   |
