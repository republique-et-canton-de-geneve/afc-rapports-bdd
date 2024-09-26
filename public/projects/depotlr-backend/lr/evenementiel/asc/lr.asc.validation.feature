#language: fr
Fonctionnalité: Validation d'une LR ASC

  Contexte:
    Etant donné qu'un DPI ASC est sélectionné
    Etant donné l´année en cours 2021

  Scénario: Valider une LR complète
    Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
    Quand l´utilisateur valide sa LR
    Alors le système renvoie que la LR est Valide

  Scénario: Valider une LR nouvelle
    Etant donné qu'il existe une LR Brouillon en 2021 pour ce DPI
    Quand l´utilisateur valide sa LR
    Alors le système renvoie que la LR est Invalide
