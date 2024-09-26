#language: fr
Fonctionnalité: F36 - Impression locale d'une taxation immo référentiel

  @impressionLocale @PP
  Scénario: Un document est généré pour un assuj PP
    Etant donné un assujettissement pour un contribuable PP
    Quand l'utilisateur demande de générer un document de taxation immo référentiel pour cet assuj
    Alors un document de taxation immo référentiel est généré

  @impressionLocale @PM
  Scénario: Un document est généré pour un assuj PM
    Etant donné un assujettissement pour un contribuable PM
    Quand l'utilisateur demande de générer un document de taxation immo référentiel pour cet assuj
    Alors un document de taxation immo référentiel est généré
