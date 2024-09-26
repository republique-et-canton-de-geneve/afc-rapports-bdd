#language: fr

Fonctionnalité: F2 - Validation de changement de nom

  Règle: R1 - Afin d'être valide un changement de nom doit satisfaire les critères suivants:
  - Le nom est obligatoire
  - le nom doit contenir entre 2 et 30 caractère
  - le nom ne doit pas être Benjamin, Fabien ou Nicolas
  - un commentaire est obligatoire
  - il doit avoir un nombre de caractères de 5

    @validation
    Plan du scénario: Validation de changement de nom <Test> -> <Observation>
      Etant donné que l´utilisateur saisi le nom <nom> et le commentaire <commentaire>
      Quand le système valide le changement de nom
      Alors le système renvoie pour le nom : <resultatNom>
      Et le système renvoie pour le commentaire : <resultatCommentaire>
      Exemples:
        | Test | nom                                                               | commentaire          | resultatNom                                                 | resultatCommentaire                           | Observation                |
        | 1    | thomas                                                            | Test                 | valide                                                      | valide                                        | Formulaire Valide          |
        | 2    | Benjamin                                                          | Test                 | le nom Benjamin est beaucoup trop commun                    | valide                                        | Nom trop commun (benjamin) |
        | 3    | fabien                                                            | Test                 | le nom fabien est beaucoup trop commun                      | valide                                        | Nom trop commun (fabien)   |
        | 4    | f                                                                 | Test                 | Le nouveau nom doit avoir une taille comprise entre 2 et 30 | valide                                        | Nom trop court             |
        | 5    | unnombeaucouptroplong unnombeaucouptroplong unnombeaucouptroplong | Test                 | Le nouveau nom doit avoir une taille comprise entre 2 et 30 | valide                                        | Nom trop long              |
        | 6    | thomas                                                            | comentaire trop long | valide                                                      | Ce commentaire est trop grand. Taille max : 5 | Commentaire trop long      |
