#language: fr

Fonctionnalité: Validation du travail en France pour une personne périodique

  Règle: La règle de validation du travail en France est la suivante :
  - L'année fiscale doit être supérieure ou égale à 2025
  - Le DPI doit être de type salarié
  - Le type de contribuable doit être salarié
  - Le mois declaré doit être décembre ou toutes les périodes d'activités terminées
  - Le pays de domicile est la France

    Plan du scénario: <Test> : Condition d'application du travail en France (<Observation>)
      Etant donné que la date du jour est <date du jour>
      Et que l´utilisateur est un DPI de type <type Dpi>
      Et que l´utilisateur a créé une nouvelle LR <année fiscale> pour ce DPI
      Et que une personne <type contribuable salarie> complète est initialisée
      Et que la personne a une adresse domicile à <type adresse domicile>
      Et que la personne est en activité du <début> au <fin>
      Quand je vérifie si le travail en France est applicable sur cette LR
      Alors le travail en France est <resultat>
      Exemples:
        | Test | année fiscale | type Dpi           | type contribuable salarie | date du jour | début      | fin        | type adresse domicile | resultat       | Observation                                                                           |
        | 1    | 2023          | SALARIES           | SALARIEFRANCE             | 30.12.2025   | 01.02.2025 | 01.03.2025 | l'étranger FR         | Non applicable | L'année fiscale n'est pas correcte pour appliquer le travail en France                |
        | 2    | 2025          | BENEFICIAIRE_RENTE | SALARIEFRANCE             | 30.12.2025   | 01.02.2025 |            | l'étranger FR         | Non applicable | Le type de Dpi n'est pas correct pour appliquer le travail en France                  |
        | 3    | 2025          | SALARIES           | ADMIN                     | 30.12.2025   | 01.02.2025 | 01.03.2025 | l'étranger FR         | Non applicable | Le type de contribuable salarié n'est pas correct pour appliquer le travail en France |
        | 4    | 2025          | SALARIES           | SALARIEFRANCE             | 30.12.2025   | 01.02.2025 | 01.03.2025 | l'étranger FR         | Applicable     | Prérequis corrects, derniers mois actif est octobre mais périodes terminées           |
        | 5    | 2025          | SALARIES           | SALARIEFRANCE             | 30.12.2025   | 01.02.2025 |            | l'étranger FR         | Applicable     | Prérequis corrects et dernier mois actif est décembre                                 |
        | 6    | 2025          | SALARIES           | SALARIEFRANCE             | 30.10.2025   | 01.02.2025 |            | l'étranger FR         | Non applicable | Les périodes ne sont pas terminées et le dernier mois actif n'est pas decembre        |
        | 7    | 2025          | SALARIES           | SALARIEFRANCE             | 30.10.2025   |            |            | l'étranger FR         | Non applicable | Prérequis corrects aucune pèriode et dernier mois actif octobre                       |
        | 8    | 2025          | SALARIES           | SALARIEFRANCE             | 30.12.2025   | 01.02.2025 | 01.03.2025 | l'étranger FR         | Applicable     | Tous les éléments sont corrects pour appliquer le de travail en France                |
        | 9    | 2025          | SALARIES           | SALARIEFRANCE             | 30.12.2025   | 01.02.2025 |            | l'étranger FR         | Applicable     | Tous les éléments sont corrects pour appliquer le de travail en France                |
        | 10   | 2025          | SALARIES           | SALARIEFRANCE             | 15.01.2026   | 01.02.2025 |            | l'étranger FR         | Applicable     | Date du jour Janvier 2026 pour année fiscale 2025, dernier mois actif decembre        |
        | 11   | 2025          | SALARIES           | SALARIEFRANCE             | 30.12.2025   | 01.02.2025 |            | l'étranger DE         | Non applicable | Le pays de domicile n'est pas correct  pour appliquer le de travail en France         |
        | 12   | 2025          | SALARIES           | SALARIEFRANCE             | 30.12.2025   | 01.02.2025 |            | l'étranger FR         | Applicable     | Tous les éléments sont corrects pour appliquer le de travail en France                |
        | 13   | 2025          | SALARIES           | SALARIEFRANCE             | 30.12.2025   | 01.02.2025 |            | GENEVE                | Non applicable | Le pays de domicile n'est pas correct  pour appliquer le de travail en France         |
