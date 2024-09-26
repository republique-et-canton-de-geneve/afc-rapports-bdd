#language: fr

Fonctionnalité: F4 -Exonérations d'une ligne détail

  Règle: R1 - Une ligne détail de type Fortune (B, T ou L) ou Revenu (R) est exonérée ssi :
  - elle a un taux exo Fortune (pour B,T ou L) ou Revenu (R) strictement positif
  - ET ce n'est pas une 15.10 ou 15.20 ou 15.30

    @exoneration @PM  @PP
    Plan du Scénario: Exonération d'une ligne détail (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable <type personne>
      Et que la valeur immobilière pour cet assujettissement est de type <type vi>
      Et a comme usage <usage>
      Et a les taux exo <type exo>: <taux exo rvi>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le code <code taxation>
      Et cette ligne détail est <exonérée>
      Exemples:
        | Test | type personne | type vi      | usage         | type exo | taux exo rvi | code taxation | exonérée     | Observation                                |
        | 1    | PP            | BATIMENT     | OCCUPE        | FORTUNE  | (40%)        | 15.10         | PAS EXONEREE | Ligne 15.10 B => pas exonérée              |
        | 2    | PP            | TERRAIN      | OCCUPE        | FORTUNE  | (40%)        | 15.10         | PAS EXONEREE | Ligne 15.10 T => pas exonérée              |
        | 3    | PP            | ETAT_LOCATIF | OCCUPE        | FORTUNE  | (40%)        | 15.10         | PAS EXONEREE | Ligne 15.10 L => pas exonérée              |
        | 4    | PP            | BATIMENT     | LOUE          | FORTUNE  | (40%)        | 15.20         | PAS EXONEREE | Ligne 15.20 B => pas exonérée              |
        | 5    | PP            | BATIMENT     | PROFESSIONNEL | FORTUNE  | (40%)        | 15.30         | PAS EXONEREE | Ligne 15.30 B => pas exonérée              |
        | 6    | PP            | BATIMENT     | OCCUPE        | FORTUNE  | (40%)        | 15.40         | EXONEREE     | Ligne 15.40 B => exonérée                  |
        | 7    | PP            | BATIMENT     | LOUE          | FORTUNE  | (40%)        | 15.50         | EXONEREE     | Ligne 15.50 B => exonérée                  |
        | 8    | PP            | BATIMENT     | PROFESSIONNEL | FORTUNE  | (40%)        | 15.50         | EXONEREE     | Ligne 15.50 B Pro => exonérée              |
        | 9    | PP            | QVL          | OCCUPE        | REVENU   | (40%)        | 15.10         | PAS EXONEREE | Ligne 15.10 R => pas exonérée              |
        | 10   | PP            | QVL          | OCCUPE        | REVENU   | (40%)        | 15.40         | EXONEREE     | Ligne 15.40 R => exonérée                  |
        | 11   | PM            | BATIMENT     | OCCUPE        | FORTUNE  | (60%)        | 3.2           | EXONEREE     | Ligne 3.2 B et taux exo 60% => exonérée    |
        | 12   | PM            | BATIMENT     | OCCUPE        | FORTUNE  | (0%)         | 3.2           | PAS EXONEREE | Ligne 3.2 B et taux exo 0% => pas exonérée |
        | 13   | PM            | BATIMENT     | LOUE          | FORTUNE  | (60%)        | 3.1           | EXONEREE     | Ligne 3.1 B et taux exo 60% => exonérée    |
        | 14   | PM            | BATIMENT     | LOUE          | FORTUNE  | (0%)         | 3.1           | PAS EXONEREE | Ligne 3.1 B et taux exo 0% => pas exonérée |

  Règle: R2 - la ligne de detail doit reporter les informations des exonérations venant de RVI.

    @exoneration @PP @PM
    Plan du Scénario: la ligne de detail doit reporter les informations des exonérations (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable <personne>
      Et que la valeur immobilière pour cet assujettissement a 100% d'exonérations: <libellé exo1 rvi>, <libellé exo2 rvi>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec les exonérations 100% suivantes: <libellé exo1 taximmo>, <libellé exo2 taximmo>
      Exemples:
        | Test | personne | libellé exo1 rvi | libellé exo2 rvi | libellé exo1 taximmo | libellé exo2 taximmo | Observation                                                  |
        | 1    | PP       | Art. 1           | Art. 2           | Art. 1               | Art. 2               | Une valeur immobilière avec deux exonérations  pour un PP    |
        | 2    | PP       | Art. 1           |                  | Art. 1               |                      | Une valeur immobilière avec une seule exonération pour un PP |
        | 3    | PM       | Art. 1           | Art. 2           | Art. 1               | Art. 2               | Une valeur immobilière avec deux exonérations pour un PM     |


  Règle: R3 - Pour les PP et PM, le taux d'exonération (fortune, IIC ou revenu) appliqué pour une ligne détail avec un code taxation éxonéré sélectionne le plus avantageux parmi la liste des exos.
  - Si la valeur immobilière ne contient pas d'exonération, la taux d'exo appliqué sera de 0%
  - Si la valeur immobilière contient une seule exonération, la taux d'exo appliqué sera celui de la valeur immobilière
  - Si la valeur immobilière contient plusieurs exonérations, la taux d'exo appliqué sera le taux le plus grand

    @exoneration @PP @PM @tauxExoFortune @tauxExoRevenu
    Plan du Scénario: Déterminer le taux d'exonération d'une ligne détail (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable <type personne>
      Et que la valeur immobilière pour cet assujettissement est de type <type vi>
      Et a comme usage OCCUPE
      Et a les taux exo <type exo>: <taux exo rvi>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le code <code taxation>
      Et cette ligne détail a un taux EXONERE <type exo> <taux exo taximmo>
      Exemples:
        | Test | type personne | type vi  | type exo | taux exo rvi    | code taxation | taux exo taximmo | Observation                                                                                                      |
        | 1    | PP            | BATIMENT | FORTUNE  | (75%, 50%)      | 15.40         | 75%              | la valeur immobilière pour un PM contient plusieurs exonération fortune dont une avec un taux d'exonération 75%  |
        | 2    | PP            | BATIMENT | FORTUNE  | (80%)           | 15.40         | 80%              | la valeur immobilière pour un PP contient une seule exonération fortune avec un taux d'exonération 100%          |
        | 3    | PP            | BATIMENT | FORTUNE  | (100%, 50%, 0%) | 15.40         | 100%             | la valeur immobilière pour un PP contient plusieurs exonération fortune dont une avec un taux d'exonération 100% |
        | 4    | PP            | QVL      | REVENU   | (75%, 50%)      | 15.40         | 75%              | la valeur immobilière pour un PP contient plusieurs exonération fortune dont une avec un taux d'exonération 100% |
        | 5    | PM            | BATIMENT | FORTUNE  | (75%, 50%)      | 3.2           | 75%              | la valeur immobilière pour un PM contient plusieurs exonération fortune dont une avec un taux d'exonération 75%  |

    @exoneration @PP @PM @tauxExoIIC
    Plan du Scénario: Déterminer le taux d'exonération IIC à appliquer (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable <type personne>
      Et que la valeur immobilière pour cet assujettissement est de type BATIMENT
      Et a les taux exo IIC: <taux exo rvi>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors la taxation immobilière contient les lignes détail avec les taux exo IIC: <taux exo iic taximmo>
      Exemples:
        | Test | type personne | taux exo rvi     | taux exo iic taximmo | Observation                                                                                      |
        | 1    | PP            | (50%)            | (50%)                | la taxation immobilière pour un PP contient une seule exonération IIC avec un taux d'exonération |
        | 2    | PP            | (50%, 100%, 10%) | (100%)               | la taxation immobilière pour un PP sélectionne le taux IIC le plus avantageux à appliquer        |
        | 3    | PP            | (50%, 100%, 10%) | (100%)               | la taxation immobilière pour un PP sélectionne le taux IIC le plus avantageux à appliquer        |
        | 4    | PM            | (50%, 100%, 10%) | (100%)               | la taxation immobilière pour un PM sélectionne le taux IIC le plus avantageux à appliquer        |

  Règle: R5 - Pour les 15.10, 15.20 et 15.30, le taux fortune (pour les B,T et L) ou le taux revenu (pour les R) est un taux taxable = 100% - taux exo (voir R3).
  - Pour le reste, le taux fortune est le taux exo (voir R3)

    @exoneration @PP @tauxTaxableFortune @tauxTaxableRevenu
    Plan du Scénario: Déterminer le taux Fortune pour un PP (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable <type personne>
      Et que la valeur immobilière pour cet assujettissement est de type <type vi>
      Et a comme usage <usage>
      Et a les taux exo <type exo>: <taux exo rvi>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le code <code taxation>
      Alors cette ligne détail est PAS EXONEREE
      Et cette ligne détail a un taux TAXABLE <type exo> <taux taxable>
      Exemples:
        | Test | type personne | type vi      | usage         | type exo | taux exo rvi    | code taxation | taux taxable | Observation                                                                                                          |
        | 1    | PP            | BATIMENT     | OCCUPE        | FORTUNE  | (10%)           | 15.10         | 90%          | taux taxable d'une 15.10, B avec une exo                                                                             |
        | 2    | PP            | BATIMENT     | OCCUPE        | FORTUNE  | (50%, 75%, 30%) | 15.10         | 25%          | taux taxable d'une 15.10, B avec plusieurs exo                                                                       |
        | 3    | PP            | QVL          | OCCUPE        | REVENU   | (10%)           | 15.10         | 90%          | taux taxable d'une 15.10, R avec une exo                                                                             |
        | 4    | PP            | TERRAIN      | OCCUPE        | FORTUNE  | (10%)           | 15.10         | 90%          | taux taxable d'une 15.10, T avec une exo                                                                             |
        | 5    | PP            | ETAT_LOCATIF | OCCUPE        | FORTUNE  | (10%)           | 15.10         | 90%          | taux taxable d'une 15.10, L avec une exo                                                                             |
        | 6    | PP            | BATIMENT     | LOUE          | FORTUNE  | (10%)           | 15.20         | 90%          | taux taxable d'une 15.20, B avec une exo                                                                             |
        | 7    | PP            | BATIMENT     | PROFESSIONNEL | FORTUNE  | (10%)           | 15.30         | 90%          | la taxation immobilière pour un PP sélectionne le taux exonération fortune le plus avantageux à appliquer sur 1 taux |

  Règle: R6 - Filtrer les exonérations pour les PM et PP :
  -- Pour IIC :
  --- Vérifier que le 31.12 de l'année de début de l'assuj est comprise dans la période de validité de l'exonération (du 01.01 de l'année de début au 31.12 de l'année de fin)
  -- Pour la FORTUNE et REVENU :
  --- Vérifier que la date de fin de l'assuj est comprise dans la période de l'exonération (du 01.01 de l'année de début au 31.12 de l'année de fin)
  - Pour une éxonération sans année de fin, on considère la date du 31.12.9999

    @exoneration @PM @PP
    Plan du Scénario: Filtrer les exonérations pour les PM et PP (<Test> - <Observation>)
      Etant donné un assujettissement <période assuj> pour l'année fiscale <année fiscale> pour un contribuable <type contribuable>
      Et que la valeur immobilière pour cet assujettissement a une période de validité <période assuj>
      Et a l'exo : <exo vi> de type <type exo> avec année de début <année début exo> et année de fin <année fin exo>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors la taxation immobilière contient les lignes détail avec les exonérations <type exo> : <exo taximmo>
      Exemples:
        | Test | type contribuable | période assuj               | année fiscale | exo vi | type exo | année début exo | année fin exo | exo taximmo | Observation                                                                                                         |
        | 1    | PP                | du 01.01.2020 au 31.12.2020 | 2020          | Art.1  | FORTUNE  | 2000            | 2020          | Art.1       | L'exo est valide car la date de fin d'assuj est comprise dans la période d'exo                                      |
        | 2    | PP                | du 01.01.2020 au 30.03.2020 | 2020          | Art.4  | IIC      | 2020            | 2020          | Art.4       | L'exo est valide car le 31.12 de l'année de début de l'assuj est compris dans la période d'exo |
        | 3    | PP                | du 01.01.2020 au 30.03.2020 | 2020          | Art.5  | REVENU   | 2020            | 2020          | Art.5       | L'exo est valide car la date de fin d'assuj est comprise dans la période d'exo                                      |
        | 4    | PP                | du 01.01.2020 au 30.03.2020 | 2020          | Art.5  | REVENU   | 1992            | 2000          |             | L'exo est valide car la date de fin d'assuj est comprise dans la période d'exo                                      |
        | 5    | PM                | du 01.04.2020 au 31.03.2021 | 2021          | Art.7  | FORTUNE  | 2020            | 2020          |             | L'exo n'est pas valide car l'année de fin d'assujn'est pas comprise dans la période d'exo                           |
        | 6    | PM                | du 01.04.2020 au 31.03.2021 | 2021          | Art.8  | FORTUNE  | 2021            |               | Art.8       | L'exo est valide car la date de fin d'assuj est comprise dans la période d'exo                                      |
        | 7    | PM                | du 01.04.2020 au 31.03.2021 | 2021          | Art.9  | IIC      | 2020            | 2020          | Art.9       | L'exo est pas valide car la date du 31.12 de l'année de début de l'assuj est comprise dans la période d'exo         |
        | 8    | PM                | du 01.04.2020 au 31.03.2021 | 2021          | Art.10 | IIC      | 2021            | 2023          |             | L'exo n'est pas valide car la date du 31.12 de l'année de début de l'assuj n'est pas comprise dans la période d'exo |

    @exoneration @PP @PM
    Plan du Scénario: Création des lignes détail à partir des valeurs immobilières et des exonérations
      Etant donné un assujettissement <période assuj> pour l'année fiscale <année fiscale> pour un contribuable <type contribuable>
      Et que la valeur immobilière pour cet assujettissement est de type <type vi>
      Et a une période de validité <période assuj>
      Et a comme usage <usage>
      Et a l'exo de type <type exo> avec année de début <année début exo> et année de fin <année fin exo> avec un taux à 40%
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient les lignes avec les codes suivants: <ligne 1>, <ligne 2>

      Exemples:
        | Test | type contribuable | période assuj                | année fiscale | type exo | année début exo | année fin exo | type vi  | usage  | ligne 1 | ligne 2 | Observation                                                                                                                |
        | 1    | PP                | du 01.01.2020 au 31.12.2020  | 2020          | FORTUNE  | 2000            |               | BATIMENT | LOUE   | 15.20   | 15.50   | Exonération fortune valide pour l'assujettissement                                                                         |
        | 2    | PP                | du 01.01.2020 au 31.12.2020  | 2020          | FORTUNE  | 2022            | 2024          | BATIMENT | OCCUPE | 15.10   |         | Exonération fortune non valide pour l'assujettissement                                                                     |
        | 3    | PP                | du 01.01.2020 au 30.03.2020  | 2020          | IIC      | 1995            | 1999          | TERRAIN  | OCCUPE | 15.10   |         | Exonération iic non valide année de fin exo < 31.12.année de début d'assuj                                                 |
        | 4    | PP                | du 01.01.2020 au 30.03.2020  | 2020          | REVENU   | 2020            | 2020          | QVL      | OCCUPE | 15.10   | 15.40   | Exonération revenu valide pour l'assujettissement                                                                          |
        | 5    | PM                | du 01.04.2020 au 31.03.2021  | 2021          | IIC      | 2020            | 2020          | BATIMENT | OCCUPE | 3.2     |         | Exonération iic valide car la date du 31.12 de l'année de début d'assuj est comprise dans la période d'exo                 |
        | 6    | PM                | du 01.04.2020 au 31.03.2021  | 2021          | IIC      | 2021            | 2023          | TERRAIN  | LOUE   | 3.1     |         | Exonération iic n'est pas valide car la date du 31.12 de l'année de début d'assuj n'est pas comprise dans la période d'exo |


  Règle: R7 - Pour les PP et PM, le libellé de l'exonération IIC appliqué pour une ligne détail sélectionne le libellé du taux exo IIC le plus avantageux parmi la liste des exos.
  - Le taux exo le plus avantageux étant celui ayant la plus grande valeur"

    @exoneration @PP @PM @libelleExoIIC
    Plan du Scénario: Déterminer le libellé de l'exonération IIC à appliquer (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable <type personne>
      Et que la valeur immobilière pour cet assujettissement est de type BATIMENT
      Et a les exos IIC avec des taux IIC <exo taux iic rvi> et respectivement des libelles <exo libelle iic rvi>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors la taxation immobilière contient les lignes détail avec le libelle exo IIC: <libelle exo iic taximmo>
      Exemples:
        | Test | type personne | exo taux iic rvi | exo libelle iic rvi | libelle exo iic taximmo | Observation                                                                                         |
        | 1    | PP            | (50%)            | exo1                | exo1                    | la taxation immobilière pour un PP contient une seule exonération IIC avec un libellé d'exonération |
        | 2    | PP            | (50%,100%,10%)   | exo1,exo2,exo3      | exo2                    | la taxation immobilière pour un PP sélectionne le libellé IIC le plus avantageux à appliquer        |
        | 3    | PM            | (50%,100%,10%)   | exo1,exo2,exo3      | exo2                    | la taxation immobilière pour un PM sélectionne le libellé IIC le plus avantageux à appliquer        |
