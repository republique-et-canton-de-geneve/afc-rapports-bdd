#language: fr

Fonctionnalité: F7 - Création des lignes détail à partir des valeurs immo

  Règle: R0 - Si aucune valeur immobilière n'existe pour un assuj donné, alors aucune ligne détail n'est créée.

    @creation-ligne-detail @PP @PM
    Plan du Scénario: Créer une taxation immo pour un contribuable seul sans valeur immobilière (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable <type>
      Etant donné que il n'existe aucune valeur immobilière pour cet assujettissement
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière ne contient aucune ligne de détail
      Exemples:
        | Test | type | Observation                   |
        | 1    | PP   | Aucune valeur immo pour un PP |
        | 2    | PM   | Aucune valeur immo pour un PM |

  Règle: R1 - Une ligne détail est créée pour chaque usage de valeur immobilière
  sauf dans le cas d'une valeur immobilière de type QVL avec un usage LOUE

    @creation-ligne-detail @PP @PM
    Plan du Scénario: Le nombre de lignes depend du type et de l'usage des valeurs immobilères (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable <type>
      Et que la valeur immobilière pour cet assujettissement est de type <type val immo>
      Et a comme usages: <usage 1>, <usage 2>, <usage 3>
      Et a aussi les taux exo REVENU: (0%)
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient les lignes avec les codes suivants: <ligne 1>, <ligne 2>, <ligne 3>
      Exemples:
        | Test | type | type val immo | usage 1     | usage 2       | usage 3 | ligne 1 | ligne 2 | ligne 3 | Observation                              |
        | 1    | PP   | BATIMENT      | OCCUPE      |               |         | 15.10   |         |         | 1 usage => 1 ligne détail                |
        | 2    | PP   |TERRAIN        | OCCUPE      | LOUE          |         | 15.10   | 15.20   |         | 2 usages => 2 lignes détail              |
        | 3    | PP   |BATIMENT       | OCCUPE      | PROFESSIONNEL | LOUE    | 15.10   | 15.30   | 15.20   | 3 usages => 3 lignes détail              |
        | 4    | PP   |QVL            | OCCUPE      |               |         | 15.10   |         |         | 1 usage QVL occupe => 1 ligne détail     |
        | 5    | PP   |QVL            | LOUE        | PROFESSIONNEL |         | 15.20   | 15.30   |         | 2 usages => 2 lignes détail              |
        | 5    | PP   |QVL            | LOUE        | IMPRODUCTIF   |         | 15.20   | 15.20   |         | 2 usages => 2 lignes détail              |
        | 6    | PM   |QVL            | OCCUPE      |               |         | 3.2     |         |         | 1 usage QVL occupe => 1 ligne détail     |
        | 7    | PM   |QVL            | LOUE        |               |         | 3.1     |         |         | 1 usage QVL loue => 1 ligne détail       |
        | 8    | PM   |QVL            | IMPRODUCTIF |               |         | 3.1     |         |         | 1 usage QVL improductif => 1 ligne détail|
  Règle: R2 - Pour chaque usage de valeur immobilière de type Fortune, créer une ligne détail
  - si la date de fin de validité de la valeur immobilière est égale à la date de fin de l'assujettissement
  - ou si le 31.12 de l'année N-1 est compris dans la période de la valeur immo

  R3 - Pour un PP ou PM et pour chaque valeur immobilière de type Fortune ou Revenu,
  - si la date de fin de validité de la valeur immobilière est supérieure à la date de fin de l'assujettissement
  --- alors une exception est levée

    @creation-ligne-detail @PP @PM
    #TODO AFCTAXIMMO-440 Vérifier les valeurs immo tel que Une date de fin de valeur immo FORTUNE ou REVENU après assuj PP => exception
    Plan du Scénario: Les lignes détail créées dépendent des dates de fin de la valeur immo par rapport à la date de fin de l'assuj (<Test> - <Observation>)
      Etant donné un assujettissement <période assuj> pour l'année fiscale <annee fiscale> pour un contribuable seul <type Personne>
      Et que la valeur immobilière pour cet assujettissement est de type <type valeur>
      Et a un usage OCCUPE
      Et a une période de validité <période vi>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors le système a créé <nb lignes> ligne détail
      Exemples:

        | Test | type Personne | annee fiscale | période assuj               | type valeur | période vi                  | nb lignes | Observation                                                                                                                            |
        | 1    | PP            | 2020          | du 01.01.2020 au 31.12.2020 | BATIMENT    | du 01.01.2020 au 31.12.2020 | 1         | Même période entre assuj PP fin d'année et vi => ligne détail créée                                                                    |
        | 2    | PP            | 2020          | du 01.01.2020 au 30.06.2020 | BATIMENT    | du 01.01.2020 au 30.06.2020 | 1         | Même période entre assuj PP en cours d'année et vi => ligne détail créée                                                               |
        | 3    | PP            | 2020          | du 01.01.2020 au 30.12.2020 | BATIMENT    | du 01.01.2020 au 30.06.2020 | 0         | Un usage vendu avant fin d'assuj PP => Pas de ligne détail                                                                             |
        | 5    | PP            | 2020          | du 01.01.2020 au 30.12.2020 | QVL         | du 01.01.2020 au 30.06.2020 | 1         | Une valeur immo REVENU avec un usage de type LOUE (cf. R1) et une date de fin inférieure à la date de fin Assuj PP => Une ligne détail |
        | 6    | PM            | 2020          | du 01.01.2020 au 31.12.2020 | BATIMENT    | du 01.01.2020 au 31.12.2020 | 1         | Même période entre assuj PM et vi => ligne détail créée                                                                                |
        | 7    | PM            | 2020          | du 01.01.2020 au 31.12.2020 | BATIMENT    | du 01.01.2020 au 30.06.2020 | 0         | Un usage vendu avant fin d'assuj PM => Pas de ligne détail                                                                             |
        | 8    | PM            | 2021          | du 01.01.2020 au 15.03.2021 | BATIMENT    | du 01.01.2020 au 15.03.2021 | 1         | Assuj sur 2 ans et même date de fin entre assuj PM et vi qui couvrent deux ans => ligne détail créée                                   |
        | 9    | PM            | 2021          | du 01.01.2020 au 15.03.2021 | BATIMENT    | du 01.01.2020 au 01.03.2021 | 1         | Assuj sur 2 ans et période vi sur 2 ans et contient 31.12 => ligne détail créée                                                        |
        | 10   | PM            | 2021          | du 01.01.2020 au 15.03.2021 | BATIMENT    | du 01.01.2020 au 31.12.2020 | 1         | Assuj sur 2 ans et période vi sur 1 an et se termine au 31.12 => ligne détail créée                                                    |
        | 11   | PM            | 2021          | du 01.01.2020 au 15.03.2021 | BATIMENT    | du 01.01.2020 au 30.12.2020 | 0         | Assuj sur 2 ans et période vi sur 1 an et se termine avant 31.12 => pas de ligne détail                                                |
        | 12   | PM            | 2021          | du 01.01.2020 au 15.03.2021 | BATIMENT    | du 15.01.2021 au 15.03.2021 | 1         | Assuj sur 2 ans et période vi sur l'année N et se termine à la fin de l'assuj => ligne détail créée                                    |
        | 13   | PM            | 2021          | du 01.01.2020 au 15.03.2021 | BATIMENT    | du 15.01.2021 au 14.02.2021 | 0         | Assuj sur 2 ans et période vi sur l'année N et se termine avant la fin de l'assuj => pas de ligne détail                               |
        | 14   | PM            | 2021          | du 01.01.2020 au 15.03.2021 | BATIMENT    | du 31.12.2020 au 30.01.2021 | 1         | Assuj sur 2 ans et période vi sur 2 ans et contient 31.12 avec date début postérieure à date début assuj => ligne détail créée         |

  Règle: R4 -
  Pour un PP et pour chaque valeur immobilière de type fortune (B,T et L):
  - si la valeur immobilière contient au moins un taux d'exonération fortune positif
  --- alors le système crée une ligne détail pour la partie exonérée (15.40 pour usage occupé ou 15.50 pour usage loué ou pro)
  - si la valeur immobilière ne contient pas une exonération avec taux d'exonération fortune de 100%
  --- alors le système crée une ligne détail pour la partie taxable (15.10 ou 15.20 ou 15.30)
  Pour un PM, une seule ligne détail est crée quelle que soit l'exonération

    @creation-ligne-detail @code-ligne-detail @PP @PM
    Plan du Scénario: Les lignes détail créées dépendent de l'usage et de l'exonération de la valeur immobilière (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable <personne>
      Et que la valeur immobilière pour cet assujettissement est de type BATIMENT
      Et a un usage <usage>
      Et a aussi les taux exo FORTUNE: (<taux exo>)
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient <nb lignes> lignes détail avec les codes taxation <codes taxation>
      Exemples:
        | Test | personne | usage         | taux exo  | nb lignes | codes taxation | Observation                                                                                                                      |
        | 1    | PP       | OCCUPE        | 25%       | 2         | 15.10, 15.40   | une valeur immobilière PP OCCUPE avec une exo fortune positve et pas 100% crée deux lignes détail -> occupée et exonérée fortune |
        | 2    | PP       | OCCUPE        | 0%        | 1         | 15.10          | une valeur immobilière PP OCCUPE sans exo fortune crée une ligne détail -> occupée sans exonération                              |
        | 3    | PP       | OCCUPE        | 100%      | 1         | 15.40          | une valeur immobilière PP OCCUPE avec une exo fortune 100% crée une ligne détail -> occupée avec exonération                     |
        | 4    | PP       | LOUE          | 25%       | 2         | 15.20, 15.50   | une valeur immobilière PP LOUE avec une exo fortune positve et pas 100% crée deux lignes détail -> louée et exonérée fortune     |
        | 4    | PP       | PROFESSIONNEL | 25%       | 2         | 15.30, 15.50   | une valeur immobilière PP PRO avec une exo fortune positve et pas 100% crée deux lignes détail -> pro et exonérée fortune        |
        | 5    | PP       | LOUE          | 0%        | 1         | 15.20          | une valeur immobilière PP LOUE sans exo fortune crée une ligne détail -> louée sans exonération                                  |
        | 6    | PP       | LOUE          | 100%      | 1         | 15.50          | une valeur immobilière PP LOUE avec une exo fortune 100% crée une ligne détail -> louée avec exonération                         |
        | 7    | PP       | IMPRODUCTIF   | 50%       | 2         | 15.20, 15.50   | une valeur immo IMPRODUCTIF se comporte comme une valeur immo LOUE                                                               |
        | 8    | PM       | OCCUPE        | 25%       | 1         | 3.2            | une valeur immobilière PM OCCUPE avec une exo fortune crée une ligne détail                                                      |
        | 9    | PM       | OCCUPE        | 0%        | 1         | 3.2            | une valeur immobilière PM OCCUPE sans exo fortune crée une ligne détail                                                          |
        | 10   | PM       | OCCUPE        | 100%      | 1         | 3.2            | une valeur immobilière PM OCCUPE avec exo fortune 100% crée une ligne détail                                                     |
        | 11   | PM       | LOUE          | 25%       | 1         | 3.1            | une valeur immobilière PM LOUE avec exo fortune crée une ligne détail                                                            |
        | 12   | PP       | OCCUPE        | 25%, 100% | 1         | 15.40          | une valeur immobilière PP OCCUPE avec deux exos dont une exo fortune à 100% crée une ligne détail                                |

  Règle: R5 -
  Pour un PP et pour chaque valeur immobilière de type revenue (QVL):
  - si la valeur immobilière contient un taux d'exonération revenu positif et inférieure à 100%
  --- alors le système crée deux lignes détail: une pour la partie taxable et une pour la partie exonérée
  - si la valeur immobilière contient un taux d'exonération revenu égal à 100%
  --- alors le système crée une seule ligne détail pour la partie exonérée
  - si la valeur immobilière contient un taux d'exonération revenu égal à 0%
  --- alors le système crée une seule ligne détail pour la partie taxable
  Pour un PM, il ne peut pas y avoir de valeur immobilière QVL

    @creation-ligne-detail @code-ligne-detail @PP
    Plan du Scénario: Les lignes détail créées dépendent de l'usage et de l'exonération de la valeur immobilière revenu (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable PP
      Et que la valeur immobilière pour cet assujettissement est de type QVL
      Et a un usage OCCUPE
      Et a aussi les taux exo REVENU: (<taux exo revenu>)
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient <nb lignes> lignes détail avec les codes taxation <codes taxation>
      Exemples:
        | Test | taux exo revenu | nb lignes | codes taxation | Observation                                                                                                     |
        | 1    | 25%             | 2         | 15.10, 15.40   | une valeur immobilière QVL PP OCCUPE avec une exo revenu crée deux lignes détails -> taxable et exonérée revenu |
        | 2    | 0%              | 1         | 15.10          | une valeur immobilière QVL PP OCCUPE sans exo revenu crée une ligne détail -> taxable sans exonération          |
        | 3    | 100%            | 1         | 15.40          | une valeur immobilière QVL PP OCCUPE avec une exo reven à 100% crée une ligne détail taxable                    |


  Règle: R6 - Pour une valeur immobilière de type revenue (QVL) avec plusieurs usages OCCUPE
  - la taxation immobilière crée une seule ligne détail REVENU uniquement pour l'usage avec la date d'occupation la plus ancienne.
  – Si plusieurs usages OCCUPE contiennent la même date d'occupation la plus ancienne
  – Alors la taxation immobilière crée une seule ligne détail REVENU pour le premier usage OCCUPE trouvé

    @creation-ligne-detail @PP @Revenu
    Plan du Scénario: Une ligne de revenu est crée uniquement pour l'usage OCCUPE avec la date d'occupation la plus ancienne (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable PP
      Et que la valeur immobilière pour cet assujettissement est de type QVL
      Et a comme usages: <usage 1> <date d'occupation 1>, <usage 2> <date d'occupation 2>, <usage 3> <date d'occupation 3>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient les lignes avec les codes suivants: <ligne 1>, <ligne 2>, <ligne 3>
      Exemples:
        | Test | type val immo | usage 1       | date d'occupation 1 | usage 2 | date d'occupation 2 | usage 3 | date d'occupation 3 | ligne 1 | ligne 2 | ligne 3 | Observation                                                                                                                                                   |
        | 1    | QVL           | OCCUPE        | 01.01.2008          | OCCUPE  | 01.01.2018          | OCCUPE  | 01.01.2020          | 15.10   |         |         | 3 usages OCCUPE => 1 lignes détail revenu pour la date d'occupation la plus ancienne                                                                          |
        | 2    | QVL           | OCCUPE        | 01.01.2008          |         |                     |         |                     | 15.10   |         |         | 1 usage OCCUPE => 1 lignes détail revenu                                                                                                                      |
        | 3    | QVL           | OCCUPE        | 01.01.2008          | OCCUPE  | 01.01.2008          | OCCUPE  | 01.01.2018          | 15.10   |         |         | 3 usage OCCUPE (dont 2 avec la même date d'occupation)=> 1 ligne détail revenu pour la date d'occupation la plus ancienne                                     |
        | 4    | QVL           | PROFESSIONNEL |                     | OCCUPE  | 01.01.2018          | OCCUPE  | 01.01.2020          | 15.30   | 15.10   |         | 1 usage PROFESSIONNEL et 2 usages OCCUPE => 1 ligne détail pour revenu PROFESSIONNEL, 1 ligne détail revenu OCCUPE pour la date d'occupation la plus ancienne |
