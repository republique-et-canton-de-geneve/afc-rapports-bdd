#language: fr
Fonctionnalité: F1 - Enregistrement d'une taxation immo visée

  Règle: La taxation immobilière visée doit contenir le nom de l'utilisateur courant, la date/heure courante et le type de visa MANUEL

    @TaxationImmoVisee @PP @PM
    Scénario: La taxation immo visée doit contenir le nom de l'utilisateur
      Etant donné la date du jour 30.05.2023 et l'heure actuelle 12:41
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Et que l'utilisateur courant est DOEJ
      Quand l'utilisateur demande l'enregistrement MANUEL de la taxation immobilière visée pour cet assujettissement
      Alors la taxation immobilière visée est enregistrée
      Et la taxation immobilière visée contient le nom d'utilisateur DOEJ
      Et la taxation immobilière visée contient une date et heure de création au 30.05.2023 à 12:41
      Et la taxation immobilière visée contient un type de visa MANUEL
