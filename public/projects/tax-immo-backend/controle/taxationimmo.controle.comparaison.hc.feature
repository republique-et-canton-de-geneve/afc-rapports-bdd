#language: fr

Fonctionnalité: F32 - Comparaison entre lignes lieu fiscal de l’assuj d’une année N et les lignes lieu fiscal de l’assuj d’une année N-1

  Règle: R1 - Comparer les montants fortune des lignes lieu fiscal entre contribuable et référentiel
  - Deux lignes lieu fiscal avec la même clé sont comparées avec les règles suivantes :
  -- Si le montant des deux lignes est inexistant, alors aucun message de contrôle n'est généré
  -- Si le montant est inexistant pour un seul, alors un message de contrôle est généré
  -- Si les montants existent pour les deux lignes, alors ces montants sont comparés :
  --- par rapport au plafond paramétré en fonction du type de montant, du code de taxation et de l'année fiscale :
  ---- Si ValeurAbsolue (Montant N - Montant N-1) > Plafond alors un message de contrôle est généré
  --- par rapport à la tolérance paramétrée en fonction du type de montant, du code de taxation et de l'année fiscale :
  ---- Si (ValeurAbsolue (Montant N - Montant N-1)) / Montant N > Tolérance alors un message de contrôle est généré
  - Si un message de contrôle a été généré, alors il est le suivant :
  -- "RTAX xx.xx-XXX-XX a une différence entre l'année yyyy et yyyy sur Fortune"
  - Si le plafond ou la tolérance ne sont pas paramétrés, la comparaison renvoie une erreur

    # TODO AFCTAXIMMO-1089 qu'est-ce qu'on fait si pas de taxation immo contribuable pour N - 1 ?

    Règle: On affiche un message lorsque soit le plafond, soit la tolerance est depassé

    @PP @comparaison @HC @fortune
    Plan du Scénario: On affiche un message lorsque soit le plafond, soit la tolerance est depassé
      Etant donné que le plafond de contrôle pour FORTUNE est paramétré à <plafond> pour l'année 2020, le code taxation 15.10 et le type HC
      Et que la tolérance de contrôle pour FORTUNE est paramétrée à <tolérance> pour l'année 2020, le code taxation 15.10 et le type HC
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Etant donné que la taxation immobilière contribuable pour cet assuj contient la ligne lieu fiscal hors canton 15.10 avec le montant FORTUNE <montant N>
      Etant donné que la taxation immobilière contribuable pour l'assuj de l'année fiscale précédente contient la ligne lieu fiscal hors canton 15.10 avec le montant FORTUNE <montant N-1>
      Quand l'utilisateur compare la taxation immobilière entre cet assuj et celui de l'année précédente
      Alors un message de contrôle est généré : <résultat>
      Exemples:
        | Test | plafond | tolérance | montant N | montant N-1 | résultat | Observation                                                |
        | 1    | 200     | 50%       | 1000      | 900         | non      |                                                            |
        | 2    | 200     | 50%       | 1000      | 1200        | non      | plafond limite                                             |
        | 3    | 200     | 50%       | 1000      | 1300        | oui      | plafond dépassé                                            |
        | 4    | 300     | 50%       | 1000      | 1300        | non      | plafond non dépassé suite variation du plafond             |
        | 5    | 200     | 50%       | 100       | 151         | oui      | tolérance dépassée                                         |
        | 6    | 200     | 51%       | 100       | 151         | non      | tolérance non dépassée suite variation de la tolérance     |
        | 7    | 200     | 50%       | 100       | 150         | non      | tolérance limite                                           |
        | 8    | 200     | 50%       | 150       | 100         | non      | différence de 33% par rapport à N : tolérance non dépassée |
        | 9    | 200     | 50%       | 100       | 300         | oui      | plafond et tolérance dépassés                              |

    @PP @comparaison @HC @fortune
    Scénario: Comparer la fortune des lignes lieu fiscal contribuable pp entre l’année N et N-1
      Etant donné que les plafonds de contrôle sont paramétrés par défaut à 200
      Etant donné que les tolérances de contrôle sont paramétrées par défaut à 50%
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Etant donné les lignes lieu fiscal hors canton contribuable pour cet assuj :
        | Code taxation | Code pays | Code canton | Fortune |
        | 15.10         | CHE       | VD          | 1000    |
        | 15.20         | CHE       | VD          | 1000    |
        | 15.20         | CHE       | BE          | 100     |
      Et que les lignes lieu fiscal hors canton contribuable pour l'assuj de l'année fiscale précédente :
        | Code taxation | Code pays | Code canton | Fortune |
        | 15.10         | CHE       | VD          | 900     |
        | 15.20         | CHE       | VD          | 1300    |
        | 15.20         | CHE       | BE          | 151     |
      Quand l'utilisateur compare la taxation immobilière entre cet assuj et celui de l'année précédente
      Alors le résultat de la comparaison affiche les messages suivants :
        | RTAX 15.20-CH-VD a une différence entre l'année 2020 et 2019 sur Fortune |
        | RTAX 15.20-CH-BE a une différence entre l'année 2020 et 2019 sur Fortune |

    @PP @comparaison @HC @revenuIFD @revenuICC
    Scénario: Comparer les revenus des lignes lieu fiscal contribuable pp entre l’année N et N-1
      Etant donné que les plafonds de contrôle sont paramétrés par défaut à 200
      Etant donné que les tolérances de contrôle sont paramétrées par défaut à 50%
      Etant donné un assujettissement pour l'année fiscale 2019 pour un contribuable seul PP
      Etant donné les lignes lieu fiscal hors canton contribuable pour cet assuj :
        | Code taxation | Code pays | Code canton | Revenu IFD | Revenu ICC |
        | 15.10         | CHE       | VD          | 1000       | 2000       |
        | 15.20         | CHE       | VD          | 1000       | 2000       |
        | 15.20         | CHE       | BE          | 100        | 300        |
      Et que les lignes lieu fiscal hors canton contribuable pour l'assuj de l'année fiscale précédente :
        | Code taxation | Code pays | Code canton | Revenu IFD | Revenu ICC |
        | 15.10         | CHE       | VD          | 2000       | 1000       |
        | 15.20         | CHE       | VD          | 2000       | 1000       |
        | 15.20         | CHE       | BE          | 1000       | 100        |
      Quand l'utilisateur compare la taxation immobilière entre cet assuj et celui de l'année précédente
      Alors le résultat de la comparaison affiche les messages suivants :
        | RTAX 15.10-CH-VD a une différence entre l'année 2019 et 2018 sur Revenu |

    @PP @comparaison @HC
    Scénario: Certaines lignes lieu fiscal hors canton ne se retrouvent pas entre l’année N et N-1
      Etant donné un assujettissement pour l'année fiscale 2021 pour un contribuable seul PP
      Etant donné les lignes lieu fiscal hors canton contribuable pour cet assuj :
        | Code taxation | Code pays | Code canton |
        | 15.10         | CHE       | VD          |
        | 15.20         | CHE       | VD          |
        | 15.20         | FRA       |             |
      Et que les lignes lieu fiscal hors canton contribuable pour l'assuj de l'année fiscale précédente :
        | Code taxation | Code pays | Code canton |
        | 15.10         | CHE       | VD          |
        | 15.20         | FRA       |             |
        | 15.10         | FRA       |             |
      Quand l'utilisateur compare la taxation immobilière entre cet assuj et celui de l'année précédente
      Alors le résultat de la comparaison affiche les messages suivants :
        | RTAX 15.20-CH-VD manquante dans l'année 2020 |
        | RTAX 15.10-FRA manquante dans l'année 2021    |
