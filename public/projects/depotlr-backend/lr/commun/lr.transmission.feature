#language: fr
Fonctionnalité: Transmission nouvelle LR

  Scénario: La transmission LR ASC dans l'état Brouillon complète
    Etant donné qu'un DPI ASC est sélectionné
    Etant donné l´année en cours 2021
    Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
    Quand l´utilisateur transmet sa LR
    Alors la LR est transmise
    Et ses retenues sont à l'état TRANSMIS

  @WIP
  Scénario: La transmission LR PRESTATIONS_EN_CAPITAL dans l'état Brouillon complète
    Etant donné qu'un DPI PRESTATIONS_EN_CAPITAL est sélectionné
    Etant donné l´année en cours 2021
    Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
    Quand l´utilisateur transmet sa LR
    Alors la LR est transmise
    Et ses retenues sont à l'état TRANSMIS

  Scénario: La transmission LR SALARIE dans l'état Brouillon complète
    Etant donné qu'un DPI SALARIES est sélectionné
    Etant donné l´année en cours 2021
    Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
    Quand l´utilisateur transmet sa LR
    Alors la LR est transmise

  Scénario: Erreur de validation lors de la transmission d'une LR ASC n'ayant ni retenues ni lieux de travail
    Etant donné qu'un DPI ASC est sélectionné
    Etant donné l´année en cours 2021
    Etant donné qu'il existe une LR Brouillon en 2021 pour ce DPI
    Quand l´utilisateur transmet sa LR
    Alors la LR n'est pas transmise
    Et ses retenues ne sont pas à l'état TRANSMIS

  Scénario: Erreur de validation lors de la transmission d'une LR SALARIE n'ayant ni retenues ni personnes ni lieux de travail
    Etant donné qu'un DPI SALARIES est sélectionné
    Etant donné l´année en cours 2021
    Etant donné qu'il existe une LR Brouillon en 2021 pour ce DPI
    Quand l´utilisateur transmet sa LR
    Alors la LR n'est pas transmise

  Scénario: Transmission d'une LR déjà transmise
    Etant donné qu'un DPI ASC est sélectionné
    Etant donné l´année en cours 2021
    Etant donné qu'il existe une LR transmise pour l'année 2021 pour ce DPI
    Quand l´utilisateur transmet sa LR
    Alors la LR n'est pas re-transmise
