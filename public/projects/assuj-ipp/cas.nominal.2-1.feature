#language: fr
Fonctionnalité: Cas nominal 2-1

  Règle: R1

    Scénario: Etape 1 : 2 personnes en séjour résidentes (résidentes à Genève permis B) qui sont mariées
      Etant donné une personne de type de résidence GENEVE_SEJOUR
      Et de majorité MAJEUR
      Et de sources de revenus ACTIVITE_DEPENDANTE
      Et avec un revenu de 130000
      Et un conjoint de type de résidence GENEVE_SEJOUR
      Et de majorité MAJEUR
      Et de sources de revenus ACTIVITE_DEPENDANTE
      Et avec un revenu de 100000
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le mode d'imposition de l'assujettissement final est IS
      Alors le type d'assujettissement final est IPP_RO
      Alors pour le conjoint le mode d'imposition de l'assujettissement final est IS
      Alors le type d'assujettissement final est IPP_RO

    Scénario: Etape 2 : Toujours sur année N , changement d'adresse à nouveau (donc à nouveau un changement déclenchant un changement d'assuj sans être lui même un critère)
      Etant donné une personne de type de résidence GENEVE_SEJOUR
      Et de majorité MAJEUR
      Et de sources de revenus ACTIVITE_DEPENDANTE
      Et avec un revenu de 130000
      Et de mode d'imposition initial IS
      Et de type d'assujettissement initial IPP_RO
      Et un conjoint de type de résidence GENEVE_SEJOUR
      Et de majorité MAJEUR
      Et de sources de revenus ACTIVITE_DEPENDANTE
      Et avec un revenu de 100000
      Et de mode d'imposition initial IS
      Et de type d'assujettissement initial IPP_RO
      Quand le moteur calcule les assujettissements pour cette personne
      Alors pour la personne le mode d'imposition de l'assujettissement final est IS
      Alors le type d'assujettissement final est IPP_RO
      Alors pour le conjoint le mode d'imposition de l'assujettissement final est IS
      Alors le type d'assujettissement final est IPP_RO

