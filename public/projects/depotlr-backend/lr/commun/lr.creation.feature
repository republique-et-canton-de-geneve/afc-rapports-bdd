#language: fr
Fonctionnalité: Création d'une nouvelle LR

  Plan du Scénario: Création d´une nouvelle LR dans l'état Brouillon - <Test> -> <Observation>
    Etant donné que l´utilisateur est un DPI de type <typeDpi>
    Etant donné l´année en cours <annee en cours>
    Quand l´utilisateur crée une nouvelle LR <annee LR> pour ce DPI
    Alors le système DepotLR accepte
    Et la LR de type <typeDpi> est créée dans l'état Brouillon
    Exemples:
      | Test | typeDpi                | annee en cours | annee LR | Description                                                  |
      | 1    | ASC                    | 2021           | 2021     | Création d´une nouvelle LR ASC                               |
      | 2    | PRESTATIONS_EN_CAPITAL | 2021           | 2021     | Création d´une nouvelle LR PRESTATIONS_EN_CAPITAL            |
      | 3    | SALARIES               | 2021           | 2021     | Création d´une nouvelle LR SALARIES                          |
      | 4    | CAISSE_COMPENSATION    | 2021           | 2021     | Création d´une nouvelle LR REVENUS_COMPENSATION_TRAVAIL_NOIR |
      | 5    | BENEFICIAIRE_RENTE     | 2021           | 2021     | Création d´une nouvelle LR BENEFICIAIRE_RENTE                |

  Plan du Scénario: Rejeter la création d´une nouvelle LR pour une année inférieure à 2021
    Etant donné que l´utilisateur est un DPI de type <type DPI>
    Etant donné l´année en cours <annee en cours>
    Quand l´utilisateur crée une nouvelle LR <annee creation LR> pour ce DPI
    Alors le système DepotLR <statut>
    Exemples:
      | type DPI | annee en cours | annee creation LR | statut  |
      | ASC      | 2021           | 2021              | accepte |
      | ASC      | 2021           | 2020              | refuse  |
      | ASC      | 2022           | 2023              | refuse  |
      | ASC      | 2023           | 2022              | accepte |
      | ASC      | 2026           | 2022              | refuse  |

  Scénario: Reprise lors de la creation d'une LR car LR transmise l'année N
    Etant donné un DPI ASC
    Etant donné l´année en cours 2021
    Etant donné qu'il existe une LR transmise pour l'année 2021 pour ce DPI
    Quand l´utilisateur crée une nouvelle LR 2021 pour ce DPI
    Alors le système DepotLR reprend les données de la LR transmise

#  TODO MUST M: Implementer le scenario lorsqu'il y a déjà plusieurs lrs transmises l'année N (vérifier qu'on prend bien la dernière transmise)
