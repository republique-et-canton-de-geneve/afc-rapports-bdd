#language: fr
Fonctionnalité: Cas nominal 1

  Règle: R1

    Scénario: Etape 1 : Cas Simple IS Célibataire année N - Par Ex: Séjour, Activité Dépendante, Rev < 120K
      Etant donné une personne de type de résidence GENEVE_SEJOUR
      Et de majorité MAJEUR
      Et de sources de revenus ACTIVITE_DEPENDANTE
      Et avec un revenu de 100000
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le mode d'imposition de l'assujettissement final est IS
      Alors le type d'assujettissement final est IPP

    Scénario: Etape 2 : Se marie avec un IO année N. Par ex: Suisse + résident Geneve (= Etabli)
      Etant donné une personne de type de résidence GENEVE_SEJOUR
      Et de majorité MAJEUR
      Et de sources de revenus ACTIVITE_DEPENDANTE
      Et avec un revenu de 100000
      Et de mode d'imposition initial IS
      Et de type d'assujettissement initial IPP
      Et un conjoint de type de résidence GENEVE_ETABLI
      Et de majorité MAJEUR
      Et de sources de revenus ACTIVITE_DEPENDANTE
      Et avec un revenu de 100000
      Et de mode d'imposition initial IO
      Et de type d'assujettissement initial IPP
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le mode d'imposition de l'assujettissement final est IO
      Alors le type d'assujettissement final est IPP_RO
      Alors l'étendue de l'assujettissement final est ILLIMITEE

    Scénario: Etape 3 : Divorce année N
      Etant donné une personne de type de résidence GENEVE_SEJOUR
      Et de majorité MAJEUR
      Et de sources de revenus ACTIVITE_DEPENDANTE
      Et avec un revenu de 100000
      Et de mode d'imposition initial IS_ET_IO
      Et de type d'assujettissement initial IPP_RO
      Et d'étendue initiale ILLIMITEE
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le mode d'imposition de l'assujettissement final est IS
      Alors le type d'assujettissement final est IPP_RO
