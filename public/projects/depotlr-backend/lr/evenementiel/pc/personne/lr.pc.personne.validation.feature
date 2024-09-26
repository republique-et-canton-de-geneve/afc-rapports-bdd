#language: fr
Fonctionnalité: Validation d'une PRESTATIONS_EN_CAPITAL - Partie personne

  Contexte:
    Etant donné qu'un DPI PRESTATIONS_EN_CAPITAL est sélectionné
    Etant donné que l´année fiscale de la déclaration est 2021
    Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI

  Règle: Afin d'être valide, une personne PRESTATIONS_EN_CAPITAL doit satisfaire les critères suivants
  - Le Numero AVS est facultatif
  - Le nom est obligatoire
  - Le prénom est obligatoire
  - La date de naissance est obligatoire
  - L'adresse est obligatoire et est étrangère
  - La nationalité est obligatoire

    Plan du scénario: Validation Personne PRESTATIONS_EN_CAPITAL - Validation des champs <Test> -> <Observation>
      Et l'utilisateur saisit pour la première retenue de la LR dans "Nom" la valeur "<nom>"
      Et l'utilisateur saisit pour la première retenue de la LR dans "Numéro AVS" la valeur "<numero AVS>"
      Et l'utilisateur saisit pour la première retenue de la LR dans "Prénom" la valeur "<prenom>"
      Et l'utilisateur saisit pour la première retenue de la LR dans "Date de naissance" la valeur "<date de naissance>"
      Et l'utilisateur saisit pour la première retenue de la LR dans "Adresse" la valeur "<adresse>"
      Et l'utilisateur saisit pour la première retenue de la LR dans "Nationalité" la valeur "<nationalite>"
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est <resultat>
      Exemples:
        | Test | numero AVS       | nom | prenom | date de naissance | adresse       | nationalite | resultat | Observation                 |
        | 1    | 756.9999.9999.91 | nom | prenom | 01.01.1990        | ETRANGER      | CH          | Valide   | Personne valide             |
        | 2    |                  | nom | prenom | 01.01.1990        | ETRANGER      | CH          | Valide   | Personne valide             |
        | 3    | 756.9999.9999.91 |     | prenom | 01.01.1990        | ETRANGER      | CH          | Invalide | Manque nom                  |
        | 4    | 756.9999.9999.91 | nom |        | 01.01.1990        | ETRANGER      | CH          | Invalide | Manque prénom               |
        | 5    | 756.9999.9999.91 | nom | prenom |                   | ETRANGER      | CH          | Invalide | Manque la date de naissance |
        | 6    | 756.9999.9999.91 | nom | prenom | 01.01.1990        | NON_RENSEIGNE | CH          | Invalide | Manque l'adresse            |
        | 7    | 756.9999.9999.91 | nom | prenom | 01.01.1990        | HORS_GENEVE   | CH          | Invalide | Adresse non étrangère       |
        | 8    | 756.9999.9999.91 | nom | prenom | 01.01.1990        | GENEVE        | CH          | Invalide | Adresse non étrangère       |
        | 9    | 756.9999.9999.91 | nom | prenom | 01.01.1990        | ETRANGER      |             | Invalide | Manque la nationalité       |

  Règle: Une personne PRESTATIONS_EN_CAPITAL est valide lorsque la taille des champs ci-dessous est respecté:
  - Si Le nom est renseigné il doit être compris entre 2 et 60 caractères
  - Si Le prénom est renseigné il doit être compris entre 2 et 30 caractères

    Plan du scénario: Validation Personne PRESTATIONS_EN_CAPITAL -  taille champs <Test> -> <Observation>
      Et l'utilisateur saisit pour la première retenue de la LR dans "Nom" une valeur avec <taille_nom> caractères
      Et l'utilisateur saisit pour la première retenue de la LR dans "Prénom" une valeur avec <taille_prenom> caractères
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est <resultat>
      Exemples:
        | Test | taille_nom | taille_prenom | resultat | Observation                                 |
        | 1    | 1          | 2             | Invalide | Nom renseigné avec moins de 2 caracteres    |
        | 2    | 2          | 1             | Invalide | Prénom renseigné avec moins de 2 caracteres |
        | 3    | 61         | 2             | Invalide | Nom renseigné avec plus de 60 caracteres    |
        | 4    | 2          | 31            | Invalide | Prénom renseigné avec plus de 30 caracteres |
        | 5    | 60         | 2             | Valide   | Nom renseigné avec 60 caracteres            |
        | 6    | 2          | 30            | Valide   | Prénom renseigné avec 30 caracteres         |

    Plan du scénario: Validation Personne PRESTATIONS_EN_CAPITAL - Numéro AVS <Test> -> <Observation>
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

  Règle: La date de naissance d'une personne prestations en capital est valide si :
  - La date de naissance est renseignée
  - La date de naissance est dans le passé
  - L'âge maximal (100 ans) de la personne n'est pas dépassé

    Plan du scénario: Validation Personne PRESTATIONS_EN_CAPITAL - Date de naissance <Test> -> <Observation> => <Resultat>
      Etant donné que la date du jour est 01.04.2021
      Et l'utilisateur saisit pour la première retenue de la LR dans "Date de naissance" la valeur "<date de naissance>"
      Quand l'utilisateur valide cette première retenue
      Alors le système indique que cette retenue est <résultat>
      Exemples:
        | Test | date de naissance | résultat                               | Observation                        |
        | 1    | 01.02.1990        | valide                                 | Personne a 31 ans                  |
        | 2    | 02.05.2021        | invalide car la date est dans le futur | Personne née un mois dans le futur |
        | 3    | 01.01.1920        | invalide car dépasse l'âge maximal     | Personne a 101 ans                 |
        | 4    | 01.01.1921        | valide                                 | Personne a 100 ans                 |
        | 5    | 01.01.2021        | valide                                 | Personne née en 2021               |
        | 6    | 01.04.2021        | valide                                 | Personne née le jour même          |

  Règle: Les règles de validation d'une adresse domicile étrangère d'une personne sont les suivantes :
  - Pays obligatoire
  - rue obligatoire
  - NPA obligatoire
  - Localité obligatoire
    Plan du scénario: Validation Personne PRESTATIONS_EN_CAPITAL - Adresse domicile étrangère <Test> -> <Observation>
      Et l'utilisateur saisit pour la première retenue de la LR dans "NPA" la valeur "<NPA>"
      Et l'utilisateur saisit pour la première retenue de la LR dans "Localité" la valeur "<localité>"
      Et l'utilisateur saisit pour la première retenue de la LR dans "Rue" la valeur "<rue>"
      Et l'utilisateur saisit pour la première retenue de la LR dans "Pays" la valeur "<pays>"
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est <resultat>
      Exemples:
        | Test | pays | rue | NPA   | localité | resultat | Observation                        |
        | 1    |      |     |       |          | invalide | Champs obligatoires non renseignés |
        | 2    |      | rue | 74100 | Evian    | invalide | Pays non renseigné                 |
        | 3    | FR   |     | 74100 | Evian    | invalide | Rue non renseignée                 |
        | 4    | FR   | rue |       | Evian    | invalide | NPA non renseigné                  |
        | 5    | FR   | rue | 74100 |          | invalide | Localité non renseignée            |
        | 6    | FR   | rue | 74100 | Evian    | valide   | Champs obligatoires renseignés     |
