#language: fr
Fonctionnalité: Validation d'une LR Periodique

  Contexte:
    Etant donné qu'un DPI SALARIES est sélectionné
    Etant donné l´année en cours 2021

  Scénario: Valider une LR complète
    Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
    Quand l´utilisateur valide sa LR
    Alors le système renvoie que la LR est Valide

  Scénario: Valider une LR avec des erreurs basiques de validation
    Etant donné qu'il existe une LR Brouillon en 2021 pour ce DPI
    Quand l´utilisateur valide sa LR
    Alors le système renvoie que la LR est Invalide

  Scénario: Validation d'une LR SALARIE avec un DPI ayant des informations invalides
    Etant donné que la date du jour est 01.01.2021
    Etant donné l´année fiscale de la déclaration est 2021
    Etant donné un DPI SALARIES invalide est sélectionné
    Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
    Quand l´utilisateur valide sa LR
    Alors le système renvoie que la LR est Invalide

  # TODO SHOULD si le contrat de la méthode valider évolue pour renvoyer des violations au lieu d'un boolean, on pourra préciser ce qu'on attend (des erreurs sur la personne)
  Scénario: Validation d'une LR SALARIE avec un salarié incomplet
    Etant donné qu'il existe une LR Brouillon en 2021 pour ce DPI
    Etant donné qu'une personne SALARIE complète est initialisée
    Etant donné que la date de naissance saisie est vide
    Etant donné que cette personne a été enregistrée
    Quand l´utilisateur valide sa LR
    Alors le système renvoie que la LR est Invalide

  # TODO SHOULD si le contrat de la méthode valider évolue pour renvoyer des violations au lieu d'un boolean, on pourra préciser ce qu'on attend (des erreurs sur le lieu de travail)
  Scénario: Validation d'une LR SALARIE avec un lieu de travail vide
    Etant donné qu'il existe une LR Brouillon en 2021 pour ce DPI
    Etant donné que l´utilisateur a saisi un lieu de travail vide dans le référentiel des lieux de travail
    Quand l´utilisateur valide sa LR
    Alors le système renvoie que la LR est Invalide

  # TODO MUST: réactiver et préciser pourquoi la retenue est invalide (ligne 33), créer un salarié, ajouter le règle
  @WIP
  Scénario: Validation d'une LR SALARIE avec DPI de droit public et une retenue ADMIN dont le montant ne respecte pas la règle des 25%
    Etant donné que la date du jour est 01.01.2021
    Etant donné l´année fiscale de la déclaration est 2021
    Etant donné un DPI SALARIES qui n'est pas de type entreprise de droit public est sélectionné
    Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
    Etant donné qu'une personne ADMIN a une prestation saisie avec un montant de retenue invalide
    Quand l´utilisateur valide sa LR
    Alors le système renvoie que la LR est Valide

  # TODO SHOULD : Utiliser plutôt des plans de scenarios
  Règle: Lors de la validation d'une LR, les retenues mensuelles après le dernier mois actif ne doivent pas être validées.
    Scénario: Valeurs des retenues mensuelles non renseignées pour un mois actif : LR Invalide
      Etant donné que la date du jour est 31.01.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné que l´utilisateur a saisi un lieu de travail valide dans le référentiel des lieux de travail
      Etant donné que l´utilisateur a ajouté une personne à temps plein active toute l'année
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est Invalide

    Scénario: Valeurs des retenues mensuelles renseignées pour tous les mois actifs : LR Valide
      Etant donné que la date du jour est 31.01.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné que l´utilisateur a saisi un lieu de travail valide dans le référentiel des lieux de travail
      Etant donné que l´utilisateur a ajouté une personne à temps plein active toute l'année
      Etant donné que l´utilisateur a renseigné pour ce salarié les valeurs de la retenue mensuelle pour le mois de Janvier
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est Valide

    Scénario: Valeurs des retenues mensuelles renseignées seulement pour un des mois actifs : LR Invalide
      Etant donné que la date du jour est 28.02.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné que l´utilisateur a saisi un lieu de travail valide dans le référentiel des lieux de travail
      Etant donné que l´utilisateur a ajouté une personne à temps plein active toute l'année
      Etant donné que l´utilisateur a renseigné pour ce salarié les valeurs de la retenue mensuelle pour le mois de Janvier
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est Invalide

    Scénario: Valeurs des retenues mensuelles renseignées pour tous les salariées pour les mois actifs : LR Valide
      Etant donné que la date du jour est 28.02.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné que l´utilisateur a saisi un lieu de travail valide dans le référentiel des lieux de travail
      Etant donné que l´utilisateur a ajouté une personne à temps plein active toute l'année
      Etant donné que l´utilisateur a renseigné pour ce salarié les valeurs de la retenue mensuelle pour le mois de Janvier
      Etant donné que l´utilisateur a renseigné pour ce salarié les valeurs de la retenue mensuelle pour le mois de Février
      Etant donné que l´utilisateur a ajouté une personne à temps plein active toute l'année
      Etant donné que l´utilisateur a renseigné pour ce salarié les valeurs de la retenue mensuelle pour le mois de Janvier
      Etant donné que l´utilisateur a renseigné pour ce salarié les valeurs de la retenue mensuelle pour le mois de Février
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est Valide

    Scénario: Valeurs des retenues mensuelles non renseignées pour tous les salariées pour les mois actifs : LR Invalide
      Etant donné que la date du jour est 28.02.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné que l´utilisateur a saisi un lieu de travail valide dans le référentiel des lieux de travail
      Etant donné que l´utilisateur a ajouté une personne à temps plein active toute l'année
      Etant donné que l´utilisateur a renseigné pour ce salarié les valeurs de la retenue mensuelle pour le mois de Janvier
      Etant donné que l´utilisateur a renseigné pour ce salarié les valeurs de la retenue mensuelle pour le mois de Février
      Etant donné que l´utilisateur a ajouté une personne à temps plein active toute l'année
      Etant donné que l´utilisateur a renseigné pour ce salarié les valeurs de la retenue mensuelle pour le mois de Janvier
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est Invalide
