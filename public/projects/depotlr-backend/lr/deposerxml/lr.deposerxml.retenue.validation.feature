#language: fr
Fonctionnalité: Validation d'une LR dans le cadre du dépôt LR via fichier XML - retenue

  Règle: Pour qu'une retenue Déposer XML soit valide il faut que :
  - Le montant prestation apériodique doit être inférieur ou égal au montant des prestations imposées
  - Les barèmes appliqués sont cohérents avec le type du contribuable

    Plan du scénario: Validation LR Salariés - Validation Partie Retenue - Montants <Test> -> <Observation>
      Etant donné que l´utilisateur est un DPI de type SALARIES
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné que l'utilisateur a créé une nouvelle LR Déposer XML 2021 pour ce DPI
      Etant donné qu'un contribuable déposer xml de type contribuable <Type Contribuable> a été ajoutée à cette LR sans retenue
      Etant donné que une retenue <Type Retenue> déposer xml a été ajoutée pour ce contribuable pour le mois Janvier avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette retenue déposer xml a des prestations soumises avec la valeur <prestations soumises>
      Etant donné que cette retenue déposer xml a une retenue IS avec la valeur <retenue IS>
      Etant donné que cette retenue déposer xml a un montant apériodique avec la valeur <montant apériodique>
      Etant donné que cette retenue déposer xml a un montant determinant avec la valeur <montant determinant>
      Etant donné que cette retenue déposer xml a un barème avec la valeur <barème>
      Quand l'utilisateur valide cette retenue Déposer XML
      Alors le système renvoie que la retenue déposer xml est <résultat>
      Exemples:
        | Test | Type Contribuable | Type Retenue | prestations soumises | retenue IS | montant apériodique | montant determinant | barème         | résultat                                                                | Observation                                             |
        | 1    | SALARIE           | SALARIE      | 1000                 | 999        | 1000                | 1                   | A0             | valide                                                                  |                                                         |
        | 2    | SALARIE           | SALARIE      | 1000                 | 999        | 1001                | 1000                | A0             | invalide car montant apériodique est supérieur aux prestations soumises | Invalide car Montant apériodique > Prestations soumises |
        | 3    | SALARIE           | SALARIE      | 1000                 | 999        | 999                 | 1000                | A0             | valide                                                                  | Valide (Montant apériodique >  Prestations soumises)    |
        | 4    | SALARIE           | SALARIE      |                      | 999        | 999                 | 1000                | A0             | invalide à cause d'une information manquante                            | Invalide car prestations soumises non renseigné         |
        | 5    | SALARIE           | SALARIE      | 1000                 |            | 999                 | 1000                | A0             | invalide à cause d'une information manquante                            | Invalide car retenue IS non renseigné                   |
        | 6    | SALARIE           | SALARIE      | 1000                 | 999        |                     | 1000                | A0             | valide                                                                  | Valide (Montant apériodique non renseigné)              |
        | 7    | SALARIE           | SALARIE      | 1000                 | 999        |                     |                     | A0             | invalide à cause d'une information manquante                            | Invalide car Montant determinant non renseigné          |
        | 8    | SALARIE           | SALARIE      | 1000                 | 999        |                     | 0                   | A0             | invalide à cause d'un montant minimum non respecté                      | Montant determinant doit etre 1 au minimum              |
        | 9    | SALARIE           | SALARIE      | 1000                 | 999        |                     | -1                  | A0             | invalide à cause d'un montant minimum non respecté                      | Montant determinant doit etre 1 au minimum              |
        | 10   | SALARIE           | ADMIN        | 1000                 | 999        | 1000                | 1000                | ADMINISTRATEUR | valide                                                                  | Valide                                                  |
        | 11   | SALARIE           | ADMIN        | 1000                 | 999        | 1001                | 1000                | ADMINISTRATEUR | invalide car montant apériodique est supérieur aux prestations soumises | Invalide car Montant apériodique > Prestations soumises |
        | 12   | SALARIE           | ADMIN        |                      | 999        | 1001                | 1000                | ADMINISTRATEUR | invalide à cause d'une information manquante                            | Invalide car prestations soumises non renseigné         |
        | 13   | SALARIE           | ADMIN        | 1000                 |            | 1000                | 1000                | ADMINISTRATEUR | invalide à cause d'une information manquante                            | Invalide car retenue IS non renseigné                   |
        | 14   | SALARIE           | ADMIN        | 1000                 | 999        |                     | 1000                | ADMINISTRATEUR | valide                                                                  | Valide (Montant apériodique non renseigné)              |
        | 15   | SALARIE           | ADMIN        | 1000                 | 999        | 1000                |                     | ADMINISTRATEUR | invalide à cause d'une information manquante                            | Invalide car Montant determinant non renseigné          |

    Plan du scénario: Validation LR Salariés - Validation Partie Retenue - Barème <Test> -> <Observation>
      Etant donné que l´utilisateur est un DPI de type SALARIES
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné que l'utilisateur a créé une nouvelle LR Déposer XML 2021 pour ce DPI
      Etant donné qu'un contribuable déposer xml de type contribuable SALARIE a été ajoutée à cette LR sans retenue
      Etant donné que une retenue <type retenue> déposer xml a été ajoutée pour ce contribuable pour le mois Janvier avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette retenue déposer xml a un barème avec la valeur <barème>
      Quand l'utilisateur valide cette retenue Déposer XML
      Alors le système renvoie que la retenue déposer xml est <résultat>
      Exemples:
        | Test | type retenue | barème         | résultat                            | Observation     |
        | 1    | SALARIE      | A0             | valide                              | Valide          |
        | 2    | SALARIE      | PCOL           | invalide car la barème est invalide | Barème invalide |
        | 3    | SALARIE      | G              | invalide car la barème est invalide | Barème invalide |
        | 4    | SALARIE      | Q              | invalide car la barème est invalide | Barème invalide |
        | 5    | SALARIE      | ZN             | invalide car la barème est invalide | Barème invalide |
        | 6    | SALARIE      | TRAVAIL_NOIR   | invalide car la barème est invalide | Barème invalide |
        | 7    | SALARIE      | ADMINISTRATEUR | invalide car la barème est invalide | Barème invalide |
        | 8    | SALARIE      | EFFEUILLEUR    | invalide car la barème est invalide | Barème invalide |
        | 9    | SALARIE      | C2             | valide                              | Valide          |
        | 10   | ADMIN        | ADMINISTRATEUR | valide                              | Valide          |
        | 11   | ADMIN        | C2             | invalide car la barème est invalide | Barème invalide |
        | 12   | EFFEUILLEUR  | EFFEUILLEUR    | valide                              | Valide          |
        | 13   | EFFEUILLEUR  | Q              | invalide car la barème est invalide | Barème invalide |


    Plan du scénario: Validation LR Revenus en compensation - Validation Retenue Caisse compensation <Test> -> <Observation>
      Etant donné que l´utilisateur est un DPI de type CAISSE_COMPENSATION
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné que l'utilisateur a créé une nouvelle LR Déposer XML 2021 pour ce DPI
      Etant donné qu'un contribuable déposer xml de type contribuable <type contribuable> a été ajoutée à cette LR sans retenue
      Etant donné que une retenue <type contribuable> déposer xml a été ajoutée pour ce contribuable pour le mois Janvier avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette retenue déposer xml a des prestations soumises avec la valeur <prestations soumises>
      Etant donné que cette retenue déposer xml a une retenue IS avec la valeur <retenue IS>
      Etant donné que cette retenue déposer xml a un montant apériodique avec la valeur <montant apériodique>
      Etant donné que cette retenue déposer xml a un montant determinant avec la valeur <montant determinant>
      Etant donné que cette retenue déposer xml a un barème avec la valeur <barème>
      Quand l'utilisateur valide cette retenue Déposer XML
      Alors le système renvoie que la retenue déposer xml est <résultat>
      Exemples:
        | Test | type contribuable | prestations soumises | retenue IS | montant apériodique | montant determinant | barème       | résultat                                           | Observation                                |
        | 1    | CAISSE_COMP       | 1000                 | 999        | 1000                | 1000                | G            | valide                                             | Barème valide                              |
        | 2    | CAISSE_COMP       | 1000                 | 999        | 1000                | 1000                | A0           | invalide car la barème est invalide                | Barème invalide                            |
        | 3    | CAISSE_COMP       | 1000                 | 999        | 1000                | 1000                | Q            | valide                                             | Barème valide                              |
        | 4    | CAISSE_COMP       |                      | 999        | 1000                | 1000                | Q            | invalide à cause d'une information manquante       | Prestations soumises non renseignés        |
        | 5    | CAISSE_COMP       | 1000                 |            | 1000                | 1000                | Q            | invalide à cause d'une information manquante       | Retenue IS non renseignés                  |
        | 6    | CAISSE_COMP       | 1000                 | 999        |                     | 1000                | Q            | valide                                             | Montant apériodique non renseignés         |
        | 7    | CAISSE_COMP       | 1000                 | 999        |                     |                     | Q            | invalide à cause d'une information manquante       | Montant determinant non renseignés         |
        | 8    | CAISSE_COMP       | 1000                 | 999        |                     | 0                   | Q            | invalide à cause d'un montant minimum non respecté | Montant determinant doit etre 1 au minimum |
        | 9    | TRAVAIL_AU_NOIR   | 1000                 | 999        | 1000                | 1000                | TRAVAIL_NOIR | valide                                             | Barème invalide                            |
        | 10   | TRAVAIL_AU_NOIR   | 1000                 | 999        | 1000                | 1000                | A1           | invalide car la barème est invalide                | Barème valide                              |
        | 11   | TRAVAIL_AU_NOIR   |                      | 999        | 1000                | 1000                | TRAVAIL_NOIR | invalide à cause d'une information manquante       | Prestations soumises non renseignés        |
        | 12   | TRAVAIL_AU_NOIR   | 1000                 |            | 1000                | 1000                | TRAVAIL_NOIR | invalide à cause d'une information manquante       | Retenue IS non renseignés                  |
        | 13   | TRAVAIL_AU_NOIR   | 1000                 | 999        |                     | 1000                | TRAVAIL_NOIR | valide                                             | Montant apériodique non renseignés         |
        | 14   | TRAVAIL_AU_NOIR   | 1000                 | 999        |                     |                     | TRAVAIL_NOIR | invalide à cause d'une information manquante       | Montant determinant non renseignés         |


    Plan du scénario: Validation LR Bénéficiaire de rentes - Validation Retenue Bénéficiaire de rente <Test> -> <Observation>
      Etant donné que l´utilisateur est un DPI de type BENEFICIAIRE_RENTE
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné que l'utilisateur a créé une nouvelle LR Déposer XML 2021 pour ce DPI
      Etant donné qu'un contribuable déposer xml de type contribuable BENEFICIAIRE_RENTE a été ajoutée à cette LR sans retenue
      Etant donné que une retenue BENEFICIAIRE_RENTE déposer xml a été ajoutée pour ce contribuable pour le mois Janvier avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette retenue déposer xml a des prestations soumises avec la valeur <prestations soumises>
      Etant donné que cette retenue déposer xml a une retenue IS avec la valeur <retenue IS>
      Quand l'utilisateur valide cette retenue Déposer XML
      Alors le système renvoie que la retenue déposer xml est <résultat>
      Exemples:
        | Test | prestations soumises | retenue IS | résultat                                     | Observation                                            |
        | 1    | 1000                 | 100.00     | valide                                       | Valide                                                 |
        | 2    | 1000                 |            | invalide à cause d'une information manquante | Retenue IS manquante                                   |
        | 3    |                      | 100        | invalide à cause d'une information manquante | Prestations soumises manquantes                        |
        | 4    | 1000                 | 1000       | valide                                       | Valide - montants des prestations soumis = retenues IS |

    Plan du scénario: Validation LR Salariés - Validation Partie Période d'activité <Test> -> <Observation>
      Etant donné que l´utilisateur est un DPI de type <Type Dpi>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné que l'utilisateur a créé une nouvelle LR Déposer XML 2021 pour ce DPI
      Etant donné qu'un contribuable déposer xml de type contribuable <Type Contribuable> a été ajoutée à cette LR sans retenue
      Etant donné que une retenue <Type Retenue> déposer xml a été ajoutée pour ce contribuable pour le mois <mois> avec une période d'activité <activité>
      Quand l'utilisateur valide cette retenue Déposer XML
      Alors le système renvoie que la retenue déposer xml est <résultat>
      Exemples:
        | Test | Type Dpi            | Type Contribuable  | Type Retenue       | mois    | activité                    | résultat                                            | Observation                              |
        | 1    | SALARIES            | SALARIE            | SALARIE            | Janvier | du 01.01.2021 au 31.01.2021 | valide                                              | Valide                                   |
        | 2    | SALARIES            | SALARIE            | SALARIE            | Février | du 01.01.2021 au 31.01.2021 | invalide car le mois ne correspond pas à la période | Invalide car mois différent des périodes |
        | 3    | SALARIES            | SALARIE            | SALARIE            | Janvier | du 01.02.2021 au 24.02.2021 | invalide car le mois ne correspond pas à la période | Invalide car mois différent des périodes |
        | 4    | SALARIES            | SALARIE            | SALARIE            | Janvier | du 01.02.2021 au 24.02.2021 | invalide car le mois ne correspond pas à la période | Invalide car mois différent des périodes |
        | 5    | SALARIES            | SALARIE            | ADMIN              | Janvier | du 01.01.2021 au 31.01.2021 | valide                                              | Invalide car mois différent des périodes |
        | 6    | SALARIES            | SALARIE            | ADMIN              | Janvier | du 01.01.2021 au 31.03.2021 | invalide car le mois ne correspond pas à la période | Invalide car mois différent des périodes |
        | 7    | SALARIES            | SALARIE            | EFFEUILLEUR        | Janvier | du 01.01.2021 au 31.01.2021 | valide                                              | Invalide car mois différent des périodes |
        | 8    | SALARIES            | SALARIE            | EFFEUILLEUR        | Janvier | du 01.03.2021 au 31.03.2021 | invalide car le mois ne correspond pas à la période | Invalide car mois différent des périodes |
        | 9    | BENEFICIAIRE_RENTE  | BENEFICIAIRE_RENTE | BENEFICIAIRE_RENTE | Janvier | du 01.01.2021 au 31.01.2021 | valide                                              | Valide                                   |
        | 10   | BENEFICIAIRE_RENTE  | BENEFICIAIRE_RENTE | BENEFICIAIRE_RENTE | Janvier | du 01.03.2021 au 31.03.2021 | invalide car le mois ne correspond pas à la période | Invalide car mois différent des périodes |
        | 11   | CAISSE_COMPENSATION | CAISSE_COMP        | CAISSE_COMP        | Janvier | du 01.01.2021 au 31.01.2021 | valide                                              | Valide                                   |
        | 12   | CAISSE_COMPENSATION | CAISSE_COMP        | CAISSE_COMP        | Janvier | du 01.03.2021 au 31.03.2021 | invalide car le mois ne correspond pas à la période | Invalide car mois différent des périodes |
        | 13   | CAISSE_COMPENSATION | TRAVAIL_AU_NOIR    | TRAVAIL_AU_NOIR    | Janvier | du 01.01.2021 au 31.01.2021 | valide                                              | Valide                                   |
        | 14   | CAISSE_COMPENSATION | TRAVAIL_AU_NOIR    | TRAVAIL_AU_NOIR    | Janvier | du 01.03.2021 au 31.03.2021 | invalide car le mois ne correspond pas à la période | Invalide car mois différent des périodes |

    Plan du scénario: Validation LR Remboursement AVS - Validation Retenue Remboursement AVS <Test> -> <Observation>
      Etant donné que l´utilisateur est un DPI de type REMBOURSEMENT_AVS
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné que l'utilisateur a créé une nouvelle LR Déposer XML 2021 pour ce DPI
      Etant donné qu'un contribuable déposer xml de type contribuable REMBOURSEMENT_AVS a été ajoutée à cette LR sans retenue
      Etant donné que une retenue évènementiel REMBOURSEMENT_AVS déposer xml a été ajoutée pour ce contribuable
      Etant donné que cette retenue évènementiel déposer xml a des prestations soumises avec la valeur <prestations soumises>
      Etant donné que cette retenue évènementiel déposer xml a une retenue IS avec la valeur <retenue IS>
      Etant donné que cette retenue évènementiel déposer xml a une date de remboursement <date remboursement>
      Quand l'utilisateur valide cette retenue évènementiel Déposer XML
      Alors le système renvoie que la retenue évènementiel déposer xml est <résultat>
      Exemples:
        | Test | prestations soumises | retenue IS | date remboursement | résultat                                                        | Observation                                            |
        | 1    | 1000                 | 100.00     | 20.01.2021         | valide                                                          | Valide                                                 |
        | 2    | 1000                 |            | 20.01.2021         | invalide à cause d'une information manquante                    | Retenue IS manquante                                   |
        | 3    |                      | 100        | 20.01.2021         | invalide à cause d'une information manquante                    | Prestations soumises manquantes                        |
        | 4    | 1000                 | 1000       | 20.01.2021         | valide                                                          | Valide - montants des prestations soumis = retenues IS |
        | 5    | 1000                 | 1000       |                    | invalide à cause d'une information manquante                    | Date de remboursement non renseignée                   |
        | 6    | 1000                 | 1000       | 20.01.2020         | invalide car la date remboursement est différente de l'année LR | Date de remboursement différente de l'année LR         |
        | 7    | 1000                 | 1000       | 20.01.2022         | invalide car la date remboursement est différente de l'année LR | Date de remboursement différente de l'année LR         |
