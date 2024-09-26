#language: fr

Fonctionnalité: F5 - Calcul des montants des lignes agrégées

  Règle: R1 - Le capital selon estimation d'une ligne agrégée est égal à la somme des capitaux selon estimations pour toutes ses lignes détail

    @capitalSelonEstimation @lignesAgregees
    Scénario: Calcul du capital selon estimation pour une ligne agrégée à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | Capital selon estimation |
        | BATIMENT      | 1000                     |
        | TERRAIN       | 2102                     |
        | BATIMENT      | 2390                     |
        | REVENU_OCCUPE |                          |
        | REVENU_OCCUPE |                          |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Nb lignes détail | Capital selon estimation |
        | 5                | 5492                     |

    @capitalSelonEstimation @lignesAgregees @batimentOuTerrain @PP @PM
    Plan du Scénario: Calcul du capital selon estimation pour une ligne agrégée à partir des valeurs immo
      Etant donné un assujettissement pour un contribuable <personne>
      Et que les valeurs immobilières pour cet assujettissement sont :
        | Type     | Id OC    | Usages | Valeur totale |
        | TERRAIN  | 22-150-7 | OCCUPE | 1000          |
        | BATIMENT | 22-150-7 | OCCUPE | 1000          |
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Nb lignes détail | Capital selon estimation | Code taxation   | Id OC    | Types lignes détail |
        | 2                | 2000                     | <code taxation> | 22-150-7 | (B, T)              |
      Exemples:
        | personne | code taxation |
        | PP       | 15.10         |
        | PM       | 3.2           |

  Règle: R2 - Le capital après abattement d'une ligne agrégée est égal à la somme des capitaux après abattement pour toutes ses lignes détail

    @capitalApresAbattement @lignesAgregees
    Scénario: Calcul du capital après abattement pour une ligne agrégée à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | Capital après abattement |
        | BATIMENT      | 1000                     |
        | TERRAIN       | 2000                     |
        | BATIMENT      | 300                      |
        | REVENU_OCCUPE |                          |
        | REVENU_OCCUPE |                          |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Nb lignes détail | Capital après abattement |
        | 5                | 3300                     |

  Règle: R3 - Le montant IIC d'une ligne agrégée est égal à la somme de la valeur précise des montants IIC pour toutes ses lignes détail (arrondi à 5 centimes près, voir règle F1.R2)

    @montantIIC @lignesAgregees
    Scénario: Calcul du montant IIC pour une ligne agrégée
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | Montant IIC |
        | BATIMENT      | 1000.14     |
        | TERRAIN       | 2500.18     |
        | BATIMENT      | 300         |
        | BATIMENT      | 1300        |
        | REVENU_OCCUPE |             |
        | REVENU_OCCUPE |             |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Nb lignes détail | Montant IIC |
        | 6                | 5100.30     |

  Règle: R4 - Le revenu IFD d'une ligne agrégée est égal à la somme des valeurs précises des revenus IFD (et non pas les arrondis) pour toutes ses lignes détail
    @revenuIFD @lignesAgregees
    Scénario: Calcul du revenu IFD pour une ligne agrégée à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | Revenu IFD |
        | BATIMENT      |            |
        | TERRAIN       |            |
        | REVENU_OCCUPE | 1000.49    |
        | REVENU_OCCUPE | 2500.94    |
        | REVENU_OCCUPE | 1234       |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Nb lignes détail | Revenu IFD |
        | 5                | 4735       |

  Règle: R5 - L'entretien IFD d'une ligne agrégée est égal à la somme des entretiens IFD pour toutes ses lignes détail

    @entretienIFD @lignesAgregees
    Scénario: Calcul de l'entretien IFD pour une ligne agrégée à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | Entretien IFD |
        | BATIMENT      |               |
        | TERRAIN       |               |
        | REVENU_OCCUPE | 1000.49       |
        | REVENU_OCCUPE | 2500.94       |
        | REVENU_OCCUPE | 1234          |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Nb lignes détail | Entretien IFD |
        | 5                | 4735          |

  Règle: R6 - Le revenu ICC d'une ligne agrégée est égal à la somme des revenus ICC pour toutes ses lignes détail

    @revenuICC @lignesAgregees
    Scénario: Calcul du revenu IFD pour une ligne agrégée à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | Revenu ICC |
        | BATIMENT      |            |
        | TERRAIN       |            |
        | REVENU_OCCUPE | 1000.49    |
        | REVENU_OCCUPE | 2500.94    |
        | REVENU_OCCUPE | 1234       |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Nb lignes détail | Revenu ICC |
        | 5                | 4735       |

  Règle: R7 - L'entretien ICC d'une ligne agrégée est égal à la somme des entretiens ICC pour toutes ses lignes détail

    @entretienICC @lignesAgregees
    Scénario: Calcul de l'entretien ICC pour une ligne agrégée à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | Entretien ICC |
        | BATIMENT      |               |
        | TERRAIN       |               |
        | REVENU_OCCUPE | 1000.49       |
        | REVENU_OCCUPE | 2500.94       |
        | REVENU_OCCUPE | 1234          |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Nb lignes détail | Entretien ICC |
        | 5                | 4735          |

  Règle: R8 - L'utilisateur peut saisir le montant total de l'état locatif pour une ligne agrégée en fonction de l'année du visa de la valeur immobilière
  - L'utilisateur peut saisir le montant total de l'état locatif pour une ligne agrégée :
  -- Si l'assuj est fermé
  -- Et que l'année du visa est nulle ou inférieure à l'année de l'assujettissement
  -- Sinon l'utilisateur ne pourra pas saisir le montant total de l'état

    @etatLocatif @lignesAgregees @PP @PM
    Plan du Scénario: Le montant total de l'état locatif peut être saisi en fonction de l'année du visa de la valeur immobilière
      Etant donné un assujettissement <période assuj> pour l'année fiscale <Année fiscale> pour un contribuable seul <Type personne>
      Et que la valeur immobilière pour cet assujettissement est de type ETAT_LOCATIF
      Et a une période de validité du 01.01.2020 au 31.12.2020
      Et a comme année de visa de l'état locatif <Année visa>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne agrégée dont le montant de l'état locatif peut être saisi pour cet assujettissement : <Résultat>
      Exemples:
        | Test | période assuj               | Type personne | Année fiscale | Année visa | Résultat | Observation                                                     |
        | 1    | du 01.01.2020 au 31.12.2020 | PP            | 2020          |            | oui      | PP Assuj fermé et année du visa nulle                           |
        | 2    | du 01.01.2020 au 31.12.2020 | PP            | 2020          | 2019       | oui      | PP Assuj fermé et année du visa inférieure à l'année de l'assuj |
        | 3    | depuis le 01.01.2020        | PP            | 2021          | 2019       | non      | PP l'assuj est ouvert                                           |
        | 4    | du 01.01.2020 au 31.12.2020 | PP            | 2020          | 2020       | non      | PP Assuj fermé et année du visa égale à l'année de l'assuj      |
        | 5    | du 01.01.2020 au 31.12.2020 | PP            | 2020          | 2021       | non      | PP Assuj fermé et année du visa supérieure à l'année de l'assuj |
        | 6    | du 01.01.2020 au 31.12.2020 | PM            | 2020          |            | oui      | PM Assuj fermé et année du visa nulle                           |
        | 7    | du 01.01.2020 au 31.12.2020 | PM            | 2020          | 2019       | oui      | PM Assuj fermé et année du visa inférieure à l'année de l'assuj |
        | 8    | depuis le 01.01.2020        | PM            | 2021          | 2019       | non      | PM l'assuj est ouvert                                           |
        | 9    | du 01.01.2020 au 31.12.2020 | PM            | 2020          | 2020       | non      | PM Assuj fermé et année du visa égale à l'année de l'assuj      |
        | 10   | du 01.01.2020 au 31.12.2020 | PM            | 2020          | 2021       | non      | PM Assuj fermé et année du visa supérieure à l'année de l'assuj |

  Règle: R9 - Le montant soumis IIC d'une ligne agrégée est égal à la somme des montants soumis IIC pour toutes ses lignes détail
    @montantIIC @lignesAgregees
    Scénario: Calcul du montant soumis IIC pour une ligne agrégée
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | Montant soumis IIC |
        | BATIMENT      | 1000.14            |
        | TERRAIN       | 2500.18            |
        | BATIMENT      | 300                |
        | BATIMENT      | 0                  |
        | REVENU_OCCUPE |                    |
        | REVENU_OCCUPE |                    |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Nb lignes détail | Montant soumis IIC |
        | 6                | 3800.30            |

    # Note : Si le montant soumis IIC d'une ligne détail est à zéro, alors ce zéro doit avoir un arrondi à cinq centimes
    # sinon l'opération de somme lèvera un exception pour arrondis différents. (par défaut MontantCHF.ZERO est arrondi au centime près)
    @capitalSelonEstimation @lignesAgregees @batimentOuTerrain @PP @PM
    Plan du Scénario: Calcul du montant soumis IIC pour une ligne agrégée à partir des valeurs immo
      Etant donné un assujettissement pour un contribuable <personne>
      Et que les valeurs immobilières pour cet assujettissement sont :
        | Type     | Id OC    | Usages | Valeur totale | Début      | Fin        |
        | TERRAIN  | 22-150-7 | OCCUPE | 1000          | 01.01.2021 | 31.12.2021 |
        | BATIMENT | 22-150-7 | OCCUPE | 1000          | 01.01.2022 | 31.12.2022 |
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient les lignes agrégées suivantes :
        | Nb lignes détail | Capital selon estimation | Montant soumis IIC | Code taxation   | Id OC    | Types lignes détail |
        | 2                | 2000                     | 1000               | <code taxation> | 22-150-7 | (B, T)              |
      Exemples:
        | personne | code taxation |
        | PP       | 15.10         |
        | PM       | 3.2           |
