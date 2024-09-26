#language: fr
Fonctionnalité: Validation d'une personne périodique : salarié, caisse de compensation, bénéficiaire de rente
  La validation d'une personne intervient à plusieurs moments :
  - Lorsque la LR est transmise
  - Lorsqu'une personne est editée (soit en création, soit en modification)

  # Voir https://github.com/cucumber/cucumber/issues/869 pour le support limité de ce keyword (notamment dans le JSON formatter)
  Règle: Les règles de validation d'une date de naissance d'une personne sont les suivantes :
  - obligatoire pour un salarié ou un bénéficiaire de rente, optionnelle pour les administrateurs et LR Caisse Compensation
  - dans le passé (par rapport à la date du jour)
  - l'âge ne doit pas dépasser 100 ans (par rapport à la date du jour)

    Plan du scénario: Validation Personne - Date de naissance <Test> -> <Observation> => <résultat>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'une personne <type personne> complète est initialisée
      Etant donné que la date de naissance saisie est <date de naissance>
      Quand la validation est appliquée sur la personne
      Alors le système renvoie que la personne est <résultat>
      Exemples:
        | Test | type personne      | date de naissance | résultat                       | Observation                                                            |
        | 1    | SALARIE            | 31.03.2000        | valide                         | Date de naissance valide pour un Salarié                               |
        | 2    | SALARIE            |                   | invalide avec une seule erreur | Date de naissance non renseignée pour un Salarié                       |
        | 3    | SALARIE            | 01.04.2021        | invalide avec une seule erreur | Date de naissance supérieure au jour en cours                          |
        | 4    | SALARIE            | 30.03.2021        | valide                         | Date de naissance égale au jour en cours                               |
        | 5    | SALARIE            | 30.03.1921        | valide                         | Age égal à 100 ans à un moment dans l'annéee fiscale                   |
        | 6    | SALARIE            | 28.03.1920        | invalide avec une seule erreur | Age supérieur à 100 ans à un moment dans l'annéee fiscale              |
        | 7    | ADMIN              | 31.03.2000        | valide                         | Date de naissance valide pour un Administrateur                        |
        | 8    | ADMIN              |                   | valide                         | Date de naissance non renseignée pour un Administrateur                |
        | 9    | ADMIN              | 01.04.2021        | invalide avec une seule erreur | Date de naissance invalide pour un Administrateur                      |
        | 10   | CAISSE_COMP        | 31.03.2000        | valide                         | Date de naissance valide pour une Personne Caisse Compensation         |
        | 11   | CAISSE_COMP        |                   | invalide avec une seule erreur | Date de naissance non renseignée pour une Personne Caisse Compensation |
        | 12   | CAISSE_COMP        | 01.04.2021        | invalide avec une seule erreur | Date de naissance invalide pour une Personne CAISSE_COMP               |
        | 13   | BENEFICIAIRE_RENTE | 31.03.2000        | valide                         | Date de naissance valide pour un bénéficiaire de rente                 |
        | 14   | BENEFICIAIRE_RENTE |                   | invalide avec une seule erreur | Date de naissance non renseignée pour un bénéficiaire de rente         |

  Règle: Les règles de validation du NAVS de personne périodique sont les suivantes :
  - optionnel pour tout type de personne périodique
  - doit être valide

    Plan du scénario: Validation Personne - NAVS <Test> -> <Observation>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'une personne <type personne> complète est initialisée
      Etant donné que le NAVS saisi est <NAVS>
      Quand la validation est appliquée sur la personne
      Alors le système renvoie que la personne est <résultat>
      Exemples:
        | Test | NAVS             | type personne      | résultat                       | Observation                                      |
        | 1    |                  | SALARIE            | valide                         | NAVS non renseigné pour un salarié               |
        | 2    |                  | BENEFICIAIRE_RENTE | valide                         | NAVS non renseigné pour un bénéficiaire de rente |
        | 3    | 756.9999.9999.99 | BENEFICIAIRE_RENTE | invalide avec une seule erreur | NAVS invalide pour un bénéficiaire de rente      |
        | 4    | 756.9999.9999.99 | SALARIE            | invalide avec une seule erreur | NAVS invalide pour un salarié                    |

  Règle: Les règles de validation du sexe de la personne sont les suivantes :
  - obligatoire pour un salarié, optionnelle pour les administrateurs et LR Caisse Compensation

    Plan du scénario: Validation Personne - Sexe <Test> -> <Observation>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'une personne <type personne> complète est initialisée
      Etant donné que le sexe saisie est <sexe>
      Quand la validation est appliquée sur la personne
      Alors le système renvoie que la personne est <résultat>
      Exemples:
        | Test | sexe | type personne | résultat                       | Observation                                                      |
        | 1    | M    | SALARIE       | valide                         | Sexe renseigné                                                   |
        | 2    | F    | SALARIE       | valide                         | Sexe renseigné                                                   |
        | 3    |      | SALARIE       | invalide avec une seule erreur | Sexe non renseigné pour un salarié                               |
        | 4    |      | ADMIN         | valide                         | Sexe non renseigné pour un admin                                 |
        | 5    | M    | ADMIN         | valide                         | Sexe renseigné                                                   |
        | 6    |      | CAISSE_COMP   | valide                         | Sexe non renseigné pour une personne de type Caisse Compensation |
        | 7    | F    | CAISSE_COMP   | valide                         | Sexe renseigné                                                   |

  Règle: Les règles de validation pour l'état civil d'une personne sont les suivantes :
  - obligatoire pour un salarié, optionnelle pour les administrateurs et LR Caisse Compensation

    Plan du scénario: Validation Personne - Etat Civil <Test> -> <Observation>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'une personne <type personne> complète est initialisée
      Etant donné que le salarié a l´état civil <etat civil>
      Quand la validation est appliquée sur la personne
      Alors le système renvoie que la personne est <résultat>
      Exemples:
        | Test | etat civil  | type personne | résultat                       | Observation                                                            |
        | 1    | CELIBATAIRE | SALARIE       | valide                         | Etat civil renseigné                                                   |
        | 2    |             | SALARIE       | invalide avec une seule erreur | Etat civil non renseigné pour un salarié                               |
        | 3    | CELIBATAIRE | ADMIN         | valide                         | Etat civil renseigné                                                   |
        | 4    |             | ADMIN         | valide                         | Etat civil non renseigné pour un admin                                 |
        | 5    | CELIBATAIRE | CAISSE_COMP   | valide                         | Etat civil renseigné                                                   |
        | 6    |             | CAISSE_COMP   | valide                         | Etat civil non renseigné pour une personne de type Caisse Compensation |

  Règle: Les règles de validation pour le NPA de l'adresse domicile d'une personne sont les suivantes :
  - obligatoire
  - doit être compris entre 1000 et 9999

    Plan du scénario: Validation Personne - NPA domicile Genevois <Test> -> <Observation>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'un salarié complet est initialisé
      Etant donné que l'adresse domicile est dans une commune genevoise
      Etant donné que le NPA du domicile saisi est "<NPA>"
      Quand la validation est appliquée sur la personne
      Alors le système renvoie que la personne est <résultat>
      Exemples:
        | Test | NPA   | résultat                       | Observation          |
        | 1    |       | invalide avec une seule erreur | Pas de NPA           |
        | 2    | 999   | invalide avec une seule erreur | NPA inférieur à 1000 |
        | 3    | 1000  | valide                         | NPA valide           |
        | 4    | 10000 | invalide avec une seule erreur | NPA supérieur à 9999 |

    Scénario: Validation Personne - NPA domicile Suisse <Test> -> <Observation>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'un salarié complet est initialisé
      Etant donné que l'adresse domicile est Suisse mais non genevoise
      Quand la validation est appliquée sur la personne
      Alors le système renvoie que la personne est Invalide

  Règle: Les règles de validation d'une adresse domicile genevoise d'une personne sont les suivantes :
  - Rue obligatoire
  - NPA obligatoire
  - Localité obligatoire
  - Commune politique obligatoire
    Plan du scénario: Validation Personne - Adresse domicile genevoise <Test> -> <Observation>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'un salarié complet est initialisé
      Etant donné que l'adresse domicile est dans une commune genevoise
      Etant donné que le NPA du domicile saisi est "<NPA>"
      Etant donné que la localité du domicile saisie est "<localité>"
      Etant donné que la rue du domicile saisie est "<rue>"
      Etant donné que la commune politique saisie est "<commune politique>"
      Quand la validation est appliquée sur la personne
      Alors le système renvoie que la personne est <résultat>
      Exemples:
        | Test | rue | NPA  | localité | commune politique | résultat | Observation                      |
        | 1    | rue | 1012 | Genève   | 6621              | valide   | Champs obligatoires renseignés   |
        | 2    |     | 1012 | Genève   | 6621              | invalide | Rue non renseignée               |
        | 3    | rue | 1012 | Genève   |                   | invalide | Commune politique non renseignée |
        | 4    | rue | 1012 |          | 6621              | invalide | Localite non renseignée          |
        | 5    | rue |      | Genève   | 6621              | invalide | NPA non renseignée               |

  Règle: Les règles de validation d'une adresse domicile étrangère d'une personne sont les suivantes :
  - rue obligatoire
  - NPA obligatoire
  - Localité obligatoire
    Plan du scénario: Validation Personne - Adresse domicile étrangère <Test> -> <Observation>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'un salarié complet est initialisé
      Etant donné que l'adresse domicile est étrangère
      Etant donné que le NPA du domicile saisi est "<NPA>"
      Etant donné que la localité du domicile saisie est "<localité>"
      Etant donné que la rue du domicile saisie est "<rue>"
      Quand la validation est appliquée sur la personne
      Alors le système renvoie que la personne est <résultat>
      Exemples:
        | Test | rue | NPA   | localité | résultat | Observation                        |
        | 1    |     |       |          | invalide | Champs obligatoires non renseignés |
        | 2    |     | 74100 | Evian    | invalide | Rue non renseigné                  |
        | 3    | rue |       | Evian    | invalide | NPA non renseigné                  |
        | 4    | rue | 74100 |          | invalide | Localité non renseigné             |
        | 5    | rue | 74100 | Evian    | valide   | Champs obligatoires renseignés     |

  Règle: Une adresse expedition étrangère d'une personne est valide même si aucun des champs a été renseigné
    Scénario: Validation Personne - Adresse expedition étrangère
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'un salarié complet est initialisé
      Etant donné que l'adresse expedition est étrangère et ne contient aucun champ renseigné
      Quand la validation est appliquée sur la personne
      Alors le système renvoie que la personne est valide

    Plan du scénario: Validation Personne - Date naissance enfants <Test> -> <Observation> => <résultat>
      Etant donné la date du jour est 30.03.2022
      Etant donné que l´année fiscale de la déclaration est <annee fiscale>
      Etant donné qu'un salarié complet est initialisé
      Etant donné que un enfant est ajouté avec la date de naissance <date de naissance>
      Quand la validation est appliquée sur la personne
      Alors le système renvoie que la personne est <résultat>
      Exemples:
        | Test | date de naissance | annee fiscale | résultat                       | Observation                                              |
        | 1    | 31.03.2010        | 2021          | valide                         | Date de naissance valide                                 |
        | 2    |                   | 2021          | invalide avec une seule erreur | Date de naissance non renseignée                         |
        | 3    | 01.04.2022        | 2022          | invalide avec une seule erreur | Date de naissance postérieure au jour en cours           |
        | 4    | 30.03.2022        | 2022          | valide                         | Date de naissance égale au jour en cours                 |
        | 5    | 29.03.2022        | 2022          | valide                         | Date de naissance inférieure au jour en cours            |
        | 6    | 29.03.2022        | 2021          | invalide avec une seule erreur | Année Date de naissance postérieure à l'annéee fiscale   |
        | 7    | 01.01.1997        | 2022          | valide                         | Age inférieur à 26 ans durant toute l'annéee fiscale     |
        | 8    | 31.12.1996        | 2022          | invalide avec une seule erreur | Age supérieur à 26 ans à un moment dans l'annéee fiscale |

    Plan du Scénario: Etat Civil -> Union Libre Possible : <Test> -> <Observation>
      Etant donné qu'un salarié complet est initialisé
      Etant donné que le salarié a l´état civil <Etat Civil>
      Alors une union libre est possible : <Union Libre Possible>
      Alors c'est un couple officiel : <Partenariat Enregistré>
      Exemples:
        | Test | Etat Civil             | Union Libre Possible | Partenariat Enregistré | Observation                                     |
        | 1    | CELIBATAIRE            | Oui                  | Non                    | CELIBATAIRE partenariat pas possible            |
        | 2    | MARIE                  | Non                  | Oui                    | MARIE partenariat possible                      |
        | 3    | VEUF                   | Oui                  | Non                    | VEUF partenariat possible                       |
        | 4    | DIVORCE                | Oui                  | Non                    | DIVORCE partenariat possible                    |
        | 5    | SEPARE                 | Oui                  | Non                    | SEPARE partenariat possible                     |
        | 6    | PARTENARIAT_ENREGISTRE | Non                  | Oui                    | PARTENARIAT_ENREGISTRE partenariat pas possible |
        | 7    | PARTENARIAT_DISSOUS    | Oui                  | Non                    | PARTENARIAT_DISSOUS partenariat pas possible    |

    Plan du scénario: Validation Personne - Union libre <Test> -> <Observation> => <résultat>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est <anneeFiscaleLr>
      Etant donné qu'un salarié complet est initialisé
      Etant donné que l'option de vie en union libre choisie est <union libre>
      Etant donné que le salarié a l´état civil <EtatCivil>
      Etant donné que l'utilisateur saisit les informations d'un conjoint complet <Infos conjoint>
      Etant donné que le salarié a des enfants nés en : <anneesEnfants>
      Quand la validation est appliquée sur la personne salariée
      Alors le système renvoie que la personne est <résultat>
      Exemples:
        | Test | anneeFiscaleLr | anneesEnfants | union libre   | EtatCivil           | Infos conjoint | résultat                       | Observation                                                                                                |
        | 1    | 2021           |               | OUI           | CELIBATAIRE         | Oui            | valide                         | Célibataire en union libre                                                                                 |
        | 2    | 2021           |               | NON           | DIVORCE             | Non            | valide                         | Divorcé pas en union libre                                                                                 |
        | 3    | 2021           |               | NON_RENSEIGNE | SEPARE              | Oui            | valide                         | Séparé union libre non renseigne                                                                           |
        | 4    | 2021           | 2010          | OUI           | VEUF                | Oui            | valide                         | RM enfant 2021 - Veuf avec enfant en union libre                                                           |
        | 5    | 2021           | 2010          | NON           | CELIBATAIRE         | Non            | valide                         | RM enfant 2021 - Célibataire avec enfant pas en union libre                                                |
        | 6    | 2021           | 2010          | NON_RENSEIGNE | DIVORCE             | Oui            | valide                         | RM enfant 2021 - Divorcé avec enfant union libre non renseigne                                             |
        | 7    | 2021           | 2010          |               | DIVORCE             | Non            | invalide avec une seule erreur | RM enfant 2021 - Divorcé avec enfant union libre à null                                                    |
        | 8    | 2021           | 2000          | NON_RENSEIGNE | DIVORCE             | Oui            | valide                         | RM enfant 2021 - Enfants majeurs                                                                           |
        | 9    | 2021           | 2020          |               | PARTENARIAT_DISSOUS | Non            | invalide avec une seule erreur | RM enfant 2021 - Partenariat dissous avec enfant mineur et union libre à null                              |
        | 10   | 2021           | 2020          |               | VEUF                | Non            | invalide avec une seule erreur | RM enfant 2021 - Veuf avec enfant mineur et union libre à null                                             |
        | 11   | 2021           |               |               | PARTENARIAT_DISSOUS | Non            | valide                         | Partenariat dissous sans enfants et union libre à null                                                     |
        | 12   | 2021           |               |               | VEUF                | Non            | valide                         | Veuf sans enfants et union libre à null                                                                    |
        | 13   | 2021           | 2020          | OUI           | PARTENARIAT_DISSOUS | Oui            | valide                         | RM enfant 2021 - Partenariat dissous en union libre                                                        |
        | 14   | 2021           | 2001          |               | DIVORCE             | Non            | valide                         | RM enfant 2021 - Divorcé avec enfant agé de 20 ans union libre à null en 2021                              |
        | 15   | 2023           | 1997          |               | DIVORCE             | Non            | invalide avec une seule erreur | RM enfant 2023 -Divorcé avec enfant agé de 26 ans union libre à null en 2023 (invalide car age max 25 ans) |
        | 16   | 2023           | 1997          |               | DIVORCE             | Non            | invalide avec une seule erreur | RM enfant 2023 -Divorcé avec enfant agé de 26 ans union libre à null en 2023 (invalide car age max 25 ans) |
        | 17   | 2023           | 1999          | OUI           | VEUF                | Oui            | valide                         | VRM enfant 2023 - euf avec enfant en union libre                                                           |
        | 18   | 2023           | 1999          | NON           | CELIBATAIRE         | Non            | valide                         | CRM enfant 2023 - élibataire avec enfant pas en union libre                                                |
        | 19   | 2023           | 1999          | NON_RENSEIGNE | DIVORCE             | Oui            | valide                         | RM enfant 2023 - Divorcé avec enfant union libre non renseigne                                             |
        | 20   | 2023           | 1999          |               | DIVORCE             | Non            | invalide avec une seule erreur | RM enfant 2023 - Divorcé avec enfant union libre à null                                                    |
        | 21   | 2023           | 1997          | NON_RENSEIGNE | DIVORCE             | Oui            | invalide avec une seule erreur | RM enfant 2023 - Enfants majeurs (invalide car age max 25 ans)                                             |
        | 22   | 2023           | 1999          |               | PARTENARIAT_DISSOUS | Non            | invalide avec une seule erreur | RM enfant 2023 - Partenariat dissous avec enfant mineur et union libre à null                              |
        | 23   | 2023           | 1999          |               | VEUF                | Non            | invalide avec une seule erreur | RM enfant 2023 - Veuf avec enfant mineur et union libre à null                                             |
        | 24   | 2023           | 1999          | OUI           | PARTENARIAT_DISSOUS | Oui            | valide                         | RM enfant 2023 - Partenariat dissous en union libre                                                        |
        | 25   | 2023           | 1998          |               | DIVORCE             | Non            | valide                         | RRM enfant 2023 - M enfant 2021 - Divorcé avec enfant agé de 20 ans union libre à null en 2021             |

    Plan du scénario: Validation Personne - Nombre d'enfants <Test> -> <Observation> => <résultat>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'un salarié complet est initialisé
      Etant donné que le salarié a <nombre d'enfants> enfant(s)
      Quand la validation est appliquée sur la personne
      Alors le système renvoie que la personne est <résultat>
      Exemples:
        | Test | nombre d'enfants | résultat                       | Observation                                  |
        | 1    | 0                | valide                         | Pas d'enfant                                 |
        | 2    | 1                | valide                         | Un enfant                                    |
        | 3    | 20               | valide                         | Nombre maximum d'enfants                     |
        | 4    | 21               | invalide avec une seule erreur | Nombre d'enfants supérieur à la limite de 20 |

    Plan du scénario: Validation Personne - Taille des nom prénom <Test> -> <Observation> => <résultat>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'un salarié complet est initialisé
      Etant donné que l´utilisateur saisit pour le contribuable dans "Nom" une valeur avec <taille_nom> caractères
      Etant donné que l´utilisateur saisit pour le contribuable dans "Prénom" une valeur avec <taille_prenom> caractères
      Quand la validation est appliquée sur la personne salariée
      Alors le système renvoie que la personne est <résultat>
      Exemples:
        | Test | taille_nom | taille_prenom | résultat                       | Observation                                 |
        | 1    | 2          | 2             | valide                         | Valide                                      |
        | 2    | 1          | 2             | invalide avec une seule erreur | Nom renseigné avec moins de 2 caractères    |
        | 3    | 2          | 1             | invalide avec une seule erreur | Prénom renseigné avec moins de 2 caractères |
        | 4    | 2          | 61            | invalide avec une seule erreur | Nom renseigné avec plus de 60 caractères    |
        | 5    | 2          | 31            | invalide avec une seule erreur | Prénom renseigné avec plus de 30 caractères |
        | 6    | 60         | 2             | valide                         | Nom renseigné avec 60 caractères            |
        | 7    | 2          | 30            | valide                         | Prénom renseigné avec 30 caractères         |

    Plan du scénario: Validation Personne - Informations conjoint <Test> -> <Observation> => <résultat>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'un salarié complet est initialisé
      Etant donné que le salarié a l´état civil <EtatCivil>
      Etant donné que l'option de vie en union libre choisie est <union libre>
      Etant donné que le numero AVS du conjoint est "<NAVS conjoint>"
      Etant donné que le nom du conjoint est "<nom conjoint>"
      Etant donné que le prénom du conjoint est "<prénom conjoint>"
      Etant donné que l'option choisie pour les revenus du conjoint est <conjoint avec revenus>
      Quand la validation est appliquée sur la personne salariée
      Alors le système renvoie que la personne est <résultat>
      Exemples:
        | Test | EtatCivil              | union libre | nom conjoint | prénom conjoint | NAVS conjoint    | conjoint avec revenus | résultat                       | Observation                                                                  |
        | 1    | MARIE                  |             | nom          | prénom          | 756.1234.5678.97 | OUI                   | valide                         | L'état civil permet de renseigner le champ Union Libre                       |
        | 2    | MARIE                  |             |              | conjoint        |                  | OUI                   | invalide avec une seule erreur | L'état civil permet de renseigner le champ Union Libre                       |
        | 3    | PARTENARIAT_ENREGISTRE |             | nom conjoint |                 |                  | OUI                   | invalide avec une seule erreur | Manque le prénom dans les informations conjoint pour partenariat enregistré  |
        | 4    | MARIE                  |             | nom conjoint | prénom conjoint |                  |                       | invalide avec une seule erreur | Manque le revenus dans les informations conjoint pour partenariat enregistré |
        | 5    | MARIE                  |             | nom conjoint | prénom conjoint |                  | NON_RENSEIGNE         | valide                         | Conjoint avec revenu avec option NON_RENSEIGNE                               |
        | 6    | DIVORCE                | OUI         |              |                 |                  | NON_RENSEIGNE         | valide                         | Aucun renseignement conjoint pour partenariat non enregistré                 |
        | 7    | CELIBATAIRE            | OUI         |              |                 | 756.1234.5678.98 | NON_RENSEIGNE         | invalide avec une seule erreur | Le NAVS du conjoint est incorrect pour partenariat non enregistré            |
        | 8    | VEUF                   | OUI         | nom conjoint |                 |                  | NON_RENSEIGNE         | invalide avec une seule erreur | Le prenom du conjoint est vide alors que le nom est renseigne pour un veuf   |
        | 9    | VEUF                   | OUI         |              | prénom          |                  | NON_RENSEIGNE         | invalide avec une seule erreur | Le nom du conjoint est vide alors que le prénom est renseigne pour un veuf   |
        | 10   | MARIE                  |             | Doe          | John            | 756.1234.5678.98 | NON_RENSEIGNE         | invalide avec une seule erreur | Le NAVS du conjoint est incorrect pour partenariat non enregistré            |

  Règle: Le champ Union Libre peut être renseigné si l'état civil est :
  - DIVORCE
  - CELIBATAIRE
  - VEUF
  - SEPARE
  - PARTENARIAT_DISSOUS
    Plan du scénario: Validation Personne - L'Etat Civil permet de renseigner le champ Union Libre <Test> -> <Observation> => <résultat>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'un salarié complet est initialisé
      Etant donné que le salarié a l´état civil <Etat civil>
      Etant donné que l'option de vie en union libre choisie est <Union libre>
      Etant donné que l'utilisateur saisit les informations d'un conjoint complet
      Quand la validation est appliquée sur la personne salariée
      Alors le système indique que la personne est <Résultat>
      Exemples:
        | Test | Etat civil             | Union libre | Résultat                                                                   | Observation                                                                          |
        | 1    | MARIE                  | OUI         | invalide car l'état civil ne permet pas de renseigner le champ Union Libre | L'état civil MARIE ne permet pas de renseigner le champ Union Libre                  |
        | 2    | PARTENARIAT_ENREGISTRE | OUI         | invalide car l'état civil ne permet pas de renseigner le champ Union Libre | L'état civil PARTENARIAT_ENREGISTRE ne permet pas de renseigner le champ Union Libre |
        | 3    | DIVORCE                | OUI         | valide                                                                     | L'état civil DIVORCE permet de renseigner le champ Union Libre                       |
        | 4    | CELIBATAIRE            | OUI         | valide                                                                     | L'état civil CELIBATAIRE permet de renseigner le champ Union Libre                   |
        | 5    | VEUF                   | OUI         | valide                                                                     | L'état civil VEUF permet de renseigner le champ Union Libre                          |
        | 6    | SEPARE                 | OUI         | valide                                                                     | L'état civil SEPARE permet de renseigner le champ Union Libre                        |
        | 7    | PARTENARIAT_DISSOUS    | OUI         | valide                                                                     | L'état civil PARTENARIAT_DISSOUS permet de renseigner le champ Union Libre           |

  Règle: Le champ Infos Conjoint peut être renseigné si l'état civil est :
  - MARIE
  - PARTENARIAT_ENREGISTRE
  Ou si Union Libre a pour valeur :
  - OUI
  - NON_RENSEIGNE
    Plan du scénario: Validation Personne - L'Etat Civil et Union Libre permettent de renseigner Infos Conjoint <Test> -> <Observation> => <résultat>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'un salarié complet est initialisé
      Etant donné que le salarié a l´état civil <Etat civil>
      Etant donné que l'option de vie en union libre choisie est <Union libre>
      Etant donné que l'utilisateur saisit les informations d'un conjoint complet
      Quand la validation est appliquée sur la personne salariée
      Alors le système indique que la personne est <Résultat>
      Exemples:
        | Test | Etat civil             | Union libre   | Résultat                                                              | Observation                                          |
        | 1    | MARIE                  |               | valide                                                                | MARIE avec union libre à NULL                        |
        | 3    | PARTENARIAT_ENREGISTRE |               | valide                                                                | PARTENARIAT_ENREGISTRE avec union libre à NULL       |
        | 4    | DIVORCE                | OUI           | valide                                                                | DIVORCE avec union libre à OUI                       |
        | 5    | DIVORCE                | NON           | invalide car les informations du conjoint ne peuvent être renseignées | DIVORCE avec union libre à NON                       |
        | 6    | DIVORCE                | NON_RENSEIGNE | valide                                                                | DIVORCE avec union libre à NON_RENSEIGNE             |
        | 7    | DIVORCE                |               | invalide car les informations du conjoint ne peuvent être renseignées | DIVORCE avec union libre à NULL                      |
        | 8    | CELIBATAIRE            | OUI           | valide                                                                | CELIBATAIRE avec union libre à OUI                   |
        | 9    | CELIBATAIRE            | NON           | invalide car les informations du conjoint ne peuvent être renseignées | CELIBATAIRE avec union libre à NON                   |
        | 10   | CELIBATAIRE            | NON_RENSEIGNE | valide                                                                | CELIBATAIRE avec union libre à NON_RENSEIGNE         |
        | 11   | CELIBATAIRE            |               | invalide car les informations du conjoint ne peuvent être renseignées | CELIBATAIRE avec union libre à NULL                  |
        | 12   | VEUF                   | OUI           | valide                                                                | VEUF avec union libre à OUI                          |
        | 13   | VEUF                   | NON           | invalide car les informations du conjoint ne peuvent être renseignées | VEUF avec union libre à NON                          |
        | 14   | VEUF                   | NON_RENSEIGNE | valide                                                                | VEUF avec union libre à NON_RENSEIGNE                |
        | 15   | VEUF                   |               | invalide car les informations du conjoint ne peuvent être renseignées | VEUF avec union libre à NULL                         |
        | 16   | SEPARE                 | OUI           | valide                                                                | SEPARE avec union libre à OUI                        |
        | 17   | SEPARE                 | NON           | invalide car les informations du conjoint ne peuvent être renseignées | SEPARE avec union libre à NON                        |
        | 18   | SEPARE                 | NON_RENSEIGNE | valide                                                                | SEPARE avec union libre à NON_RENSEIGNE              |
        | 19   | SEPARE                 |               | invalide car les informations du conjoint ne peuvent être renseignées | SEPARE avec union libre à NULL                       |
        | 20   | PARTENARIAT_DISSOUS    | OUI           | valide                                                                | PARTENARIAT_DISSOUS avec union libre à OUI           |
        | 21   | PARTENARIAT_DISSOUS    | NON           | invalide car les informations du conjoint ne peuvent être renseignées | PARTENARIAT_DISSOUS avec union libre à NON           |
        | 22   | PARTENARIAT_DISSOUS    | NON_RENSEIGNE | valide                                                                | PARTENARIAT_DISSOUS avec union libre à NON_RENSEIGNE |
        | 23   | PARTENARIAT_DISSOUS    |               | invalide car les informations du conjoint ne peuvent être renseignées | PARTENARIAT_DISSOUS avec union libre à NULL          |

    Plan du scénario: Validation Personne - Informations conjoint - Taille des nom prénom <Test> -> <Observation> => <résultat>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'un salarié complet est initialisé
      Etant donné que le salarié a l´état civil MARIE
      Etant donné que l'option de vie en union libre n'est pas renseignée
      Etant donné que l´utilisateur saisit pour le conjoint dans "Nom" une valeur avec <taille_nom> caractères
      Etant donné que l´utilisateur saisit pour le conjoint dans "Prénom" une valeur avec <taille_prenom> caractères
      Quand la validation est appliquée sur la personne salariée
      Alors le système renvoie que la personne est <résultat>
      Exemples:
        | Test | taille_nom | taille_prenom | résultat                       | Observation                                 |
        | 1    | 2          | 2             | valide                         | Valide                                      |
        | 2    | 1          | 2             | invalide avec une seule erreur | Nom renseigné avec moins de 2 caractères    |
        | 3    | 2          | 1             | invalide avec une seule erreur | Prénom renseigné avec moins de 2 caractères |
        | 4    | 2          | 61            | invalide avec une seule erreur | Nom renseigné avec plus de 60 caractères    |
        | 5    | 2          | 31            | invalide avec une seule erreur | Prénom renseigné avec plus de 30 caractères |
        | 6    | 60         | 2             | valide                         | Nom renseigné avec 60 caractères            |
        | 7    | 2          | 30            | valide                         | Prénom renseigné avec 30 caractères         |

    # Scenario qui vérifie que Nom, Prenom et Date de naissance sont bien renseignés
    Plan du scénario: Validation Personne - Validation enfants <Test> -> <Observation> => <résultat>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'un salarié complet est initialisé
      Etant donné qu'un enfant "<NomEnfant>" "<PrenomEnfant>" né le <date de naissance> est ajouté au salarié
      Quand la validation est appliquée sur la personne salariée
      Alors le système renvoie que la personne est <résultat>
      Exemples:
        | Test | NomEnfant | PrenomEnfant | date de naissance | résultat                       | Observation            |
        | 1    | Nom       | prenom       | 30.03.2020        | valide                         | Enfants valide         |
        | 2    | Nom       |              | 30.03.2021        | invalide avec une seule erreur | Prénom non renseigné   |
        | 3    |           | prenom       | 30.03.2021        | invalide avec une seule erreur | Nom non renseigné      |
        | 4    | Nom       | prenom       |                   | invalide avec une seule erreur | Date non renseigné     |
        | 5    |           |              | 30.03.2020        | invalide                       | Nom prenom obligatoire |
        | 6    | Nom       | prenom       | 30.03.2022        | invalide                       | Date dans le futur     |

    # TODO-SHOULD: ajouter un scenario qui teste les validations de Nom (limite 1-60 caractères) et ensuite
    # un scenario qui vérifie que Nom groupe, Nom artiste, Nom Personne ASC,... sont de type Nom ?
    # Comme cela si demain la règle change à 70 caractères par exemple, ben on aura qu'un seul scénario à changer
    Plan du scénario: Validation Taille des nom prénom enfants <Test> -> <Observation> => <résultat>
      Etant donné la date du jour est 30.03.2021
      Etant donné l´année fiscale de la déclaration est 2021
      Etant donné qu'un salarié complet est initialisé
      Etant donné qu'un enfant avec un nom de <taille_nom> caractères et un prénom avec <taille_prenom> caractères né le <date de naissance> est ajouté au salarié
      Quand la validation est appliquée sur la personne salariée
      Alors le système renvoie que la personne est <résultat>
      Exemples:
        | Test | taille_nom | taille_prenom | date de naissance | résultat                       | Observation                                 |
        | 1    | 2          | 2             | 30.03.2020        | valide                         | Enfants valide                              |
        | 2    | 2          | 1             | 30.03.2021        | invalide avec une seule erreur | Prénom renseigné avec moins de 2 caractères |
        | 3    | 1          | 2             | 30.03.2021        | invalide avec une seule erreur | Nom renseigné avec moins de 2 caractères    |
        | 4    | 2          | 31            | 30.03.2021        | invalide avec une seule erreur | Prénom renseigné avec plus de 30 caractères |
        | 5    | 61         | 2             | 30.03.2021        | invalide avec une seule erreur | Nom renseigné avec plus de 60 caractères    |
        | 6    | 2          | 30            | 30.03.2021        | valide                         | Prénom renseigné avec 30 caractères         |
        | 7    | 60         | 2             | 30.03.2021        | valide                         | Nom renseigné avec 60 caractères            |
