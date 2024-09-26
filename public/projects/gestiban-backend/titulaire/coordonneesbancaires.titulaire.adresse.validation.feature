#language: fr

Fonctionnalité: Validation d'une Adresse

  Règle: R1 - Afin d'être valide, une adresse doit satisfaire les critères suivants :
  - Les champs obligatoires sont : Pays, Rue, Numero, Code Postal, Commune
  - La taille du nom de la rue doit être entre 2 et 29 caractères
  - Avoir un code pays de 2 caractères

    Plan du scénario: Validation adresse du titulaire du compte <Test> -> <Observation>
      Etant donné que l´utilisateur saisit le pays <pays>
      Et que l´utilisateur saisit la rue <rue>
      Et que l´utilisateur saisit le numéro <numero>
      Et que l´utilisateur saisit le code postal <codePostal>
      Et que l´utilisateur saisit la ville <ville>
      Quand le système valide l'adresse
      Alors le système renvoie que l'adresse est <resultat>

      Exemples:
        | Test | pays   | rue       | numero | codePostal | ville     | resultat | Observation                                                |
        | 1    | France | salève    | 22     | 74100      | Annemasse | valide   | Saisie Manuelle - Tous les champs obligatoires renseignés  |
        | 2    |        |           |        |            |           | invalide | Saisie Manuelle - Aucune information obligatoire renseigné |
        | 3    |        | salève    | 22     | 74100      | Annemasse | invalide | Saisie Manuelle - Pays non renseigné                       |
        | 4    | France | salève    |        | 74100      |           | invalide | Saisie Manuelle - Commune non renseignée                   |
        | 5    | France | salève    | 22     |            | Annemasse | invalide | Saisie Manuelle - Code postal non renseigné                |
        | 6    | France | salève    |        | 74100      | Annemasse | invalide | Saisie Manuelle - Numéro de rue non renseigné              |
        | 7    | France |           | 22     | 74100      | Annemasse | invalide | Saisie Manuelle - Nom Rue non Renseigné                    |
        | 8    | Suisse | grand-pré | 64     | 1202       | Genève    | valide   | Saisie Manuelle - Tous les champs obligatoires renseignés  |
        | 9    |        | grand-pré | 64     | 1226       | Genève    | invalide | Saisie Manuelle - Pays non renseigné                       |
        | 10   | Suisse | grand-pré |        | 1226       |           | invalide | Saisie Manuelle - Commune non renseignée                   |
        | 11   | Suisse | grand-pré | 64     |            | Genève    | invalide | Saisie Manuelle - Code postal non renseigné                |
        | 12   | Suisse | grand-pré |        | 1226       | Genève    | invalide | Saisie Manuelle - Numéro de rue non renseigné              |
        | 13   | Suisse |           | 64     | 1226       | Genève    | invalide | Saisie Manuelle - Nom Rue non Renseigné                    |

  Règle: R2 - Afin d'être valide, un nom de la rue doit satisfaire les critères suivants :
  - Avoir une taille entre 2 et 29 caractères

    Plan du scénario: Validation de la taille du champ "Rue" <Test> -> <Observation>
      Etant donné que l´utilisateur a saisi une adresse valide
      Et que l'utilisateur saisit un nom de rue avec <taille_nom_rue> caractères
      Quand le système valide l'adresse
      Alors le système renvoie que l'adresse est <resultat>

      Exemples:
        | Test | taille_nom_rue | resultat | Observation                    |
        | 1    | 1              | invalide | Nom avec moins de 2 caractères |
        | 2    | 2              | valide   | Nom avec 2 caractères          |
        | 3    | 43             | valide   | Nom avec 43 caractères         |
        | 3    | 44             | valide   | Nom avec 44 caractères         |
        | 4    | 46             | invalide | Nom avec plus de 44 caractères |

  Règle: R3 - Afin d'être valide, un numéro de la rue doit satisfaire les critères suivants :
  - Avoir une taille maximale de 5 caractères

    Plan du scénario: Validation de la taille du champ "Numéro rue" <Test> -> <Observation>
      Etant donné que l´utilisateur a saisi une adresse valide
      Et que l'utilisateur saisit un numéro de rue avec <taille_numéro_rue> caractères
      Quand le système valide l'adresse
      Alors le système renvoie que l'adresse est <resultat>

      Exemples:
        | Test | taille_numéro_rue | resultat | Observation                      |
        | 1    | 1                 | valide   | Numéro avec 1 caractère          |
        | 2    | 5                 | valide   | Numéro avec 5 caractères         |
        | 3    | 6                 | invalide | Numéro avec plus de 5 caractères |

  Règle: R4 - Afin d'être valide, un code postal doit satisfaire les critères suivants :
  - Avoir une taille maximale de 6 caractères

    Plan du scénario: Validation de la taille du champ "Code postal" <Test> -> <Observation>
      Etant donné que l´utilisateur a saisi une adresse valide
      Et que l'utilisateur saisit un code postal de rue avec <taille_code_postal> caractères
      Quand le système valide l'adresse
      Alors le système renvoie que l'adresse est <resultat>

      Exemples:
        | Test | taille_code_postal | resultat | Observation                           |
        | 1    | 1                  | valide   | Code postal avec 1 caractère          |
        | 2    | 6                  | valide   | Code postal avec 6 caractères         |
        | 3    | 7                  | invalide | Code postal avec plus de 6 caractères |

  Règle: R5 - Afin d'être valide, une commune doit satisfaire les critères suivants :
  - Avoir une taille maximale de 28 caractères

    Plan du scénario: Validation de la taille du champ "Ville" <Test> -> <Observation>
      Etant donné que l´utilisateur a saisi une adresse valide
      Et que l'utilisateur saisit un nom de ville avec <taille_commune> caractères
      Quand le système valide l'adresse
      Alors le système renvoie que l'adresse est <resultat>

      Exemples:
        | Test | taille_commune | resultat | Observation                      |
        | 1    | 1              | valide   | Ville avec 1 caractère           |
        | 2    | 43             | valide   | Ville avec 43 caractères         |
        | 3    | 44             | invalide | Ville avec plus de 43 caractères |
