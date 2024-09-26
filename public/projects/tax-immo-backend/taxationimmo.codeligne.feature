#language: fr

Fonctionnalité: F3 - Génération du code ligne détail à partir d'une valeur immo

  Règle: R1 - Le code taxation d'une ligne détail est :
  - 15.10 pour PP avec un usage OCCUPE et la partie taxable des montants.
  - 15.20 pour un PP avec un usage LOUE, INCONNU ou IMPRODUCTIF et la partie taxable des montants.
  - 15.30 pour un PP avec un usage PROFESSIONNEL.
  - 15.40 pour PP avec un usage OCCUPE et la partie exonérée des montants.
  - 15.50 pour PP avec un usage LOUE, INCONNU ou IMPRODUCTIF et la partie exonérée des montants.
  - 3.2 pour PM avec un usage OCCUPE et la partie taxable des montants.
  - 3.1 pour PM avec un usage LOUE ou IMPRODUCTIF et la partie taxable des montants.

    @code-ligne-detail @PP @PM
    Plan du Scénario: Determiner les codes taxations en fonction de l'usage, du type de personne et du type d'exo (<Test> - <Observation>)
      Etant donné un assujettissement pour un contribuable <type personne>
      Et que la valeur immobilière pour cet assujettissement est de type BATIMENT
      Et a comme usage <usage>
      Et a les taux exo FORTUNE: (<taux exo>)
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors cette taxation immobilière contient une ligne détail avec le code <code taxation>
      Exemples:
        | Test | type personne | usage         | taux exo | code taxation | Observation                                                                    |
        | 1    | PP            | OCCUPE        | 0%       | 15.10         | PP avec un bien occupé sans exo => 15.10                                       |
        | 2    | PP            | LOUE          | 0%       | 15.20         | PP avec un bien loué sans exo => 15.20                                         |
        | 3    | PP            | PROFESSIONNEL | 0%       | 15.30         | PP avec un bien professionel sans exo => 15.30                                 |
        | 4    | PP            | IMPRODUCTIF   | 0%       | 15.20         | PP avec un bien d'usage improductif sans exo => 15.20                          |
        | 5    | PM            | OCCUPE        | 0%       | 3.2           | PM avec un bien occupé  => 3.2                                                 |
        | 6    | PM            | LOUE          | 0%       | 3.1           | PM avec un bien loué  => 3.1                                                   |
        | 7    | PM            | IMPRODUCTIF   | 0%       | 3.1           | PM avec un bien d'usage improductif => 3.1                                     |
        | 8    | PP            | OCCUPE        | 100%     | 15.40         | PP avec un bien occupé et 100% exonérée => 15.40                               |
        | 9    | PP            | LOUE          | 100%     | 15.50         | PP avec un bien loué et 100% exonérée => 15.50                                 |
        | 10   | PP            | PROFESSIONNEL | 100%     | 15.50         | PP avec un bien pro et 100% exonérée => 15.50                                  |
        | 11   | PP            | OCCUPE        | 0%, 50%  | 15.10         | PP avec un bien occupé et une partie exonérée non 100% => ligne taxable 15.10  |
        | 12   | PP            | OCCUPE        | 0%, 50%  | 15.40         | PP avec un bien occupé et une partie exonérée non 100% => ligne exonérée 15.40 |
        | 13   | PP            | LOUE          | 0%, 50%  | 15.20         | PP avec un bien loué et une partie exonérée non 100% => ligne taxable 15.20    |
        | 14   | PP            | LOUE          | 0%, 50%  | 15.50         | PP avec un bien loué et une partie exonérée non 100% => ligne exonérée 15.50   |
        | 15   | PP            | PROFESSIONNEL | 0%, 50%  | 15.30         | PP avec un bien pro et une partie exonérée non 100% => ligne taxable 15.30     |
        | 16   | PP            | PROFESSIONNEL | 0%, 50%  | 15.50         | PP avec un bien pro et une partie exonérée non 100% => ligne exonérée 15.50    |
        | 17   | PM            | OCCUPE        | 0%, 50%  | 3.2           | PM avec un bien loué et une partie exonérée non 100% => ligne 3.2              |
