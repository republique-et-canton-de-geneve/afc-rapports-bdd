#language: fr

Fonctionnalité: Téléchargement d'un document

  Scénario: Télécharger un document et le marquer comme lu
    Etant donné que un document avec comme numeroR "12345" et comme identifiant d'acces "ABC123"
    Quand Je télécharge le document en question
    Alors le document est téléchargé
    Et le document est marqué comme lu
