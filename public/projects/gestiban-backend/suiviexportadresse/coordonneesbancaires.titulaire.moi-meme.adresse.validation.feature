#language: fr
Fonctionnalité: F1 - Validation de l'adresse du titulaire si c'est Moi-même

  Règle: R1 - Afin d'être valide, l'adresse du titulaire si c'est moi-même doit satisifare les critères suivants :
    - Exister quand on la recherche par le Numéro R de l'utilisateur connecté
    - Avoir le flag validiteDomicile à true

      Plan du scénario: Validation adresse du titulaire si c'est Moi-même pour adresse domicile valide <Test> -> <Observation>
        Etant donné que l'utilisateur saisit comme titulaire Moi-même
        Et que l'utilisateur connecté a une adresse <validiteAdresse>
        Quand le système valide l'adresse du titulaire
        Alors le système renvoie que l'adresse de domicile du titulaire est <resultat>

        Exemples:
          | Test | validiteAdresse  | resultat    | Observation                   |
          | 1    | valide           | valide      | Adresse du domicile valide    |
          | 2    | invalide         | invalide    | Adresse du domicile invalide  |
