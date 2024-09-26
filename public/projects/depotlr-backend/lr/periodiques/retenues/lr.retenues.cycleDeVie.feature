#language: fr
#TODO SHOULD renommer ce répertoire et les features (le nommage devrait indiquer que cela concerne les retenues mensuelles)
Fonctionnalité: Gérer le cycle de vie des Retenues Mensuelles d'un salarié par les périodes d'activité

  Règle: Lors de l'ajout d'un salarié, le système crée les retenues mensuelles pour les périodes d'activité du salarié.
    Plan du Scénario: Création des retenues mensuelles lors de l'ajout d'un salarié - <Test> -> <Observation>
      Etant donné qu'un DPI <Type DPI> est sélectionné
      Etant donné que la date du jour est <Jour>
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Quand l'utilisateur ajoute un salarié à cette LR avec les périodes d'activité <Périodes d'activité>
      Alors il existe les retenues mensuelles suivantes pour ce salarié seulement pour les mois suivants: <Mois retenues>
      Exemples:
        | Test | Type DPI | Jour       | Périodes d'activité                                      | Mois retenues    | Observation                                                                                                     |
        | 1    | SALARIES | 31.12.2021 | du 01.01.2021 au 31.01.2021                              | Janvier          | Retenues mensuelles créées pour Janvier si le salarié est actif en Janvier                                      |
        | 2    | SALARIES | 01.03.2021 | du 01.01.2021 au 28.02.2021                              | Janvier, Février | Retenues mensuelles créées pour Janvier, Février si le salarié est actif en Janvier, Février                    |
        | 3    | SALARIES | 31.12.2021 | du 01.01.2021 au 31.01.2021, du 01.03.2021 au 31.03.2021 | Janvier, Mars    | Retenues mensuelles créées pour Janvier, Mars si le salarié est actif en Janvier, Mars                          |
        | 4    | SALARIES | 31.12.2021 | du 01.01.2021 au 31.12.2021                              | Tous             | Retenues mensuelles créées pour tous les mois de l'année si le salarié ajouté est toujours actif                |
        | 5    | SALARIES | 17.11.2021 | du 01.01.2021 au 28.05.2022                              | Tous             | Retenues mensuelles créées pour tous les mois de l'année si le salarié ajouté est actif jusque l'année suivante |
