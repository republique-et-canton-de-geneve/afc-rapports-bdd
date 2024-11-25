#language: fr

Fonctionnalité: Test deadletter service

  Scénario: recupere tous les messages de la DLQ
    Étant donné un message est ajouté dans la Dead Letter Queue
    Quand on récupère tous les messages de la Dead Letter Queue
    Alors on récupère 1 messages

