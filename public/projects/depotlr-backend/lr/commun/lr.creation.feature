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

  Scénario: Creation LR à partir Année-1 : les données taux travail en France pour les salariés sont réinitialisées
    Etant donné un DPI SALARIES
    Etant donné que la date du jour est 30.12.2025
    Etant donné qu'il existe une LR Brouillon en 2025 pour ce DPI
    Etant donné une personne salarie avec un domicile en FR et un taux de travail en France à 20.00 est ajouté au referentiel personne
    Etant donné une personne salarie avec un domicile en FR et un taux de travail en France à 20.00 est ajouté au referentiel personne
    Etant donné une personne salarie avec un domicile en GE et sans travail en France est ajouté au referentiel personne
    Etant donné que l´utilisateur transmet sa LR
    Etant donné que la date du jour est 01.02.2026
    Quand l´utilisateur crée une nouvelle LR 2026 pour ce DPI
    Alors le système DepotLR reprend les données de la LR transmise avec <nombre personne> employé(s) domicilié(s) en <domicile> sans données de travail en France
    Exemples:
      | Test | domicile | nombre personne | Observation                                             |
      | 1    | FR       | 2               | 2 personnes domicilées en France sans travail en France |
      | 2    | GE       | 1               | 1 personne domicilée en Suisse sans travail en France   |

  Scénario: Creation LR à partir Année-1 : Les données travail en France sont réinitialisées pour les salariés domiciliés en France pour un salarié sans pérode de fin
    Etant donné un DPI SALARIES
    Etant donné que la date du jour est 30.11.2025
    Etant donné qu'il existe une LR Brouillon en 2025 pour ce DPI
    Etant donné une personne salarie avec une période d'activité du 01.01.2025 au  avec un domicile en FR et sans travail en France est ajouté au referentiel personne
    Etant donné une personne salarie avec un domicile en FR et sans travail en France est ajouté au referentiel personne
    Etant donné une personne salarie avec un domicile en GE et sans travail en France est ajouté au referentiel personne
    Etant donné que l´utilisateur transmet sa LR
    Etant donné que la date du jour est 01.02.2026
    Quand l´utilisateur crée une nouvelle LR 2026 pour ce DPI
    Alors le système DepotLR reprend les données de la LR transmise avec <nombre personne> employé(s) domicilié(s) en <domicile> sans données de travail en France
    Exemples:
      | Test | domicile | nombre personne | Observation                                             |
      | 1    | FR       | 2               | 2 personnes domicilées en France sans travail en France |
      | 2    | GE       | 1               | 1 personne domicilé en Suisse sans travail en France    |

  Scénario: Creation LR à partir Année-1 : Pas de données travail en France pour les DPI hors salarié
    Etant donné un DPI CAISSE_COMPENSATION
    Etant donné que la date du jour est 30.12.2025
    Etant donné qu'il existe une LR Brouillon en 2025 pour ce DPI
    Etant donné qu'une personne CAISSE_COMPENSATION a été ajoutée à cette LR avec un domicile en FR
    Etant donné qu'une personne CAISSE_COMPENSATION a été ajoutée à cette LR avec un domicile en FR
    Etant donné qu'une personne CAISSE_COMPENSATION a été ajoutée à cette LR avec un domicile en GE
    Etant donné que l´utilisateur transmet sa LR
    Etant donné que la date du jour est 01.02.2026
    Quand l´utilisateur crée une nouvelle LR 2026 pour ce DPI
    Alors le système DepotLR reprend les données de la LR transmise avec <nombre personne> employé(s) domicilié(s) en <domicile> sans données de travail en France
    Exemples:
      | Test | domicile | nombre personne | Observation                                             |
      | 1    | FR       | 2               | 2 personnes domicilées en France sans travail en France |
      | 2    | GE       | 1               | 1 personne domicilée en Suisse sans travail en France   |
