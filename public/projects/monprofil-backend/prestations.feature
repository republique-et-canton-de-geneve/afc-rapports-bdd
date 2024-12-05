#language: fr

Fonctionnalité: F1 - Prestations

  Règle: R1 - Rechercher les prestations
  - Les prestations sont les mêmes pour tous les utilisateurs et ne dépendent d'aucun critère de recherche.

    Scénario: Rechercher les prestations
      Etant donné les prestations suivantes :
        | ACCUEIL                  |
        | MES_COURRIERS_REÇUS      |
        | MES_COMPTES_ET_PAIEMENTS |
      Quand l'utilisateur recherche ses prestations
      Alors il reçoit les prestations suivantes :
        | ACCUEIL                  |
        | MES_COURRIERS_REÇUS      |
        | MES_COMPTES_ET_PAIEMENTS |
