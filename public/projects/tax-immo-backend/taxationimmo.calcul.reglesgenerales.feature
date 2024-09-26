#language: fr

Fonctionnalité: F1 - Règles générales de calculs et arrondis

  Règle: R1 - Certains montants doivent être arrondis au franc le plus près
  - Au franc inférieur si inférieur à x.50
  - Au franc supérieur si supérieur à x.50
  - Au franc supérieur si égal à x.50

    @montants
    Plan du Scénario: Les montants doivent être arrondis au franc le plus près et au franc supérieur si égal à x.50 (<Test> - <Observation>)
      Etant donné un montant décimal arrondi à 5 centimes près de <montant>
      Alors le montant arrondi au franc près est <montant arrondi>
      Exemples:
        | Test | montant | montant arrondi | Observation                              |
        | 1    | 1000.55 | 1001            | le nombre de centimes est supérieur à 50 |
        | 2    | 1000.50 | 1001            | le nombre de centimes est égal à 50      |
        | 3    | 1000.45 | 1000            | le nombre de centimes est inférieur à 50 |

  Règle: R2 - Certains montants doivent être arrondis à 5 centimes près
  - au multiple de 5 centimes inférieur si le nombre de centimes est inférieur à 2.5
  - au multiple de 5 centimes supérieur si le nombre de centimes est supérieur à 2.5
  - au multiple de 5 centimes supérieur si le nombre de centimes est égal à 2.5

    @montants
    Plan du Scénario: Les montants doivent être arrondis à 5 centimes près (<Test> - <Observation>)
      Etant donné un montant décimal arrondi au centime près de <montant>
      Alors le montant arrondi à 5 centimes près est <montant arrondi>
      Exemples:
        | Test | montant | montant arrondi | Observation                               |
        | 1    | 1000.55 | 1000.55         | le nombre de centimes est supérieur à 2.5 |
        | 2    | 1000.53 | 1000.55         | le nombre de centimes est égal à 2.5      |
        | 3    | 1000.52 | 1000.50         | le nombre de centimes est inférieur à 2.5 |
