#language: fr
Fonctionnalité: F10 - Détermination du nom du fichier pdf relevé de compte

  Règle: R1 - le fichier pdf de relevé de compte doit être nommé "ReleveDeCompte - AAAAMMJJ-HHMM"
   - AAAAMMJJ-HHMM étant implémenté avec la date et l'heure courante

    Scénario: Détermination du nom du fichier pdf releve de compte
      Etant donné qu'il est 15h30 le 25.11.2024
      Quand le contribuable télécharge un relevé de compte au format pdf
      Alors le fichier pdf a pour nom: "ReleveDeCompte - 20241125-1530.pdf"
