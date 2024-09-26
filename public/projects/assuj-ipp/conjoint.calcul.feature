#language: fr
Fonctionnalité: Calcul des assujettissements incluant les critères du conjoint
  Règle: Les types d'assujettissements calculés sont les suivants:
  - IPP_RO : résidence est en Suisse, conjoint avec un mode d'imposition IO et conjoint a aucune des caractéristiques suivantes : GENEVE_SEJOUR, sans aucune sourc

    Plan du Scénario: Calcul du mode d'imposition - <Test> -> <Observation>
      Etant donnée une personne de type de résidence GENEVE_SEJOUR
      Et une personne de sources de revenus ACTIVITE_DEPENDANTE
      Et une personne de majorité MAJEUR

      Et un conjoint de type de résidence <conjoint de type de résidence>
      Et un conjoint de type d'assujettissement initial <conjoint de type d'assujettissement>
      Et un conjoint de sources de revenus <conjoint de sources de revenus>
      Et un conjoint de majorité <majorité conjoint>
      Et un conjoint d'étendue initiale <conjoint étendue>
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le type d'assujettissement final est <type assujettissement>

      Exemples:
        | Test | conjoint de type d'assujettissement | conjoint de type de résidence | conjoint étendue | conjoint de sources de revenus | majorité conjoint | type assujettissement | Observation |
        | 1    | IPP_RO                              | SUISSE_HORS_GENEVE            | ILLIMITEE        | ACTIVITE_DEPENDANTE            | MINEUR            | IPP                   |             |
        | 2    | IPP_RO                              | ETRANGER                      | ILLIMITEE        | ACTIVITE_DEPENDANTE            | MINEUR            | IPP                   |             |
        | 3    | IPP_RO                              | ETRANGER                      | ILLIMITEE        | ACTIVITE_DEPENDANTE            | MINEUR            | IPP                   |             |
        | 4    | IPP_RO                              | GENEVE_SEJOUR                 | ILLIMITEE        | ACTIVITE_DEPENDANTE            | MAJEUR            | IPP_RO                |             |
        | 5    | IPP_RO                              | GENEVE_SEJOUR                 | ILLIMITEE        | ACTIVITE_DEPENDANTE            | MAJEUR            | IPP_RO                |             |
        | 6    | IPP_RO                              | SUISSE_HORS_GENEVE            | LIMITEE          | ACTIVITE_DEPENDANTE            | MINEUR            | IPP                   |             |
        | 7    | IPP_RO                              | ETRANGER                      | LIMITEE          | ACTIVITE_DEPENDANTE            | MINEUR            | IPP                   |             |
        | 8    | IPP_RO                              | ETRANGER                      | LIMITEE          | ACTIVITE_DEPENDANTE            | MINEUR            | IPP                   |             |
        | 9    | IPP_RO                              | GENEVE_SEJOUR                 | LIMITEE          | ACTIVITE_DEPENDANTE            | MAJEUR            | IPP                   |             |
        | 10   | IPP_RO                              | GENEVE_SEJOUR                 | LIMITEE          | ACTIVITE_DEPENDANTE            | MAJEUR            | IPP                   |             |
