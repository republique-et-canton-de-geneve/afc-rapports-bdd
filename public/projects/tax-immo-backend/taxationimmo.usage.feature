#language: fr

Fonctionnalité: F12 - Récupération de l'usage de la ligne détail

  Règle: R1 - la ligne de detail doit reporter les informations de l'usage

    @usage @PP
    Plan du Scénario: la ligne de detail doit reporter les informations de l'usage (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable PP
      Et que la valeur immobilière pour cet assujettissement a un usage avec part <part usage rvi>, date d'occupation <date occupation rvi>, type d’usage <type usage rvi>
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec l'usage part <part usage taximmo>, date d'occupation <date occupation taximmo>, type d’usage <type usage taximmo>
      Exemples:
        | Test | part usage rvi | date occupation rvi | type usage rvi | part usage taximmo | date occupation taximmo | type usage taximmo | Observation                                                 |
        | 1    | 1/1            |                     | LOUE           | 1/1                |                         | LOUE               | Une valeur immobilière avec un usage sans date d'occupation |
