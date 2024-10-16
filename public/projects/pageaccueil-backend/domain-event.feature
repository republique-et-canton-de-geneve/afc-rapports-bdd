#language: fr

Fonctionnalité: F1 - Envoie d'une fin de mise en attente

  Règle: R1 - Envoyer une fin de mise en attente doit envoyer un DomainEvent

    @domain-event
    Scénario: Envoie d'une fin de mise en attente
      Etant donné l'id de mise en attente 14
      Etant donné la date de mise en attente 10.02.2024
      Quand l'utilisateur envoie une mise en attente
      Alors un évènement de fin de mise en attente est envoyé avec l'id 14 et la date 10.02.2024
