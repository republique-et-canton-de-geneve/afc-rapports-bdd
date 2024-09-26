#language: fr
Fonctionnalité: F33 - Contrôle du montant de l'états locatif pour toutes les lignes L

  Règle: R1 -  Prérequis "états locatifs" : contrôler la saisie des montants totaux des états locatifs
  - Ce prérequis est valide ssi :
  – Toutes les lignes agrégée de type L contiennent un montant total de l'état locatif saisi pour l'année de l'assujettissement
  - Si invalide, afficher le message suivant "Au moins un montant total de l'état locatif n'a pas été saisis pour l'année (année de l'assujettissement)"
  - Ce prérequis est non bloquant c.a.d les contrôles suivants sont exécutés si invalide

    @PP @prerequisEtatLocatif @couple
    Scénario: Vérifier prérequis de saisie des montants totaux des états locatifs
      Etant donné un assujettissement pour l'année fiscale 2022 pour un contribuable seul PP
      Et que la taxation immobilière contient les lignes agrégées de type L ayants pour état locatif :
        | Montant état locatif | Année visa    |
        | 139974               | 2022          |
        | 100000               | 2022          |
        | 500                  | 2021          |
        | 6589                 | 2022          |
      Quand l'utilisateur valide le prérequis des états locatifs pour cet assujettissement
      Alors le résultat affiche les messages de contrôle suivants :
        | Message                                                                          | Sévérité      | Type      |
        | Au moins un montant total de l'état locatif n'a pas été saisi pour l'année 2022 | AVERTISSEMENT | PREREQUIS |

    @PP @prerequisEtatLocatif @couple
    Scénario: Vérifier prérequis de saisie des montants totaux des états locatifs
      Etant donné un assujettissement pour l'année fiscale 2022 pour un contribuable seul PP
      Et que la taxation immobilière contient les lignes agrégées de type L ayants pour état locatif :
        | Montant état locatif | Année visa    |
        | 139974               | 2022          |
        | 100000               | 2022          |
        | 500                  | 2022          |
        | 6589                 | 2022          |
      Quand l'utilisateur valide le prérequis des états locatifs pour cet assujettissement
      Alors aucun message de contrôle n'est généré

