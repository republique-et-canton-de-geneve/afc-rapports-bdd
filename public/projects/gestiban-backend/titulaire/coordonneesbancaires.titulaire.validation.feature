#language: fr
Fonctionnalité: F1 - Validation du titulaire du compte bancaire

  Règle: R1 - Afin d'être valide, un titulaire doit satisfaire les critères suivants :
  - Avoir un nom/prénom renseigné
  - Avoir une taille de minimum 2 caractères et de maximum 35 caractères

    Plan du scénario: Validation titulaire <Test> -> <Observation>
      Etant donné que l´utilisateur saisi un titulaire avec nomPrenom : <nomPrenom>
      Quand le système valide le titulaire
      Alors le système renvoie que le titulaire est <resultat>
      Exemples:
| Test | nomPrenom                                                                                                                                                                                                                                                                                                                   | resultat                                 | Observation                          |
        | 1    | Marie Durand                                                                                                                                                                                                                                                                                                        | valide                                   | Valide                               |
        | 2    |                                                                                                                                                                                                                                                                                                                     | invalide car nomPrenom vide              | Invalide car nomPrenom non renseigné |
        | 3    | M                                                                                                                                                                                                                                                                                                                   | invalide car longueur nomPrenom invalide | Invalide car taille nomPrenom < 2    |
        | 4    | Marie Mauricette Jeanne-Laure Annick Georgette Iphigénie Erin Julie Alicia Gwendoline Katya Sophie Andromède Sandrine Miho Nafissatou Aminata Sandy Demi Vivina Alice Audrey Clara Ygritte Renée Laurie Noémie Saadia Norah Sarah Okoye Nakia Dee Dee Serena Venus Ophélie Oprah Karine Louise Emilie Durand-Dupont | invalide car longueur nomPrenom invalide | Invalide car taille nomPrenom > 300  |
        | 5    | Marie Mauricette Jeanne-Laure Duran                                                                                                                                                                                                                                                                                 | valide                                   | valide car taille nomPrenom <= 300   |
        | 6    | JL                                                                                                                                                                                                                                                                                                                  | valide                                   | valide car taille nomPrenom = 2      |
