#language: fr

Fonctionnalité: F2 - Règles générales sur l’assujettissement dans la taxation immo

  Règle: R1 - La taxation immobilière est calculée sur une période finie.
  - La période de taxation est une copie de la période d’assujettissement.
  - Si la période d’assujettissement n’est pas finie alors on force la date de fin au 31.12 de l’année de début de période d’assujettissement.

    Scénario: La période d’assujettissement ne comporte pas de date de fin (<Test> - <Observation>)
      Etant donné un assujettissement sans date de fin débutant le 01.01.2020 pour l'année fiscale 2020 pour un contribuable seul PP
      Et que la valeur immobilière pour cet assujettissement a une période de validité du 01.01.2020 au 31.12.2020
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors la taxation immobilière est calculée sur la période du 01.01.2020 au 31.12.2020

    Scénario: La période d’assujettissement comporte une date de fin (<Test> - <Observation>)
      Etant donné un assujettissement du 01.01.2020 au 31.12.2020 pour l'année fiscale 2020 pour un contribuable seul PP
      Et que la valeur immobilière pour cet assujettissement a une période de validité du 01.01.2020 au 31.12.2020
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors la taxation immobilière est calculée sur la période du 01.01.2020 au 31.12.2020

  Règle: R2 - Calculer le nombre de jours de l'assujettissement
  - Il faut compter 30 jours pour tous les mois de l'année
  - Nb jours = ((anneeFin assuj - anneeDebut assuj) * 12 + (moisFin assuj - moisDebut assuj)) * 30 + min(jourFin assuj, 30) - jourDebut assuj + 1

    @PP @PM @nbJoursAssuj
    Plan du Scénario: Calculer le nombre de jours dans la période de l'assujettissement (<Test> - <Observation>)
      Etant donné un assujettissement <periode assuj> pour l'année fiscale 2020 pour un contribuable seul
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors l'assujettissement contient le nombre de jours <nombre jours assuj>
      Exemples:
        | Test | periode assuj               | nombre jours assuj | Observation                                                              |
        | 1    | du 01.01.2020 au 31.12.2020 | 360                | Nombre de jours de l'assuj pour une année complète                       |
        | 2    | du 01.01.2019 au 15.03.2020 | 435                | Nombre de jours de l'assuj pour une période qui dépasse 1 année complète |
        | 3    | du 01.01.2020 au 01.01.2020 | 1                  | Nombre de jours de l'assuj pour une période sur un jour                  |
        | 4    | du 01.01.2020 au 31.01.2020 | 30                 | Nombre de jours de l'assuj pour une période sur un mois                  |
        | 5    | du 01.01.2020 au 01.02.2020 | 31                 | Nombre de jours de l'assuj pour une période sur deux mois                |
        | 6    | du 31.01.2020 au 01.02.2020 | 2                  | Nombre de jours de l'assuj pour une période sur deux mois                |
        | 7    | depuis le 01.01.2020        | 360                | Nombre de jours de l'assuj pour une période ouverte (sans date de fin)   |
