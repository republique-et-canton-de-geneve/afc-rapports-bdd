#language: fr
Fonctionnalité: Règles métier concernant les lieux de travail

  Règle: Le libellé de la commune de travail est déterminé comme suit :
  - Si la personne travaille dans le canton de Genève : nom de la commune politique
  - Si la personne travaille en Suisse mais dehors Genève : code commune de travail + canton
  - Si la personne travaille hors Suisse : nom du pays

    Plan du scénario: Détermination du libellé de la commune de travail
      Etant donné qu'un lieu de travail a le Code Canton "<Code canton>"
      Et que ce lieu de travail a le Code Pays "<Code pays>"
      Et que ce lieu de travail a la Code Commune "<Code commune>"
      Et que ce lieu de travail a le NPA "<NPA>"
      Et que ce lieu de travail a la Localite "<Localité>"
      Quand on demande le libellé de la commune de travail pour ce lieu de travail
      Alors le système répond que le libellé de la commune de travail est <Résultat>
      Exemples:
        | Test | Code canton | Code pays | Code commune | NPA   | Localité    | Résultat | Observation                                   |
        | 1    | GE          | CH        | 6603         | 1227  | Les Acacias | Avully   | personne travaillant dans le canton de Genève |
        | 2    | VD          | CH        | 5586         | 1234  | Lau         | 5586 VD  | personne travaillant dans le canton de Vaud   |
        | 3    |             | FR        |              | 74000 | Annecy      | France   | personne travaillant en France                |
