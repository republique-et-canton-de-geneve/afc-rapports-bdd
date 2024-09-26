#language: fr

Fonctionnalité: F11 - Génération du type ligne détail à partir d'une valeur immo

  Règle: R1 - Le type de ligne de la ligne détail est :
  - BATIMENT si la valeur immobilière est de type BATIMENT.
  - TERRAIN si la valeur immobilière est de type TERRAIN.
  - REVENU_OCCUPE si la valeur immobilière est de type QVL (qui a forcément un usage OCCUPE).
  - ETAT_LOCATIF si la valeur immobilière est de type ETAT_LOCATIF (qui a forcément un usage LOUE).

    @type-ligne-detail @PP @PM
    Plan du Scénario: Determiner les types de ligne détail en fonction du type de valeur immo (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable <type personne>
      Et que la valeur immobilière pour cet assujettissement est de type <type valeur>
      Et a un usage <usage>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le type <type ligne>
      Exemples:
        | Test | type personne | type valeur  | usage  | type ligne    | Observation                   |
        | 1    | PP            | BATIMENT     | OCCUPE | BATIMENT      | Type valeur immo Batiment     |
        | 2    | PP            | TERRAIN      | OCCUPE | TERRAIN       | Type valeur immo Terrain      |
        | 3    | PP            | QVL          | OCCUPE | REVENU_OCCUPE | Type valeur immo QVL          |
        | 4    | PP            | ETAT_LOCATIF | LOUE   | ETAT_LOCATIF  | Type valeur immo Etat Locatif |
        | 5    | PM            | BATIMENT     | OCCUPE | BATIMENT      | Type valeur immo Batiment     |
        | 6    | PM            | TERRAIN      | OCCUPE | TERRAIN       | Type valeur immo Terrain      |

