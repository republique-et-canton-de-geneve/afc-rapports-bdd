#language: fr

Fonctionnalité: F8 - Récupération de l'objet cadastral de la ligne détail

  Règle: R1 - la ligne de detail doit reporter les informations de l'objet cadastral

    @objet-cadastral @PP
    Plan du Scénario: la ligne de detail doit reporter les info de l'objet cadastral (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable PP
      Et que la valeur immobilière pour cet assujettissement contient l'objet cadastral id <id rvi>, commune <commune rvi>, parcelle <parcelle rvi>, PPE <PPE rvi>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec l'objet cadastral id <id taximmo>, commune <commune taximmo>, parcelle <parcelle taximmo>, PPE <PPE taximmo>
      Exemples:
        | Test | id rvi   | commune rvi | parcelle rvi | PPE rvi | id taximmo | commune taximmo | parcelle taximmo | PPE taximmo | Observation             |
        | 1    | 22-150-7 | 22          | 150          | 7       | 22-150-7   | 22              | 150              | 7           | tous les champs remplis |
        | 2    | 22-150   | 22          | 150          |         | 22-150     | 22              | 150              |             | PPE vide                |
