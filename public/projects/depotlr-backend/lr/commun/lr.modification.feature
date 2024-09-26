#language: fr
Fonctionnalité: Modification d'une nouvelle LR

  Contexte:
    Etant donné qu'un DPI ASC est sélectionné

  Scénario: Sauvegarde d'une LR Brouillon
    Etant donné l´année en cours 2021
    Etant donné l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
    Quand l´utilisateur sauvegarde cette LR
    Alors le système DepotLR accepte
    Et la LR est sauvegardée
