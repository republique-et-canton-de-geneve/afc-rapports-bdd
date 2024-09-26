#language: fr
Fonctionnalité: Tri des périodes de travail pour un salarié

  Scénario: Récupèrer un rapport de travail préalablement enregistré avec des périodes dans le désordre
    Etant donné un rapport de travail préalablement enregistré avec les périodes d'activité dans l'ordre suivant :
      | Début      | Fin        |
      |            | 25.01.2021 |
      | 15.02.2021 | 22.02.2021 |
      | 03.04.2021 |            |
    Quand l'utilisateur récupère le rapport de travail préalablement enregistré
    Alors les périodes d'activité sont dans l'ordre suivant :
      | Début      | Fin        |
      | 03.04.2021 |            |
      | 15.02.2021 | 22.02.2021 |
      |            | 25.01.2021 |
