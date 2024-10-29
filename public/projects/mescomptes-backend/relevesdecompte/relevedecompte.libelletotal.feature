#language: fr
Fonctionnalité: F3 - Détermination du texte de libellé du solde du relevé de compte

  Règle: R1 - Le texte du libellé du solde d'un relevé de compte dépend des éléments suivants :
  - Le type de prestation (ICC, IFD, ICHIENS...)
  - Le solde du compte : débiteur, créditeur, à zéro
  - L'existence ou non d'un bordereau de notification dans les mouvements du compte

    Plan du scénario: Détermination du texte de libellé pour une prestation <CodePrestation>. <Test> -> <Observation>
      Etant donné que le contribuable possède un compte <CodePrestation>, avec bordereau <TypeBordereau> avec montant <Montant>
      Quand le système détermine le texte de libellé du relevé de compte
      Alors le système renvoie le libellé <Resultat>
      Exemples:
        | Test | CodePrestation | TypeBordereau |  Montant |  Resultat                    | Observation                                                                                     |
        | 1    | ICC            |  Sans impact  |  5000    |  Total à payer:              | Total à payer car prestation ICC et solde débiteur                                              |
        | 2    | ICC            |  Sans impact  |  -500    |  Total:                      | Total car prestation ICC et solde créditeur                                                     |
        | 3    | ICHIENS        |  Sans impact  |  5000    |  Total à payer:              | Total à payer car prestation ICHIENS et solde débiteur                                          |
        | 4    | IFD            |  Sans impact  |  0       |  Total:                      | Total car prestation IFD et solde à zéro                                                        |
        | 5    | IFD            |  Sans impact  |  5000    |  Total à payer:              | Total à payer car prestation IFD et solde débiteur                                              |
        | 6    | TPERS          |  Sans impact  |  -125    |  Total:                      | Total car prestation TPERS et solde créditeur                                                   |
        | 7    | CRCATHROM      |  Notifié      |  5000    |  Contribution non versée:    | Contribution non versée car prestation CRCATHROM avec bordereau notifié et solde débiteur       |
        | 8    | CRCATHCHR      |  Notifié      |  -500    |  Contribution suppl. versée: | Contribution suppl. versée car prestation CRCATHCHR avec bordereau notifié et solde créditeur   |
        | 9    | CRPROTEST      |  Notifié      |  0       |  Total:                      | Total car prestation CRPROTEST et solde à zéro                                                  |
        | 10   | CRPROTEST      |  Non notifié  |  5000    |  Total:                      | Total car prestation CRPROTEST et solde débiteur                                                |
        | 11   | CRPROTEST      |  Non notifié  |  -500    |  Total:                      | Total car prestation CRPROTEST et solde créditeur                                               |
        | 12   | CRPROTEST      |  Non notifié  |  0       |  Total:                      | Total car prestation CRPROTEST et solde à zéro                                                  |

