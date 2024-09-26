#language: fr

Fonctionnalité: Envoie d'une demande de formulaire de changement assujettissement

  Règle: Envoyer une demande de formulaire de changement assujettissement doit envoyer un DomainEvent

    Scénario: Envoie d'une demande de formulaire de changement assujettissement
      Etant donné la reference de l'assuj 106.62.5360-2024-IBO-1
      Etant donné la nouvelle date de debut d'assuj 02.02.2024
      Etant donné la nouvelle date de fin d'assuj 11.11.2024
      Etant donné le commentaires dans la demande: Test commentaires éà
      Quand l'utilisateur envoie un formulaire de demande de changement de période d'assujettissement
      Alors Un DomainEvent de type CHANGEMENT_PERIODE_ASSUJETTISSEMENT est envoyé avec comme ref d'assuj 106.62.5360-2024-IBO-1 avec une nouvelle date de début 02.02.2024, une nouvelle date de fin 11.11.2024, et un commentaire Test commentaires éà

  Règle: Le formulaire d'envoi d'une demande d'assujettissement doit être valide

    Scénario: Envoie d'une demande de formulaire de changement d'assujettissement sans date de début ni date de fin
      Etant donné la reference de l'assuj 106.62.5360-2024-IBO-1
      Etant donné le commentaires dans la demande: Test commentaires éà
      Quand l'utilisateur envoie un formulaire de demande de changement de période d'assujettissement
      Alors une erreur métier est levée contenant le message d'erreur: Date de debut obligatoire

    Scénario: Envoie d'une demande de formulaire de changement d'assujettissement avec une periode ne correspondant pas à l'année fiscale
      Etant donné la reference de l'assuj 106.62.5360-2025-IBO-1
      Etant donné la nouvelle date de debut d'assuj 02.02.2024
      Etant donné la nouvelle date de fin d'assuj 11.11.2024
      Etant donné le commentaires dans la demande: Test commentaires éà
      Quand l'utilisateur envoie un formulaire de demande de changement de période d'assujettissement
      Alors une erreur métier est levée contenant le message d'erreur:  L'annee fiscale ne correspond pas à la nouvelle periode

    Scénario: Envoie d'une demande de formulaire de changement d'assujettissement avec une date de fin anterieure à la date de début
      Etant donné la reference de l'assuj 106.62.5360-2024-IBO-1
      Etant donné la nouvelle date de debut d'assuj 11.11.2024
      Etant donné la nouvelle date de fin d'assuj 02.02.2024
      Etant donné le commentaires dans la demande: Test commentaires éà
      Quand l'utilisateur envoie un formulaire de demande de changement de période d'assujettissement
      Alors une erreur métier est levée contenant le message d'erreur: La date de début doit être antérieure ou égale à la date de fin

    Scénario: Envoie d'une demande de formulaire de changement assujettissement avec un commentaire de plus de 2000 caractères
      Etant donné la reference de l'assuj 106.62.5360-2024-IBO-1
      Etant donné la nouvelle date de debut d'assuj 02.02.2024
      Etant donné la nouvelle date de fin d'assuj 11.11.2024
      Etant donné le commentaires dans la demande contient 2001 caractères
      Quand l'utilisateur envoie un formulaire de demande de changement de période d'assujettissement
      Alors une erreur métier est levée contenant le message d'erreur: Le commentaire doit avoir une taille inférieur ou égal à 2000 caractères
