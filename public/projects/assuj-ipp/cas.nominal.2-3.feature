#language: fr
Fonctionnalité: Cas nominal 2-3

  Règle: R1

    Scénario: Etape 1 : 1 personne célibataire en séjour résidente (résidente à Genève permis B) avec activité
      Etant donné une personne de type de résidence GENEVE_SEJOUR
      Et de majorité MAJEUR
      Et de sources de revenus ACTIVITE_DEPENDANTE
      Et avec un revenu de 130000
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le mode d'imposition de l'assujettissement final est IS
      Alors le type d'assujettissement final est IPP_RO

    Scénario: Etape 2 : Toujours sur année N, changement d'adresse (donc à nouveau un changement déclenchant un changement d'assuj sans être lui même un critère)
      Etant donné une personne de type de résidence GENEVE_SEJOUR
      Et de majorité MAJEUR
      Et de sources de revenus ACTIVITE_DEPENDANTE
      Et avec un revenu de 130000
      Et de mode d'imposition initial IS
      Et de type d'assujettissement initial IPP_RO
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le mode d'imposition de l'assujettissement final est IS
      Alors le type d'assujettissement final est IPP_RO

    Scénario: Etape 3 : Toujours sur année N, changement de permis devient permis C
      Etant donné une personne de type de résidence GENEVE_ETABLI
      Et de majorité MAJEUR
      Et de sources de revenus ACTIVITE_DEPENDANTE
      Et avec un revenu de 130000
      Et de mode d'imposition initial IS
      Et de type d'assujettissement initial IPP_RO
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le mode d'imposition de l'assujettissement final est IO
      Alors le type d'assujettissement final est IPP_RO
