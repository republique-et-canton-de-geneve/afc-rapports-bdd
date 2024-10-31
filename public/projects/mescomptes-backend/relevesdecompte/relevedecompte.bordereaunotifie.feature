#language: fr
Fonctionnalité: F4 - Vérification de l'existence d'un bordereau notifié sur un compte

  Règle: R1 - Un compte possède un bordereau notifié si :
  - dans la liste des mouvements, il existe un mouvement de type BORD

    Scénario: 1 - Vérification d'un compte avec un mouvement de type bordereau
      Etant donné que le contribuable sélectionne un compte avec ces mouvements :
        | CodeTypeMouvement |
        | BORD              |
      Quand le système vérifie s'il existe une notification bordereau
      Alors le système renvoie qu'il existe un bordereau notifié

    Scénario: 2 - Vérification d'un compte avec 2 mouvements dont un bordereau
      Etant donné que le contribuable sélectionne un compte avec ces mouvements :
        | CodeTypeMouvement |
        | BORD              |
        | SUPP              |
      Quand le système vérifie s'il existe une notification bordereau
      Alors le système renvoie qu'il existe un bordereau notifié

    Scénario: 3 - Vérification d'un compte avec 3 mouvements sans bordereau
      Etant donné que le contribuable sélectionne un compte avec ces mouvements :
        | CodeTypeMouvement |
        | IMPIA             |
        | IFI               |
      Quand le système vérifie s'il existe une notification bordereau
      Alors le système renvoie qu'il n'existe pas de bordereau notifié

    Scénario: 4 - Vérification d'un compte sans mouvement
      Etant donné que le contribuable sélectionne un compte n'ayant aucun mouvement
      Quand le système vérifie s'il existe une notification bordereau
      Alors le système renvoie qu'il n'existe pas de bordereau notifié
