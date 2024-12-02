##language: fr
#
#Fonctionnalité: Liste des tâches DDR
#
#  Scénario: Liste tâches DDR vide
#    Etant donné que un contribuable avec des tâches en attente suivant
#      | numeroR | typePrestation | idPrestation | statutTache   | echeance |
#      | R123456 | AFC.AEL.DDRPP  | 1            | AVERTISSEMENT | P15D     |
#      | R123456 | MES_COMPTES    |              | ALERTE        |          |
#      | R654321 |                |              |               |          |
#
#    Quand on recherche ses tâches
#    Alors La liste retourne le bon nombre de prestation et dans le bon status
#      | numeroR | nombreDeTaches | statutTachePrestation |
#      | R123456 | 2              | ALERTE                |
#      | R654321 | 0              |                       |
