#language: fr

Fonctionnalité: F13 - Récupération des paramètres de calcul de taux IIC

  Règle: R1 - Le taux IIC appliqué dans les calculs est récupéré avec la règle suivante :
  - Pour une PP, le taux IIC appliqué correspond au taux IIC PP des jeux de paramètre pour l'année du début de l'assujettissement
  - Pour un PM, voir R2

    @tauxIIC @PP
    Plan du scénario:  Appliquer le bon taux IIC pour une taxation immobilière pour une PP (<Test> - <Observation>)
      Etant donné que le taux IIC pour PP est paramétré avec les valeurs suivantes:
        | Année | Taux IIC |
        | 2020  | 1‰       |
        | 2021  | 0.5‰     |
      Etant donné un assujettissement <période> pour un contribuable PP
      Etant donné qu'il existe une valeur immobilière pour cet assujettissement
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors le taux IIC appliqué pour le calcul de l'IIC est <taux IIC appliqué>
      Exemples:
        | Test | période                     | taux IIC appliqué | Observation                                                          |
        | 1    | du 01.01.2020 au 31.12.2020 | 1‰                | Assuj PP 2020 => Taux IIC appliqué = taux IIC PP paramétré pour 2020 |
        | 2    | du 01.01.2021 au 31.12.2021 | 0.5‰              | Assuj PP 2021 => Taux IIC appliqué = taux IIC PP paramétré pour 2021 |
        # TODO AFCTAXIMMO-580
        # | 3   | du 01.01.2022 au 31.12.2022 | EN ERREUR         | Assuj PP 2022 => Taux IIC appliqué = ERREUR car pas de taux IIC PP paramétré pour 2022 |

  Règle: R2 - Le taux IIC PM appliqué dans les calculs est récupéré avec la règle d'aiguillage suivante :
  - Récupérer le taux IIC en respectant les étapes suivantes
  - Etape 1 : Le taux IIC Négocié PM, type usage et validité
  -- Rechercher si un taux IIC valide à la date de début de l'assujettissement existe pour la PM dans le fichier de csv selon l'usage
  -- L'usage INCONNU est considéré comme un usage LOUE
  -- Si existe, retourner le taux IIC à appliquer
  -- Si inexistant, passer à l'étape 2
  - Etape 2 : Le taux IIC par nature de juridique afc et type usage
  -- Rechercher si le taux IIC existe pour la nature juridique afc dans les jeux de paramêtres selon l'usage pour l'année du début de l'assujettissement
  -- L'usage INCONNU est considéré comme un usage LOUE
  -- Si existe, retourner le taux IIC à appliquer
  -- Si inexistant, passer à l'étape 3
  - Etape 3 : Le taux IIC par défaut pour les PM
  -- Rechercher le taux par type usage dans les jeux de paramêtres
  -- L'usage INCONNU est considéré comme un usage LOUE

    @tauxIIC @PM @tauxIICParDefaut
    Plan du scénario: Appliquer le bon taux IIC pour une taxation immobilière pour une PM (<Test> - <Observation>)
      Etant donné que le taux IIC par defaut pour PM est paramétré avec les valeurs suivantes:
        | Année | Type usage  | Taux IIC |
        | 2020  | OCCUPE      | 1‰       |
        | 2020  | LOUE        | 1.5‰     |
        | 2020  | IMPRODUCTIF | 2.8‰     |
        | 2021  | OCCUPE      | 3‰       |
        | 2021  | LOUE        | 3.5‰     |
        | 2021  | IMPRODUCTIF | 5.8‰     |
      Etant donné un assujettissement <période> pour un contribuable PM
      Etant donné qu'il existe une valeur immobilière pour cet assujettissement
      Et a comme usage <typeUsage>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors le taux IIC appliqué pour le calcul de l'IIC est <taux IIC appliqué>
      Exemples:
        | Test | période                     | typeUsage   | taux IIC appliqué | Observation                                               |
        | 1    | du 01.01.2020 au 31.12.2020 | OCCUPE      | 1‰                | Assuj PM 2020 => Taux IIC par défaut occupé appliqué      |
        | 2    | du 01.01.2021 au 31.12.2021 | OCCUPE      | 3‰                | Assuj PM 2021 => Taux IIC par défaut occupé appliqué      |
        | 3    | du 01.01.2021 au 31.12.2021 | LOUE        | 3.5‰              | Assuj PM 2021 => Taux IIC par défaut loué appliqué        |
        | 4    | du 01.01.2021 au 31.12.2021 | IMPRODUCTIF | 5.8‰              | Assuj PM 2021 => Taux IIC par défaut improductif appliqué |

    @tauxIIC @PM @tauxIICNatureJuridiqueAfc
    Plan du Scénario: Appliquer le bon taux IIC PM par nature juridique afc pour une taxation immobilière (<Test> - <Observation>)
      Etant donné que le taux IIC PM par nature juridique afc est paramétré avec les valeurs suivantes:
        | Année | Nature juridique afc | Type usage  | Taux IIC |
        | 2020  | SCOOP                | OCCUPE      | 1‰       |
        | 2020  | SCOOP                | LOUE        | 2‰       |
        | 2020  | SCOOP                | IMPRODUCTIF | 3‰       |
        | 2020  | ASSOC                | LOUE        | 5‰       |
        | 2021  | ASSOC                | OCCUPE      | 4‰       |
        | 2021  | ASSOC                | LOUE        | 5‰       |
        | 2021  | ASSOC                | IMPRODUCTIF | 6‰       |
      Etant donné un assujettissement <période> pour un contribuable PM avec un numéro R 20017047
      Etant donné qu'il existe une valeur immobilière pour cet assujettissement
      Et a comme usage <typeUsage>
      Et a une personne morale avec le numeroR 20017047 et une nature juridique afc <natureJuridiqueAfc> à la date de fin d'assuj
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors le taux IIC appliqué pour le calcul de l'IIC est <taux IIC appliqué>
      Exemples:
        | Test | période                     | natureJuridiqueAfc | typeUsage   | taux IIC appliqué | Observation                                          |
        | 1    | du 01.01.2020 au 31.12.2020 | SCOOP              | OCCUPE      | 1‰                | Assuj PM 2020 => Taux IIC SCOOP OCCUPE appliqué      |
        | 2    | du 01.01.2020 au 31.12.2020 | SCOOP              | LOUE        | 2‰                | Assuj PM 2020 => Taux IIC SCOOP LOUE appliqué        |
        | 3    | du 01.01.2020 au 31.12.2020 | SCOOP              | IMPRODUCTIF | 3‰                | Assuj PM 2020 => Taux IIC SCOOP IMPRODUCTIF appliqué |
        | 4    | du 01.01.2021 au 31.12.2021 | ASSOC              | OCCUPE      | 4‰                | Assuj PM 2021 => Taux IIC ASSOC OCCUPE appliqué      |
        | 5    | du 01.01.2021 au 31.12.2021 | ASSOC              | LOUE        | 5‰                | Assuj PM 2021 => Taux IIC ASSOC LOUE appliqué        |
        | 6    | du 01.01.2021 au 31.12.2021 | ASSOC              | IMPRODUCTIF | 6‰                | Assuj PM 2021 => Taux IIC ASSOC IMPRODUCTIF appliqué |
        | 7    | du 01.01.2020 au 31.12.2021 | ASSOC              | LOUE        | 5‰                | Assuj PM 2020 => Taux IIC ASSOC LOUE appliqué        |

    @tauxIIC @PM @tauxIICNégocié @tauxIICNatureJuridiqueAfc @tauxIICParDefaut
    Plan du Scénario: Appliquer le bon taux IIC pour PM pour une taxation immobilière selon la règle d'aiguillage(<Test> - <Observation>)
      Etant donné que le taux IIC négocié PM est paramétré avec les valeurs suivantes:
        | Début      | Fin        | PM       | Type usage | Taux IIC |
        | 01.01.1900 | 01.01.9999 | 20263748 | OCCUPE     | 0.5‰     |
      Et que le taux IIC PM par nature juridique afc est paramétré avec les valeurs suivantes:
        | Année | Nature juridique afc | Type usage | Taux IIC |
        | 2020  | SCOOP                | OCCUPE     | 1‰       |
      Et que le taux IIC par defaut pour PM est paramétré avec les valeurs suivantes:
        | Année | Type usage | Taux IIC |
        | 2020  | OCCUPE     | 1.5‰     |
      Etant donné un assujettissement <période> pour un contribuable PM avec un numéro R <numR>
      Etant donné qu'il existe une valeur immobilière pour cet assujettissement
      Et a comme usage OCCUPE
      Et a une personne morale avec le numeroR <numR> et une nature juridique afc <natureJuridiqueAfc> à la date <date personne morale>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors le taux IIC appliqué pour le calcul de l'IIC est <taux IIC appliqué>
      Exemples:
        | Test | période                     | date personne morale | numR     | natureJuridiqueAfc | taux IIC appliqué | Observation                                                                                                 |
        | 1    | du 01.01.2020 au 31.12.2020 | 31.12.2020           | 20263748 | SCOOP              | 0.5‰              | Assuj PM 2020 => Taux IIC négocié OCCUPE appliqué car le taux IIC négocié PM est paramétré                  |
        | 2    | du 01.01.2020 au 31.12.2020 | 31.12.2020           | 26139883 | SCOOP              | 1‰                | Assuj PM 2020 => Taux IIC SCOOP OCCUPE appliqué car le taux IIC PM par nature juridique afc est paramétré   |
        | 3    | du 01.01.2020 au 31.12.2020 | 31.12.2015           | 26139883 | SCOOP              | 1.5‰              | Assuj PM 2020 => Taux IIC par défaut OCCUPE appliqué car nature juridique inconnue à la date de fin d'assuj |
        | 4    | du 01.01.2020 au 31.12.2020 | 31.12.2020           | 27139653 | SA                 | 1.5‰              | Assuj PM 2020 => Taux IIC par défaut OCCUPE appliqué car le taux IIC par defaut pour PM est paramétré       |

    @tauxIIC @PM @tauxIICNégociés
    Plan du Scénario: Appliquer le bon taux IIC négocié PM pour une taxation immobilière (<Test> - <Observation>)
      Etant donné que le taux IIC négocié PM est paramétré avec les valeurs suivantes:
        | Début      | Fin        | PM       | Type usage  | Taux IIC |
        | 01.01.1900 | 01.01.9999 | 20263748 | OCCUPE      | 0.5‰     |
        | 01.01.2010 | 01.01.9999 | 26139883 | LOUE        | 2‰       |
        | 04.06.1981 | 01.01.2045 | 20416960 | IMPRODUCTIF | 1.5‰     |
        | 04.06.2046 | 01.01.2050 | 20416960 | IMPRODUCTIF | 0.6‰     |
        | 01.01.2010 | 01.01.9999 | 26139900 | LOUE        | 3.5‰     |
      Etant donné un assujettissement pour l'année fiscale <anneeFiscale> pour un contribuable PM ayant comme numeroR <numR>
      Etant donné qu'il existe une valeur immobilière pour cet assujettissement
      Et a comme usage <typeUsage>
      Et a une personne morale avec le numeroR <numR> et une nature juridique afc SCOOP à la date 20.10.2023
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors le taux IIC appliqué pour le calcul de l'IIC est <taux IIC appliqué>
      Exemples:
        | Test | anneeFiscale | numR     | typeUsage   | taux IIC appliqué | Observation                                                                                                                        |
        | 1    | 2020         | 20263748 | OCCUPE      | 0.5‰              | Assuj PM 20263748 => Taux IIC négocié OCCUPE appliqué                                                                              |
        | 2    | 2020         | 26139883 | LOUE        | 2‰                | Assuj PM 26139883 => Taux IIC négocié LOUE appliqué                                                                                |
        | 3    | 2021         | 20416960 | IMPRODUCTIF | 1.5‰              | Assuj PM 20416960 avec deux deux clés similaires => Taux IIC négocié IMPRODUCTIF appliqué par rapport à la période de l'assuj 2021 |
        | 4    | 2047         | 20416960 | IMPRODUCTIF | 0.6‰              | Assuj PM 20416960 avec deux deux clés similaires => Taux IIC négocié IMPRODUCTIF appliqué par rapport à la période de l'assuj 2047 |
        | 5    | 2022         | 20416961 | LOUE        | 0.0‰              | La PM n'est pas présente dans la liste                                                                                             |
