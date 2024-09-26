#language: fr
Fonctionnalité: Validation d'une LR dans le cadre du dépôt LR via fichier XML
  
  Scénario: Validation d'une Liste Récapitulative Déposer XML avec des contribuables Salariés
      Etant donné que l´utilisateur est un DPI de type SALARIES
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'il existe une LR Déposer XML complète et valide en 2021 pour ce DPI
      Quand l'utilisateur valide sa LR Déposer XML
      Alors le système renvoie que la LR déposer xml est valide

    Scénario: Validation d'une Liste Récapitulative Déposer XML avec des contribuables Caisse Compensation
      Etant donné que l´utilisateur est un DPI de type CAISSE_COMPENSATION
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'il existe une LR Déposer XML complète et valide en 2021 pour ce DPI
      Quand l'utilisateur valide sa LR Déposer XML
      Alors le système renvoie que la LR déposer xml est valide

    Scénario: Validation d'une Liste Récapitulative Déposer XML avec des contribuables Beneficiaire Rente
      Etant donné que l´utilisateur est un DPI de type BENEFICIAIRE_RENTE
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'il existe une LR Déposer XML complète et valide en 2021 pour ce DPI
      Quand l'utilisateur valide sa LR Déposer XML
      Alors le système renvoie que la LR déposer xml est valide

  Règle: La LR doit avoir au moins 1 contribuable
    Scénario: Validation d'une Liste Récapitulative Déposer XML sans contribuables
      Etant donné que l´utilisateur est un DPI de type SALARIES
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné que l'utilisateur a créé une nouvelle LR Déposer XML 2021 pour ce DPI
      Quand l'utilisateur valide sa LR Déposer XML
      Alors le système renvoie que la LR déposer xml est invalide car aucun contribuable

  Règle: La LR doit avoir au moins 1 retenue par contribuable
    Scénario: Validation d'une Liste Récapitulative Déposer XML sans retenues
      Etant donné que l´utilisateur est un DPI de type SALARIES
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné que l'utilisateur a créé une nouvelle LR Déposer XML 2021 pour ce DPI
      Etant donné qu'un contribuable déposer xml de type contribuable SALARIE a été ajoutée à cette LR sans retenue
      Quand l'utilisateur valide sa LR Déposer XML
      Alors le système renvoie que la LR déposer xml est invalide car aucune retenue

    Scénario: Validation d'une Liste Récapitulative Déposer XML avec des contribuables Remboursement AVS
      Etant donné que l´utilisateur est un DPI de type REMBOURSEMENT_AVS
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'il existe une LR Déposer XML complète et valide en 2021 pour ce DPI
      Quand l'utilisateur valide sa LR Déposer XML
      Alors le système renvoie que la LR déposer xml est valide
