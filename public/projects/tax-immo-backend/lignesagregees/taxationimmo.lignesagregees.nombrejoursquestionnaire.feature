#language: fr

Fonctionnalité: F35 -  Calculer le Nb de jours du questionnaire pour les lignes agrégées BTR

  Règle: R1 - Calculer le Nb de jours du questionnaire pour les lignes agrégées BTR
  - Si la ligne agrégée ne contient pas de ligne détail R
  – alors le Nb de jours du questionnaire sera vide
  - Sinon si la ligne agrégée contient une seule ligne détail R
  – Alors Nb de jours du questionnaire de la ligne agrégée est égal au nb de jours de la ligne détail R
  - Sinon si toutes les lignes détail de type Revenu présentes dans la ligne agrégée ont le même nombre de jours du questionnaire
  – Alors Nb de jours du questionnaire de la ligne agrégée est égal au nb de jours de la première ligne détail R trouvée
  - Sinon
  – Alors Nb de jours du questionnaire de la ligne agrégée est égal au nb de jours le plus élevé parmi toutes les lignes détail R

    @PP @couple @nbJoursQuestionnaire @LigneAgrégéeBTR
    Scénario: Si la ligne agrégée ne contient pas de ligne détail R alors le Nb de jours du questionnaire sera vide
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | nombre jours questionnaire |
        | BATIMENT      | 1000                       |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient une ligne agrégée dont le nombre de jours questionnaire : vide

    @PP @couple @nbJoursQuestionnaire @LigneAgrégéeBTR
    Scénario: Si la ligne agrégée contient une seule ligne détail R alors Nb de jours du questionnaire de la ligne agrégée est égal au nb de jours de la ligne détail R
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | nombre jours questionnaire |
        | REVENU_OCCUPE | 360                        |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient une ligne agrégée dont le nombre de jours questionnaire : 360

    @PP @couple @nbJoursQuestionnaire @LigneAgrégéeBTR
    Scénario: Si toutes les lignes détail de type Revenu présentes dans la ligne agrégée ont le même nombre de jours du questionnaire alors Nb de jours du questionnaire de la ligne agrégée est égal au nb de jours de la première ligne détail R trouvée
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | nombre jours questionnaire |
        | REVENU_OCCUPE | 140                        |
        | REVENU_OCCUPE | 140                        |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient une ligne agrégée dont le nombre de jours questionnaire : 140

    @PP @couple @nbJoursQuestionnaire @LigneAgrégéeBTR
    Scénario:  Si toutes les lignes détail de type Revenu présentes dans la ligne agrégée ont des nombre de jours du questionnaire différent alors Nb de jours du questionnaire de la ligne agrégée est égal au nb de jours le plus élevé parmi toutes les lignes détail R
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Type          | nombre jours questionnaire |
        | REVENU_OCCUPE | 160                        |
        | REVENU_OCCUPE | 200                        |
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient une ligne agrégée dont le nombre de jours questionnaire : 200
