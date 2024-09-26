#language: fr
Fonctionnalité: F29 - Contrôle du prérequis Dossier de l’année précédente.

  Règle: R1 - Contrôler le prérequis dossier de taxation de l'année précédente
  - Si le dossier de l'année précédente de l'assujettissement existe ET son volet immobilier n'a pas besoin de validation.
  - Alors afficher le message BLOQUANT "Le volet immobilier du dossier de taxation de l'année 2020 n'existe pas".
  - Si le dossier de l'année précédente de l'assujettissement existe ET que son volet immobilier est validé.
  - Alors le contrôle est OK
  - Sinon afficher le message d'AVERTISSEMENT "Le volet immobilier du dossier de taxation de l'année XXX n'est pas validé".

    @prerequisVoletImmoDossierTaxationAnneePrecedente @PP
    Scénario: vérifier prérequis de dossier de taxation de l'année précédente pour l'assujettissement avec volet immobilier non valide
      Etant donné un assujettissement pour toute l'année fiscale 2020 pour un contribuable PP
      Et que le volet immobilier du dossier de taxation pour l'année précédente de cet assujettissement n'est pas validé avec le message d'erreur "L'immeuble n'est pas validé"
      Quand l'utilisateur valide le prérequis du dossier de taxation de l'année précédente pour cet assujettissent
      Alors le résultat affiche les messages de contrôle suivants :
        | Message                                                                                | Sévérité | Type      |
        | Le volet immobilier du dossier de taxation de l'année 2019 n'est pas validé : L'immeuble n'est pas validé| BLOQUANT | PREREQUIS |

    @prerequisVoletImmoDossierTaxationAnneePrecedente @PP
    Scénario:  Vérifier l'existence du dossier de taxation de l'année précédente pour l'assujettissement avec volet immobilier validé
      Etant donné un assujettissement pour toute l'année fiscale 2020 pour un contribuable PP
      Et que le volet immobilier du dossier de taxation pour l'année précédente de cet assujettissement est validé
      Quand l'utilisateur valide le prérequis du dossier de taxation de l'année précédente pour cet assujettissent
      Alors un message de contrôle BLOQUANT est généré : non

    @prerequisVoletImmoDossierTaxationAnneePrecedente @PP
    Scénario: Le volet immobilier du dossier de taxation n'existe pas => prérequis KO
      Etant donné un assujettissement pour toute l'année fiscale 2020 pour un contribuable PP
      Et que le volet immobilier du dossier de taxation pour l'année précédente de cet assujettissement est inexistant avec le message d'erreur "Contribuable sans assujettissement PPHC en 2020"
      Quand l'utilisateur valide le prérequis du dossier de taxation de l'année précédente pour cet assujettissent
      Alors un message de contrôle de type PREREQUIS et de sévérité BLOQUANT est généré : "Le volet immobilier du dossier de taxation de l'année 2019 n'existe pas : Contribuable sans assujettissement PPHC en 2020"
