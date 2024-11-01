#language: fr

Fonctionnalité: Téléchargement d'un courrier

  Scénario: Télécharger un courrier et le marquer comme lu
    Etant donné que un courrier "S712RPYM" pour le contribuable "156753" avec une liste de documents
      | 123              |
      | 456              |
      | 789              |
    Quand Je télécharge le courrier en question
    Alors le courrier est téléchargé
    Et le courrier est marqué comme lu
