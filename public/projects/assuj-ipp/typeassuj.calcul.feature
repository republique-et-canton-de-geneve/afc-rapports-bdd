#language: fr
Fonctionnalité: Calcul des assujettissements pour la règle sur le type d'assujettissement

  Règle: Les types d'assujetissement calculés sont les suivants:
  - IPP_RO : lorsque la personne possède un mode d'imposition contenant IO au final
  - IPP_RO : lorsque la personne possède demande taxation ordinaire ultérieure validée
  - IPP_RO : lorsque le type de résidence est GENEVE_SEJOUR et que le montant du revenu est supérieur au seuil de 120 000 CHF
  - IPP_RO : lorsque le type d'assujettissement initial est IPP_RO et que la résidence est SUISSE_HORS_GENEVE ou GENEVE_ETABLI

    Plan du Scénario: Calcul du type d'assujettissement - <Test> -> <Observation>
      Etant donné une personne de type de résidence <type de résidence>
      Et de sources de revenus <sources de revenus>
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le mode d'imposition de l'assujettissement final est <mode imposition>
      Alors le type d'assujettissement final est <type assujettissement>
      Exemples:
        | Test | type de résidence | sources de revenus  | mode imposition | type assujettissement | Observation                                              |
        | 1    | GENEVE_SEJOUR     | ACTIVITE_DEPENDANTE | IS              | IPP                   | Mode imposition IS => type d'assujettissement est IPP    |
        | 2    | GENEVE_SEJOUR     | AUTRE               | IO              | IPP_RO                | Mode imposition IO => type d'assujettissement est IPP_RO |

    Plan du Scénario: Calcul du type d'assujetissement - <Test> -> <Observation>
      Etant donné une personne avec une demande de taxation ordinaire ultérieure <demande taxation ordinaire ultérieure>
      Et de type de résidence GENEVE_SEJOUR
      Et de majorité MAJEUR
      Et de sources de revenus ACTIVITE_DEPENDANTE
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le type d'assujettissement final est <type assujettissement>
      Exemples:
        | Test | demande taxation ordinaire ultérieure | type assujettissement | Observation                                                                                       |
        | 1    | AUCUNE                                | IPP                   | Personne sans demande de taxation ordinaire ultérieure, son type d'assujetissement est IPP        |
        | 2    | ROLEORDINAIRE                         | IPP_RO                | Personne avec une demande de taxation ordinaire ultérieure, son type d'assujetissement est IPP_RO |

    Plan du Scénario: Calcul du type d'assujetissement - <Test> -> <Observation>
      Etant donné une personne de type de résidence <type de residence>
      Et de sources de revenus ACTIVITE_DEPENDANTE
      Et de majorité MAJEUR
      Et de type d'assujettissement initial <type assujettissement initial>
      Et d'étendue initiale <Etendue initiale>
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le type d'assujettissement final est <type assujettissement attendu>
      Exemples:
        | Test | type de residence  | type assujettissement initial | Etendue initiale | type assujettissement attendu | Observation                                                                                                                                                                                   |
        | 1    | INCONNU            | AUCUN                         | ILLIMITEE        | AUCUN                         | Personne avec type de résidence INCONNU, alors son type d'assujettissement final est AUCUN                                                                                                    |
        | 2    | ETRANGER           | IPP                           | ILLIMITEE        | IPP                           | Personne avec type de résidence ETRANGER et son type d'assujettissement initial IPP, alors son type d'assujettissement final est IPP                                                          |
        | 3    | SUISSE_HORS_GENEVE | IPP_RO                        | ILLIMITEE        | AUCUN                         | Personne avec type de résidence SUISSE_HORS_GENEVE et son type d'assujettissement initial IPP_RO, alors son type d'assujettissement final est AUCUN                                           |
        | 4    | GENEVE_ETABLI      | IPP_RO                        | ILLIMITEE        | IPP_RO                        | Personne avec type de résidence GENEVE_ETABLI et son type d'assujettissement initial IPP_RO, alors son type d'assujettissement final est IPP_RO                                               |
        | 5    | ETRANGER           | IPP_RO                        | ILLIMITEE        | IPP                           | Personne avec type de résidence ETRANGER et son type d'assujettissement initial IPP_RO, alors son type d'assujettissement final est IPP                                                       |
        | 6    | SUISSE_HORS_GENEVE | IPP_RO                        | LIMITEE          | AUCUN                         | Personne avec type de résidence SUISSE_HORS_GENEVE, son type d'assujettissement initial IPP_RO et son etendue initiale n'est pas illimitée, alors son type d'assujettissement final est AUCUN |
        | 7    | GENEVE_ETABLI      | IPP_RO                        | LIMITEE          | IPP_RO                        | Personne avec type de résidence GENEVE_ETABLI, son type d'assujettissement initial IPP_RO et son etendue initiale n'est pas illimitée, alors son type d'assujettissement final est IPP_RO     |

    Plan du Scénario: Calcul du type d'assujettissement - <Test> -> <Observation>
      Etant donné une personne avec un revenu de <revenu>
      Et de sources de revenus ACTIVITE_DEPENDANTE
      Et de majorité MAJEUR
      Et de type de résidence <type de residence>
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le type d'assujettissement final est <type assujettissement>
      Exemples:
        | Test | revenu | type de residence | type assujettissement | Observation                                                                                       |
        | 1    | 120000 | ETRANGER          | IPP                   | Personne avec un revenu égal au seuil et résidant à l'étranger a un type d'assuj IPP              |
        | 2    | 120000 | GENEVE_SEJOUR     | IPP_RO                | Personne avec un revenu égal au seuil a un type d'assuj IPP                                       |
        | 3    | 120001 | ETRANGER          | IPP                   | Personne résidant à l'étranger n'a pas de type d'assuj                                            |
        | 4    | 120001 | GENEVE_SEJOUR     | IPP_RO                | Personne avec un revenu superieur au seuil et de résidence GENEVE_SEJOUR a un type d'assuj IPP_RO |
        | 5    | 119000 | ETRANGER          | IPP                   | Personne avec un revenu inférieur au seuil et résidant à l'étranger a un type d'assuj IPP         |
        | 6    | 119000 | GENEVE_SEJOUR     | IPP                   | Personne avec un revenu inférieur au seuil a un type d'assuj IPP                                  |
