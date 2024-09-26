#language: fr

Fonctionnalité: F9 - Identifiant les personnes et leur rôle dans une ligne détail

  Règle: R1- La taxation immo détermine le rôle de la personne d'une ligne détail en fonction du numéro R

    @personne @PP @couple
    Scénario: la personne de la ligne détail est identifiée à partir de son numéro R pour un couple
      Etant donné un assujettissement couple avec contribuable 87654321 et conjoint 87654322
      Et que les valeurs immobilières pour cet assujettissement sont :
        | Personne | Usages |
        | 87654321     | LOUE   |
        | 87654322     | OCCUPE |
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors les lignes détails sont les suivantes :
        | Code taxation | Role personne |
        | 15.20         | CONTRIBUABLE  |
        | 15.10         | CONJOINT      |

    @personne @PP @PPseul
    Plan du Scénario: la personne de la ligne détail est identifiée à partir de son numéro R pour un PP seul ou PM (Test -> Observation)
      Etant donné un assujettissement pour un contribuable <Type Personne> ayant comme numeroR 87654321
      Et que la valeur immobilière pour cet assujettissement a comme usage LOUE
      Et a la personne 87654321
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail <Code Taxation> pour le CONTRIBUABLE
      Exemples:
        | Test | Type Personne | Code Taxation | Observation                       |
        | 1    | PP            | 15.20         | Role contribuable pour un PP seul |
        | 2    | PM            | 3.1           | Role contribuable pour un PM      |
