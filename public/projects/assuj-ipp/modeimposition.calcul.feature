#language: fr
Fonctionnalité: Calcul des assujettissments

  Règle: Les modes d'imposition calculés sont les suivants:
  - IO : lorsque la personne est non établie et que sa source de revenue est autre
  - IS : lorsque la personne réside à l'étranger et que sa source de revenue est une activité dépendante
  - AUCUN : lorsque la résidence est inconnue ou que la personne n'a aucune source de revenus
  - IO : lorsque la personne réside en séjour à genève, et si le conjoint a un mode d'imposition IO et qu'il ne remplit pas une des conditions : GENEVE_SEJOUR, sans aucune source de revenu et majeur, alors le mode d'imposition  passe IO.

    Plan du Scénario: Calcul du mode d'imposition - <Test> -> <Observation>
      Etant donné une personne de type de résidence <type de residence>
      Et de sources de revenus <source de revenus>
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le mode d'imposition de l'assujettissement final est <mode imposition>
      Exemples:
        | Test | type de residence  | source de revenus   | mode imposition | Observation                                                                          |
        | 1    | INCONNU            | AUCUNE              | AUCUN           | Personne avec une type de résidence inconnu, son mode d'imposition est aucun         |
        | 2    | ETRANGER           | AUCUNE              | AUCUN           | Personne sans source de revenus, son mode d'imposition est aucun                     |
        | 3    | INCONNU            | ACTIVITE_DEPENDANTE | AUCUN           | Personne avec une type de résidence inconnu, son mode d'imposition est aucun         |
        | 4    | ETRANGER           | ACTIVITE_DEPENDANTE | IS              | Personne étrangère avec une activité dépendante, son mode d'imposition est IS        |
        | 5    | SUISSE_HORS_GENEVE | ACTIVITE_DEPENDANTE | AUCUN           | Personne non étrangère avec une activité dépendante, son mode d'imposition est aucun |
        | 6    | GENEVE_SEJOUR      | ACTIVITE_DEPENDANTE | IS              | Personne est séjour avec une activité dépendante, son mode d'imposition est IS       |
        | 7    | GENEVE_ETABLI      | ACTIVITE_DEPENDANTE | AUCUN           | Personne non étrangère avec une activité dépendante, son mode d'imposition est aucun |
        | 8    | INCONNU            | AUTRE               | AUCUN           | Personne non établie avec une source de revenus autre, son mode d'imposition est IO  |
        | 9    | ETRANGER           | AUTRE               | IO              | Personne non établie avec une source de revenus autre, son mode d'imposition est IO  |
        | 10   | SUISSE_HORS_GENEVE | AUTRE               | IO              | Personne non établie avec une source de revenus autre, son mode d'imposition est IO  |
        | 11   | GENEVE_SEJOUR      | AUTRE               | IO              | Personne non établie avec une source de revenus autre, son mode d'imposition est IO  |
        | 12   | GENEVE_ETABLI      | AUTRE               | AUCUN           | Personne établie avec une source de revenus autre, son mode d'imposition est aucun   |

    Plan du Scénario: Calcul du mode d'imposition avec conjoint - <Test> -> <Observation>
      Etant donné une personne de type de résidence <type de residence>
      Et de sources de revenus <sources de revenus>
      Et de majorité <majorité>
      Et un conjoint de type de résidence <conjoint de type de résidence>
      Et de sources de revenus <conjoint de sources de revenus>
      Et de majorité <majorité conjoint>
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le mode d'imposition de l'assujettissement final est <mode imposition personne>
      Alors pour la conjoint le mode d'imposition de l'assujettissement final est <mode imposition conjoint>

      Exemples:
        | Test | type de residence | sources de revenus  | majorité | conjoint de type de résidence | conjoint de sources de revenus | majorité conjoint | mode imposition personne | mode imposition conjoint | Observation                                                  |
        | 1    | GENEVE_SEJOUR     | ACTIVITE_DEPENDANTE | MAJEUR   | GENEVE_SEJOUR                 | ACTIVITE_DEPENDANTE            | MAJEUR            | IS                       | IS                       | Personne IS et Conjoint IS Simple                            |
        | 2    | GENEVE_SEJOUR     | ACTIVITE_DEPENDANTE | MAJEUR   | GENEVE_SEJOUR                 | AUTRE                          | MAJEUR            | IS                       | IO                       | Personne IS etConjoint IO car indep uniquement et non etabli |
        | 3    | GENEVE_SEJOUR     | ACTIVITE_DEPENDANTE | MAJEUR   | GENEVE_ETABLI                 | AUTRE                          | MAJEUR            | IO                       | IO                       | Personne IO etConjoint IO car etabli                         |

    Scénario: Mineur suisse avec activité dépendante
      Etant donné une personne de type de résidence SUISSE_HORS_GENEVE
      Et de sources de revenus ACTIVITE_DEPENDANTE
      Et de majorité MINEUR
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le mode d'imposition de l'assujettissement final est AUCUN
