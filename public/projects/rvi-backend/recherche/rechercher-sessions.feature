#language: fr
Fonctionnalité: Recherche de sessions

  Contexte:
    Etant donné le reférentiel
    """yaml
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        surface: 1000
        ppes:
          - identifier: 16-16-1
        ddps:
          - identifier: 16-16-1
      - identifier: 16-17
        mutationDebut: *mut_01_01_2010
        surface: 1000
    """

  Scénario: cas recherche sur les objets sélectionnés
    Etant donnée une nouvelle session de libellé "session1"
    Etant donné l'ajout des objets sélectionnés sur la session
      | identifiant | type     |
      | 16-16       | parcelle |
    Etant donnée une nouvelle session de libellé "session2"
    Etant donné l'ajout des objets sélectionnés sur la session
      | identifiant | type     |
      | 16-16-1     | ppe      |
    Etant donnée une nouvelle session de libellé "session3"
    Etant donné l'ajout des objets sélectionnés sur la session
      | identifiant | type     |
      | 16-17       | parcelle |
      | 16-16-1     | ppe      |

    Quand on recherche des sessions sur l'objet sélectionné 16-16
    Alors on obtient 3 sessions
    Alors la session de libellé "session1" est dans les résultats
    Alors la session de libellé "session2" est dans les résultats
    Alors la session de libellé "session3" est dans les résultats

    Quand on recherche des sessions sur l'objet sélectionné 16-16-1
    Alors on obtient 2 sessions
    Alors la session de libellé "session2" est dans les résultats
    Alors la session de libellé "session3" est dans les résultats

    Quand on recherche des sessions sur l'objet sélectionné 16-17
    Alors on obtient 1 sessions
    Alors la session de libellé "session3" est dans les résultats

    Quand on recherche des sessions sur l'objet sélectionné 16-1
    Alors on obtient 0 sessions