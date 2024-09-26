#language: fr
Fonctionnalité: Validation des retenues d'une liste récapitulative de prestations en capital

  Contexte:
    Etant donné que l´année fiscale de la déclaration est 2021

  Règle: La validation des retenues d'une LR PRESTATIONS_EN_CAPITAL doit être prise en compte dans la validation de la LR

    Contexte:
      Etant donné qu'un DPI PRESTATIONS_EN_CAPITAL est sélectionné
      Etant donné l´année en cours 2021

    Scénario: Validation d'une LR PRESTATIONS_EN_CAPITAL complète
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est valide

    Scénario: Validation d'une LR PRESTATIONS_EN_CAPITAL avec une retenue vide
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Etant donné que cette LR contient une retenue de prestations en capital vide
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est invalide à cause de ses retenues

  Règle: Afin d'être valide, une retenue PRESTATIONS_EN_CAPITAL doit satisfaire les critères suivants
  - La date d'échéance est obligatoire
  - Le motif est obligatoire
  - Le montant de la prestation transmise est obligatoire
  - Le taux d'imposition ICC est obligatoire
  - Le montant d'impôt ICC est obligatoire
  - Le montant d'impôt IFD est obligatoire
  - L'observation est facultatif
  - Le montant des prestations soumises doit être un nombre entier sans décimaux

    Plan du scénario: Validation retenue PRESTATIONS_EN_CAPITAL - Validation des champs <Test> -> <Description scenario>
      Etant donné que la date du jour est 01.01.2021
      Etant donné que l´année fiscale de la déclaration est 2021
      Etant donné une retenue de prestations en capital complète
      Etant donné que la date d'échéance de cette retenue a la valeur <date échéance>
      Etant donné que le motif de cette retenue a la valeur <motif>
      Etant donné que le montant de la prestation soumise à l'impôt de cette retenue a la valeur <Prestations soumises>
      Etant donné que le taux d'imposition ICC de cette retenue a la valeur <taux imposition>
      Etant donné que le montant d'impôt ICC de cette retenue a la valeur <montant ICC>
      Etant donné que le montant d'impôt IFD de cette retenue a la valeur <montant IFD>
      Etant donné que l'observation de cette retenue a la valeur <observation>
      Quand l'utilisateur valide cette retenue
      Alors le système indique que cette retenue est <Résultat>
      Exemples:
        | Test | date échéance | motif                  | Prestations soumises | taux imposition | montant ICC | montant IFD | observation     | Résultat                                      | Description scenario                    |
        | 1    | 01.01.2021    | RETRAITE_OU_INVALIDITE | 10000                | 17              | 100         | 10          | une observation | valide                                        | Tous les champs sont remplis et valides |
        | 2    |               | RETRAITE_OU_INVALIDITE | 10000                | 17              | 100         | 10          | une observation | invalide à cause d'une information manquante  | Date échéance manquante                 |
        | 3    | 01.01.2021    |                        | 10000                | 17              | 100         | 10          | une observation | invalide à cause d'une information manquante  | Motif manquant                          |
        | 4    | 01.01.2021    | RETRAITE_OU_INVALIDITE |                      | 17              | 100         | 10          | une observation | invalide à cause d'une information manquante  | Prestations soumises manquantes         |
        | 5    | 01.01.2021    | RETRAITE_OU_INVALIDITE | 10000                |                 | 100         | 10          | une observation | invalide à cause d'une information manquante  | Taux imposition manquant                |
        | 6    | 01.01.2021    | RETRAITE_OU_INVALIDITE | 10000                | 17              |             | 10          | une observation | invalide à cause d'une information manquante  | Montant impôt ICC manquant              |
        | 7    | 01.01.2021    | RETRAITE_OU_INVALIDITE | 10000                | 17              | 100         |             | une observation | invalide à cause d'une information manquante  | Montant impôt IFD manquant              |
        | 8    | 01.01.2021    | RETRAITE_OU_INVALIDITE | 10000                | 17              | 100         | 10          |                 | valide                                        | Observation manquante                   |
        | 9    | 01.01.2021    | RETRAITE_OU_INVALIDITE | 123.45               | 17              | 100         | 10          | une observation | invalide car le montant est un nombre décimal | Prestations soumises avec décimaux      |
        | 10   | 01.01.2021    | RETRAITE_OU_INVALIDITE | 10000                | 17              | -100        | 10          | une observation | invalide car le montant est négatif           | Montant ICC négatif                     |
        | 11   | 01.01.2021    | RETRAITE_OU_INVALIDITE | 10000                | 17              | 100         | -10         | une observation | invalide car le montant est négatif           | Montant IFD négatif                     |


  Règle: la date d'échéance pour les prestations en capital doit satisfaire les critères suivants:
  - doit être comprise entre (01.12.Année_Fiscale - 1) et la date du jour de l'année fiscale concernée
  - ou entre (01.12.Année_Fiscale - 1) et 31.12.Année_Fiscale si l'année de la date du jour est supérieure à l'année fiscale

    Plan du scénario: Validation date d'échéance PRESTATIONS_EN_CAPITAL - Validation des champs <Test> -> <Description scenario>
      Etant donné que la date du jour est <date du jour>
      Etant donné une retenue de prestations en capital complète
      Etant donné que la date d'échéance de cette retenue a la valeur <date échéance>
      Quand l'utilisateur valide cette retenue
      Alors le système indique que cette retenue est <Résultat>
      Exemples:
        | Test | date du jour | date échéance | Résultat                                            | Description scenario                                                                       |
        | 1    | 30.03.2021   | 31.03.2021    | invalide à cause de la règle sur la date d'échéance | Date d'échéance après la date du jour                                                      |
        | 2    | 30.03.2021   | 30.03.2021    | valide                                              | Date d'échéance égale à la date du jour                                                    |
        | 3    | 30.03.2021   | 29.03.2021    | valide                                              | Date d'échéance avant la date du jour                                                      |
        | 4    | 30.03.2021   | 31.03.2022    | invalide à cause de la règle sur la date d'échéance | Date d'échéance après l'année fiscale                                                      |
        | 5    | 30.03.2021   | 01.12.2020    | valide                                              | Date d'échéance 01.12.AnnéeFiscale-1 (cas limite - premiere date valide)                   |
        | 6    | 30.03.2021   | 30.11.2020    | invalide à cause de la règle sur la date d'échéance | Date d'échéance 30.11.AnnéeFiscale-1 (cas limite - premiere date invalide)                 |
        | 7    | 30.03.2022   | 01.01.2021    | valide                                              | Année courante supérieure à l'année fiscale avec date d'échéance dans l'année fiscale      |
        | 8    | 30.03.2022   | 01.12.2020    | valide                                              | Année courante supérieure à l'année fiscale avec date d'échéance au 01.12.AnnéeFiscale-1   |
        | 9    | 30.03.2022   | 30.11.2020    | invalide à cause de la règle sur la date d'échéance | Année courante supérieure à l'année fiscale avec date d'échéance au 30.11.AnnéeFiscale-1   |
        | 10   | 30.03.2023   | 01.12.2020    | valide                                              | Année courante 2 années après l'année fiscale avec date d'échéance au 01.12.AnnéeFiscale-1 |
        | 11   | 30.03.2023   | 30.11.2020    | invalide à cause de la règle sur la date d'échéance | Année courante 2 années après l'année fiscale avec date d'échéance au 30.11.AnnéeFiscale-1 |
        | 12   | 30.03.2023   | 01.01.2022    | invalide à cause de la règle sur la date d'échéance | Année courante 2 années après l'année fiscale avec date d'échéance après l'année fiscale   |

  Règle: Lorsque le montant des prestations soumises à l'impôt est supérieur à Fr. 17'800.-, la retenue IS doit être supérieure à zéro.

    Plan du scénario: Validation du montant de la retenue IS pour une retenue PRESTATIONS_EN_CAPITAL (<Test> -> <Description scénario>)
      Etant donné une retenue de prestations en capital complète
      Etant donné la date du jour est 01.02.2021
      Etant donné que la date d'échéance de cette retenue a la valeur 01.02.2021
      Etant donné que le montant de la prestation soumise à l'impôt de cette retenue a la valeur <Prestations soumises>
      Etant donné que le montant de la retenue IS de cette retenue a la valeur <Retenue IS>
      Quand l'utilisateur valide cette retenue
      Alors le système indique que cette retenue est <Résultat>
      Exemples:
        | Test | Prestations soumises | Retenue IS | Résultat                                      | Description scénario                                                                              |
        | 1    | 1                    |            | valide                                        | Retenue IS non renseignée pour des prestations soumises < limite                                  |
        | 2    | 17800                |            | valide                                        | Retenue IS non renseignée pour des prestations soumises = limite (cas limite)                     |
        | 3    | 19000                | 900        | valide                                        | Retenue IS renseignée pour des prestations soumises > limite                                      |
        | 4    | 17801                |            | invalide car la retenue IS doit être positive | Retenue IS non renseignée pour des prestations soumises juste au dessus de la limite (cas limite) |
        | 5    | 17801                | 0          | invalide car la retenue IS doit être positive | Retenue IS à zéro pour des prestations soumises juste au dessus de la limite (cas limite)         |
        | 6    | 19000                |            | invalide car la retenue IS doit être positive | Retenue IS non renseignée pour des prestations soumises > limite                                  |

  Règle: Le taux d'imposition ICC doit être compris entre 0 et 100 et ne doit comporter que 5 decimales au maximum.
    Plan du scénario: Validation du taux d'imposition ICC pour une retenue PRESTATIONS_EN_CAPITAL (<Test> -> <Description scénario> => <Résultat>)
      Etant donné une retenue de prestations en capital complète
      Etant donné la date du jour est 01.02.2021
      Etant donné que la date d'échéance de cette retenue a la valeur 01.02.2021
      Etant donné que le taux d'imposition ICC de cette retenue a la valeur <montant ICC>
      Quand l'utilisateur valide cette retenue
      Alors le système indique que cette retenue est <Résultat>
      Exemples:
        | Test | montant ICC | Résultat                                                          | Description scénario             |
        | 1    | 1           | valide                                                            | Taux imposition ICC à 1%         |
        | 2    | 10          | valide                                                            | Taux imposition ICC à 10%        |
        | 3    | 10.1        | valide                                                            | Taux imposition ICC à 10.1%      |
        | 4    | 10.12       | valide                                                            | Taux imposition ICC à 10.12%     |
        | 5    | 10.123      | valide                                                            | Taux imposition ICC à 10.123%    |
        | 6    | 10.1234     | valide                                                            | Taux imposition ICC à 10.1234%   |
        | 7    | 10.12345    | valide                                                            | Taux imposition ICC à 10.12345%  |
        | 8    | 10.123456   | invalide car un montant dépasse le nombre de décimales autorisé   | Taux imposition ICC à 10.123456% |
        | 9    | 0.00001     | valide                                                            | Taux imposition ICC à 0.00001%   |
        | 10   | 1.000000    | invalide car un montant dépasse le nombre de décimales autorisé   | Taux imposition ICC à 1.000000%  |
        | 11   | 0           | valide                                                            | Taux imposition ICC à 0%         |
        | 12   | -1          | invalide car un montant est inférieur au montant minimal autorisé | Taux imposition ICC à -1%        |
        | 13   | 101         | invalide car un montant est supérieur au montant maximal autorisé | Taux imposition ICC à 101%       |
        | 14   | 100.00001   | invalide car un montant est supérieur au montant maximal autorisé | Taux imposition ICC à 100.00001% |
        | 15   | 100.00000   | valide                                                            | Taux imposition ICC à 100.00000% |
        | 16   | 150         | invalide car un montant est supérieur au montant maximal autorisé | Taux imposition ICC à 150%       |
