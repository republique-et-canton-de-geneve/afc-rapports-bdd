#language: fr
Fonctionnalité: Validation d'une LR dans le cadre du dépôt LR via fichier XML - contribuable

  Règle: Pour qu'un contribuable de type Salarié soit valide il faut que:
  - La date de naissance des contribuables est obligatoire et doit être inférieure ou égale à l'année fiscale
  - Le nom /prénom sont obligatoires et et leur taille est au minimum 1 caractère

    Plan du scénario: Validation Partie Personne - Date de naissance du contribuable <Test> -> <Observation>
      Etant donné que l´utilisateur est un DPI de type SALARIES
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné que l'utilisateur a créé une nouvelle LR Déposer XML 2021 pour ce DPI
      Etant donné qu'une personne salariée déposer xml de type contribuable <Type Contribuable> a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que la date de naissance du contribuable est le <date de naissance>
      Etant donné que le nom du contribuable est le "<nom>"
      Etant donné que le prénom du contribuable est le "<prenom>"
      Quand l'utilisateur valide ce contribuable Déposer XML
      Alors le système renvoie que le contribuable déposer xml est <résultat>
      Exemples:
        | Test | Type Contribuable | date de naissance | nom | prenom | résultat                                                    | Observation                           |
        | 1    | SALARIE           | 11.01.2000        | nom | prenom | valide                                                      | Date de naissance valide              |
        | 2    | SALARIE           | 11.01.2022        | nom | prenom | invalide car la date de naissance est après l'année fiscale | Date de naissance après année fiscale |
        | 3    | SALARIE           |                   | nom | prenom | invalide à cause d'une information manquante                | Date de naissance pas renseigné       |
        | 5    | SALARIE           | 11.01.2000        |     | prenom | invalide à cause d'une information manquante                | Nom pas renseigné                     |
        | 6    | SALARIE           | 11.01.2000        | nom |        | invalide à cause d'une information manquante                | Prénom pas renseigné                  |
        | 7    | SALARIE           | 11.01.2000        | n   | p      | valide                                                      | Nom et prénom avec 1 seul caractère   |

  Règle: Pour qu'un Enfant Déposer XML soit valide il faut que :
  - Les champs nom, prénom et date de naissance sont obligatoires
  - La date de naissance doit être inférieure ou égale à l'année fiscale et inférieure à  26 ans

    Plan du scénario: Validation Nom/Prénom Enfants <Test> -> <Observation>
      Etant donné que l´utilisateur est un DPI de type SALARIES
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné que l'utilisateur a créé une nouvelle LR Déposer XML 2021 pour ce DPI
      Etant donné qu'une personne salariée déposer xml de type contribuable <Type Contribuable> a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette personne a un enfant
      Etant donné que le nom de l'enfant est "<nom>"
      Etant donné que le prénom de l'enfant est "<prénom>"
      Quand l'utilisateur valide ce contribuable Déposer XML
      Alors le système renvoie que le contribuable déposer xml est <résultat>
      Exemples:
        | Test | Type Contribuable | nom | prénom | résultat                                     | Observation                             |
        | 1    | SALARIE           | nom | prénom | valide                                       | Tous les champs renseignés              |
        | 2    | SALARIE           |     | prénom | invalide à cause d'une information manquante | Nom pas renseigné                       |
        | 3    | SALARIE           | nom |        | valide | Prénom pas renseigné                    |
        | 4    | SALARIE           | n   | p      | valide                                       | Valide (nom et prénom avec 1 caractere) |

    Plan du scénario: Validation Enfants - Date de naissance <Test> -> <Observation>
      Etant donné que l´utilisateur est un DPI de type SALARIES
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné que l'utilisateur a créé une nouvelle LR Déposer XML 2021 pour ce DPI
      Etant donné qu'une personne salariée déposer xml de type contribuable <Type Contribuable> a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.01.2021
      Etant donné que cette personne a un enfant
      Etant donné que la date de naissance de l'enfant est le <date de naissance>
      Quand l'utilisateur valide ce contribuable Déposer XML
      Alors le système renvoie que le contribuable déposer xml est <résultat>
      Exemples:
        | Test | Type Contribuable | date de naissance | résultat                                                    | Observation                           |
        | 1    | SALARIE           | 11.01.1996        | valide                                                      | Date de naissance valide              |
        | 2    | SALARIE           | 11.01.2022        | invalide car la date de naissance est après l'année fiscale | Date de naissance après année fiscale |
        | 3    | SALARIE           | 01.01.1995        | invalide car âge supérieur à 25 ans                         | Age supérieur 25 ans                  |
        | 4    | SALARIE           |                   | invalide à cause d'une information manquante                | Date de naissance pas renseigné       |





