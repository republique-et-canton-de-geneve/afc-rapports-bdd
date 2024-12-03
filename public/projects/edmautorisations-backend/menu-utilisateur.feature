#language: fr

Fonctionnalité: F1 - Menu Utilisateur

  Règle: R1 - Rechercher le menu utilisateur
  - Le menu utilisateur est le même pour tous les utilisateurs et ne dépend d'aucun critère de recherche.

    Scénario: Rechercher le menu utilisateur
      Etant donné un menu utilisateur avec les entrées suivantes :
        | ACCUEIL                  |
        | MES_COURRIERS_REÇUS      |
        | MES_COMPTES_ET_PAIEMENTS |
      Quand l'utilisateur recherche son menu
      Alors il reçoit le menu utilisateur suivant :
        | ACCUEIL                  |
        | MES_COURRIERS_REÇUS      |
        | MES_COMPTES_ET_PAIEMENTS |
