#language: fr

Fonctionnalité: F22 - Contrôle taxation immo contribuable PP

  Règle: R1 - Contrôler les montants entretien ICC et entretien IFD des lignes parcelle contribuable
  - Les montants entretiens IFD et ICC sont contrôlés pour les lignes parcelle contribuable 15.10 BTR ou 15.20 BTR
  - Si les deux montants entretiens et revenus sont inexistants, alors aucun message de contrôle n'est généré
  -	Si seulement les montants entretien sont inexistants, alors aucun message de contrôle n'est généré
  -	Si seulement les montants revenus sont inexistants, alors aucun message de contrôle n'est généré
  - Une ligne parcelle contribuable est contrôlée avec les règles suivantes :
  -- Si les montants revenus existent pour la ligne, alors les montants entretiens sont comparés :
  --- par rapport au plafond :
  -- Si montant entretien > plafond alors un message de contrôle est généré
  --- par rapport à la tolérance  :
  -- Si Montant entretien / Montant revenu > Tolérance alors un message de contrôle est généré
  -- Si les montants revenus n'existent pas pour la ligne, alors les montants entretiens sont comparés :
  --- par rapport au plafond uniquement :
  -- Si montant entretien > plafond alors un message de contrôle est
  -- Si un message de contrôle a été généré, alors il est le suivant :
  --- "TaxImmo xx-xx-xx est divergente sur Entretien"

    @PP @controleContribuable @entretienIFD
    Plan du Scénario: Contrôle l'entretien IFD des lignes parcelle contribuable ne s'applique que pour les lignes 15.10 et 15.20 (<Test> - <Observation>)
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Etant donné que la taxation immobilière contribuable pour cet assuj contient une ligne parcelle <code taxation> BTR qui dépasse le plafond et la tolérance pour IFD
      Quand l'utilisateur contrôle la taxation immobilière genevoise du contribuable
      Alors un message de contrôle est généré : <résultat>
      Exemples:
        | Test | code taxation | résultat | Observation                                            |
        | 1    | 15.10         | oui      | Plafond et tolérance entretien respectés pour un 15.10 |
        | 2    | 15.20         | oui      | Plafond et tolérance entretien respectés pour un 15.20 |
        | 3    | 15.30         | non      | Pas de contrôle d’entretien pour les 15.30             |
        | 4    | 15.40         | non      | Pas de contrôle d’entretien pour les 15.40             |
        | 5    | 15.50         | non      | Pas de contrôle d’entretien pour les 15.50             |

    @PP @controleContribuable @entretienIFD
    Plan du Scénario: Contrôler le plafond de l'entretien IFD des lignes parcelle contribuable  (<Test> - <Observation>)
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Etant donné que le plafond de contrôle pour ENTRETIEN_IFD est paramétré à 200 pour l'année 2020, le code taxation 15.10 et le type GE
      Et que la taxation immobilière contribuable pour cet assuj contient la ligne parcelle 15.10 BTR avec un ENTRETIEN_IFD <entretien ifd> et un REVENU_IFD <revenu ifd>
      Quand l'utilisateur contrôle la taxation immobilière genevoise du contribuable
      Alors un message de contrôle est généré : <résultat>
      Exemples:
        | Test | entretien ifd | revenu ifd | résultat | Observation                                                       |
        | 1    | 200           | 700        | non      | Plafond entretien ifd non dépassé                                 |
        | 2    | 201           | 700        | oui      | Plafond entretien ifd dépassé                                     |
        | 3    | 200           |            | non      | Pas de message de contrôle si revenu ifd inexistant               |
        | 4    | 200           | 0          | non      | Pas de message de contrôle si revenu ifd à 0                      |
        | 5    | 201           |            | oui      | Message de contrôle si revenu ifd inexistant                      |
        | 6    | 201           | 0          | oui      | Message de contrôle si revenu ifd à 0                             |
        | 7    |               | 200        | non      | Pas de message de contrôle si entretien ifd inexistant            |
        | 8    | 0             | 200        | non      | Pas de message de contrôle si entretien ifd = 0                   |
        | 9    |               |            | non      | Pas de message de contrôle si entretien et revenu ifd inexistants |
        | 10   | 0             | 0          | non      | Pas de message de contrôle si entretien et revenu ifd = 0         |

    @PP @controleContribuable @entretienIFD
    Plan du Scénario: Contrôler la tolérence de l'entretien IFD des lignes parcelle contribuable (<Test> - <Observation>)
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Etant donné que le plafond de contrôle pour ENTRETIEN_IFD est paramétré à 9999 pour l'année 2020, le code taxation 15.10 et le type GE
      Et que la tolérance de contrôle pour ENTRETIEN_IFD est paramétrée à 50% pour l'année 2020, le code taxation 15.10 et le type GE
      Et que la taxation immobilière contribuable pour cet assuj contient la ligne parcelle 15.10 BTR avec un ENTRETIEN_IFD <entretien ifd> et un REVENU_IFD <revenu ifd>
      Quand l'utilisateur contrôle la taxation immobilière genevoise du contribuable
      Alors un message de contrôle est généré : <résultat>
      Exemples:
        | Test | entretien ifd | revenu ifd | résultat | Observation                                                       |
        | 1    | 100           | 200        | non      | Tolérance entretien ifd n'est pas dépassée                        |
        | 2    | 101           | 200        | oui      | Tolérance entretien ifd dépassée pour un 15.10                    |
        | 3    | 100           |            | non      | Pas de message de contrôle si revenu ifd inexistant               |
        | 4    | 100           | 0          | non      | Pas de message de contrôle si revenu ifd à 0                      |
        | 5    |               | 100        | non      | Pas de message de contrôle si entretien ifd inexistant            |
        | 6    | 0             | 100        | non      | Pas de message de contrôle si entretien ifd = 0                   |
        | 7    |               |            | non      | Pas de message de contrôle si entretien et revenu ifd inexistants |
        | 8    | 0             | 0          | non      | Pas de message de contrôle si entretien et revenu ifd = 0         |

    @PP @controleContribuable @entretienICC @entretienIFD
    Plan du scénario: L'entretien est controle pour ICC et IFD (<Test> - <Observation>)
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Et que la taxation immobilière contribuable pour cet assuj contient une ligne parcelle 15.10 BTR qui dépasse le plafond et la tolérance pour <type entretien et revenu>
      Quand l'utilisateur contrôle la taxation immobilière genevoise du contribuable
      Alors un message de contrôle est généré : <résultat>
      Exemples:
        | Test | type entretien et revenu | résultat | Observation             |
        | 1    | IFD                      | oui      | regle applique pour IFD |
        | 2    | ICC                      | oui      | regle applique pour ICC |


    @PP @controleContribuable @entretienICC @entretienIFD
    Plan du scénario: L'entretien est controle pour les lignes lieu fiscal hors canton de la meme facon (<Test> - <Observation>)
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Et que la taxation immobilière contribuable pour cet assuj contient la ligne lieu fiscal hors canton 15.10 BTR qui dépasse le plafond et la tolérance pour <type entretien et revenu>
      Quand l'utilisateur contrôle la taxation immobilière hors canton du contribuable
      Alors un message de contrôle est généré : <résultat>
      Exemples:
        | Test | type entretien et revenu | résultat | Observation             |
        | 1    | IFD                      | oui      | regle applique pour IFD |
        | 2    | ICC                      | oui      | regle applique pour ICC |

    @PP @controleContribuable @entretienIFD @entretienICC
    Scénario: Contrôler l'entretien IFD et l'entretien ICC des lignes parcelle contribuable
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Et que le plafond de contrôle pour ENTRETIEN_IFD, ENTRETIEN_ICC est paramétré à 200 pour l'année 2020, le code taxation 15.10 et le type GE
      Et que la tolérance de contrôle pour ENTRETIEN_IFD, ENTRETIEN_ICC est paramétrée à 50% pour l'année 2020, le code taxation 15.10 et le type GE
      Et que la taxation immobilière contribuable contient les lignes parcelle suivantes :
        | Code taxation | Code commune | Numéro parcelle | Type ligne parcelle | Entretien IFD | Revenu IFD | Entretien ICC | Revenu ICC |
        | 15.10         | 22           | 150             | BTR                 | 300           | 400        | 300           | 400        |
        | 15.10         | 22           | 151             | BTR                 | 200           | 500        | 300           | 400        |
        | 15.10         | 22           | 152             | BTR                 | 300           | 400        | 200           | 500        |
        | 15.10         | 22           | 153             | BTR                 | 200           | 500        | 200           | 500        |
      Quand l'utilisateur contrôle la taxation immobilière genevoise du contribuable
      Alors le résultat du contrôle affiche les messages suivants :
        | RTAX 15.10-22-150-BTR est divergente sur Entretien |
        | RTAX 15.10-22-151-BTR est divergente sur Entretien |
        | RTAX 15.10-22-152-BTR est divergente sur Entretien |

    @controle-ligne-lieufiscal-horscanton-contribuable @PP @entretienIFD @entretienICC
    Scénario: Contrôler l'entretien IFD et l'entretien ICC des lignes lieu fiscal HC contribuable
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Et que le plafond de contrôle pour ENTRETIEN_IFD, ENTRETIEN_ICC est paramétré à 200 pour l'année 2020, le code taxation 15.10 et le type HC
      Et que la tolérance de contrôle pour ENTRETIEN_IFD, ENTRETIEN_ICC est paramétrée à 50% pour l'année 2020, le code taxation 15.10 et le type HC
      Et que les lignes lieu fiscal hors canton contribuable pour cet assuj :
        | Code taxation | Code pays | Code canton | Entretien IFD | Revenu IFD | Entretien ICC | Revenu ICC |
        | 15.10         | CHE       | VD          | 300           | 400        | 300           | 400        |
        | 15.10         | FRA       |             | 200           | 500        | 300           | 400        |
        | 15.10         | CHE       | BE          | 300           | 400        | 200           | 500        |
        | 15.10         | CHE       | VS          | 200           | 500        | 200           | 500        |
      Quand l'utilisateur contrôle la taxation immobilière hors canton du contribuable
      Alors le résultat du contrôle affiche les messages suivants :
        | RTAX 15.10-CH-VD pour l'année 2020 est divergente sur Entretien |
        | RTAX 15.10-FRA pour l'année 2020 est divergente sur Entretien    |
        | RTAX 15.10-CH-BE pour l'année 2020 est divergente sur Entretien |

    @PP @controleContribuable @entretienIFD @entretienICC
    Plan du Scénario: Contrôler l'entretien IFD et l'entretien ICC des lignes contribuable (<Test> - <Observation>)
      Etant donné un assujettissement pour toute l'année fiscale <année fiscale> pour un contribuable seul PP
      Etant donné que le plafond de contrôle pour ENTRETIEN_IFD est paramétré à 1000 pour l'année 2021, le code taxation 15.10 et le type GE
      Et que la tolérance de contrôle pour ENTRETIEN_IFD est paramétrée à 100% pour l'année 2021, le code taxation 15.10 et le type GE
      Etant donné que le plafond de contrôle pour ENTRETIEN_IFD est paramétré à 500 pour l'année 2022, le code taxation 15.10 et le type GE
      Et que la tolérance de contrôle pour ENTRETIEN_IFD est paramétrée à 50% pour l'année 2022, le code taxation 15.10 et le type GE
      Etant donné que les autres paramètres de contrôle ne sont pas renseignés
      Et que la taxation immobilière contribuable pour cet assuj contient la ligne parcelle 15.10 BTR avec un ENTRETIEN_IFD 700 et un REVENU_IFD 700
      Quand l'utilisateur contrôle la taxation immobilière genevoise du contribuable
      Alors un message de contrôle est généré : <résultat>
      Exemples:
        #TODO AFCTAXIMMO-446 ajouter et vérifier colonnes intermédiaires : plafond appliqué et tolérance appliquée
        | Test | année fiscale | résultat | Observation                    |
        | 1    | 2021          | non      | Pas de dépassement en 2021     |
        | 2    | 2022          | oui      | Plafond et ratio 2022 dépassés |
        | 3    | 2023          | erreur   | Plafond et tolérance absents   |

  Règle: R2 - Contrôler "Entretien valide" : Contrôler si tous les biens immobiliers déclarés avec de l'entretien contiennent également du revenu
  - L'entretien déclaré est valide ssi :
  - Pour les biens hors canton :
  - Toutes les lignes contribuable lieu fiscal qui contiennent de l'entretien IFD ou ICC doivent avoir un revenu IFD ou ICC non vide
  - Sinon si au moins une ligne contribuable lieu fiscal contient de l'entretien IFD ou ICC sans revenu IFD ou ICC
  - Alors afficher le message suivant "Au moins une ligne RTAX HC contient de l'entretien avec un revenu vide"
  - Pour les biens genevois :
  - Toutes les lignes contribuable parcelle qui contiennent de l'entretien IFD ou ICC doivent avoir un revenu IFD ou ICC non vide
  - Sinon si au moins une ligne contribuable parcelle contient de l'entretien IFD ou ICC sans revenu IFD ou ICC
  - Alors afficher le message suivant "Au moins une ligne RTAX GE contient de l'entretien avec un revenu vide"

    @PP @controleContribuable @EntretienIFD
    Scénario: Contrôler "Entretien valide" du bien immobilier (<Test Id> -> <Observation>)
      Etant donné un assujettissement pour un contribuable seul PP
      Etant donné les lignes contribuable PP suivantes pour le dossier de taxation de cet assuj :
        | Code taxation |Code commune cadastrale |Code canton   |Code pays  |Entretien IFD | Revenu IFD |Entretien ICC |Revenu ICC |
        | 15.10         |19                      |GE            |  CHE      |1985          | 6000       |              |           |
        | 15.20         |                        |VD            |  CHE      |560           | 8000       |560           |8000       |
        | 15.20         |19                      |GE            |  CHE      |840           | 7520       |840           |2000       |
      Quand l'utilisateur contrôle l'entretien
      Alors le résultat du contrôle n'affiche aucun message

    @PP @controleContribuable @EntretienIFD
    Scénario: Contrôler "Entretien valide" du bien immobilier (<Test Id> -> <Observation>)
      Etant donné un assujettissement pour un contribuable seul PP
      Etant donné les lignes contribuable PP suivantes pour le dossier de taxation de cet assuj :
        |Code taxation |Code commune cadastrale |Code canton |Code pays |Entretien IFD |Revenu IFD |Entretien ICC |Revenu ICC |
        |15.10         |150                     |GE          |CHE       |1985          |6000       |1985          |6000       |
        |15.20         |19                      |GE          |CHE       |560           |8000       |560           |8000       |
        |15.20         |                        |VD          |CHE       |840           |6000       |840           |           |
      Quand l'utilisateur contrôle l'entretien
      Alors le résultat affiche les messages de contrôle sans tenir compte des clés de tri suivantes :
        |Code taxation | Type lieu fiscal   |Message                                                                | Sévérité      | Type                  |
        |15.20         | CANTON_HORS_GENEVE |Au moins une ligne RTAX HC contient de l'entretien avec un revenu vide| AVERTISSEMENT  | CONTROLE_CONTRIBUABLE |

    @PP @controleContribuable @EntretienIFD
    Scénario: Contrôler "Entretien valide" du bien immobilier (<Test Id> -> <Observation>)
      Etant donné un assujettissement pour un contribuable seul PP
      Etant donné les lignes contribuable PP suivantes pour le dossier de taxation de cet assuj :
        | Code taxation |Code commune cadastrale |Code canton   |Code pays  |Entretien IFD | Revenu IFD |Entretien ICC |Revenu ICC |
        | 15.10         |19                      |GE            |  CHE      |1985          | 6000       |1985          |6000       |
        | 15.20         |                        |VD            |  CHE      |560           | 8000       |560           |           |
        | 15.10         |150                     |GE            |  CHE      |5000          |            |2000          |           |
        | 15.20         |160                     |GE            |  CHE      |840           |            |              |           |
      Quand l'utilisateur contrôle l'entretien
      Alors le résultat affiche les messages de contrôle sans tenir compte des clés de tri suivantes :
        |Code taxation | Type lieu fiscal   | Message                                                                | Sévérité      | Type                  |
        |15.10         | COMMUNE_GENEVOISE  | Au moins une ligne RTAX GE contient de l'entretien avec un revenu vide | AVERTISSEMENT | CONTROLE_CONTRIBUABLE |
        |15.20         | COMMUNE_GENEVOISE  | Au moins une ligne RTAX GE contient de l'entretien avec un revenu vide | AVERTISSEMENT | CONTROLE_CONTRIBUABLE |
        |15.20         | CANTON_HORS_GENEVE | Au moins une ligne RTAX HC contient de l'entretien avec un revenu vide | AVERTISSEMENT | CONTROLE_CONTRIBUABLE |
