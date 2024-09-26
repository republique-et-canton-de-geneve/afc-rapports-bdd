#language: fr

Fonctionnalité: F26 - Contrôle du prérequis Assuj

  Règle: R1 - Prérequis "Assuj valide" : Contrôler la validité de l'assujettissement
  - L'assujettissement est valide ssi il :
  -- a le rôle IBO, PPHC pour les Personnes Physiques ou le rôle PM pour les Personnes Morales
  -- a un état "A taxer"
  -- est fermé
  - Si invalide, afficher le message suivant "L'assujettissement ne respecte pas un ou plusieurs des critères suivants : à taxer, fermé et de rôle IBO, PPHC ou PM"
  - Ce prérequis est bloquant c.a.d les contrôles suivants ne sont pas exécutés si invalide

    @prerequisAssuj @PP @PM
    Plan du Scénario: Vérifier prérequis "Assuj valide" de l'assujettissement (<Test Id> -> <Observation>)
      Etant donné un assujettissement <personne> de rôle <rôle> dans l'état <état> <période>
      Quand l'utilisateur valide le prérequis Assuj pour cet assujettissement
      Alors un message de contrôle BLOQUANT est généré : <résultat>
      Exemples:
        | Test Id | personne | rôle  | état       | période                     | résultat | Observation                       |
        | 1       | PP       | IBO   | A_TAXER    | du 01.01.2020 au 31.12.2020 | non      | IBO, AT,fermé => Valide           |
        | 2       | PP       | PPHC  | A_TAXER    | du 01.01.2020 au 31.12.2020 | non      | PPHC, AT,fermé => Valide          |
        | 3       | PM       | PM    | A_TAXER    | du 01.01.2020 au 31.12.2020 | non      | PM, PM, AT,fermé => Valide        |
        | 4       | PP       | IS    | A_TAXER    | du 01.01.2020 au 31.12.2020 | oui      | IS, AT,fermé => Invalide          |
        | 5       | PP       | IBO   | INFORMATIF | du 01.01.2020 au 31.12.2020 | oui      | IBO, Informatif,fermé => Invalide |
        | 6       | PP       | IBO   | A_TAXER    | depuis le 01.01.2020        | oui      | IBO, AT,ouvert => Invalide        |
        | 7       | PM       | AUCUN | A_TAXER    | du 01.01.2020 au 31.12.2020 | oui      | PM, AUCUN, AT,fermé => Invalide   |

    @prerequisAssuj
    Scénario: Le prérequis "Assuj valide" génère un message de contrôle bloquant
      Etant donné un assujettissement PP de rôle IS dans l'état INFORMATIF depuis le 01.01.2020
      Quand l'utilisateur valide le prérequis Assuj pour cet assujettissement
      Alors le résultat du contrôle affiche les messages suivants :
        | Cet assujettissement est informatif pour l'année 2020             |
        | Cet assujettissement n'a pas de date de fin pour l'année 2020     |
        | Ce n'est pas un assujettissement IBO PPHC ou PM pour l'année 2020 |

  Règle: R2 - Prérequis "Article 14" : Contrôler si Cet assujettissement est un article 14
  - Et si c'est le cas afficher le message d'avertissement suivant "Cet assujettissement est un article 14

    @prerequisArticle14 @PP
    Scénario: Un assujettissment PP "Article 14" génère un message d'avertissement
      Etant donné un assujettissement pour un contribuable PP imposé d'après la dépense i.e. article 14
      Quand l'utilisateur valide le prérequis Article 14 pour cet assujettissement
      Alors le résultat affiche les messages de contrôle suivants :
        | Message                                | Sévérité      | Type      |
        | Cet assujettissement est un article 14 | AVERTISSEMENT | PREREQUIS |

    @prerequisArticle14 @PP
    Scénario: Un assujettissment PP non "Article 14" ne génère pas de message d'avertissement
      Etant donné un assujettissement pour un contribuable PP imposé sur le revenu et la fortune
      Quand l'utilisateur valide le prérequis Article 14 pour cet assujettissement
      Alors aucun message de contrôle n'est généré

  Règle: R3 - Prérequis Assuj Unique : Contrôler l'existence de plusieurs assuj sur la période fiscale
  Si pour la ou les personnes de l'assujettissement il existe d'autres assujettissements à taxer et fermé sur la même période fiscale
  - alors afficher le message d'avertissement suivant "Plusieurs assujettissements pour 2020 : (722.39.2620-2021-IBO-1, 566.39.2789-2021-IBO-1)
  - sinon, le prérequis est validé

    @prerequisAssujUnique @PP @PM
    Plan du Scénario: Vérifier prérequis de l'existence de plusieurs assuj sur la période fiscale
      Etant donné un assujettissement pour l'année fiscale 2021 pour un contribuable <personne> ayant comme numeroR 20222925 avec la référence métier <id assuj ct>
      Et que le contribuable 20222925 a aussi les assujettissements <autres id assuj ct> à taxer et fermé
      Quand l'utilisateur valide le prérequis Assuj Unique pour cet assujettissement
      Alors un message de contrôle AVERTISSEMENT est généré : <résultat>
      Exemples:
        | Test Id | personne | id assuj ct            | autres id assuj ct      | résultat | Observation           |
        | 1       | PP       | 722.39.2620-2021-IBO-1 |                         | non      | PP avec un seul assuj |
        | 2       | PP       | 722.39.2620-2021-IBO-1 | 722.39.2620-2021-PPHC-1 | oui      | PP avec deux assujs   |
        | 3       | PM       | 722.39.2620-2021-PM-1  |                         | non      | PM avec un seul assuj |
        | 4       | PM       | 722.39.2620-2021-PM-1  | 722.39.2620-2021-PM-2   | oui      | PM avec deux assujs   |

    @prerequisAssujUnique @PP @couple
    Plan du Scénario: Vérifier prérequis de l'existence de plusieurs assuj sur la période fiscale (<Test Id> -> <Observation>)
      Etant donné un assujettissement couple 722.39.2620-2021-IBO-1 avec contribuable 20222925 et conjoint 20845729 pour l'année fiscale 2021
      Et que le contribuable 20222925 a aussi les assujettissements <id assuj ct> à taxer et fermé
      Et que le contribuable 20845729 a aussi les assujettissements <id assuj cj> à taxer et fermé
      Quand l'utilisateur valide le prérequis Assuj Unique pour cet assujettissement
      Alors un message de contrôle AVERTISSEMENT est généré : <résultat>
      Exemples:
        | Test Id | id assuj ct            | id assuj cj            | résultat | Observation                         |
        | 1       |                        |                        | non      | CT et CJ avec le même assuj         |
        | 2       | 845.31.4750-2021-IBO-1 |                        | oui      | CT avec deux assujs                 |
        | 3       |                        | 945.31.4750-2021-IBO-1 | oui      | CJ avec deux assujs                 |
        | 4       |                        | 945.31.4750-2021-IBO-1 | oui      | CT et CJ avec des assujs différents |

    Scénario: Vérifier message du prérequis Assuj unique
      Etant donné un assujettissement pour l'année fiscale 2021 pour un contribuable PP ayant comme numeroR 20222925 avec la référence métier 722.39.2620-2021-IBO-1
      Et que le contribuable 20222925 a aussi les assujettissements 722.39.2620-2021-PPHC-1 à taxer et fermé
      Quand l'utilisateur valide le prérequis Assuj Unique pour cet assujettissement
      Alors le résultat affiche les messages de contrôle suivants :
        | Message                                                                                 | Sévérité      | Type      |
        | Plusieurs assujettissements pour 2021 : 722.39.2620-2021-IBO-1, 722.39.2620-2021-PPHC-1 | AVERTISSEMENT | PREREQUIS |
