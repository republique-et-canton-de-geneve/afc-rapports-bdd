#language: fr

Fonctionnalité: Calcul de la TVA
  En tant que comptable
  Je veux calculer la TVA afin d'établir la facture correctement

  @finance @tva
  Scénario: Calcul simple de TVA à 8.1%
    Etant donné un montant HT de 100.00
    Quand je calcule la TVA au taux standard
    Alors le montant de TVA est 8.10 et le total TTC est 108.10