#TODO COULD ajouter des exemples avec d'autres types de LR (implique d'ajouter le bon type de personne et pas un salarié)
#        | 2    | CAISSE_COMPENSATION | 01.03.2021 | Janvier, Février | Janvier, Février | Retenues mensuelles créées pour Janvier, Février si le salarié est actif en Janvier, Février     |
#        | 3    | BENEFICIAIRE_RENTE  | 31.12.2021 | Janvier, Mars    | Janvier, Mars    | Retenues mensuelles créées pour Janvier, Mars si le salarié est actif en Janvier, Mars           |

  Règle: Lors de la suppression d'un salarié, le système supprime les retenues mensuelles pour ce salarié.
    Scénario: Suppression des retenues mensuelles lors de la suppression d'un salarié
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Quand l'utilisateur supprime la personne 1 de la LR
      Alors il n'existe plus de retenue mensuelle pour la personne 1
      Et il existe toujours des retenues mensuelles pour la personne 2

  Règle: Lors de la modification d'un salarié, quand ses périodes d'activité ont changé:
  -On ajoute les retenues mensuelles pour les nouveaux mois d'activité de ce salarié.
  -On supprime les retenues mensuelles pour les mois où le salarié n'a plus d'activité.

    Scénario: Création de retenues mensuelles lors de l'extension de la période d'activité d'un salarié
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 17.11.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.03.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Retenue IS |
        | Janvier | 10000                | 500                 | 2400.53    |
        | Février | 9000                 | 123                 | 1500.40    |
        | Mars    | 10000                | 200                 | 9898.25    |
      Quand l'utilisateur modifie les périodes d'activité de ce salarié:
        | Début      | Fin        |
        | 01.01.2021 | 30.04.2021 |
      Alors il existe seulement les retenues mensuelles suivantes pour cette personne:
        | Mois    | Prestations soumises | Montant apériodique | Retenue IS |
        | Janvier | 10000                | 500                 | 2400.53    |
        | Février | 9000                 | 123                 | 1500.40    |
        | Mars    | 10000                | 200                 | 9898.25    |
        | Avril   |                      |                     |            |

    Scénario: Suppression de retenues mensuelles lors de la réduction de la période d'activité d'un salarié
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 17.11.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.03.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Retenue IS |
        | Janvier | 10000                | 500                 | 2400.53    |
        | Février | 9000                 | 123                 | 1500.40    |
        | Mars    | 10000                | 200                 | 9898.25    |
      Quand l'utilisateur modifie les périodes d'activité de ce salarié:
        | Début      | Fin        |
        | 01.01.2021 | 28.02.2021 |
      Alors il existe seulement les retenues mensuelles suivantes pour cette personne:
        | Mois    | Prestations soumises | Montant apériodique | Retenue IS |
        | Janvier | 10000                | 500                 | 2400.53    |
        | Février | 9000                 | 123                 | 1500.40    |

    Scénario: Création et suppression de retenues mensuelles lors de la modification de la période d'activité d'un salarié
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 17.11.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 31.03.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Retenue IS |
        | Janvier | 10000                | 500                 | 2400.53    |
        | Février | 9000                 | 123                 | 1500.40    |
        | Mars    | 10000                | 200                 | 9898.25    |
      Quand l'utilisateur modifie les périodes d'activité de ce salarié:
        | Début      | Fin        |
        | 01.01.2021 | 25.01.2021 |
        | 15.02.2021 | 22.02.2021 |
        | 03.04.2021 | 28.05.2021 |
      Alors il existe seulement les retenues mensuelles suivantes pour cette personne:
        | Mois    | Prestations soumises | Montant apériodique | Retenue IS |
        | Janvier | 10000                | 500                 | 2400.53    |
        | Février | 9000                 | 123                 | 1500.40    |
        | Avril   |                      |                     |            |
        | Mai     |                      |                     |            |

  Règle: Quand on duplique les retenues mensuelles depuis un mois avec de l'activité vers un mois avec de l'activité, celles-ci sont copiées
  pour le mois suivant, et remplacent ainsi celles qui existaient pour ce mois, avec les règles suivantes :
  - le montant périodique n'est pas repris du mois précédent, il est vide
  - toutes les autres informations sont écrasées, qu'elles soient renseignées ou non dans la source ou la cible
  - la duplication vers le mois de janvier est interdite

    Contexte:
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 31.10.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 30.04.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 500                 | 600                 | 2400.53    | Acacias         | C0     | Non           |
        | Février | 9000                 | 123                 | 700                 |            | Acacias         | C1     | Oui           |
        | Mars    |                      |                     |                     |            |                 |        |               |
        | Avril   | 6000                 | 300                 | 100                 | 2200       | Genève          | C1     | Oui           |

    Scénario: Duplication des retenues mensuelles dans une LR avec un seul SALARIE à partir d'un mois contenant une retenue complète
      Quand l'utilisateur duplique dans cette LR les retenues mensuelles du mois précédant Février
      Alors il existe seulement les retenues mensuelles suivantes pour cette personne:
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 500                 | 600                 | 2400.53    | Acacias         | C0     | Non           |
        | Février | 10000                |                     | 600                 | 2400.53    | Acacias         | C0     | Non           |
        | Mars    |                      |                     |                     |            |                 |        |               |
        | Avril   | 6000                 | 300                 | 100                 | 2200       | Genève          | C1     | Oui           |
      Et le système DepotLR accepte

    Scénario: Duplication des retenues mensuelles dans une LR avec un seul SALARIE à partir d'un mois contenant une retenue vide
      Quand l'utilisateur duplique dans cette LR les retenues mensuelles du mois précédant Avril
      Alors il existe seulement les retenues mensuelles suivantes pour cette personne:
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 500                 | 600                 | 2400.53    | Acacias         | C0     | Non           |
        | Février | 9000                 | 123                 | 700                 |            | Acacias         | C1     | Oui           |
        | Mars    |                      |                     |                     |            |                 |        |               |
        | Avril   |                      |                     |                     |            |                 |        |               |
      Et le système DepotLR accepte

    Scénario: Duplication des retenues mensuelles dans une LR avec un seul SALARIE pour le mois de janvier
      Quand l'utilisateur duplique dans cette LR les retenues mensuelles du mois précédant Janvier
      Alors le système DepotLR refuse


  Règle: Lors de la duplication d'une retenue mensuelle autre que SALARIE
  Pour un ADMIN ou un BENEFICIAIRE_RENTE :
  - On ne copie pas le montant apériodique
  - On ne copie pas le montant déterminant
  Pour une CAISSE_COMPENSATION :
  - On ne copie pas le montant apériodique

    Contexte:
      Etant donné que la date du jour est 31.10.2021

    Scénario: Duplication des retenues mensuelles dans une LR avec un seul BENEFICIAIRE_RENTE à partir d'un mois contenant une retenue complète avec des montants déterminant et apériodique anormalement remplis
      Etant donné qu'un DPI BENEFICIAIRE_RENTE est sélectionné
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne BENEFICIAIRE_RENTE a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 30.04.2021
      Etant donné que cette personne de type BENEFICIAIRE_RENTE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 2400.53    |                 | C0     | Non           |
        | Février | 9000                 |            |                 | C1     | Oui           |
        | Mars    |                      |            |                 |        |               |
        | Avril   | 6000                 | 2200       |                 | C1     | Oui           |
      Quand l'utilisateur duplique dans cette LR les retenues mensuelles du mois précédant Février
      Alors il existe seulement les retenues mensuelles suivantes pour cette personne:
        | Mois    | Prestations soumises | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 2400.53    |                 | C0     | Non           |
        | Février | 10000                | 2400.53    |                 | C0     | Non           |
        | Mars    |                      |            |                 |        |               |
        | Avril   | 6000                 | 2200       |                 | C1     | Oui           |
      Et le système DepotLR accepte

    Scénario: Duplication des retenues mensuelles dans une LR avec un seul ADMIN à partir d'un mois contenant une retenue complète avec des montants déterminant et apériodique anormalement remplis
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable ADMIN a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 30.04.2021
      Etant donné que cette personne de type ADMIN a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 2400.53    | Acacias         | C0     | Non           |
        | Février | 9000                 |            | Acacias         | C1     | Oui           |
        | Mars    |                      |            |                 |        |               |
        | Avril   | 6000                 | 2200       | Genève          | C1     | Oui           |
      Quand l'utilisateur duplique dans cette LR les retenues mensuelles du mois précédant Février
      Alors il existe seulement les retenues mensuelles suivantes pour cette personne:
        | Mois    | Prestations soumises | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Janvier | 10000                | 2400.53    | Acacias         | C0     | Non           |
        | Février | 10000                | 2400.53    | Acacias         | C0     | Non           |
        | Mars    |                      |            |                 |        |               |
        | Avril   | 6000                 | 2200       | Genève          | C1     | Oui           |
      Et le système DepotLR accepte

    Scénario: Duplication des retenues mensuelles dans une LR avec une seule CAISSE_COMPENSATION à partir d'un mois contenant une retenue complète avec des montants déterminant et apériodique anormalement remplis
      Etant donné qu'un DPI CAISSE_COMPENSATION est sélectionné
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne CAISSE_COMPENSATION a été ajoutée à cette LR avec une période d'activité du 01.01.2021 au 30.04.2021
      Etant donné que cette personne de type CAISSE_COMPENSATION a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant déterminant | Retenue IS | Barème | Barème ajusté |
        | Janvier | 10000                | 600                 | 2400.53    | C0     | Non           |
        | Février | 9000                 | 700                 |            | C1     | Oui           |
        | Mars    |                      |                     |            |        |               |
        | Avril   | 6000                 | 100                 | 2200       | C1     | Oui           |
      Quand l'utilisateur duplique dans cette LR les retenues mensuelles du mois précédant Février
      Alors il existe seulement les retenues mensuelles suivantes pour cette personne:
        | Mois    | Prestations soumises | Montant déterminant | Retenue IS | Barème | Barème ajusté |
        | Janvier | 10000                | 600                 | 2400.53    | C0     | Non           |
        | Février | 10000                | 600                 | 2400.53    | C0     | Non           |
        | Mars    |                      |                     |            |        |               |
        | Avril   | 6000                 | 100                 | 2200       | C1     | Oui           |
      Et le système DepotLR accepte



  Règle: Quand un utilisateur demande la duplication des retenues mensuelles depuis un mois précédent sans activité ou vers un mois sans activité, il ne se passe rien.

    Scénario: Duplication des retenues mensuelles depuis un mois précédent sans activité -> les retenues restent inchangées et pas d'erreur
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 31.12.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.02.2021 au 31.03.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Février | 9000                 | 123                 | 700                 |            | Acacias         | C1     | Oui           |
        | Mars    | 10000                | 200                 | 800                 | 9898.25    | Genève          | C1     | Oui           |
      Quand l'utilisateur duplique dans cette LR les retenues mensuelles du mois précédant Février
      Alors il existe seulement les retenues mensuelles suivantes pour cette personne:
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Février | 9000                 | 123                 | 700                 |            | Acacias         | C1     | Oui           |
        | Mars    | 10000                | 200                 | 800                 | 9898.25    | Genève          | C1     | Oui           |
      Et le système DepotLR accepte

    Scénario: Duplication des retenues mensuelles vers un mois sans activité -> les retenues restent inchangées et pas d'erreur
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné que la date du jour est 31.12.2021
      Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
      Etant donné qu'une personne salariée de type contribuable SALARIE a été ajoutée à cette LR avec une période d'activité du 01.02.2021 au 31.03.2021
      Etant donné que cette personne de type SALARIE a les retenues mensuelles suivantes :
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Février | 9000                 | 123                 | 700                 |            | Acacias         | C1     | Oui           |
        | Mars    | 10000                | 200                 | 800                 | 9898.25    | Genève          | C1     | Oui           |
      Quand l'utilisateur duplique dans cette LR les retenues mensuelles du mois précédant Avril
      Alors il existe seulement les retenues mensuelles suivantes pour cette personne:
        | Mois    | Prestations soumises | Montant apériodique | Montant déterminant | Retenue IS | Lieu de travail | Barème | Barème ajusté |
        | Février | 9000                 | 123                 | 700                 |            | Acacias         | C1     | Oui           |
        | Mars    | 10000                | 200                 | 800                 | 9898.25    | Genève          | C1     | Oui           |
      Et le système DepotLR accepte
