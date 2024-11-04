#language: fr
Fonctionnalité: F2 - Détermination du compte de type Eglise

  Règle: R1 - Un compte est de type Eglise si le type prestation est :
  - CRCATHROM
  - CRCATHCHR
  - CRPROTEST

    Plan du scénario: Vérifier si le compte est de type Eglise pour une prestation <CodePrestation>. <Test> -> <Observation>
      Etant donné que le compte du contribuable est de type  <CodePrestation>
      Quand le système vérifie le type du compte
      Alors le système renvoie que le type de prestation est <Resultat>
      Exemples:
        | Test | CodePrestation | Resultat      | Observation                                                       |
        | 1    | CRCATHROM      | Eglise        | Eglise car prestation CRCATHROM est une prestation Eglise         |
        | 2    | CRCATHCHR      | Eglise        | Eglise car prestation CRCATHCHR est une prestation Eglise         |
        | 3    | CRPROTEST      | Eglise        | Eglise car prestation CRPROTEST est une prestation Eglise         |
        | 4    | ICC            | Pas Eglise    | Pas Eglise car prestation ICC n'est pas une prestation Eglise     |
        | 5    | IFD            | Pas Eglise    | Pas Eglise car prestation IFD n'est pas une prestation Eglise     |

