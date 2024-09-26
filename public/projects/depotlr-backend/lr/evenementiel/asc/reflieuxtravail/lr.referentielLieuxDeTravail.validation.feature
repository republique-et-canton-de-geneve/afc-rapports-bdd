#language: fr

Fonctionnalité: Validation d'une LR ASC - Partie Référentiel des Lieux de Travail

  Contexte:
    Etant donné qu'un DPI ASC est sélectionné
    Etant donné l´année en cours 2021

  Règle: Les champs obligatoires pour un lieu de travail ASC sont :
  - Les champs obligatoires sont : Pays, NPA, Commune, Rue (pas localité)
  - L'adresse doit être Genevoise pour un ASC

    Plan du scénario: Validation LR - Référentiel des lieux de travail <Test> -> <Observation>
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Etant donné que l´utilisateur a saisi un lieu de travail dans le référentiel des lieux de travail
      Et que ce lieu de travail a le Mode <typeSaisie>
      Et que ce lieu de travail a le Code Pays "<pays>"
      Et que ce lieu de travail a la Rue "<rue>"
      Et que ce lieu de travail a la Code Commune "<commune>"
      Et que ce lieu de travail a le NPA "<npa>"
      Et que ce lieu de travail a la Localite "<localite>"
      Et que ce lieu de travail a le Code Canton "<canton>"
      Et que ce lieu de travail a le Nom Lieu "<nom>"
      Et que ce lieu de travail a l'adresse WS "<adresseWS>"
      Et que ce lieu de travail a le IdPadr "<idPadr>"
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est <resultat>

      Exemples:
        | Test | typeSaisie | pays | nom | rue | commune | npa   | localite | canton | adresseWS | idPadr    | resultat | Observation                                             |
        | 1    | Libre      | CH   | nom | rue | 6621    | 1000  |          | GE     |           |           | Valide   | Saisie Libre - Tous les champs obligatoires renseignés  |
        | 2    | Libre      |      |     |     |         |       |          |        |           |           | Invalide | Saisie Libre - Aucune information obligatoire renseigné |
        | 3    | Libre      |      | nom | rue | 6621    | 1000  | Genève   | GE     |           |           | Invalide | Saisie Libre - Pays non renseigné                       |
        | 4    | Libre      | CH   | nom | rue | 6621    | 1000  |          | GE     |           |           | Valide   | Saisie Libre - Localité non renseigné                   |
        | 5    | Libre      | CH   | nom | rue | 1000    | 1000  | Lausanne | VD     |           |           | Invalide | Saisie Libre - Adresse non genevoise pour un ASC        |
        | 6    | Libre      | CH   | nom | rue | 6621    |       | Genève   | GE     |           |           | Invalide | Saisie Libre - Npa non renseigné                        |
        | 7    | Libre      | CH   | nom | rue | 6621    | 999   | Genève   | GE     |           |           | Invalide | Saisie Libre - Npa inférieur à 1000                     |
        | 8    | Libre      | CH   | nom | rue | 6621    | 10000 | Genève   | GE     |           |           | Invalide | Saisie Libre - Npa supérieur à 9999                     |
        | 9    | Libre      | CH   | nom | rue |         | 1000  | Genève   | GE     |           |           | Invalide | Saisie Libre - Commune non renseigné                    |
        | 10   | Libre      | CH   | nom | rue | 6600    | 1000  | Genève   | GE     |           |           | Invalide | Saisie Libre - Commune inférieur à  6601                |
        | 11   | Libre      | CH   | nom | rue | 6646    | 1000  | Genève   | GE     |           |           | Invalide | Saisie Libre - Commune supérieur à  6645                |
        | 12   | Libre      | CH   | nom | rue | 6602    | 1000  | Genève   | GE     |           |           | Valide   | Saisie Libre - Commune égale à  6602                    |
        | 13   | Libre      | CH   | nom | rue | 6645    | 1000  | Genève   | GE     |           |           | Valide   | Saisie Libre - Commune égale à  6645                    |
        | 14   | Libre      | CH   | nom |     | 6645    | 1000  | Genève   | GE     |           |           | Invalide | Saisie Libre - Rue non Renseigné                        |
        | 15   | Libre      | CH   |     | rue | 6645    | 1000  | Genève   | GE     |           |           | Invalide | Saisie Libre - Nom non Renseigné                        |
        | 16   | Libre      | CH   | nom | rue | 6621    | 1000  |          |        |           |           | Invalide | Saisie Libre - Manque le canton                         |
        | 17   | Libre      | CH   | nom | rue | 6621    | 1000  |          | TT     |           |           | Invalide | Saisie Libre - Canton inconnu                           |
        | 18   | WebService |      |     |     |         |       |          | GE     |           | 123456789 | Invalide | Saisie WS - Aucune information obligatoire renseigné    |
        | 19   | WebService | CH   | nom | rue | 6621    | 1000  |          | GE     | AA        | 123456789 | Valide   | Saisie WS - Tous les champs obligatoires renseignés     |
        | 20   | WebService |      | nom | rue | 6621    | 1000  | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Pays non renseigné                          |
        | 21   | WebService | CH   | nom | rue | 6621    | 1000  |          | GE     | AA        | 123456789 | Valide   | Saisie WS - Localité non renseigné                      |
        | 22   | WebService | CH   | nom | rue | 6621    |       | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Npa non renseigné                           |
        | 23   | WebService | CH   | nom | rue | 6621    | 999   | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Npa inférieur à 1000                        |
        | 24   | WebService | CH   | nom | rue | 6621    | 10000 | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Npa supérieur à 9999                        |
        | 25   | WebService | CH   | nom | rue |         | 1000  | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Commune non renseigné                       |
        | 26   | WebService | CH   | nom | rue | 6600    | 1000  | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Commune inférieur à  6601                   |
        | 27   | WebService | CH   | nom | rue | 6646    | 1000  | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Commune supérieur à  6645                   |
        | 28   | WebService | CH   | nom | rue | 6602    | 1000  | Genève   | GE     | AA        | 123456789 | Valide   | Saisie WS - Commune égale à  6602                       |
        | 29   | WebService | CH   | nom | rue | 6645    | 1000  | Genève   | GE     | AA        | 123456789 | Valide   | Saisie WS - Commune égale à  6645                       |
        | 30   | WebService | CH   | nom |     | 6645    | 1000  | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Rue non Renseigné                           |
        | 31   | WebService | CH   |     | rue | 6645    | 1000  | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Nom non Renseigné                           |
        | 32   | WebService | CH   | nom | rue | 6645    | 1000  | Genève   | GE     |           | 123456789 | Invalide | Saisie WS - Adresse WS non renseigné                    |
        | 33   | WebService | CH   | nom |     |         |       |          |        | AA        | 123456789 | Invalide | Saisie WS - Adresse WS sans complétion                  |
        | 34   | WebService | CH   | nom | rue | 6645    | 1000  | Genève   | GE     | AA        |           | Invalide | Saisie WS - IdPAdr non renseigné                        |
        | 35   | WebService | CH   | nom | rue | 1000    | 1000  | Lausanne | VD     | AA        | 123456789 | Invalide | Saisie WS - Adresse non genevoise pour un ASC           |

    Plan du scénario: Validation LR - Référentiel des lieux de travail unicité nom lieu de représentation <Test> -> <Observation>
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Etant donné que l´utilisateur a saisi un lieu de travail valide dans le référentiel des lieux de travail
      Et que ce lieu de travail a le Nom Lieu "<nom>"
      Et que l´utilisateur a saisi un autre lieu de travail valide dans le référentiel des lieux de travail
      Et que ce lieu de travail a le Nom Lieu "<nom2>"
      Quand l´utilisateur valide sa LR
      Alors le système renvoie que la LR est <resultat>

      Exemples:
        | Test | nom | nom2 | resultat | Observation                        |
        | 1    | nom | nom2 | Valide   | Nom lieu representation unique     |
        | 2    | nom | nom  | Invalide | Nom lieu representation non unique |
