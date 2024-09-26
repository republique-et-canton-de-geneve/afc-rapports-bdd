#language: fr

Fonctionnalité: Validation d'une LR ASC / Périodique - Partie DPI

  Contexte:
    Etant donné qu'un DPI ASC est sélectionné
    Etant donné l´année en cours 2021

  # Cette règle teste la taille min / max du champ Nom Dpi
  Plan du scénario: Validation LR - Nom Dpi <Test> -> <Observation>
    Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
    Et l´utilisateur saisit un nom de dpi avec <taille> caractères
    Quand l´utilisateur valide sa LR
    Alors le système renvoie que la LR est <resultat>
    Exemples:
      | Test | taille | resultat | Observation                               |
      | 1    | 0      | Invalide | Nom non renseigné                         |
      | 2    | 2      | Valide   | Nom renseigné avec 2 caractères           |
      | 3    | 501    | Invalide | Nom trop long avec plus de 500 caractères |
      | 4    | 500    | Valide   | Nom avec 500   caractères                 |
      | 5    | 499    | Valide   | Nom avec moins de 500 caractères          |
      | 6    | 1      | Invalide | Nom avec moins de 2 caractère             |

    # TODO SHOULD - Cette règle est applicable à chaque objet qui utilise une adresse. Rendre cette règle plus générique et pas seulement applicable à un DPI.
  Plan du scénario: Validation LR - Adresse Dpi <Test> -> <Observation>
    Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
    Et l´utilisateur est en mode pour le Dpi <typeSaisie>
    Et l´utilisateur a saisi pour le Dpi le code pays <pays>
    Et l´utilisateur a saisi pour le Dpi dans "NPA" la valeur "<npa>"
    Et l´utilisateur a saisi pour le Dpi dans "Canton" la valeur "<canton>"
    Et l´utilisateur a saisi pour le Dpi dans "Localite" la valeur "<localite>"
    Et l´utilisateur a saisi pour le Dpi dans "Adresse WS" la valeur "<adresseWS>"
    Et l´utilisateur a saisi pour le Dpi dans "idPadr" la valeur "<idPadr>"
    Quand l´utilisateur valide sa LR
    Alors le système renvoie que la LR est <resultat>

    Exemples:
      | Test | typeSaisie | pays | npa   | localite | adresseWS | canton | idPadr    | resultat | Observation                                             |
      | 1    | Libre      | CH   | 1000  | Genève   |           | GE     | 123456789 | Valide   | Saisie Libre - Tous les champs obligatoires renseignés  |
      | 2    | Libre      | CH   | 1000  | Genève   |           |        | 123456789 | Invalide | Saisie Libre - Invalide car il manque le canton         |
      | 3    | Libre      | CH   | 1000  | Genève   |           | TT     | 123456789 | Invalide | Saisie Libre - Invalide car canton invalide             |
      | 4    | Libre      |      |       |          |           | GE     | 123456789 | Invalide | Saisie Libre - Aucune information obligatoire renseigné |
      | 5    | Libre      |      | 1000  | Genève   |           | GE     | 123456789 | Invalide | Saisie Libre - Pays non renseigné                       |
      | 6    | Libre      | CH   |       | Genève   |           | GE     | 123456789 | Invalide | Saisie Libre - Npa non renseigné                        |
      | 7    | Libre      | CH   | 1000  |          |           | GE     | 123456789 | Invalide | Saisie Libre - Localité non renseigné                   |
      | 8    | Libre      | CH   | 999   | Genève   |           | GE     | 123456789 | Invalide | Saisie Libre - Npa inférieur à 1000                     |
      | 9    | Libre      | CH   | 10000 | Genève   |           | GE     | 123456789 | Invalide | Saisie Libre - Npa supérieur à 10000                    |
      | 10   | Libre      | CH   | 1000  | Genève   |           | GE     |           | Valide   | Saisie Libre - IdPAdr non renseigné                     |
      | 11   | WebService |      |       |          |           | GE     | 123456789 | Invalide | Saisie WS - Aucune information obligatoire renseigné    |
      | 12   | WebService | CH   | 1000  | Genève   | AA        | GE     | 123456789 | Valide   | Saisie WS - Tous les champs obligatoires renseignés     |
      | 13   | WebService |      | 1000  | Genève   | AA        | GE     | 123456789 | Invalide | Saisie WS - Pays non renseigné                          |
      | 14   | WebService | CH   |       | Genève   | AA        | GE     | 123456789 | Invalide | Saisie WS - Npa non renseigné                           |
      | 15   | WebService | CH   | 1000  |          | AA        | GE     | 123456789 | Invalide | Saisie WS - Localité non renseigné                      |
      | 16   | WebService | CH   | 999   | Genève   | AA        | GE     | 123456789 | Invalide | Saisie WS - Npa inférieur à 1000                        |
      | 17   | WebService | CH   | 10000 | Genève   | AA        | GE     | 123456789 | Invalide | Saisie WS - Npa supérieur à 10000                       |
      | 18   | WebService |      |       |          | AA        | GE     | 123456789 | Invalide | Saisie WS - Adresse WS saisie sans complétion           |
      | 19   | WebService | CH   | 5555  | Genève   |           | GE     | 123456789 | Invalide | Saisie WS - Adresse WS non renseigné                    |
      | 20   | WebService | CH   | 1000  | Genève   | AA        | GE     |           | Invalide | Saisie WS - IdPAdr non renseigné                        |

  Plan du scénario: Validation LR - Adresse Dpi le code commune politique est facultatif <Test> -> <Observation>
    Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
    Et l´utilisateur a saisi pour le Dpi dans "Commune Politique" la valeur "<commune politique>"
    Quand l´utilisateur valide sa LR
    Alors le système renvoie que la LR est <resultat>

    Exemples:
      | Test | commune politique | resultat | Observation                          |
      | 1    | 1234              | Valide   | Code commune politique renseigné     |
      | 2    |                   | Valide   | Code commune politique non renseigné |
