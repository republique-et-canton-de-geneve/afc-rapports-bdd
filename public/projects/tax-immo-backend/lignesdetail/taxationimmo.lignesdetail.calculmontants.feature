#language: fr

Fonctionnalité: F6 - Récupération et calcul des montants de la ligne détail

  Règle: R12 - la ligne de detail doit reporter les informations de montants

    @montants @PP @valeurTotale
    Plan du Scénario: la ligne de detail doit reporter les informations de montants (<Test>)
      Etant donné un assujettissement pour un contribuable PP
      Et que la valeur immobilière pour cet assujettissement a une valeur totale <valeur totale rvi>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec la valeur totale <valeur totale taximmo>
      Exemples:
        | Test | valeur totale rvi | valeur totale taximmo |
        | 1    | 104832            | 104832                |
        | 2    | 64832             | 64832                 |

  Règle: R11 - la ligne de détail doit reporter le montant de l’état locatif provenant de RVI

    @montants @montantEL @etatLocatif @PP @PM
    Plan du Scénario: la ligne de détail de type L doit reporter les informations de montants pour les valeurs immobilières état locatif (<Test>)
      Etant donné un assujettissement pour un contribuable <contribuable>
      Et que la valeur immobilière pour cet assujettissement est de type ETAT_LOCATIF
      Et a un montant de l'état locatif <montant etat locatif vi>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le montant de l'état locatif <montant etat locatif taximmo>
      Exemples:
        | Test | contribuable | montant etat locatif vi | montant etat locatif taximmo |
        | 1    | PP           | 1400                    | 1400                         |
        | 2    | PM           | 1200                    | 1200                         |


  Règle: R1 - Calculer le capital selon estimation pour une valeur immobilière de type Bâtiment ou Terrain
  - valeur par usage et responsabilité =  valeur totale * part d'usage * part de responsabilité
  - Capital selon estimation (arrondi au franc le plus près, voir règle F1.R1)
  --  = valeur par usage et responsabilité * taux taxable fortune, pour les 15.10 ou 15.20 ou 15.30
  --  = valeur par usage et responsabilité * taux exo fortune, pour les 15.40 et 15.50
  --  = valeur par usage et responsabilité, pour les 3.1 et 3.2

    @montants @capitalSelonEstimation @batimentOuTerrain @PP @PM
    Plan du Scénario: Le calcul du capital selon estimation dépend de l'exonération des valeurs imobilières (<Test>)
      Etant donné un assujettissement pour un contribuable <personne>
      Et que la valeur immobilière pour cet assujettissement est de type BATIMENT
      Et a une valeur totale <valeur totale>
      Et a un usage <type usage> avec une part <part Usage>
      Et a une part de responsabilite <part responsabilite>
      Et a les taux exo FORTUNE: (<taux exo fortune>)
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le code <code taxation>
      Et cette ligne détail a un montant du capital selon estimation <capit selon estim>
      Exemples:
        | Test | personne | valeur totale | type usage    | part Usage | part responsabilite | taux exo fortune | code taxation | capit selon estim | Observation                                                                                                            |
        | 1    | PP       | 1000          | OCCUPE        | 1/1        | 1/1                 | 10%              | 15.40         | 100               | capital selon estimation calculé correctement pour un 15.40                                                            |
        | 2    | PP       | 1000          | OCCUPE        | 1/2        | 1/1                 | 10%              | 15.40         | 50                | quand la part d'usage varie, le capital selon estimation varie                                                         |
        | 3    | PP       | 1000          | OCCUPE        | 1/1        | 1/2                 | 10%              | 15.40         | 50                | quand la part du bien imposable varie, le capital selon estimation varie                                               |
        | 4    | PP       | 1000          | OCCUPE        | 1/1        | 1/1                 | 20%              | 15.40         | 200               | quand le taux exo fortune varie, le capital selon estimation varie                                                     |
        | 5    | PP       | 5000          | OCCUPE        | 1/1        | 1/1                 | 10%              | 15.40         | 500               | quand la valeur totale varie, le capital selon estimation varie                                                        |
        | 6    | PP       | 1000          | LOUE          | 1/1        | 1/1                 | 10%              | 15.50         | 100               | capital selon estimation calculé correctement pour un 15.50                                                            |
        | 7    | PP       | 1000          | OCCUPE        | 1/3        | 1/1                 | 10%              | 15.40         | 33                | capital selon estimation arrondi correctement pour un 15.40                                                            |
        | 8    | PP       | 1000          | OCCUPE        | 1/1        | 1/1                 | 10%              | 15.10         | 900               | capital selon estimation calculé correctement pour un 15.10                                                            |
        | 9    | PP       | 1000          | OCCUPE        | 1/3        | 1/1                 | 10%              | 15.10         | 300               | capital selon estimation calculé correctement pour un 15.10                                                            |
        | 10   | PP       | 1000          | LOUE          | 1/1        | 1/1                 | 10%              | 15.20         | 900               | capital selon estimation calculé correctement pour un 15.20                                                            |
        | 11   | PP       | 1000          | OCCUPE        | 1/3        | 1/1                 | 20%              | 15.10         | 266.4               | capital selon estimation arrondi correctement pour un 15.10                                                            |
        | 12   | PM       | 1000          | OCCUPE        | 1/1        | 1/1                 | 10%              | 3.2           | 1000              | capital selon estimation calculé correctement pour un 3.2                                                              |
        | 13   | PM       | 1000          | LOUE          | 1/1        | 1/1                 | 10%              | 3.1           | 1000              | capital selon estimation calculé correctement pour un 3.1                                                              |
        | 14   | PM       | 5000          | OCCUPE        | 1/2        | 1/5                 | 10%              | 3.2           | 500               | quand la valeur totale, la part du bien imposable et la part usage varient, capital selon estimation varie pour un 3.2 |
        | 15   | PP       | 1000          | PROFESSIONNEL | 1/1        | 1/1                 | 10%              | 15.50         | 100               | capital selon estimation calculé correctement pour un 15.50 venant d'un usage pro                                      |
        | 16   | PP       | 1000          | PROFESSIONNEL | 1/1        | 1/1                 | 10%              | 15.30         | 900               | capital selon estimation calculé correctement pour un 15.30                                                            |

  Règle: R2 - Calculer la valeur fiscal exonérée et imposable pour une valeur immobilière de type Bâtiment ou Terrain Pour les PM
  - valeur par usage et responsabilité =  valeur totale * part d'usage * part de responsabilite
  - Capital selon estimation (arrondi au franc le plus près, voir règle F1.R1)
  --  = valeur par usage et responsabilité, pour les 3.1 et 3.2
  - Valeur fiscale imposable (arrondi au franc le plus près)
  --  = valeur par usage et responsabilité * taux taxable pour les lignes avec un code exo TAXABLE
  - Valeur fiscale exonerée (arrondi au franc le plus près)
  --  = valeur par usage et responsabilité * taux taxable pour les lignes avec un code exo EXONERE

    @montants @capitalSelonEstimation @batimentOuTerrain @valeurFiscaleExonere @valeurFiscaleImposable @PM
    Plan du Scénario: Le calcul du capital selon estimation dépend de l'exonération des valeurs imobilières (<Test>)
      Etant donné un assujettissement pour un contribuable <personne>
      Et que la valeur immobilière pour cet assujettissement est de type BATIMENT
      Et a une valeur totale <valeur totale>
      Et a un usage <type usage> avec une part <part Usage>
      Et a une part de responsabilite <part responsabilite>
      Et a les taux exo FORTUNE: (<taux exo fortune>)
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le code <code taxation>
      Et cette ligne détail a un montant du capital selon estimation <capit selon estim>
      Et cette ligne détail a une valeur fiscale exonere <valeur fiscale exonere>
      Et cette ligne détail a une valeur fiscale imposable <valeur fiscale imposable>
      Exemples:
        | Test | personne | valeur totale | type usage | part Usage | part responsabilite | taux exo fortune | code taxation | capit selon estim | valeur fiscale exonere | valeur fiscale imposable | Observation                                                                                                   |
        | 1    | PM       | 1000          | OCCUPE     | 1/1        | 1/1                 | 50%              | 3.2           | 1000              | 500                    | 500                      | les valeurs fiscale imposable et exonere fortune calculés correctement pour un 3.2                            |
        | 2    | PM       | 1000          | LOUE       | 1/1        | 1/1                 | 10%              | 3.1           | 1000              | 100                    | 900                      | les valeurs fiscale imposable et exonere fortune calculés correctement pour un 3.1                            |
        | 3    | PM       | 5000          | OCCUPE     | 1/2        | 1/5                 | 20%              | 3.2           | 500               | 100                    | 400                      | quand le taux exo fotune varie, les valeurs fiscale imposable et exonere fortune varient pour un 3.2          |
        | 4    | PM       | 5000          | OCCUPE     | 1/2        | 1/5                 | 100%             | 3.2           | 500               | 500                    | 0                        | quand  le taux exo fotune varie varient, les valeurs fiscale imposable et exonere fortune varient pour un 3.2 |

  Règle: R3 - Calculer l'état des loyers capitalisés pour une valeur immobilière de type état locatif
  - Montant état locatif net (arrondi au franc près)  =
  -- montant état locatif * part usage * part bien imposable * taux taxable fortune, pour les 15.20
  -- montant état locatif * part usage * part bien imposable * taux exo fortune, pour les 15.50
  -- montant état locatif * part usage * part bien imposable, pour les 3.1
  - Etat des loyers capitalisés (arrondi au franc près) =  Montant état locatif net / taux de capitalisation
  - L'état des loyers capitalisés n'est pas calculé lorsque le taux de capitalisation est vide

    @montants @montantEL @etatLoyersCapitalises @PP @PM @etatLocatif
    Plan du Scénario: la ligne de détail de type L doit reporter les informations de montants pour les valeurs immobilières état locatif (<Test> -> <Observation>)
      Etant donné un assujettissement pour un contribuable <personne>
      Et que la valeur immobilière pour cet assujettissement est de type ETAT_LOCATIF
      Et a un montant de l'état locatif <montant etat locatif vi>
      Et a une part d'usage <part usage>
      Et a une part de responsabilite <part responsabilite>
      Et a les taux exo FORTUNE: (<taux exo fort>)
      Et a un taux de capitalisation <taux de capitalisation>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le code <code taxation>
      Et cette ligne détail a un montant de l'état locatif net <montant etat locatif net>
      Et cette ligne détail a un montant de l'état des loyers capitalisés <etat loyers capt>
      Exemples:
        | Test | personne | montant etat locatif vi | part usage | part responsabilite | taux exo fort | taux de capitalisation | code taxation | montant etat locatif net | etat loyers capt | Observation                                                                                                                                                                              |
        | 1    | PP       | 1000                    | 1/1        | 1/1                 | 50%           | 10%                    | 15.50         | 500                      | 5000             | montant état locatif net et etat loyers capitalisés pour un 15.50 calculés correctement                                                                                                  |
        | 2    | PP       | 1100                    | 1/1        | 1/1                 | 50%           | 10%                    | 15.50         | 550                      | 5500             | quand le montant état locatif varie, le montant état locatif net et etat loyers capitalisés pour un 15.50 varient                                                                        |
        | 3    | PP       | 1000                    | 1/1        | 1/1                 | 20%           | 10%                    | 15.50         | 200                      | 2000             | quand le taux exo fortune varie, le montant état locatif net et etat loyers capitalisés pour un 15.50 varient                                                                            |
        | 4    | PP       | 1000                    | 1/1        | 1/2                 | 50%           | 10%                    | 15.50         | 250                      | 2500             | quand la part du bien imposable varie, le montant état locatif net et etat loyers capitalisés pour un 15.50 varient                                                                      |
        | 5    | PP       | 1000                    | 1/2        | 1/1                 | 50%           | 10%                    | 15.50         | 250                      | 2500             | quand la part usage varie, le montant état locatif net et etat loyers capitalisés pour un 15.50 varient                                                                                  |
        | 6    | PP       | 1000                    | 1/1        | 1/1                 | 50%           | 5%                     | 15.50         | 500                      | 10000            | quand le taux de capitalisation varie, le montant état locatif net et etat loyers capitalisés pour un 15.50 varient                                                                      |
        | 7    | PP       | 1000                    | 1/1        | 1/1                 | 50%           | 10%                    | 15.20         | 500                      | 5000             | montant état locatif net et etat loyers capitalisés pour un 15.20 calculés correctement                                                                                                  |
        | 8    | PP       | 1000                    | 1/2        | 1/1                 | 20%           | 10%                    | 15.20         | 400                      | 4000             | quand le taux exo fortune varie, la la part usage varie, le taux taxable fortune varie et le montant état locatif net et etat loyers capitalisés pour un 15.20 varient                   |
        | 9    | PP       | 23300                   | 1/1        | 1/3                 | 9.50%         | 12.89%                 | 15.20         | 7029                     | 54531            | montant état locatif net et etat loyers capitalisés calculés correctement avec des valeurs décimales                                                                                     |
        | 10   | PP       | 1000                    | 1/1        | 1/1                 | 50%           |                        | 15.20         | 500                      |                  | l'état loyers capitalisés n'est pas calculé car le taux de capitalisation est vide                                                                                                       |
        | 11   | PM       | 1000                    | 1/1        | 1/1                 | 50%           | 10%                    | 3.1           | 1000                     | 10000            | montant état locatif net et etat loyers capitalisés pour un 3.1 calculés correctement                                                                                                    |
        | 12   | PM       | 2000                    | 1/2        | 1/3                 | 10%           | 20%                    | 3.1           | 333                      | 1665             | quand le montant état locatif, la part usage, la part du bien imposable et le taux de capitalisation varient, le montant état locatif net et etat loyers capitalisés pour un 3.1 varient |

  Règle: R4 - Calculer la valeur locative exonérée et imposable pour une valeur immobilière de type état locatif pour les PM
  - Montant état locatif net (arrondi au franc près)  =
  -- montant état locatif * part usage * part bien imposable, pour les PM
  - Valeur locative imposable (arrondi au franc le plus près)
  --  Montant état locatif net * taux taxable fortune
  - Valeur locative exonerée (arrondi au franc le plus près)
  --  Montant état locatif net * taux exonere fortune
  - Etat des loyers capitalisés (arrondi au franc près) =  Montant état locatif net / taux de capitalisation
  - L'état des loyers capitalisés n'est pas calculé lorsque le taux de capitalisation est vide

    @montants @montantEL @etatLoyersCapitalises @valeurLocativeExonere @valeurLocativeImposable @etatLocatif @PM
    Plan du Scénario: la ligne de détail de type L doit reporter les informations de montants pour les valeurs immobilières état locatif (<Test> -> <Observation>)
      Etant donné un assujettissement pour un contribuable <personne>
      Et que la valeur immobilière pour cet assujettissement est de type ETAT_LOCATIF
      Et a un montant de l'état locatif <montant etat locatif vi>
      Et a une part d'usage <part usage>
      Et a une part de responsabilite <part responsabilite>
      Et a les taux exo FORTUNE: (<taux exo fort>)
      Et a un taux de capitalisation <taux de capitalisation>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le code <code taxation>
      Et cette ligne détail a un montant de l'état locatif net <montant etat locatif net>
      Et cette ligne détail a une valeur locative exonere <valeur locative exonere>
      Et cette ligne détail a une valeur locative imposable <valeur locative imposable>
      Et cette ligne détail a un montant de l'état des loyers capitalisés <etat loyers capt>
      Exemples:
        | Test | personne | montant etat locatif vi | part usage | part responsabilite | taux exo fort | taux de capitalisation | code taxation | montant etat locatif net | valeur locative exonere | valeur locative imposable | etat loyers capt | Observation                                                                          |
        | 1    | PM       | 1000                    | 1/1        | 1/1                 | 50%           | 10%                    | 3.1           | 1000                     | 500                     | 500                       | 10000            | valeur locative et imposable pour un 3.1 calculés correctement                       |
        | 2    | PM       | 2000                    | 1/2        | 1/3                 | 10%           | 20%                    | 3.1           | 333                      | 33                      | 300                       | 1665             | quand le taux exo fortune varie, la valeur locative et imposable pour un 3.1 varient |

  Règle: R5 - Calculer le montant soumis à l'IIC et le montant IIC pour une valeur immobilière fortune
  - capital = capital selon estimation (règle R1) ou état des loyers capitalisés (règle R2)
  - Montant soumis à IIC = capital * (100% - taux d'exonération IIC) (arrondi au franc près, voir règle F1.R1)
  - Montant IIC =  montant soumis à IIC * taux IIC (arrondi à 5 centimes près, voir règle F1.R2)

  - Le montant soumis à l'IIC est calculé ssi le 31/12 de l’année de début de l’assuj est compris dans la période de validité des valeurs immobilières PP et PM.

    @PP @PM @montantSoumisIIC
    Plan du Scénario: Calculer le montant soumis IIC ou pas en fonction de la période de l’assuj (<Test> - <Observation>)
      Etant donné un assujettissement <période assuj> pour l'année fiscale 2020 pour un contribuable seul <type Personne>
      Et que la valeur immobilière pour cet assujettissement a une période de validité <période vi>
      Et que le taux IIC par défaut paramétré pour les PM LOUE est de 2‰ pour cette année fiscale
      Et que le taux IIC pour les PP est paramétré à 2‰ pour cette année fiscale
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec un montant soumis IIC <MontantSoumisIICcalculéOUzero>
      Exemples:
        | Test | type Personne | période assuj               | période vi                  | MontantSoumisIICcalculéOUzero | Observation                                                                                                                        |
        | 1    | PP            | du 01.01.2020 au 31.12.2020 | du 01.01.2020 au 31.12.2020 | CALCULE                       | la date de fin de la valeur immobilière = 31/12 de l’année de début d’assuj pour un PP le montant ICC est calculé                  |
        | 2    | PP            | du 01.01.2020 au 30.06.2020 | du 01.01.2020 au 30.06.2020 | ZERO                          | la date de fin de la valeur immobilière < 31/12 de l’année de début d’assuj pour un PP le montant ICC n'est pas calculé            |
        | 3    | PM            | du 01.01.2020 au 31.12.2020 | du 01.01.2020 au 31.12.2020 | CALCULE                       | la date de fin de la valeur immobilière = 31/12 de l’année de début d’assuj pour un PM le montant ICC est calculé                  |
        | 4    | PM            | du 01.01.2020 au 15.03.2021 | du 01.01.2020 au 15.03.2021 | CALCULE                       | 31/12 de l’année de début d’assuj pour un PM compris dans la période de la valeur immobilière le montant ICC est calculé           |
        | 5    | PM            | du 01.01.2020 au 15.06.2021 | du 01.06.2021 au 15.06.2021 | ZERO                          | 31/12 de l’année de début d’assuj pour un PM non compris dans la période de la valeur immobilière le montant ICC n’est pas calculé |

    @PP @batimentOuTerrain @montants @montantSoumisIIC @montantIIC
    Plan du Scénario: Calculer le montant soumis à l'IIC et le montant IIC pour une valeur immobilière Bâtiment ou Terrain PP (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable PP
      Et que le taux IIC pour les PP est paramétré à <taux iic> pour cette année fiscale
      Et que la valeur immobilière pour cet assujettissement est de type <type valeur>
      Et a une valeur totale <valeur totale>
      Et a une part d'usage 1/1
      Et a une part de responsabilite 1/1
      Et a les taux exo FORTUNE: (0%)
      Et a aussi les taux exo IIC: <taux exo IIC>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le montant du capital selon estimation <capit selon estim>
      Et un montant soumis à l'IIC <montant soumis IIC>
      Et un montant IIC <montant IIC>
      Exemples:
        | Test | type valeur | valeur totale | capit selon estim | taux exo IIC | montant soumis IIC | taux iic | montant IIC | Observation                                                       |
        | 1    | TERRAIN     | 50000         | 50000             | (90%)        | 5000               | 1‰       | 5           | le montant soumis IIC et le montant IIC sont calculé correctement |
        | 2    | TERRAIN     | 50000         | 50000             | (90%)        | 5000               | 0.5‰     | 2.50        | quand le taux iic varie, le montant IIC varie                     |

    @PM @batimentOuTerrain @montants @montantSoumisIIC @montantIIC
    Plan du Scénario: Calculer le montant soumis à l'IIC et le montant IIC pour une valeur immobilière Bâtiment ou Terrain PM (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable PM
      Et que le taux IIC par défaut paramétré pour les PM <usage> est de <taux IIC parametre> pour cette année fiscale
      Et que la valeur immobilière pour cet assujettissement est de type <type valeur>
      Et a une valeur totale <valeur totale>
      Et a une part d'usage 1/1
      Et a un usage <usage>
      Et a une part de responsabilite 1/1
      Et a les taux exo FORTUNE: (0%)
      Et a aussi les taux exo IIC: <taux exo IIC>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le montant du capital selon estimation <capit selon estim>
      Et un montant soumis à l'IIC <montant soumis IIC>
      Et un montant IIC <montant IIC>
      Exemples:
        | Test | type valeur | valeur totale | capit selon estim | taux exo IIC | montant soumis IIC | usage   | taux IIC parametre | montant IIC | Observation                                                                   |
        | 1    | BATIMENT    | 50000         | 50000             | (90%)        | 5000               | OCCUPE  | 2‰                 | 10          | montant soumis IIC et montant IIC calculés correctement                       |
        | 2    | BATIMENT    | 50000         | 50000             | (75%, 28%)   | 12500              | LOUE    | 2.5‰               | 31.25       | quand le taux exo IIC varie, le montant soumis IIC et le montant IIC varient  |
        | 3    | BATIMENT    | 25000         | 25000             | (90%)        | 2500               | LOUE    | 2.2‰               | 5.50        | quand la valeur totale varie, le montant soumis IIC et le montant IIC varient |
        | 4    | BATIMENT    | 51234         | 51234             | (93%)        | 3586.40            | OCCUPE  | 3‰                 | 10.75       | en cas de calcul inexact, les montants sont arrondis suivant la règle         |

    @PP @etatLocatif @montants @montantSoumisIIC @montantIIC
    Plan du Scénario: Calculer le montant soumis à l'IIC et le montant IIC pour une valeur immobilière Etat locatif PP (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable PP
      Et que le taux IIC pour les PP est paramétré à <taux iic> pour cette année fiscale
      Et que la valeur immobilière pour cet assujettissement est de type ETAT_LOCATIF
      Et a une part de responsabilite 1/1
      Et a les taux exo FORTUNE: (0%)
      Et a aussi les taux exo IIC: <taux exo IIC>
      Et a un taux de capitalisation 10%
      Et a un montant de l'état locatif <montant etat locatif vi>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec un montant de l'état des loyers capitalisés <etat loyers capt>
      Et un montant soumis à l'IIC <montant soumis IIC>
      Et un montant IIC <montant IIC>
      Exemples:
        | Test | montant etat locatif vi | taux exo IIC | etat loyers capt | montant soumis IIC | taux iic | montant IIC | Observation                                                       |
        | 1    | 2000                    | (90%)        | 20000            | 2000               | 1‰       | 2           | le montant soumis IIC et le montant IIC sont calculé correctement |
        | 2    | 2000                    | (90%)        | 20000            | 2000               | 0.5‰     | 1           | quand le taux iic varie, le montant IIC varient                   |

    @PM @etatLocatif @montants @montantSoumisIIC @montantIIC
    Plan du Scénario: Calculer le montant soumis à l'IIC et le montant IIC pour une valeur immobilière Etat locatif PM (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable PM
      Et que le taux IIC par défaut paramétré pour les PM <usage> est de <taux IIC parametre> pour cette année fiscale
      Et que la valeur immobilière pour cet assujettissement est de type ETAT_LOCATIF
      Et a un usage <usage>
      Et a une part de responsabilite 1/1
      Et a les taux exo FORTUNE: (0%)
      Et a aussi les taux exo IIC: <taux exo IIC>
      Et a un taux de capitalisation 10%
      Et a un montant de l'état locatif <montant etat locatif vi>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec un montant de l'état des loyers capitalisés <etat loyers capt>
      Et un montant soumis à l'IIC <montant soumis IIC>
      Et un montant IIC <montant IIC>
      Exemples:
        | Test | montant etat locatif vi | taux exo IIC | etat loyers capt | montant soumis IIC | usage   | taux IIC parametre | montant IIC | Observation                                                                             |
        | 1    | 2000                    | (90%)        | 20000            | 2000               | OCCUPE  | 2‰                 | 4           | montant soumis IIC et montant IIC calculés correctement                                 |
        | 2    | 2000                    | (75%, 28%)   | 20000            | 5000               | OCCUPE  | 3‰                 | 15          | quand le taux exo IIC varie, le montant soumis IIC et le montant IIC varient            |
        | 3    | 4000                    | (90%)        | 40000            | 4000               | LOUE    | 1‰                 | 4           | quand le montant etat locatif vi varie, le montant soumis IIC et le montant IIC varient |

  Règle: R6 - Calculer le taux d'abattement
  - Le taux d’abattement est calculé uniquement pour les valeurs immobilières BTR pour un usage OCCUPE concernant une PP
  - Le nombre d'années d'occupation = minimum (10 ans, année_fin_assuj - année_date_occupation + 1)
  - Taux d'abattement = taux d'abattement annuel * nombre d'années d'occupation
  - Exception : Si la valeur immobilière est un revenu agricole ou une fortune agricole (i.e. avec une unité de prix égale à "valeur de rendement")
  -- alors le taux d'abattement est absent

    @tauxAbattement @montants @PP @batimentOuTerrain @revenu
    Plan du Scénario: Calculer le taux d'abattement (<Test> - <Observation>)
      Etant donné un assujettissement <période assuj> pour l'année fiscale 2020 pour un contribuable seul PP
      Et que le plafond d'abattement est paramétré à <plafond abattement>
      Et que la valeur immobilière pour cet assujettissement est de type <type valeur>
      Et a une période de validité <période assuj>
      Et a un usage <type usage> avec une date d'occupation <date occupation>
      Et a un batiment ou terrain avec une unité de prix <unité prix>
      Et que le taux d'abattement annuel paramétré pour les PP est de <taux abattement annuel> pour cette année fiscale
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le taux d'abattement <taux abattement>
      #TODO AFCTAXIMMO-446 ajouter et vérifier colonne de calcul intermédiaire : nombre d'années d'occupation
      Exemples:
        | Test | période assuj               | type usage    | type valeur | unité prix          | date occupation | taux abattement annuel | plafond abattement | taux abattement | Observation                                                                                                                                      |
        | 1    | du 01.01.2020 au 31.12.2020 | OCCUPE        | BATIMENT    | PRIX_ESTIME         | 01.01.2019      | 4%                     | 40%                | 8%              | La valeur immobilière est occupée depuis 1 an                                                                                                    |
        | 2    | du 01.01.2020 au 31.12.2020 | OCCUPE        | BATIMENT    | PRIX_ESTIME         | 12.04.2014      | 4%                     | 40%                | 28%             | La valeur immobilière est occupée depuis 6 an                                                                                                    |
        | 3    | du 01.01.2020 au 31.12.2020 | OCCUPE        | QVL         | PRIX_ESTIME         | 03.02.1960      | 4%                     | 40%                | 40%             | La valeur immobilière est occupée depuis 60 ans -> plafond abattement à 40%                                                                      |
        | 4    | du 01.01.2020 au 31.12.2020 | OCCUPE        | TERRAIN     | VALEUR_DE_RENDEMENT | 03.02.1960      | 4%                     | 40%                | 0%              | La valeur immobilière a une unité de prix "valeur de rendement" -> taux d'abattement absent                                                      |
        | 5    | du 01.01.2020 au 31.12.2020 | LOUE          | BATIMENT    | PRIX_ESTIME         |                 | 4%                     | 40%                |                 | La valeur immobilière a un type d'usage LOUE                                                                                                     |
        | 6    | du 01.01.2020 au 31.12.2020 | PROFESSIONNEL | BATIMENT    | PRIX_ESTIME         |                 | 4%                     | 40%                |                 | La valeur immobilière a un type d'usage PROFESSIONNEL                                                                                            |
        | 7    | du 01.01.2020 au 31.12.2020 | IMPRODUCTIF   | TERRAIN     | PRIX_ESTIME         |                 | 4%                     | 40%                |                 | La valeur immobilière a un type d'usage IMPRODUCTIF                                                                                              |
        | 8    | du 01.01.2020 au 01.10.2020 | OCCUPE        | BATIMENT    | PRIX_ESTIME         | 01.11.2019      | 4%                     | 40%                | 8%              | La valeur immobilière est occupée depuis moins d'un an                                                                                           |
        | 9    | du 01.01.2020 au 31.12.2020 | OCCUPE        | BATIMENT    | PRIX_ESTIME         | 01.01.2019      | 5%                     | 40%                | 10%             | Le taux d'abattement annuel change et le taux abattement change en fonction                                                                      |
        | 10   | du 01.01.2020 au 31.12.2020 | OCCUPE        | BATIMENT    | PRIX_ESTIME         | 03.02.1960      | 5%                     | 40%                | 40%             | La valeur immobilière est occupée depuis 60 ans + de taux d’abattement annuel à 5% + plafond abattement à 40% -> l’abattement est plafonné à 40% |
        | 11   | du 01.01.2020 au 31.12.2020 | OCCUPE        | BATIMENT    | PRIX_ESTIME         | 03.02.1960      | 5%                     | 50%                | 50%             | La valeur immobilière est occupée depuis 60 ans + de taux d’abattement annuel à 5% + plafond abattement à 40%-> l’abattement est plafonné à 50%  |

    @tauxAbattement @montants @QVL @agricole
    Plan du Scénario: Calculer le taux d'abattement (<Test> - <Observation>)
      Etant donné un assujettissement <période assuj> pour l'année fiscale 2020 pour un contribuable seul PP
      Et que le plafond d'abattement est paramétré à 40%
      Et que la valeur immobilière pour cet assujettissement est de type <type valeur>
      Et est agricole
      Et a une période de validité <période assuj>
      Et a un usage OCCUPE avec une date d'occupation <date occupation>
      Et a un batiment ou terrain avec une unité de prix <unité prix>
      Et que le taux d'abattement annuel paramétré pour les PP est de <taux abattement annuel> pour cette année fiscale
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le taux d'abattement <taux abattement>

      Exemples:
        | Test | période assuj               | type valeur | unité prix  | date occupation | taux abattement annuel | taux abattement | Observation                                                                      |
        | 1    | du 01.01.2020 au 31.12.2020 | QVL         | PRIX_ESTIME | 03.02.1960      | 4%                     | 0%              | La valeur immobilière est QVL agricole => on ne calcule pas le taux d’abattement |

  Règle: R7 - Calculer le capital après abattement
  - Le capital après abattement est calculé uniquement pour les valeurs immobilières BTR pour un usage OCCUPE concernant une PP
  - Capital = capital selon estimation (voir R1) OU état des loyers capitalisés (voir R2)
  - Capital après abattement = Capital * (100% - taux d'abattement (voir R4)) (arrondi au franc près, voir règle F1.R1)
  - Exception : Si la valeur immobilière est une fortune agricole (i.e. avec une unité de prix égale à "valeur de rendement") alors
  -- Capital après abattement = Capital

    @PP @batimentOuTerrain @montants @capitalApresAbattement
    Plan du Scénario: Calculer le capital après abattement pour les valeurs immobilières Bâtiment ou Terrain (<Test> - <Observation>)
      Etant donné un assujettissement pour toute l'année fiscale 2020 pour un contribuable seul PP
      Et que le taux d'abattement annuel paramétré pour les PP est de 4% pour cette année fiscale
      Et que le plafond d'abattement est paramétré à 40%
      Et que la valeur immobilière pour cet assujettissement est de type <type valeur>
      Et a un usage <type usage> avec une date d'occupation <date occupation> et une part 1/1
      Et a une part de responsabilite 1/1
      Et a un batiment ou terrain avec une unité de prix <unité prix>
      Et a les taux exo FORTUNE: <taux exo> depuis l'année 2020
      Et a une valeur totale <valeur totale>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail <code taxation> avec le montant du capital selon estimation <capit selon estim>
      Et le taux d'abattement <taux abattement>
      Et le capital après abattement <capit apres abatt>
      Exemples:
        | Test | type usage    | type valeur | unité prix          | taux exo | valeur totale | date occupation | capit selon estim | code taxation | taux abattement | capit apres abatt | Observation                                                                                                        |
        | 1    | OCCUPE        | BATIMENT    | PRIX_ESTIME         | (0%)     | 100000        | 01.01.2019      | 100000            | 15.10         | 8%              | 92000             | Le capital après abattement est calculé correctement en fonction du capital selon estimation et du taux abattement |
        | 2    | OCCUPE        | BATIMENT    | PRIX_ESTIME         | (0%)     | 200000        | 01.01.2019      | 200000            | 15.10         | 8%              | 184000            | Le capital après abattement varie quand le capital selon estimation varie                                          |
        | 3    | OCCUPE        | BATIMENT    | PRIX_ESTIME         | (0%)     | 100000        | 03.02.1960      | 100000            | 15.10         | 40%             | 60000             | Le capital après abattement varie quand la date occupation varie                                                   |
        | 4    | OCCUPE        | BATIMENT    | PRIX_ESTIME         | (0%)     | 333333        | 01.01.2019      | 333333            | 15.10         | 8%              | 306666            | Le capital après abattement est arrondi au franc près                                                              |
        | 5    | OCCUPE        | TERRAIN     | VALEUR_DE_RENDEMENT | (0%)     | 333333        | 01.01.2019      | 333333            | 15.10         | 0%              | 333333            | Exception à la règle : le capital après abattement est valorisé avec le montant de capital selon estimation        |
        | 6    | LOUE          | TERRAIN     | VALEUR_DE_RENDEMENT | (0%)     | 333333        | 01.01.2019      | 333333            | 15.20         |                 |                   | le capital après abattement n'est pas valorisé si usage LOUE malgré l'unité de prix valeur de rendement            |
        | 7    | LOUE          | BATIMENT    | PRIX_ESTIME         | (0%)     | 333333        |                 | 333333            | 15.20         |                 |                   | Le capital après abattement est arrondi au franc près                                                              |
        | 8    | PROFESSIONNEL | BATIMENT    | PRIX_ESTIME         | (0%)     | 333333        |                 | 333333            | 15.30         |                 |                   | Le capital après abattement est arrondi au franc près                                                              |
        | 9    | IMPRODUCTIF   | TERRAIN     | PRIX_ESTIME         | (0%)     | 333333        |                 | 333333            | 15.20         |                 |                   | Le capital après abattement est arrondi au franc près                                                              |
        | 10   | OCCUPE        | BATIMENT    | PRIX_ESTIME         | (100%)   | 100000        | 01.01.2019      | 100000            | 15.40         | 8%              | 92000             | Le capital après abattement est calculé correctement en fonction du capital selon estimation et du taux abattement |

  Règle: R8 - Calculer le nombre de jours du questionnaire dans une période de validité d'une valeur immobilière
  - Il faut compter 30 jours pour tous les mois de l'année
  - Nb jours = ((anneeFin vi - anneeDebut vi) * 12 + (moisFin vi - moisDebut vi)) * 30 + min(jourFin vi, 30) - jourDebut vi + 1

    @PP @PM @nbJoursQuestionnaire
    Plan du Scénario: Calculer le nombre de jours du questionnaire dans une période de validité d'une valeur immobilière égale à la période s'assuj (<Test> - <Observation>)
      Etant donné un assujettissement <periode vi et assuj> pour l'année fiscale 2020 pour un contribuable seul <type personne>
      Et que la valeur immobilière pour cet assujettissement est de type <type vi>
      Et a une période de validité <periode vi et assuj>
      Et a un usage OCCUPE
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le nombre de jours du questionnaire <nombre jours questionnaire>
      Exemples:
        | Test | type personne | type vi  | periode vi et assuj         | nombre jours questionnaire | Observation                                                                   |
        | 1    | PP            | BATIMENT | du 01.01.2020 au 31.12.2020 | 360                        | Nombre de jour du questionnaire pour une année complète                       |
        | 2    | PM            | BATIMENT | du 01.01.2020 au 15.03.2021 | 435                        | Nombre de jour du questionnaire pour une période qui dépasse 1 année complète |
        | 3    | PP            | BATIMENT | du 01.01.2020 au 01.01.2020 | 1                          | Nombre de jour du questionnaire pour une période sur un jour                  |
        | 4    | PP            | BATIMENT | du 01.01.2020 au 31.01.2020 | 30                         | Nombre de jour du questionnaire pour une période sur un mois                  |
        | 5    | PP            | BATIMENT | du 01.01.2020 au 01.02.2020 | 31                         | Nombre de jour du questionnaire pour une période sur deux mois                |
        | 6    | PP            | BATIMENT | du 31.01.2020 au 01.02.2020 | 2                          | Nombre de jour du questionnaire pour une période sur un deux mois             |

    @PP @nbJoursQuestionnaire
    Plan du Scénario: Calculer le nombre de jours du questionnaire dans une période de validité d'une valeur immobilière différente de la période d'assuj (<Test> - <Observation>)
      Etant donné un assujettissement <periode assuj> pour l'année fiscale 2020 pour un contribuable seul <type personne>
      Et que la valeur immobilière pour cet assujettissement est de type <type vi>
      Et a une période de validité <periode vi>
      Et a un usage OCCUPE
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le nombre de jours du questionnaire <nombre jours questionnaire>
      Exemples:
        | Test | type personne | type vi | periode assuj               | periode vi                  | nombre jours questionnaire | Observation                                                                                                  |
        | 1    | PP            | QVL     | du 01.01.2020 au 31.12.2020 | du 01.01.2020 au 28.12.2020 | 358                        | Nombre de jour du questionnaire pour une période de validité de valeur immo différente de la période d'assuj |

  Règle: R9 - Calculer le revenu IFD et l'entretien IFD pour les valeurs immobilières Revenu non agricoles pour les PP et pour les PM
  - PartOccupationForceeOuUsage = (part d'occupation forcée si elle est renseignée ou part d'usage sinon) * part de responsabilite
  - Part Jours = NbJourQuest (voir R6) / 360
  - taux revenu applicable =
  -- Taux taxable revenu, pour les lignes 15.10 (rappel: Taux taxable revenu = 100% - taux exo revenu)
  -- Taux exo revenu, pour les lignes 15.40
  - Revenu IFD =  valeur totale * PartOccupationForceeOuUsage * taux revenu applicable * Part Jours pour les 15.10 et 15.40
  - Revenu IFD =  valeur totale * PartOccupationForceeOuUsage * Part Jours, pour les 3.1 et 3.2
  - Le revenu IFD est arrondi au franc près à l'affichage (voir règle F1.R1)
  - Entretien IFD =
  -- Revenu IFD * taux IFD
  -- OU inexistant si QVL agricole
  - L'entretien IFD est arrondi au franc près à l'affichage (voir règle F1.R1)

    @PP @montants @revenuIFD @entretienIFD @revenu
    Plan du Scénario: Calculer revenu IFD et l'entretien IFD (<Test> - <Observation>)
      Etant donné un assujettissement <periode assuj> pour l'année fiscale 2020 pour un contribuable seul PP
      Et que la valeur immobilière pour cet assujettissement est de type QVL
      Et a une période de validité <periode vi>
      Et a une valeur totale <valeur totale>
      Et a un usage OCCUPE
      Et a une part d'usage <part usage>
      Et a une part de responsabilite <part responsabilite>
      Et a aussi les taux exo REVENU: (0%)
      Et a un taux IFD <taux IFD> et a un taux ICC 0% et une part d'occupation forcée <part occup forcee> et n’est pas agricole
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le nombre de jours du questionnaire <nb jour quest>
      Et cette ligne détail a un taux TAXABLE REVENU 100%
      Et avec le revenu IFD <revenu IFD>
      Et avec le revenu IFD arrondi <revenu IFD arrondi>
      Et avec l'entretien IFD <entretien IFD>
      Et avec l'entretien IFD arrondi <entretien IFD arrondi>
      Exemples:
        | Test | periode assuj               | periode vi                  | valeur totale | part usage | part occup forcee | part responsabilite | taux IFD | nb jour quest | revenu IFD | revenu IFD arrondi | entretien IFD | entretien IFD arrondi | Observation                                                                                                     |
        | 1    | du 01.01.2020 au 31.12.2020 | du 01.01.2020 au 31.12.2020 | 1000          | 1/1        | 1/2               | 1/1                 | 20%      | 360           | 500        | 500                | 100           | 100                   | revenu IFD et l'entretien IFD  calculés correctement                                                            |
        | 2    | du 01.01.2020 au 31.12.2020 | du 01.01.2020 au 31.12.2020 | 1000          | 1/2        |                   | 1/1                 | 20%      | 360           | 500        | 500                | 100           | 100                   | quand la part usage * part bien impo si pas de part occ forcéee varie, le revenu IFD et l'entretien IFD varient |
        | 3    | du 01.01.2020 au 31.12.2020 | du 01.01.2020 au 31.12.2020 | 2000          | 1/1        | 1/2               | 1/1                 | 20%      | 360           | 1000       | 1000               | 200           | 200                   | quand la valeur totale varie, le revenu IFD et l'entretien IFD varient                                          |
        | 4    | du 01.01.2020 au 31.12.2020 | du 01.01.2020 au 30.06.2020 | 1000          | 1/1        | 1/2               | 1/1                 | 20%      | 180           | 250        | 250                | 50            | 50                    | quand le de nb jour quest varie, le revenu IFD et l'entretien IFD varient                                       |
        | 5    | du 01.01.2020 au 31.12.2020 | du 01.01.2020 au 31.12.2020 | 1000          | 1/1        | 1/3               | 1/1                 | 20%      | 360           | 333.33     | 333                | 66.67         | 67                    | revenu IFD et l'entretien IFD non entiers                                                                       |
        | 6    | du 01.01.2020 au 31.12.2020 | du 01.01.2020 au 31.12.2020 | 1000          | 1/1        | 1/3               | 1/2                 | 20%      | 360           | 166.67     | 167                | 33.33         | 33                    | quand la part bien imposable varie, le revenu IFD et l'entretien IFD varient                                    |
        | 7    | du 01.01.2020 au 31.12.2020 | du 01.01.2020 au 31.12.2020 | 1000.1        | 1/1        | 1/1               | 1/2                 | 20%      | 360           | 500.05     | 500                | 100.01        | 100                   | quand la part bien imposable varie, le revenu IFD et l'entretien IFD varient                                    |


    @PM @montants @revenuIFD @entretienIFD @revenu
    Plan du Scénario: Calculer revenu IFD et l'entretien IFD (<Test> - <Observation>)
      Etant donné un assujettissement <periode assuj> pour l'année fiscale 2020 pour un contribuable seul PM
      Et que la valeur immobilière pour cet assujettissement est de type QVL
      Et a une période de validité <periode vi>
      Et a une valeur totale <valeur totale>
      Et a un usage OCCUPE
      Et a une part d'usage <part usage>
      Et a une part de responsabilite <part responsabilite>
      Et a aussi les taux exo REVENU: (0%)
      Et a un taux IFD <taux IFD> et a un taux ICC 0% et une part d'occupation forcée <part occup forcee> et n’est pas agricole
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le nombre de jours du questionnaire <nb jour quest>
      Et avec le revenu IFD <revenu IFD>
      Et avec le revenu IFD arrondi <revenu IFD arrondi>
      Et avec l'entretien IFD <entretien IFD>
      Et avec l'entretien IFD arrondi <entretien IFD arrondi>
      Exemples:
        | Test | periode assuj               | periode vi                  | valeur totale | part usage | part occup forcee | part responsabilite | taux IFD | nb jour quest | revenu IFD | revenu IFD arrondi | entretien IFD | entretien IFD arrondi | Observation                                                                                                     |
        | 1    | du 01.01.2020 au 31.12.2020 | du 01.01.2020 au 31.12.2020 | 1000          | 1/1        | 1/2               | 1/1                 | 20%      | 360           | 500        | 500                | 100           | 100                   | revenu IFD et l'entretien IFD  calculés correctement                                                            |
        | 2    | du 01.01.2020 au 31.12.2020 | du 01.01.2020 au 31.12.2020 | 1000          | 1/2        |                   | 1/1                 | 20%      | 360           | 500        | 500                | 100           | 100                   | quand la part usage * part bien impo si pas de part occ forcéee varie, le revenu IFD et l'entretien IFD varient |




  Règle: R10 - Calculer le revenu ICC et l'entretien ICC pour les valeurs immobilières Revenu non agricoles pour les PP
  - Revenu ICC =
  -- Revenu IFD (voir R7) * (100% - taux abattement (voir R4))
  -- OU Revenu IFD (voir R7), si pas de taux d'abattement
  - Le revenu ICC est arrondi au franc près à l'affichage (voir règle F1.R1)
  - Entretien ICC =
  -- Revenu ICC * taux ICC
  -- OU inexistant si QVL agricole
  - L'entretien ICC est arrondi au franc près à l'affichage (voir règle F1.R1)

    @PP @montants @revenuICC @entretienICC @revenu
    Plan du Scénario: Calculer revenu ICC et l'entretien ICC (<Test> - <Observation>)
      Etant donné un assujettissement pour toute l'année fiscale 2020 pour un contribuable seul PP
      Et que le taux d'abattement annuel paramétré pour les PP est de 4% pour cette année fiscale
      Et que le plafond d'abattement est paramétré à 40%
      Et que la valeur immobilière pour cet assujettissement est de type QVL
      Et a une valeur totale <valeur totale>
      Et a un taux IFD 20% et a un taux ICC <taux ICC> et une part d'occupation forcée 1/1 et n’est pas agricole
      Et a les taux exo REVENU: (0%)
      Et a un usage OCCUPE avec une date d'occupation <date occupation>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le taux d'abattement <taux abattement>
      Et avec le revenu IFD <revenu IFD>
      Et avec le revenu ICC <revenu ICC>
      Et avec le revenu ICC arrondi <revenu ICC arrondi>
      Et avec l'entretien ICC <entretien ICC>
      Et avec l'entretien ICC arrondi <entretien ICC arrondi>
      Exemples:
        | Test | valeur totale | taux ICC | date occupation | taux abattement | revenu IFD | revenu ICC | revenu ICC arrondi | entretien ICC | entretien ICC arrondi | Observation                                                                |
        | 1    | 100000        | 20%      | 01.01.2019      | 8%              | 100000     | 92000      | 92000              | 18400         | 18400                 | revenu ICC et l'entretien ICC calculés correctement                        |
        | 2    | 100000        | 50%      | 01.01.2019      | 8%              | 100000     | 92000      | 92000              | 46000         | 46000                 | quand le taux ICC varie, le revenu ICC et l'entretien ICC varient          |
        | 3    | 100000        | 20%      | 01.01.1960      | 40%             | 100000     | 60000      | 60000              | 12000         | 12000                 | quand le taux d’abattement varie, le revenu ICC et l'entretien ICC varient |
        | 4    | 50000         | 20%      | 01.01.2019      | 8%              | 50000      | 46000      | 46000              | 9200          | 9200                  | quand le revenu IFD varie, le revenu ICC et l'entretien ICC varient        |
        | 5    | 22487         | 20%      | 01.01.2019      | 8%              | 22487      | 20688.04   | 20688              | 4137.61       | 4138                  | quand le revenu IFD varie, le revenu ICC et l'entretien ICC varient        |

    @PP @montants @revenuIFD @revenuICC @QVL @agricole
    Plan du Scénario: Calculer revenu IFD et revenu ICC (<Test> - <Observation>)
      Etant donné un assujettissement pour toute l'année fiscale 2020 pour un contribuable seul PP
      Et que la valeur immobilière pour cet assujettissement est de type QVL
      Et a une période de validité <periode vi>
      Et a une valeur totale <valeur totale>
      Et a un usage OCCUPE avec une part <part usage>
      Et a une part de responsabilite <part responsabilite>
      Et a les taux exo REVENU: (0%)
      Et est agricole et a une part d'occupation forcée <part occup forcee>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le nombre de jours du questionnaire <nb jour quest>
      Et avec le revenu IFD <revenu IFD>
      Et avec le revenu ICC <revenu ICC>
      Et avec l'entretien ICC vide
      Et avec l'entretien IFD vide
      Exemples:
        | Test | periode vi                  | valeur totale | part usage | part occup forcee | part responsabilite | nb jour quest | revenu IFD | revenu ICC | Observation                                                                                                |
        | 1    | du 01.01.2020 au 31.12.2020 | 1000          | 1/1        | 1/2               | 1/1                 | 360           | 500        | 500        | revenu IFD et revenu ICC calculés correctement                                                             |
        | 2    | du 01.01.2020 au 31.12.2020 | 1000          | 1/2        |                   | 1/1                 | 360           | 500        | 500        | quand la part usage * part bien impo si pas de part occ forcéee varie, le revenu IFD et revenu ICC varient |
        | 3    | du 01.01.2020 au 30.06.2020 | 1000          | 1/1        | 1/2               | 1/1                 | 180           | 250        | 250        | quand le de nb jour quest varie, le revenu IFD et revenu ICC varient                                       |
