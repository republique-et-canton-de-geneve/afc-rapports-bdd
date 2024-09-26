#language: fr
Fonctionnalité: F1 - Validation de l'iban

  Règle: R1 - Afin d'être valide, un IBAN doit satisfaire les critères suivants :
  - Obligatoire
  - Avoir une taille de 21 caractères
  - Doit commencer par CH
  - Ne pas être un QR-IBAN (c'est à dire pas de '3' dans la 5éme position)
  - Et Une banque doit exister pour l'iban donné

    Plan du scénario: Validation Iban <Test> -> <Observation>
      Etant donné que l´utilisateur saisi l'iban <iban>
      Quand le système valide son iban
      Alors le système renvoie que l'iban est <resultat>
      Exemples:
        | Test | iban                   | resultat                                        | Observation                                          |
        | 1    | CH6300279279CO9984710  | valide                                          | Valide car Iban Suisse                               |
        | 2    |                        | invalide car iban vide                          | Invalide car Iban non renseigné                      |
        | 3    | CH6300279279CO998471   | invalide car longueur iban invalide             | Invalide car taille Iban < 21                        |
        | 4    | CH6300279279CO99847101 | invalide car longueur iban invalide             | Invalide car taille Iban > 21                        |
        | 5    | CH6830000001120217221  | invalide car QrIban avec un 3 en 5ème position  | Invalide car QR Iban Suisse ( un 3 em 5ème position) |
        | 6    | CH6310279279CO9984710  | invalide car check digit erroné                 | Invalide car Check Digit erronée                     |
        | 7    | FR6300279279CO9984710  | invalide car iban étranger                      | Invalide car Iban étranger                           |
        | 8    | CH6301279279CO9984710  | invalide car aucune banque existe pour cet iban | Invalide car Banque inconnu (01279 au lieu de 00279) |
