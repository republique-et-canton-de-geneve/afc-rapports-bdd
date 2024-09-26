#language: fr

Fonctionnalité: Validation d'une LR SALARIES - Partie Référentiel des Lieux de Travail

  Contexte:
    Etant donné qu'un DPI SALARIES est sélectionné
    Etant donné l´année en cours 2021

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
      | Test | typeSaisie | pays | nom | rue | commune | npa   | localite | canton | adresseWS | idPadr    | resultat | Observation                                                 |
      | 1    | Libre      |      |     |     |         |       |          | GE     |           | 123456789 | Invalide | Saisie Libre - Aucune information obligatoire renseigné     |
      | 2    | Libre      | CH   | nom | rue | 6621    | 1000  |          | GE     |           | 123456789 | Valide   | Saisie Libre - Tous les champs obligatoires renseignés      |
      | 3    | Libre      |      | nom | rue | 6621    | 1000  | Genève   | GE     |           | 123456789 | Invalide | Saisie Libre - Pays non renseigné                           |
      | 4    | Libre      | CH   | nom | rue | 6621    | 1000  |          | GE     |           | 123456789 | Valide   | Saisie Libre - Localité non renseigné                       |
      | 5    | Libre      | CH   | nom | rue | 6621    |       | Genève   | GE     |           | 123456789 | Invalide | Saisie Libre - Npa non renseigné                            |
      | 6    | Libre      | CH   | nom | rue | 6621    | 999   | Genève   | GE     |           | 123456789 | Invalide | Saisie Libre - Npa inférieur à 1000                         |
      | 7    | Libre      | CH   | nom | rue | 6621    | 10000 | Genève   | GE     |           | 123456789 | Invalide | Saisie Libre - Npa supérieur à 9999                         |
      | 8    | Libre      | CH   | nom | rue |         | 1000  | Genève   | GE     |           | 123456789 | Invalide | Saisie Libre - Commune non renseigné                        |
      | 9    | Libre      | CH   | nom | rue | 6600    | 1000  | Genève   | GE     |           | 123456789 | Invalide | Saisie Libre - Commune inférieur à  6601                    |
      | 10   | Libre      | CH   | nom | rue | 6646    | 1000  | Genève   | GE     |           | 123456789 | Invalide | Saisie Libre - Commune supérieur à  6645                    |
      | 11   | Libre      | CH   | nom | rue | 6602    | 1000  | Genève   | GE     |           | 123456789 | Valide   | Saisie Libre - Commune égale à  6602                        |
      | 12   | Libre      | CH   | nom | rue | 6645    | 1000  | Genève   | GE     |           | 123456789 | Valide   | Saisie Libre - Commune égale à  6645                        |
      | 13   | Libre      | CH   | nom |     | 6645    | 1000  | Genève   | GE     |           | 123456789 | Invalide | Saisie Libre - Rue non Renseigné                            |
      | 14   | Libre      | CH   |     | rue | 6645    | 1000  | Genève   | GE     |           | 123456789 | Invalide | Saisie Libre - Nom non Renseigné                            |
      | 15   | WebService |      |     |     |         |       |          | GE     |           | 123456789 | Invalide | Saisie WS - Aucune information obligatoire renseigné        |
      | 16   | WebService | CH   | nom | rue | 6621    | 1000  |          | GE     | AA        | 123456789 | Valide   | Saisie WS - Tous les champs obligatoires renseignés         |
      | 17   | WebService |      | nom | rue | 6621    | 1000  | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Pays non renseigné                              |
      | 18   | WebService | CH   | nom | rue | 6621    | 1000  |          | GE     | AA        | 123456789 | Valide   | Saisie WS - Localité non renseigné                          |
      | 19   | WebService | CH   | nom | rue | 6621    |       | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Npa non renseigné                               |
      | 20   | WebService | CH   | nom | rue | 6621    | 999   | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Npa inférieur à 1000                            |
      | 21   | WebService | CH   | nom | rue | 6621    | 10000 | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Npa supérieur à 9999                            |
      | 22   | WebService | CH   | nom | rue |         | 1000  | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Commune non renseigné                           |
      | 23   | WebService | CH   | nom | rue | 6600    | 1000  | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Commune inférieur à  6601                       |
      | 24   | WebService | CH   | nom | rue | 6646    | 1000  | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Commune supérieur à  6645                       |
      | 25   | WebService | CH   | nom | rue | 6602    | 1000  | Genève   | GE     | AA        | 123456789 | Valide   | Saisie WS - Commune égale à  6602                           |
      | 26   | WebService | CH   | nom | rue | 6645    | 1000  | Genève   | GE     | AA        | 123456789 | Valide   | Saisie WS - Commune égale à  6645                           |
      | 27   | WebService | CH   | nom |     | 6645    | 1000  | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Rue non Renseigné                               |
      | 28   | WebService | CH   |     | rue | 6645    | 1000  | Genève   | GE     | AA        | 123456789 | Invalide | Saisie WS - Nom non Renseigné                               |
      | 29   | WebService | CH   | nom | rue | 6645    | 1000  | Genève   | GE     |           | 123456789 | Invalide | Saisie WS - Adresse WS non renseigné                        |
      | 30   | WebService | CH   | nom |     |         |       |          |        | AA        | 123456789 | Invalide | Saisie WS - Adresse WS sans complétion                      |
      | 31   | WebService | CH   | nom | rue | 6645    | 1000  | Genève   | GE     | AA        |           | Invalide | Saisie WS - IdPAdr non renseigné                            |
      | 32   | WebService | CH   | nom | rue | 1000    | 1000  | Lausanne | VD     | AA        |           | Valide   | Saisie WS - Adresse non genevoise pour un Salarie           |
      | 33   | Libre      | CH   | nom | rue | 1000    | 1000  | Lausanne | VD     |           |           | Valide   | Saisie Libre - Adresse non genevoise pour un Salarie        |
      | 34   | Libre      | CH   | nom | rue |         | 1000  | Lausanne | VD     |           |           | Valide   | Saisie Libre - Adresse non genevoise sans commune politique |
      | 35   | Libre      | FR   | nom | rue |         | 74000 | Evian    |        |           |           | Invalide | Saisie Libre - Adresse étranger sans commune politique      |
      | 36   | Libre      | CH   | nom | rue | 1000    | 1000  | Lausanne | XX     |           |           | Invalide | Saisie Libre - Code canton invalide                         |
      | 37   | Libre      | CH   | nom | rue | 1000    | 1000  | Lausanne |        |           |           | Invalide | Saisie Libre - Code canton non renseigné                    |


  Plan du scénario: Validation taille du nom du lieu de travail <Test> -> <Observation>
    Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
    Etant donné que l´utilisateur a saisi un lieu de travail valide dans le référentiel des lieux de travail
    Et que ce lieu de travail a un Nom Lieu avec <taille_nom_lieu> caractères
    Quand l´utilisateur valide sa LR
    Alors le système renvoie que la LR est <resultat>

    Exemples:
      | Test | taille_nom_lieu | resultat | Observation                    |
      | 1    | 1               | Invalide | Nom avec moins de 2 caractères |
      | 2    | 2               | Valide   | Nom avec 2 caractères          |
      | 3    | 60              | Valide   | Nom avec 60 caractères         |
      | 4    | 61              | Invalide | Nom avec plus de 60 caractères |

































