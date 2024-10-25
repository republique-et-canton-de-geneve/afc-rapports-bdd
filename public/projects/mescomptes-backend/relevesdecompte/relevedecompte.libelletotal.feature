#language: fr
Fonctionnalité: F2 - Détermination du texte de libellé du solde du relevé de compte

  Règle: R1 - Le texte du libellé du solde d'un relevé de compte dépend des éléments suivants :
  - Le type de prestation (ICC, IFD, ICHIENS...)
  - Le solde du compte : débiteur, créditeur, à zéro
  - L'existence ou non d'un bordereau de notification dans les mouvements du compte

    Plan du scénario: Détermination du texte de libellé pour une prestation <CodePrestation>. <Test> -> <Observation>
      Etant donné que le contribuable possède un compte <CodePrestation> avec montant <Montant>
      Quand le système détermine le texte de libellé du relevé de compte
      Alors le système renvoie le libellé <Resultat>
      Exemples:
        | Test | CodePrestation |  Montant |  Resultat         | Observation                                             |
        | 1    | ICC            |  5000    |  Total à payer:   | Total à payer car prestation ICC et solde débiteur      |
        | 2    | ICC            |  -500    |  Total:           | Total car prestation ICC et solde créditeur             |
        | 3    | ICHIENS        |  5000    |  Total à payer:   | Total à payer car prestation ICHIENS et solde débiteur  |
        | 4    | IFD            |  0       |  Total:           | Total car prestation IFD et solde à zéro                |
        | 5    | IFD            |  5000    |  Total à payer:   | Total à payer car prestation IFD et solde débiteur      |
        | 6    | TPERS          |  -125    |  Total:           | Total car prestation TPERS et solde créditeur           |

