#language: fr

Fonctionnalité: F10 - Récupération de la responsabilité de la ligne détail

  Règle: R1 - la ligne de detail doit reporter les informations de l'objet cadastral

    @responsabilite @PP
    Plan du Scénario: la ligne de detail doit reporter les infos de l'objet cadastral (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable PP
      Et que la valeur immobilière pour cet assujettissement contient la responsabilité type <type rvi>, part <part rvi>, provenances <provenances rvi>, date de création <date creation rvi>, date historisation <date histo rvi>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec la responsabilité type <type taximmo>, part <part taximmo>, provenances <provenances taximmo>, date de création <date creation taximmo>, date historisation <date histo taximmo>
      Exemples:
        | Test | type rvi     | part rvi | provenances rvi | date creation rvi | date histo rvi | type taximmo | part taximmo | provenances taximmo | date creation taximmo | date histo taximmo | Observation             |
        | 1    | PROPRIETAIRE | 1/1      | Achat           | 30.07.1999        | 31.12.2020     | PROPRIETAIRE | 1/1          | Achat               | 30.07.1999            | 31.12.2020         | tous les champs remplis |
        | 2    | USUFRUITIER  | 1/2      | Vente           | 30.07.1999        | vide           | USUFRUITIER  | 1/2          | Vente               | 30.07.1999            | vide               | Date historisation vide |
