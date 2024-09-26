#language: fr
Fonctionnalité: Calcul des assujettissments

  Règle: Les étendues calculés sont les suivantes:
  - LIMITEE : lorsque la résidence n'est ni GENEVE_SEJOUR ni GENEVE_ETABLI ni INCONNU
  - ILLIMITEE : lorsque la résidence est GENEVE_SEJOUR ou GENEVE_ETABLI
  - AUCUN : lorsque la résidence est INCONNU

    Plan du Scénario: Calcul de l'étendue - <Test> -> <Observation>
      Etant donné une personne de type de résidence <type de residence>
      Et une personne de sources de revenus ACTIVITE_DEPENDANTE
      Et une personne de majorité MAJEUR
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne l'étendue de l'assujettissement final est <étendue>
      Exemples:
        | Test | type de residence | étendue   | Observation                                                                                                           |
        | 1    | GENEVE_SEJOUR     | ILLIMITEE | Personne avec une type de résidence GENEVE_SEJOUR ou GENEVE_ETABLI, son étendue est ILLIMITEE                         |
        | 2    | GENEVE_ETABLI     | ILLIMITEE | Personne avec une type de résidence GENEVE_SEJOUR ou GENEVE_ETABLI, son étendue est ILLIMITEE                         |
        | 3    | ETRANGER          | LIMITEE   | Personne avec une type de résidence différent de GENEVE_SEJOUR et différent de GENEVE_ETABLI, son étendue est LIMITEE |
        | 4    | INCONNU           | AUCUN     | Personne avec une type de résidence inconnu, son étendue est AUCUN                                                    |
