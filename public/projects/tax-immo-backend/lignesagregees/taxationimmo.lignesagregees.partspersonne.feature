#language: fr

Fonctionnalité: F16 - Calcul des parts personne d'une ligne agrégée

  Règle: R1 - Les parts contribuable (noté part_CT) et conjoint (part_CJ) sont calculées de la manière suivante:
  - Si la taxation immobilière est pour un PM, alors part_CT = 100% et part_CJ = rien
  - Sinon si la taxation immobilière est pour un PP seul, alors part_CT = 100% et part_CJ = rien
  - Sinon si la ligne agrégée ne contient que des lignes de type REVENU, alors
  --- si le revenu IFD est de 0 CHF, part_CT = 50% et part_CJ = 50%
  --- sinon part_CT = (somme du revenu IFD de CT) / (revenu IFD agrégée) et part_CJ = 100% - part_CT
  - Sinon si la ligne agrégée a un capital après abattement défini, alors
  --- si le capital après abattement est de 0 CHF, part_CT = 50% et part_CJ = 50%
  --- sinon part_CT = (somme du capitale après abattement de CT) / (capital après abattement ligne agrégée) et part_CJ = 100% - part_CT
  - Sinon si la ligne agrégée a un capital selon estimation défini, alors
  --- si le capital selon estimation est de 0 CHF, part_CT = 50% et part_CJ = 50%
  --- sinon part_CT = (somme du capitale selon estimation de CT) / (capital selon estimation ligne agrégée) et part_CJ = 100% - part_CT
  - Sinon part_CT = rien et part_CJ = rien

    @partsPersonne @PM
    Scénario: Calcul des parts contribuable et conjoint pour une ligne agrégée PM
      Etant donné un assujettissement pour un contribuable PM
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation |
        | 3.1           |
        | 3.1           |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Code taxation | Part contribuable | Part conjoint |
        | 3.1           | 100%              | vide          |

    @partsPersonne @PP @PPseul
    Scénario: Calcul des parts contribuable et conjoint pour une ligne agrégée PP seul
      Etant donné un assujettissement pour un contribuable seul PP
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation |
        | 15.10         |
        | 15.10         |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Code taxation | Part contribuable | Part conjoint |
        | 15.10         | 100%              | vide          |

    #TODO AFCTAXIMMO-584 : Utiliser le type PourcentageDecimal avec un arrondi au centième
    @partsPersonne @PP @couple
    Scénario: Calcul des parts contribuable et conjoint pour une ligne agrégée PP couple à partir du capital après abattement
      Etant donné un assujettissement couple
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation | Role personne | Capital après abattement | Capital selon estimation |
        | 15.10         | CONTRIBUABLE  | 1500                     | 2000                     |
        | 15.10         | CONTRIBUABLE  | 500                      | 1000                     |
        | 15.10         | CONJOINT      | 500                      | 1000                     |
        | 15.10         | CONJOINT      | 500                      | 1000                     |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Code taxation | Part contribuable  | Part conjoint      |
        | 15.10         | 66.66666666666666% | 33.33333333333334% |

    #TODO AFCTAXIMMO-584 : Utiliser le type PourcentageDecimal avec un arrondi au centième
    @partsPersonne @PP @couple
    Scénario: Calcul des parts contribuable et conjoint pour une ligne agrégée PP couple à partir du capital selon estimation
      Etant donné un assujettissement couple
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation | Role personne | Capital après abattement | Capital selon estimation |
        | 15.20         | CONTRIBUABLE  |                          | 1500                     |
        | 15.20         | CONTRIBUABLE  |                          | 500                      |
        | 15.20         | CONJOINT      |                          | 500                      |
        | 15.20         | CONJOINT      |                          | 500                      |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Code taxation | Part contribuable  | Part conjoint      |
        | 15.20         | 66.66666666666666% | 33.33333333333334% |

    @partsPersonne @PP @couple
    Scénario: Calcul des parts contribuable et conjoint pour une ligne agrégée PP couple à partir du capital après abattement égale à 0
      Etant donné un assujettissement couple
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation | Role personne | Capital après abattement |
        | 15.10         | CONTRIBUABLE  | 0                        |
        | 15.10         | CONJOINT      | 0                        |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Code taxation | Part contribuable | Part conjoint |
        | 15.10         | 50%               | 50%           |

    @partsPersonne @PP @couple
    Scénario: Calcul des parts contribuable et conjoint pour une ligne agrégée PP couple à partir du capital selon estimation égale à 0
      Etant donné un assujettissement couple
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation | Role personne | Capital après abattement | Capital selon estimation |
        | 15.10         | CONTRIBUABLE  |                          | 0                        |
        | 15.10         | CONJOINT      |                          | 0                        |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Code taxation | Part contribuable | Part conjoint |
        | 15.10         | 50%               | 50%           |

    @partsPersonne @PP @couple
    Plan du scénario: Calcul des parts contribuable et conjoint pour une ligne agrégée PP couple à partir du revenu IFD (et pas du capital après abattement) car lignes détails uniquement de type REVENU.
      Etant donné un assujettissement couple
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation | Type          | Role personne | Capital après abattement | Revenu IFD                |
        | 15.10         | REVENU_OCCUPE | CONTRIBUABLE  | 1000                     | <Revenu IFD contribuable> |
        | 15.10         | REVENU_OCCUPE | CONJOINT      | 1000                     | <Revenu IFD conjoint>     |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Code taxation | Part contribuable  | Part conjoint      |
        | 15.10         | <Part contribuable> | <Part conjoint> |
      Exemples:
        | Revenu IFD contribuable | Revenu IFD conjoint | Part contribuable  | Part conjoint      |
        | 2000                    | 1000                | 66.66666666666666% | 33.33333333333334% |
        | 0                       | 0                   | 50%                | 50%                |

    @partsPersonne @PP @couple
    Scénario: Calcul des parts contribuable et conjoint pour une ligne agrégée PP couple à partir du capital selon estimation (et pas du Revenu IFD) car les lignes détails sont de type REVENU et BATIMENT.
      Etant donné un assujettissement couple
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation | Type          | Role personne | Capital après abattement | Revenu IFD |
        | 15.10         | REVENU_OCCUPE | CONTRIBUABLE  | 1000                     | 1000       |
        | 15.10         | REVENU_OCCUPE | CONJOINT      | 1000                     | 2000       |
        | 15.10         | BATIMENT      | CONTRIBUABLE  | 1000                     | 3000       |
        | 15.10         | BATIMENT      | CONJOINT      | 1000                     | 4000       |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Code taxation | Part contribuable | Part conjoint |
        | 15.10         | 50%               | 50%           |

    @partsPersonne @PP @couple
    Plan du Scénario: Calcul des parts contribuable et conjoint pour une ligne agrégée PP couple avec des lignes aux montants incomplets (<Test> - <Observation>)
      Etant donné un assujettissement couple
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation | Role personne | Capital selon estimation |
        | 15.10         | CONTRIBUABLE  | <Montant contribuable>   |
        | 15.10         | CONJOINT      | <Montant conjoint>       |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Code taxation | Part contribuable   | Part conjoint   |
        | 15.10         | <Part contribuable> | <Part conjoint> |
      Exemples:
        | Test | Montant contribuable | Montant conjoint | Part contribuable | Part conjoint | Observation                         |
        | 1    | 1500                 |                  | 100%              | vide          | Pas de montant pour le Conjoint     |
        | 2    |                      | 1500             | vide              | 100%          | Pas de montant pour le Contribuable |

    @partsPersonne @PP @couple
    Plan du Scénario: Calcul des parts contribuable et conjoint pour une ligne agrégée PP couple avec seulement des lignes détail pour un seul membre du couple (<Test> - <Observation>)
      Etant donné un assujettissement couple
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation | Role personne   | Capital selon estimation |
        | 15.10         | <Role personne> | 1500                     |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Code taxation | Part contribuable   | Part conjoint   |
        | 15.10         | <Part contribuable> | <Part conjoint> |
      Exemples:
        | Test | Role personne | Part contribuable | Part conjoint | Observation                              |
        | 1    | CONTRIBUABLE  | 100%              | vide          | Pas de ligne détail pour le Conjoint     |
        | 2    | CONJOINT      | vide              | 100%          | Pas de ligne détail pour le Contribuable |
