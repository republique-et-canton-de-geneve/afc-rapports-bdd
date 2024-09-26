#language: fr
Fonctionnalité: Validation de la partie Retenues Mensuelles pour une déclaration de type Salarié

  Contexte:
    Etant donné que l´année fiscale en cours est 2021

  Règle: le <Barème ajusté> ne s'applique qu'aux barèmes A1-A5 et C0-C5

    Plan du scénario: Validation Retenue Mensuelle - Bareme ajusté <Test> -> <Observation>
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné que la date du jour est 31.01.2021
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que le salarié a <nombre d'enfants> enfant(s)
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
      Etant donné que cette personne a un barème avec la valeur <bareme> pour le mois Janvier
      Etant donné que cette personne a un barème ajusté avec la valeur <bareme ajuste> pour le mois Janvier
      Quand la validation est appliquée sur la retenue
      Alors le système renvoie que la retenue est <résultat>
      Exemples:
        | Test | nombre d'enfants | bareme | bareme ajuste | résultat                                     | Observation                             |
        | 1    | 1                | B1     | true          | invalide car le barème n'est pas ajustable   | Bareme ajusté true mais mauvais bareme  |
        | 2    | 0                | A0     | true          | invalide car le barème n'est pas ajustable   | Bareme ajusté true mais mauvais bareme  |
        | 3    | 1                | A1     | true          | valide                                       | Bareme ajusté true et barème A1         |
        | 4    | 1                | A1     | false         | valide                                       | Bareme ajusté false et barème A1        |
        | 5    | 1                | C1     | false         | valide                                       | Bareme ajusté false et bareme de type C |
        | 6    | 0                | C0     | true          | valide                                       | Bareme ajusté true et bareme de type C  |
        | 7    | 1                | C1     | true          | valide                                       | Bareme ajusté true et bareme de type C  |
        | 8    | 0                |        | true          | invalide à cause d'une information manquante | Bareme ajusté true et bareme null       |


  Règle: La validation du barème se déclenche que si le mois saisi est le dernier mois actif

    Plan du scénario: Validation Retenue Mensuelle - Cohérence du barème <Test> -> <Observation>
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est <date du jour>
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Alors le dernier mois actif est <dernier mois actif>
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.05.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
        | Février | 9000                 | 123                 | 700                 | 2400.53    | Acacias         | A1     | Non           |
        | Mars    | 9000                 |                     | 700                 | 2400.53    | Acacias         | A1     | Non           |
        | Avril   | 6000                 | 300                 | 100                 | 2200       | Genève          | A1     | Non           |
        | Mai     | 6000                 | 300                 | 100                 | 2200       | Genève          | A1     | Non           |
      Etant donné que cette personne a un barème avec la valeur <bareme> pour le mois <mois en saisie>
      Quand la validation est appliquée sur la retenue du mois <mois en saisie> avec le groupe de validation Informative
      Alors le système renvoie que la retenue est <résultat>
      Exemples:
        | Test | date du jour | dernier mois actif | mois en saisie | bareme | résultat                              | Observation                                                                           |
        | 1    | 31.05.2021   | Mai                | Mai            | A0     | valide                                | Barème cohérent                                                                       |
        | 2    | 15.05.2021   | Avril              | Avril          | A1     | invalide car le barème est incohérent | Barème incohérent, dernier mois est APRIL car date < 15 MAY                           |
        | 3    | 31.05.2021   | Mai                | Avril          | A1     | valide                                | Barème incohérent mais n'est pas la dernière retenue de la personne à la date du jour |
        | 4    | 31.05.2022   | Décembre           | Mai            | A1     | valide                                | Barème incohérent mais n'est pas la dernière retenue de la personne à la date du jour |


  Règle: validation des différents champs obligatoires des retenues mensuelles pour les Salariés
  - Le montant des prestations soumises doit être un nombre entier sans décimaux
  - Le montant apériodique doit être un nombre entier sans décimaux
  - Le montant determinant doit être un nombre entier sans décimaux

    Plan du Scénario: Validation des différents champs obligatoires des retenues mensuelles - <Test> -> <Observation>
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 31.01.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable <Type Contribuable> a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette personne a une retenues IS avec la valeur <retenues_is> pour le mois <mois>
      Etant donné que cette personne a des prestations soumises avec la valeur <prestation_soumises> pour le mois <mois>
      Etant donné que cette personne a des prestations non périodiques avec la valeur <prest_aperiodiques> pour le mois <mois>
      Etant donné que cette personne a un montant determinant avec la valeur <montantDeterminant> pour le mois <mois>
      Etant donné que cette personne a un barème avec la valeur <barème> pour le mois <mois>
      Etant donné que cette personne a un barème ajusté avec la valeur <barème_ajuste> pour le mois <mois>
      Etant donné que cette personne a un lieu de travail <type_lieu> pour le mois <mois>
      Quand la validation est appliquée sur la retenue
      Alors le système renvoie que la retenue est <résultat>
      Exemples:
        | Test | Type Contribuable | prestation_soumises | prest_aperiodiques | montantDeterminant | retenues_is | barème | barème_ajuste | type_lieu     | mois    | résultat                                           | Observation                                        |
        | 1    | SALARIE           | 2500                | 250                | 250                | 250.50      | A1     | FALSE         | GENEVE        | Janvier | valide                                             | Tous les champs renseignés                         |
        | 2    | SALARIE           |                     | 250                | 250                | 250.50      | A1     | FALSE         | GENEVE        | Janvier | invalide à cause d'une information manquante       | Prestations soumises non renseignés                |
        | 3    | SALARIE           | 2500                |                    | 250                | 250.50      | A1     | FALSE         | GENEVE        | Janvier | valide                                             | Prestations non périodes non renseigné             |
        | 4    | SALARIE           | 2500                | 250                |                    | 250.50      | A1     | FALSE         | GENEVE        | Janvier | invalide à cause d'une information manquante       | Montant determinant non renseigné                  |
        | 5    | SALARIE           | 2500                | 250                | 2500               |             | A1     | FALSE         | GENEVE        | Janvier | invalide à cause d'une information manquante       | RetenueIS non renseigné                            |
        | 6    | SALARIE           | 2500                | 250                | 2500               | 250.50      |        | FALSE         | GENEVE        | Janvier | invalide à cause d'une information manquante       | Barème non renseigné                               |
        | 7    | SALARIE           | 2500                | 250                | 2500               | 250.50      | A1     | FALSE         | NON_RENSEIGNE | Janvier | invalide à cause d'une information manquante       | Lieu de travail non renseigné                      |
        | 8    | SALARIE           | 2500                | 250                | 2500               | -250.50     | A1     | FALSE         | GENEVE        | Janvier | invalide car le montant est négatif pour Janvier   | Lieu de travail non renseigné                      |
        | 9    | SALARIE           | 0                   | 0                  | 2500               | 0           | A1     | FALSE         | GENEVE        | Janvier | valide                                             | Prestations soumises et retenue à 0                |
        | 10   | SALARIE           | 1                   | 0                  | 2500               | 0           | A1     | FALSE         | GENEVE        | Janvier | valide                                             | Prestations soumises renseignées et retenue à 0    |
        | 11   | SALARIE           | 1                   | 0                  | 0                  | 0           | A1     | FALSE         | GENEVE        | Janvier | invalide à cause d'un montant minimum non respecté | Montant determinant doit etre 1 au minimum         |
        | 12   | SALARIE           | 1                   | 0                  | 0                  | -1          | A1     | FALSE         | GENEVE        | Janvier | invalide à cause d'un montant minimum non respecté | Montant determinant doit etre 1 au minimum         |
        | 13   | ADMIN             | 2500                |                    |                    | 625.00      |        |               | GENEVE        | Janvier | valide                                             | Tous les champs renseignés                         |
        | 14   | ADMIN             |                     |                    |                    | 625.00      |        |               | GENEVE        | Janvier | invalide à cause d'une information manquante       | Prestations soumises non renseignés                |
        | 15   | ADMIN             | 2500                |                    |                    |             |        |               | GENEVE        | Janvier | invalide à cause d'une information manquante       | RetenueIS non renseignés                           |
        | 16   | ADMIN             | 2500                |                    |                    | 625.00      |        |               | NON_RENSEIGNE | Janvier | invalide à cause d'une information manquante       | Lieu de travail non renseignés                     |
        | 17   | ADMIN             | 2500                |                    |                    | 625.00      | A1     |               | GENEVE        | Janvier | invalide à cause d'une information de trop         | Le barème ne doit pas être renseigné pour un Admin |
        | 18   | ADMIN             | 0                   |                    |                    | 0           |        |               | GENEVE        | Janvier | valide                                             | Prestations soumises et retenue à 0                |
        | 19   | ADMIN             | 1                   |                    |                    | 0           |        |               | GENEVE        | Janvier | valide                                             | Prestations soumises renseignées et retenue à 0    |
        | 20   | SALARIE           | 123.45              | 250                | 250.50             | 250.50      | A1     | FALSE         | GENEVE        | Janvier | invalide car le montant est un nombre décimal      | Prestations soumises avec des décimaux             |
        | 21   | SALARIE           | 123                 | 12.3               | 250.50             | 250.50      | A1     | FALSE         | GENEVE        | Janvier | invalide car le montant est un nombre décimal      | Montant apériodique avec des décimaux              |

  Règle: validation des différents champs obligatoires des retenues mensuelles pour les bénéficiaires de rentes
  - Le montant des prestations soumises doit être un nombre entier sans décimaux

    Plan du Scénario: Validation des différents champs obligatoires des retenues mensuelles d'un bénéficiare de rentes - <Test> -> <Observation>
      Etant donné qu'un DPI BENEFICIAIRE_RENTE est sélectionné
      Etant donné que la date du jour est 31.01.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne BENEFICIAIRE_RENTE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette personne a une retenues IS avec la valeur <retenues_is> pour le mois <mois>
      Etant donné que cette personne a des prestations soumises avec la valeur <prestation_soumises> pour le mois <mois>
      Quand la validation est appliquée sur la retenue
      Alors le système renvoie que la retenue est <résultat>
      Exemples:
        | Test | prestation_soumises | retenues_is | mois    | résultat                                      | Observation                                                 |
        | 1    | 2500                | 250         | Janvier | valide                                        | Tous les champs renseignés                                  |
        | 2    |                     | 250.50      | Janvier | invalide à cause d'une information manquante  | Prestations soumises non renseignés                         |
        | 3    | 2500                |             | Janvier | invalide à cause d'une information manquante  | RetenueIS non renseigné                                     |
        | 4    | 1                   | -1          | Janvier | invalide car le montant est négatif           | RetenueIS avec montant négatif                              |
        | 5    | 0                   | 1           | Janvier | invalide car le montant est à zero            | Prestations soumises à 0                                    |
        | 6    | 1                   | 0           | Janvier | valide                                        | Prestations soumises à 0                                    |
        | 7    | 123.45              | 0           | Janvier | invalide car le montant est un nombre décimal | invalide car montant prestations soumises avec des décimaux |


  Règle: validation des différents champs obligatoires des retenues mensuelles pour les revenus en compensation
  - Le montant des prestations soumises doit être un nombre entier sans décimaux

    Plan du Scénario: Validation des différents champs obligatoires des retenues mensuelles d'un revenus en compensation - <Test> -> <Observation>
      Etant donné qu'un DPI CAISSE_COMPENSATION est sélectionné
      Etant donné que la date du jour est 31.01.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne CAISSE_COMPENSATION a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette personne a une retenues IS avec la valeur <retenues_is> pour le mois Janvier
      Etant donné que cette personne a des prestations soumises avec la valeur <prestation_soumises> pour le mois Janvier
      Etant donné que cette personne a un montant determinant avec la valeur <montant_determinant> pour le mois Janvier
      Etant donné que cette personne a un barème avec la valeur <barème> pour le mois Janvier
      Quand la validation est appliquée sur la retenue
      Alors le système renvoie que la retenue est <résultat>
      Exemples:
        | Test | prestation_soumises | retenues_is | montant_determinant | barème | résultat                                           | Observation                                                 |
        | 1    | 2500                | 250         | 2500                | G      | valide                                             | Tous les champs renseignés                                  |
        | 2    |                     | 250.50      | 2500                | G      | invalide à cause d'une information manquante       | Prestations soumises non renseignés                         |
        | 3    | 2500                |             | 2500                | G      | invalide à cause d'une information manquante       | RetenueIS non renseigné                                     |
        | 4    | 2500                | 250.50      |                     | G      | invalide à cause d'une information manquante       | Montant determinant non renseigné                           |
        | 5    | 2500                | 250.50      | 2500                |        | invalide à cause d'une information manquante       | Barème non renseigné                                        |
        | 6    | 2500                | -250.50     | 2500                | G      | invalide car le montant est négatif                | RetenueIS avec montant négatif                              |
        | 7    | 0                   | 250.50      | 2500                | G      | invalide car le montant est à zero                 | Prestations soumises à 0                                    |
        | 8    | 1                   | 0           | 2500                | G      | valide                                             | Prestations soumises à 0                                    |
        | 9    | 1                   | 0           | 0                   | G      | invalide à cause d'un montant minimum non respecté | invalide à cause d'un montant minimum non respecté          |
        | 10   | 1                   | 0           | -1                  | G      | invalide à cause d'un montant minimum non respecté | invalide à cause d'un montant minimum non respecté          |
        | 11   | 1                   | 0           | -1                  | G      | invalide à cause d'un montant minimum non respecté | invalide à cause d'un montant minimum non respecté          |
        | 12   | 123.45              | 0           | -1                  | G      | invalide car le montant est un nombre décimal      | invalide car montant prestations soumises avec des décimaux |


  Règle: Montants des revenus ADMIN :
  - Pour les LR Salarié les retenues ADMIN doivent etre égales à 25% + ou - 5 ctms de la prestation imposable si le DPI n'est pas de droit public

    Plan du scénario: Validation Retenue Mensuelle - Retenue IS pour les Administrateurs <Test> -> <Observation>
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que le DPI est de type entreprise de droit public <est de droit public>
      Etant donné que la date du jour est 31.01.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable ADMIN a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette personne a une retenues IS avec la valeur <retenues_is> pour le mois Janvier
      Etant donné que cette personne a des prestations soumises avec la valeur <prestation_soumises> pour le mois Janvier
      Etant donné que cette personne a un lieu de travail <type_lieu> pour le mois Janvier
      Quand la validation est appliquée sur la retenue
      Alors le système renvoie que la retenue est <résultat>
      Exemples:
        | Test | est de droit public | prestation_soumises | retenues_is | type_lieu | résultat                                                      | Observation                                                              |
        | 1    | true                | 1000                | 999         | GENEVE    | valide                                                        | De droit public et retenue IS presque égale à la prestation              |
        | 2    | false               | 1000                | 250.06      | GENEVE    | invalide car la retenue ne respecte pas le pourcentage défini | Pas de droit public et retenue IS > à ((25% de la prestation) + 0.05CHF) |
        | 3    | false               | 1000                | 250.05      | GENEVE    | valide                                                        | Pas de droit public et retenue IS égale à ((25% de la prestation) + 0.05 |
        | 4    | false               | 1000                | 250         | GENEVE    | valide                                                        | Pas de droit public et retenue IS égale à (25% de la prestation)         |
        | 5    | false               | 1000                | 249.95      | GENEVE    | valide                                                        | Pas de droit public et retenue IS égale à ((25% de la prestation) - 0.05 |
        | 6    | false               | 1000                | 249.94      | GENEVE    | invalide car la retenue ne respecte pas le pourcentage défini | Pas de droit public et retenue IS < à ((25% de la prestation) - 0.05CHF) |

  Règle: Retenues des Bénéficiares de rente
  - Pour les LR beneficiaire les retenues doivent etre égales à 10% + ou - 5 ctms de la prestation imposable

    Plan du scénario: Validation Retenue Mensuelle - Retenue IS pour les Bénéficiaires de rente <Test> -> <Observation>
      Etant donné qu'un DPI BENEFICIAIRE_RENTE est sélectionné
      Etant donné que la date du jour est 31.01.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne BENEFICIAIRE_RENTE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette personne a une retenues IS avec la valeur <retenues_is> pour le mois Janvier
      Etant donné que cette personne a des prestations soumises avec la valeur <prestation_soumises> pour le mois Janvier
      Quand la validation est appliquée sur la retenue
      Alors le système renvoie que la retenue est <résultat>
      Exemples:
        | Test | prestation_soumises | retenues_is | résultat                                                      | Observation                                           |
        | 1    | 1000                | 100.06      | invalide car la retenue ne respecte pas le pourcentage défini | Retenue IS > à ((10% de la prestation) + 0.05CHF)     |
        | 2    | 1000                | 100.05      | valide                                                        | Retenue IS égale à ((10% de la prestation) + 0.05CHF) |
        | 3    | 1000                | 100         | valide                                                        | Retenue IS égale à (10% de la prestation)             |
        | 4    | 1000                | 99.95       | valide                                                        | Retenue IS égale à ((10% de la prestation) - 0.05CHF) |
        | 5    | 1000                | 99.94       | invalide car la retenue ne respecte pas le pourcentage défini | Retenue IS < à ((10% de la prestation) - 0.05CHF)     |


  Règle: Barème PCOL pour Salariés
  si ce barème est selectionné alors la retenue doit correspondre à 31% de la prestation avec une marge de 10% (a corriger avec marge de 5 cent)

    Plan du Scénario: Validation LR - Bareme PCOL - <Test> -> <Observation>
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 31.01.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable <Type Contribuable> a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 500                 | 600                 | 2400.53    | Acacias         | PCOL   | Non           |
      Etant donné que cette personne a une retenues IS avec la valeur <retenues_is> pour le mois Janvier
      Etant donné que cette personne a des prestations soumises avec la valeur <prestation_soumises> pour le mois Janvier
      Quand la validation est appliquée sur la retenue
      Alors le système renvoie que la retenue est <résultat>
      Exemples:
        | Test | Type Contribuable | prestation_soumises | retenues_is | résultat                                            | Observation                       |
        | 1    | SALARIE           | 1000                | 309.9       | invalide car le taux forfaitaire n'est pas respecté | Message validation taux trop bas  |
        | 2    | SALARIE           | 1000                | 320.1       | invalide car le taux forfaitaire n'est pas respecté | Message validation taux trop haut |
        | 3    | SALARIE           | 1000                | 310         | Valide                                              | Validation retenue ok             |
        | 4    | SALARIE           | 1000                | 320         | Valide                                              | Validation retenue ok             |


  Règle: le montant de la retenue ne peut être supérieur au montant de la prestation imposée

    Plan du Scénario: Validation Retenue Mensuelle - Le montant de la retenue ne peut etre supérieur au montant de la prestation soumise à l'impot - <Test> -> <Observation>
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 31.01.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 500                 | 600                 | 2400.53    | Acacias         | A0     | Non           |
      Etant donné que cette personne a une retenues IS avec la valeur <retenues_is> pour le mois Janvier
      Etant donné que cette personne a des prestations soumises avec la valeur <prestation_soumises> pour le mois Janvier
      Quand la validation est appliquée sur la retenue
      Alors le système renvoie que la retenue est <résultat>
      Exemples:
        | Test | prestation_soumises | retenues_is | résultat                                                                     | Observation                                                    |
        | 1    | 9000                | 1000        | Valide                                                                       | Montant retenue inférieur au montant de la prestations imposée |
        | 2    | 1000                | 9000        | invalide car retenueIS supérieur ou égal au montant des prestations soumises | Montant retenue supérieur au montant de la prestations imposée |
        | 3    | 9000                | 9000        | invalide car retenueIS supérieur ou égal au montant des prestations soumises | Montant retenue égal au montant de la prestations imposée      |

  Règle: le montant aperiodique ne peut être supérieur au montant de la prestation imposée

    Plan du Scénario: Validation Retenue Mensuelle - Le montant apériodique de la retenue ne peut etre supérieur au montant de la prestation soumise à l'impot <Test> -> <Observation>
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 31.01.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 500                 | 600                 | 900.53     | Acacias         | A0     | Non           |
      Etant donné que cette personne a des prestations non périodiques avec la valeur <apériodique> pour le mois Janvier
      Etant donné que cette personne a des prestations soumises avec la valeur <prestation_soumises> pour le mois Janvier
      Quand la validation est appliquée sur la retenue
      Alors le système renvoie que la retenue est <résultat>
      Exemples:
        | Test | prestation_soumises | apériodique | résultat                                                                       | Observation                                                        |
        | 1    | 9000                | 1000        | Valide                                                                         | Montant apériodique inférieur au montant de la prestations imposée |
        | 2    | 1000                | 9000        | invalide car montant apériodique supérieur au montant des prestations soumises | Montant apériodique supérieur au montant de la prestations imposée |
        | 3    | 9000                | 9000        | Valide                                                                         | Montant apériodique égal au montant de la prestations imposée      |


  Règle: les prestations soumises ne doivent pas dépasser les 100'000 CHF

    Plan du Scénario: Validations informatives - Prestation imposée <Test> -> <Observation>
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 31.01.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 500                 | 600                 | 900.53     | Acacias         | A0     | Non           |
      Etant donné que cette personne a des prestations soumises avec la valeur <prestation_soumises> pour le mois Janvier
      Quand la validation est appliquée sur la retenue avec le groupe de validation Informative
      Alors le système renvoie que la retenue est <résultat>
      Exemples:
        | Test | prestation_soumises | résultat                                                         | Observation                     |
        | 1    | 100001              | invalide car montant des prestations soumises supérieur au seuil | Prestation imposée > 100'000CHF |
        | 2    | 100000              | Valide                                                           | Prestation imposée = 100'000CHF |
        | 3    | 50000               | Valide                                                           | Prestation imposée < 100'000CHF |

  Règle: lieu de travail est hors Canton GE pour résidents étrangers
  Si le lieu de travail est hors Canton GE et la personne est résidente à l'étranger la personne ne devrait pas etre imposée au canton GE -> message d'information au DPI

    Plan du Scénario: Validations informatives - Salariés - Lieu de travail - <Test> -> <Observation>
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 31.01.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que la personne a un adresse domicile à <type_adresse_domicile>
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Barème | Barème ajusté |
        | Janvier | 10000                | 500                 | 600                 | 2400.53    | A0     | Non           |
      Etant donné que cette personne a un lieu de travail <type_lieu> pour le mois Janvier
      Quand la validation est appliquée sur la retenue avec le groupe de validation Informative
      Alors le système renvoie que la retenue est <résultat>
      Exemples:
        | Test | type_adresse_domicile | type_lieu     | résultat                                           | Observation                                                                                                        |
        | 1    | ETRANGER              | HORS_GENEVE   | invalide car le lieu de travail doit être à Genève | Personne résidant à l'étranger n'est pas soumise à l'impôt source car elle travaille en dehors du canton de Genève |
        | 2    | GENEVE                | HORS_GENEVE   | valide                                             | Personne résidant à Genève et travaillant hors Genève                                                              |
        | 3    | ETRANGER              | GENEVE        | valide                                             | Personne résidant à l'étranger et travaille à Genève                                                               |
        | 4    | GENEVE                | GENEVE        | valide                                             | Personne résidant à Genève et travaille à Genève                                                                   |
        | 5    | GENEVE                | NON_RENSEIGNE | invalide à cause d'une information manquante       | Lieu de travail non renseigné                                                                                      |
        | 6    | NON_RENSEIGNE         | GENEVE        | valide                                             | Aucun adresse domicile                                                                                             |
        | 7    | ETRANGER              | HORS_GENEVE   | invalide car le lieu de travail doit être à Genève | Aucun adresse domicile                                                                                             |

  Règle: Pour les Administrateurs le lieu de travail est obligatoire et doit être en Suisse
  Si le lieu de travail est hors Canton GE et la personne est résidente à l'étranger la personne ne devrait pas etre imposée au canton GE -> message d'information au DPI

    Plan du Scénario: Validations Admin - Lieu de travail - <Test> -> <Observation>
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 31.01.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable ADMIN a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que la personne a un adresse domicile à <type_adresse_domicile>
      Etant donné que cette personne de type ADMIN a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Retenue IS |
        | Janvier | 10000                | 2500.00    |
      Etant donné que cette personne a un lieu de travail <type_lieu> pour le mois Janvier
      Quand la validation est appliquée sur la retenue avec le groupe de validation Informative
      Alors le système renvoie que la retenue est <résultat>
      Exemples:
        | Test | type_adresse_domicile | type_lieu     | résultat                                           | Observation                                                                                                        |
        | 1    | ETRANGER              | HORS_GENEVE   | invalide car le lieu de travail doit être à Genève | Personne résidant à l'étranger n'est pas soumise à l'impôt source car elle travaille en dehors du canton de Genève |
        | 2    | ETRANGER              | GENEVE        | valide                                             | Personne résidant à l'étranger et travaille à Genève                                                               |
        | 3    | GENEVE                | GENEVE        | valide                                             | Personne résidant à Genève et travaille à Genève                                                                   |
        | 4    | GENEVE                | NON_RENSEIGNE | invalide à cause d'une information manquante       | Lieu de travail non renseigné                                                                                      |
        | 5    | GENEVE                | HORS_GENEVE   | valide                                             | Lieu de travail hors Genève mais adresse domicile à Geneève                                                        |
        | 6    | HORS_GENEVE           | HORS_GENEVE   | valide                                             | Lieu de travail hors Genève mais adresse domicile en suisse                                                        |

  Règle: Un montant négatif pour le champ Retenue IS est interdit pour le mois de Janvier

    Scénario: Validations - Salariés - Montant Retenue IS Janvier négatif
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 01.01.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Barème | Barème ajusté |
        | Janvier | 10000                | 500                 | 600                 | -2400.53   | A0     | Non           |
      Quand la validation est appliquée sur la retenue
      Alors le système renvoie que la retenue est invalide car le montant est négatif pour Janvier

  Règle: Un montant négatif pour le champ Retenue IS est autorisé si mois différent de Janvier et montant total retenue IS >=0 jusqu'au mois courant

    Scénario: Validations - Salariés - Montant Retenue IS Février négatif
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 22.01.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 28.02.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Lieu de travail | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Barème | Barème ajusté |
        | Janvier | Acacias         | 10000                | 500                 | 600                 | 2400.53    | A0     | Non           |
        | Février | Acacias         | 10000                | 500                 | 600                 | -2400.53   | A0     | Non           |
      Quand la validation est appliquée sur la retenue
      Alors le système renvoie que la retenue est valide


  Règle: lorsque la validation est déclenché pour un mois, le total du montant retenue IS doit être >= 0 jusqu'au mois courant
  Par exemple si dans le mois de Janvier on a une retenue IS à 1'999 CHF et dans le mois de Février le montant de la retenue IS et
  à -2'000 CHF, alors le mois de Février est invalide car le montant total des retenues IS jusqu'au mois courant (Février) est négatif.

    Scénario: Validations - Salariés - Montant total retenue IS négatif pour le mois de Février
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 22.02.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 28.02.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Lieu de travail | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Barème | Barème ajusté |
        | Janvier | Acacias         | 10000                | 500                 | 600                 | 1999.00    | A0     | Non           |
        | Février | Acacias         | 10000                | 500                 | 600                 | -2000.00   | A0     | Non           |
      Quand la validation est appliquée sur la retenue
      Alors le système renvoie que la retenue est invalide pour le mois de Février car le montant total des retenues IS est négatif jusqu'à ce mois


    Scénario: Validations - Salariés - Montant total retenue IS négatif pour le mois de Février mais pas pour le mois de Mars,
    seulement le mois de Février est invalide
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 22.03.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.03.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Lieu de travail | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Barème | Barème ajusté |
        | Janvier | Acacias         | 10000                | 500                 | 600                 | 1400.53    | A0     | Non           |
        | Février | Acacias         | 10000                | 500                 | 600                 | -2000.00   | A0     | Non           |
        | Mars    | Acacias         | 10000                | 500                 | 600                 | 2000.00    | A0     | Non           |
      Quand la validation est appliquée sur la retenue
      Alors le système renvoie que la retenue est invalide pour le mois de Février car le montant total des retenues IS est négatif jusqu'à ce mois

    Scénario: Validations - Salariés - Montant total retenue IS positif jusqu'au mois courant
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 22.03.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.03.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Lieu de travail | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Barème | Barème ajusté |
        | Janvier | Acacias         | 10000                | 500                 | 600                 | 2400.53    | A0     | Non           |
        | Février | Acacias         | 10000                | 500                 | 600                 | -2400.00   | A0     | Non           |
        | Mars    | Acacias         | 10000                | 500                 | 600                 | 0.51    | A0     | Non           |
      Quand la validation est appliquée sur la retenue
      Alors le système renvoie que la retenue est valide

