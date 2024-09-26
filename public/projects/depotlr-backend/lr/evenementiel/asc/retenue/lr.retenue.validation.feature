#language: fr
Fonctionnalité: Validation d'une LR ASC - Partie Retenue

  Contexte:
    Etant donné qu'un DPI ASC est sélectionné
    Etant donné que l´année fiscale de la déclaration est 2021
    Etant donné l´année en cours 2021

  Règle: Une période de retenue est valide ssi :
  - date de début et date de fin renseignés
  - date de bébut >= date de fin
    Plan du scénario: Validation LR - Période <Test> -> <Observation>
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Et l´utilisateur saisit pour la première retenue de la LR la période <debut> - <fin>.
      Quand l'utilisateur valide cette première retenue
      Alors le système indique que cette retenue est <Résultat>
      Exemples:
        | Test | debut      | fin        | Résultat                                                                      | Observation                           |
        | 1    | 02.01.2021 | 01.01.2021 | invalide à cause d'une période dont la date de fin est avant la date de début | Date de fin inférieur à date de début |
        | 2    | 01.01.2021 | 01.01.2021 | valide                                                                        | Date de fin égale à date de début     |
        | 3    | 01.01.2021 | 01.02.2021 | valide                                                                        | Date de fin supérieur à date de début |
        | 4    | 01.01.2020 | 01.02.2020 | invalide à cause d'une période pas dans l'année fiscale                       | Date de fin pas dans l'année de la LR |
        | 5    |            |            | invalide à cause de deux informations manquantes                                  | Aucune date                           |
        | 6    |            | 01.01.2021 | invalide à cause d'une information manquante                                  | Pas de date de début                  |
        | 7    | 01.01.2021 |            | invalide à cause d'une information manquante                                  | Pas de date de fin                    |

  Règle: Une personne ASC Artiste est valide lorsque :
  - Au moins un de ses trois noms est renseigné et valide : "nom/prenom", "nom artiste" ou "nom groupe"
  - Si Le nom est renseigné alors le prénom aussi et inversement

    Plan du scénario: Validation LR - Personne Artiste <Test> -> <Observation>
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Et l´utilisateur choisit comme type activité la valeur <typeActivite>
      Et l'utilisateur saisit pour la première retenue de la LR dans "Nom" la valeur "<nom>"
      Et l'utilisateur saisit pour la première retenue de la LR dans "Prénom" la valeur "<prenom>"
      Et l'utilisateur saisit pour la première retenue de la LR dans "Nom Artiste" la valeur "<nomArtiste>"
      Et l'utilisateur saisit pour la première retenue de la LR dans "Nom Groupe" la valeur "<nomGroupe>"
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est <resultat>
      Exemples:
        | Test | typeActivite | nom | prenom | nomArtiste | nomGroupe | resultat | Observation                                                     |
        | 1    | ARTISTE      | nom | prenom |            |           | Valide   | Prénom + nom renseignés                                         |
        | 2    | ARTISTE      |     |        | nomArtiste |           | Valide   | Nom artiste renseigné                                           |
        | 3    | ARTISTE      |     |        |            | nomGroupe | Valide   | Nom groupe renseigné                                            |
        | 4    | ARTISTE      | nom | prenom | nomArtiste | nomGroupe | Valide   | Nom artiste renseigné + prénom renseigné avec nom renseigné     |
        | 5    | ARTISTE      | nom |        | nomArtiste |           | Invalide | Nom artiste renseigné + prénom non renseigné avec nom renseigné |
        | 6    | ARTISTE      |     | prenom |            | nomGroupe | Invalide | Nom groupe renseigné + nom non renseigné avec prénom renseigné  |
        | 7    | ARTISTE      |     |        |            |           | Invalide | Aucune identification renseigné                                 |

  Règle: Une personne ASC Artiste est valide lorsque la taille des champs ci-dessous est respecté:
  - Si Le nom est renseigné il doit être compris entre 2 et 60 caractères
  - Si Le prénom est renseigné il doit être compris entre 2 et 30 caractères
  - Si Le nom groupe est renseigné il doit être compris entre 2 et 60 caractères
  - Si Le nom artiste est renseigné il doit être compris entre 2 et 60 caractères

    Plan du scénario: Validation LR - Personne Artiste <Test> -> <Observation>
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Et l´utilisateur choisit comme type activité la valeur <typeActivite>
      Et l'utilisateur saisit pour la première retenue de la LR dans "Nom" une valeur avec <taille_nom> caractères
      Et l'utilisateur saisit pour la première retenue de la LR dans "Prénom" une valeur avec <taille_prenom> caractères
      Et l'utilisateur saisit pour la première retenue de la LR dans "Nom Artiste" une valeur avec <taille_nomArtiste> caractères
      Et l'utilisateur saisit pour la première retenue de la LR dans "Nom Groupe" une valeur avec <taille_nomGroupe> caractères
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est <resultat>
      Exemples:
        | Test | typeActivite | taille_nom | taille_prenom | taille_nomArtiste | taille_nomGroupe | resultat | Observation                                                |
        | 1    | ARTISTE      | 1          | 2             | 2                 | 2                | Invalide | Artiste - Nom renseigné avec moins de 2 caracteres         |
        | 2    | ARTISTE      | 2          | 1             | 2                 | 2                | Invalide | Artiste - Prénom renseigné avec moins de 2 caracteres      |
        | 3    | ARTISTE      | 2          | 2             | 1                 | 2                | Invalide | Artiste - Nom artiste renseigné avec moins de 2 caracteres |
        | 4    | ARTISTE      | 2          | 2             | 2                 | 1                | Invalide | Artiste - Nom group renseigné avec moins de 2 caracteres   |
        | 5    | ARTISTE      | 61         | 2             | 2                 | 2                | Invalide | Artiste - Nom renseigné avec plus de 60 caracteres         |
        | 6    | ARTISTE      | 2          | 31            | 2                 | 2                | Invalide | Artiste - Prénom renseigné avec plus de 30 caracteres      |
        | 7    | ARTISTE      | 2          | 2             | 61                | 2                | Invalide | Artiste - Nom artiste renseigné avec plus de 60 caracteres |
        | 8    | ARTISTE      | 2          | 2             | 2                 | 61               | Invalide | Artiste - Nom group renseigné avec plus de 60 caracteres   |
        | 9    | ARTISTE      | 60         | 2             | 2                 | 2                | Valide   | Artiste - Nom renseigné avec 60 caracteres                 |
        | 10   | ARTISTE      | 2          | 30            | 2                 | 2                | Valide   | Artiste - Prénom renseigné avec 30 caracteres              |
        | 11   | ARTISTE      | 2          | 2             | 60                | 2                | Valide   | Artiste - Nom artiste renseigné avec 60 caracteres         |
        | 12   | ARTISTE      | 2          | 2             | 2                 | 60               | Valide   | Artiste - Nom group renseigné avec 60 caracteres           |


  Règle: Une personne ASC Sportif ou Conférencier est valide lorsque :
  - Nom est Prénom sont renseignés et valides
  - Le "Nom groupe" est optionnel

    Plan du scénario: Validation LR - Personne Sportif ou Conférencier <Test> -> <Observation>
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Et l´utilisateur choisit comme type activité la valeur <typeActivite>
      Et l'utilisateur saisit pour la première retenue de la LR dans "Nom" la valeur "<nom>"
      Et l'utilisateur saisit pour la première retenue de la LR dans "Prénom" la valeur "<prenom>"
      Et l'utilisateur saisit pour la première retenue de la LR dans "Nom Groupe" la valeur "<nomGroupe>"
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est <resultat>
      Exemples:
        | Test | typeActivite | nom | prenom | nomGroupe | resultat | Observation                                                |
        | 1    | CONFERENCIER |     |        | nomGroupe | Invalide | Aucune identification renseigné                            |
        | 2    | SPORTIF      | nom |        |           | Invalide | Nom renseigné                                              |
        | 3    | CONFERENCIER |     | prenom | nomGroupe | Invalide | Prénom renseigné                                           |
        | 4    | SPORTIF      | nom | prenom |           | Valide   | Prénom et nom renseignés                                   |
        | 5    | CONFERENCIER | nom | prenom | nomGroupe | Valide   | Nom groupe renseigné + prénom renseigné avec nom renseigné |



  Règle: Une personne ASC Sportif ou Conferencier est valide lorsque  la taille des champs ci-dessous est respecté:
  - Le nom doit être compris entre 2 et 60 caractères
  - Le prénom doit être compris entre 2 et 30 caractères
  - Si Le nom groupe est renseigné il doit être compris entre 2 et 60 caractères

    Plan du scénario: Validation LR - Personne Artiste <Test> -> <Observation>
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Et l´utilisateur choisit comme type activité la valeur <typeActivite>
      Et l'utilisateur saisit pour la première retenue de la LR dans "Nom" une valeur avec <taille_nom> caractères
      Et l'utilisateur saisit pour la première retenue de la LR dans "Prénom" une valeur avec <taille_prenom> caractères
      Et l'utilisateur saisit pour la première retenue de la LR dans "Nom Groupe" une valeur avec <taille_nomGroupe> caractères
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est <resultat>
      Exemples:
        | Test | typeActivite | taille_nom | taille_prenom | taille_nomGroupe | resultat | Observation                                                   |
        | 1    | CONFERENCIER | 1          | 2             | 2                | Invalide | CONFERENCIER - Nom renseigné avec moins de 2 caracteres       |
        | 2    | CONFERENCIER | 2          | 1             | 2                | Invalide | CONFERENCIER - Prénom renseigné avec moins de 2 caracteres    |
        | 3    | CONFERENCIER | 2          | 2             | 1                | Invalide | CONFERENCIER - Nom group renseigné avec moins de 2 caracteres |
        | 4    | CONFERENCIER | 61         | 2             | 2                | Invalide | CONFERENCIER - Nom renseigné avec plus de 60 caracteres       |
        | 5    | CONFERENCIER | 2          | 31            | 2                | Invalide | CONFERENCIER - Prénom renseigné avec plus de 30 caracteres    |
        | 6    | CONFERENCIER | 2          | 2             | 61               | Invalide | CONFERENCIER - Nom group renseigné avec plus de 60 caracteres |
        | 7    | CONFERENCIER | 60         | 2             | 2                | Valide   | CONFERENCIER - Nom renseigné avec 60 caracteres               |
        | 8    | CONFERENCIER | 2          | 30            | 2                | Valide   | CONFERENCIER - Prénom renseigné avec 30 caracteres            |
        | 9    | CONFERENCIER | 2          | 2             | 60               | Valide   | CONFERENCIER - Nom group renseigné avec 60 caracteres         |
        | 10   | SPORTIF      | 1          | 2             | 2                | Invalide | SPORTIF - Nom renseigné avec moins de 2 caracteres            |
        | 11   | SPORTIF      | 2          | 1             | 2                | Invalide | SPORTIF - Prénom renseigné avec moins de 2 caracteres         |
        | 12   | SPORTIF      | 2          | 2             | 1                | Invalide | SPORTIF - Nom group renseigné avec moins de 2 caracteres      |
        | 13   | SPORTIF      | 61         | 2             | 2                | Invalide | SPORTIF - Nom renseigné avec plus de 60 caracteres            |
        | 14   | SPORTIF      | 2          | 31            | 2                | Invalide | SPORTIF - Prénom renseigné avec plus de 30 caracteres         |
        | 15   | SPORTIF      | 2          | 2             | 61               | Invalide | SPORTIF - Nom group renseigné avec plus de 60 caracteres      |
        | 16   | SPORTIF      | 60         | 2             | 2                | Valide   | SPORTIF - Nom renseigné avec 60 caracteres                    |
        | 17   | SPORTIF      | 2          | 30            | 2                | Valide   | SPORTIF - Prénom renseigné avec 30 caracteres                 |
        | 18   | SPORTIF      | 2          | 2             | 60               | Valide   | SPORTIF - Nom group renseigné avec 60 caracteres              |



    Plan du scénario: Validation LR - Numéro AVS <Test> -> <Observation>
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Et l'utilisateur saisit pour la première retenue de la LR dans "Numéro AVS" la valeur "<numeroAvs>"
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est <resultat>
      Exemples:
        | Test | numeroAvs        | resultat | Observation                  |
        | 1    |                  | Valide   | Aucun numéro avs             |
        | 2    | 756.9999.9999.91 | Valide   | Numéro avs valide            |
        | 3    | 756.9999.9999.99 | Invalide | Numéro avs invalide          |
        | 4    | 756.9999.999999  | Invalide | Numéro avs pas au bon format |

  Règle: Les prestations brutes d'une retenue sont :
  - obligatoires
  - > 0
  - Sans décimaux
    Plan du scénario: Validation LR - Prestations Brutes <Test> -> <Observation>
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Et l'utilisateur saisit pour la première retenue de la LR dans "Prestations Brutes" la valeur "<prestationsBrutes>"
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est <resultat>
      Exemples:
        | Test | prestationsBrutes | resultat | Observation                       |
        | 1    |                   | Invalide | Prestations brutes non renseignés |
        | 2    | 0                 | Invalide | Prestations brutes à 0            |
        | 3    | -1                | Invalide | Prestations brutes négative       |
        | 4    | 1                 | Valide   | Prestations brutes positive       |
        | 5    | 152.55            | Invalide | Prestations brutes avec décimaux  |

  Règle: Le nombre de personnes d'une retenue ASC doit être compris entre 1 et 2000
    Plan du scénario: Validation LR - Nombre de personnes <Test> -> <Observation>
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Et l'utilisateur saisit pour la première retenue de la LR dans "Nombre de personnes" la valeur "<nbPersonnes>"
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est <resultat>
      Exemples:
        | Test | nbPersonnes | resultat | Observation                       |
        | 1    |             | Invalide | Nombre personnes non renseigné    |
        | 2    | 0           | Invalide | Nombre personnes à 0              |
        | 3    | -1          | Invalide | Nombre personnes négative         |
        | 4    | 2001        | Invalide | Nombre personnes supérieur à 2000 |
        | 5    | 1           | Valide   | Nombre personnes à 1              |
        | 6    | 2000        | Valide   | Nombre personnes à 2000           |
        | 7    | 1000        | Valide   | Nombre personnes à 1000           |

  Règle: Le nombre de jours de représentation d'une retenue ASC doit être compris entre 1 et 366
    Plan du scénario: Validation LR - Nombre de jours de représentation <Test> -> <Observation>
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Et l'utilisateur saisit pour la première retenue de la LR dans "Nombre de jours de représentation" la valeur "<nbJoursRepresentation>"
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est <resultat>
      Exemples:
        | Test | nbJoursRepresentation | resultat | Observation                                    |
        | 1    |                       | Invalide | Nombre jours de représentation non renseigné   |
        | 2    | 0                     | Invalide | Nombre jours de représentation à 0             |
        | 3    | -1                    | Invalide | Nombre jours de représentation négative        |
        | 4    | 367                   | Invalide | Nombre jours de représentation supérieur à 366 |
        | 5    | 1                     | Valide   | Nombre jours de représentation à 1             |
        | 6    | 366                   | Valide   | Nombre jours de représentation à 366           |
        | 7    | 150                   | Valide   | Nombre jours de représentation à 150           |

  Règle: Le pays domicile d'une retenue ASC est obligatoire
    Plan du scénario: Validation LR ASC - Pays domicile <Test> -> <Observation>
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Et l'utilisateur saisit pour la première retenue de la LR dans "Pays domicile" la valeur "<paysDomicile>"
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est <resultat>
      Exemples:
        | Test | paysDomicile | resultat | Observation                 |
        | 1    |              | Invalide | Pays domicile non renseigné |
        | 2    | CH           | Valide   | Pays domicile renseigné     |
