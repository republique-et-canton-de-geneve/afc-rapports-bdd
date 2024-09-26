#language: fr
Fonctionnalité: Lecture d'une nouvelle LR

  Contexte:
    Etant donné qu'un DPI ASC est sélectionné

  Scénario: Lecture d'une LR Brouillon
    Etant donné l´année en cours 2021
    Etant donné l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
    Etant donné que l´utilisateur a sauvegardé cette LR
    Quand l´utilisateur consulte la LR Brouillon de l'année 2021
    Alors la lecture de la LR renvoie la LR précédement sauvegardée
