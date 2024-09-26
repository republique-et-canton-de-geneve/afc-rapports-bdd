#language: fr

Fonctionnalité: F27 - Contrôle du prérequis "Mise en attente"

  Règle: R1 - Prérequis "Mise en attente" : Contrôler la validité de la mise en attente
  - Ce prérequis est valide ssi :
  -- Aucune personne de l'assuj n'est pas mise en attente à la date de fin d'assuj
  - Si invalide, afficher le message suivant "Attention, la personne sélectionnée a déjà des mises en attente : - BACCI / N2020017090"
  - Ce prérequis est non bloquant c.a.d les contrôles suivants sont exécutés si invalide

    @PP @prerequisMiseEnAttente @couple
    Scénario: Vérifier prérequis de mise en attente
      Etant donné que le contribuable 87654321 est mis en attente par l'utilisateur BACCI pour le numéro de volume AAA au 31.12.2020
      Etant donné que le contribuable 87654322 est mis en attente par l'utilisateur BABA pour le numéro de volume BBB au 31.12.2020
      Etant donné un assujettissement couple avec contribuable 87654321 et conjoint 87654322 pour l'année fiscale 2020
      Quand l'utilisateur valide le prérequis de mise en attente pour cet assujettissement
      Alors le résultat affiche les messages de contrôle suivants :
        | Message                             | Sévérité      | Type      | Important |
        | Attention mises en attente AAA, BBB | AVERTISSEMENT | PREREQUIS | oui       |

    @PP @PM @prerequisMiseEnAttente
    Plan du Scénario:
      Etant donné que le contribuable 87654321 est mis en attente par l'utilisateur BACCI pour le numéro de volume AAA au 31.12.2020
      Etant donné un assujettissement pour l'année fiscale <année> pour un contribuable <type personne> ayant comme numeroR 87654321
      Quand l'utilisateur valide le prérequis de mise en attente pour cet assujettissement
      Alors un message de contrôle AVERTISSEMENT est généré : <résultat>
      Exemples:
        | type personne | année | résultat |
        | PP            | 2019  | non      |
        | PP            | 2020  | oui      |
        | PP            | 2021  | non      |
        | PM            | 2020  | oui      |
