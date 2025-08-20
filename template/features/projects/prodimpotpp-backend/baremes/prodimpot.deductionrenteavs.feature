#language: fr

Fonctionnalité: F5 - Calcul de la déduction (montant maximal) pour les rentes AVS/AI

  Règle: R1 - Calcul de la déduction (montant maximal) pour les rentes AVS/AI
  Les deductions sont calculées à partir du revenu déterminant, de la situation du contribuable, de la période fiscale et de l'indexation des deductions

    @PP @DeductionRenteAVSAI
    Plan du Scénario: Calcul de la déduction pour les rentes AVS/AI
      Etant donné une assiette pour un contribuable pour <periode fiscale>
      Et que le montant déterminant pour le taux de l'assiette rente avsai est <revenu déterminant>
      Quand l'application ProdImpot calcule la déduction pour une personne <situationFamilialeRenteAVSAI>
      Alors le montant de la déduction est <montant deduction>
      Exemples:
        | periode fiscale | revenu déterminant | situationFamilialeRenteAVSAI | montant deduction |
        | 2025            | 0                  | SEUL                         | 10661             |
        | 2025            | 53304              | SEUL                         | 10661             |
        | 2025            | 60447              | SEUL                         | 8529              |
        | 2025            | 68229              | SEUL                         | 6397              |
        | 2025            | 76225              | SEUL                         | 4264              |
        | 2025            | 84509              | SEUL                         | 2132              |
        | 2025            | 10000000000        | SEUL                         | 0                 |
        | 2025            | 0                  | COUPLE_UN_SEUL_RENTIER       | 10661             |
        | 2025            | 61300              | COUPLE_UN_SEUL_RENTIER       | 10661             |
        | 2025            | 69509              | COUPLE_UN_SEUL_RENTIER       | 8529              |
        | 2025            | 78464              | COUPLE_UN_SEUL_RENTIER       | 6397              |
        | 2025            | 87632              | COUPLE_UN_SEUL_RENTIER       | 4264              |
        | 2025            | 98080              | COUPLE_UN_SEUL_RENTIER       | 2132              |
        | 2025            | 10000000000        | COUPLE_UN_SEUL_RENTIER       | 0                 |
        | 2025            | 0                  | COUPLE_DEUX_RENTIERS         | 12260             |
        | 2025            | 61300              | COUPLE_DEUX_RENTIERS         | 12260             |
        | 2025            | 69509              | COUPLE_DEUX_RENTIERS         | 9808              |
        | 2025            | 78464              | COUPLE_DEUX_RENTIERS         | 7356              |
        | 2025            | 86833              | COUPLE_DEUX_RENTIERS         | 4904              |
        | 2025            | 98080              | COUPLE_DEUX_RENTIERS         | 2452              |
        | 2025            | 10000000000        | COUPLE_DEUX_RENTIERS         | 0                 |
        | 2024            | 0                  | SEUL                         | 10564             |
        | 2024            | 52818              | SEUL                         | 10564             |
        | 2024            | 59896              | SEUL                         | 8451              |
        | 2024            | 67607              | SEUL                         | 6338              |
        | 2024            | 75530              | SEUL                         | 4225              |
        | 2024            | 84509              | SEUL                         | 2113              |
        | 2024            | 10000000000        | SEUL                         | 0                 |
        | 2024            | 60741              | COUPLE_UN_SEUL_RENTIER       | 10564             |
        | 2024            | 68875              | COUPLE_UN_SEUL_RENTIER       | 8451              |
        | 2024            | 77748              | COUPLE_UN_SEUL_RENTIER       | 6338              |
        | 2024            | 86833              | COUPLE_UN_SEUL_RENTIER       | 4225              |
        | 2024            | 97186              | COUPLE_UN_SEUL_RENTIER       | 2113              |
        | 2024            | 10000000000        | COUPLE_UN_SEUL_RENTIER       | 0                 |
        | 2024            | 0                  | COUPLE_DEUX_RENTIERS         | 12148             |
        | 2024            | 60741              | COUPLE_DEUX_RENTIERS         | 12148             |
        | 2024            | 66150              | COUPLE_DEUX_RENTIERS         | 9719              |
        | 2024            | 77748              | COUPLE_DEUX_RENTIERS         | 7289              |
        | 2024            | 86833              | COUPLE_DEUX_RENTIERS         | 4859              |
        | 2024            | 97186              | COUPLE_DEUX_RENTIERS         | 2430              |
        | 2024            | 10000000000        | COUPLE_DEUX_RENTIERS         | 0                 |
        | 2023            | 0                  | SEUL                         | 10146             |
        | 2023            | 50729              | SEUL                         | 10146             |
        | 2023            | 57527              | SEUL                         | 8117              |
        | 2023            | 64933              | SEUL                         | 6087              |
        | 2023            | 72542              | SEUL                         | 4058              |
        | 2023            | 81166              | SEUL                         | 2029              |
        | 2023            | 10000000000        | SEUL                         | 0                 |
        | 2023            | 58338              | COUPLE_UN_SEUL_RENTIER       | 10146             |
        | 2023            | 66150              | COUPLE_UN_SEUL_RENTIER       | 8117              |
        | 2023            | 74673              | COUPLE_UN_SEUL_RENTIER       | 6087              |
        | 2023            | 83398              | COUPLE_UN_SEUL_RENTIER       | 4058              |
        | 2023            | 93341              | COUPLE_UN_SEUL_RENTIER       | 2029              |
        | 2023            | 93341              | COUPLE_UN_SEUL_RENTIER       | 2029              |
        | 2023            | 10000000000        | COUPLE_UN_SEUL_RENTIER       | 0                 |
        | 2023            | 0                  | COUPLE_DEUX_RENTIERS         | 11668             |
        | 2023            | 58338              | COUPLE_DEUX_RENTIERS         | 11668             |
        | 2023            | 66150              | COUPLE_DEUX_RENTIERS         | 9334              |
        | 2023            | 74673              | COUPLE_DEUX_RENTIERS         | 7001              |
        | 2023            | 83398              | COUPLE_DEUX_RENTIERS         | 4667              |
        | 2023            | 93341              | COUPLE_DEUX_RENTIERS         | 2334              |
        | 2023            | 10000000000        | COUPLE_DEUX_RENTIERS         | 0                 |
        | 2014            | 50388              | SEUL                         | 10078             |
        | 2014            | 50389              | SEUL                         | 10078             |
        | 2014            | 50390              | SEUL                         | 8062              |
        | 2014            | 10000000000        | SEUL                         | 0                 |
        | 2014            | 57946              | COUPLE_UN_SEUL_RENTIER       | 10078             |
        | 2014            | 57947              | COUPLE_UN_SEUL_RENTIER       | 10078             |
        | 2014            | 57948              | COUPLE_UN_SEUL_RENTIER       | 8062              |
        | 2014            | 92715              | COUPLE_UN_SEUL_RENTIER       | 2016              |
        | 2014            | 92716              | COUPLE_UN_SEUL_RENTIER       | 0                 |
        | 2014            | 10000000000        | COUPLE_UN_SEUL_RENTIER       | 0                 |
        | 2014            | 57946              | COUPLE_DEUX_RENTIERS         | 11589             |
        | 2014            | 57947              | COUPLE_DEUX_RENTIERS         | 11589             |
        | 2014            | 57948              | COUPLE_DEUX_RENTIERS         | 9272              |
        | 2014            | 92715              | COUPLE_DEUX_RENTIERS         | 2318              |
        | 2014            | 92715              | COUPLE_DEUX_RENTIERS         | 2318              |
        | 2014            | 92716              | COUPLE_DEUX_RENTIERS         | 0                 |
        | 2014            | 10000000000        | COUPLE_DEUX_RENTIERS         | 0                 |
        | 2013            | 50388              | SEUL                         | 10078             |
        | 2013            | 50389              | SEUL                         | 10078             |
        | 2013            | 50390              | SEUL                         | 8062              |
        | 2013            | 10000000000        | SEUL                         | 0                 |
        | 2013            | 57946              | COUPLE_UN_SEUL_RENTIER       | 10078             |
        | 2013            | 57500              | COUPLE_UN_SEUL_RENTIER       | 10078             |
        | 2013            | 57948              | COUPLE_UN_SEUL_RENTIER       | 8062              |
        | 2013            | 10000000000        | COUPLE_UN_SEUL_RENTIER       | 0                 |
        | 2013            | 57946              | COUPLE_DEUX_RENTIERS         | 11589             |
        | 2013            | 57947              | COUPLE_DEUX_RENTIERS         | 11589             |
        | 2013            | 57948              | COUPLE_DEUX_RENTIERS         | 9272              |
        | 2013            | 10000000000        | COUPLE_DEUX_RENTIERS         | 0                 |
        | 2011            | 49999              | SEUL                         | 10000             |
        | 2011            | 50000              | SEUL                         | 10000             |
        | 2011            | 50001              | SEUL                         | 8000              |
        | 2011            | 10000000000        | SEUL                         | 0                 |
        | 2011            | 57499              | COUPLE_UN_SEUL_RENTIER       | 10000             |
        | 2011            | 57500              | COUPLE_UN_SEUL_RENTIER       | 10000             |
        | 2011            | 57501              | COUPLE_UN_SEUL_RENTIER       | 8000              |
        | 2011            | 10000000000        | COUPLE_UN_SEUL_RENTIER       | 0                 |
        | 2011            | 57499              | COUPLE_DEUX_RENTIERS         | 11500             |
        | 2011            | 57500              | COUPLE_DEUX_RENTIERS         | 11500             |
        | 2011            | 57501              | COUPLE_DEUX_RENTIERS         | 9200              |
        | 2011            | 10000000000        | COUPLE_DEUX_RENTIERS         | 0                 |
