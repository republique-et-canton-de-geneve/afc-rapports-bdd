#language: fr

Fonctionnalité: F29 - Contrôle du prérequis "Réservation"

  Règle: R1 - Prérequis "Réservation" : Contrôler la réservation des parcelles
  - Ce prérequis est valide ssi :
  -- Aucune parcelle genevoise de l'assuj n'est réservée
  - Sinon, afficher le message suivant "Attention, l'objet cadastral XXX est réservé par l'utilisateur BACCI dans la session 1"

    @PP @PM @prerequisReservation
    Plan du scénario: Vérifier prérequis de mise en attente
      Etant donné un assujettissement pour un contribuable <type personne>
      Et que la valeur immobilière pour cet assujettissement contient l'objet cadastral 123-456-789 réservé par l'utilisateur BACCI dans la session 98765
      Et que la valeur immobilière pour cet assujettissement contient l'objet cadastral 012-345-678 réservé par l'utilisateur FABI dans la session 12345
      Quand l'utilisateur valide le prérequis de réservation pour cet assujettissement
      Alors le résultat affiche les messages de contrôle suivants :
        | Message                                                                                                 | Sévérité      | Type      |
        | L'objet cadastral 123-456-789 est réservé par BACCI par la session 98765 | AVERTISSEMENT | PREREQUIS |
        | L'objet cadastral 012-345-678 est réservé par FABI par la session 12345 | AVERTISSEMENT | PREREQUIS |
      Exemples:
        | type personne |
        | PP            |
        | PM            |

    @PP @prerequisReservation
    Scénario:
      Etant donné un assujettissement pour un contribuable PP
      Et que la valeur immobilière pour cet assujettissement contient l'objet cadastral 123-456-789 non réservé
      Quand l'utilisateur valide le prérequis de réservation pour cet assujettissement
      Alors aucun message de contrôle n'est généré
