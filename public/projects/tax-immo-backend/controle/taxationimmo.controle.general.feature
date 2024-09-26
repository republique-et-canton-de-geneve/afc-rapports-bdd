#language: fr

@controle
Fonctionnalité: F23 - Contrôle global d'une taxation immo

  Règle: R1 - Contrôler une taxation immo avec les étapes suivantes
  - 1. Contrôler tous les prérequis : s'il existe des messages bloquants ne pas continuer
  - 2. Contrôler la taxation immo du contribuable PP
  - 3. Comparer la taxation immo du contribuable PP avec le référentiel
  - 4. Agréger les messages distincts générés dans les contrôles des étapes précédentes
  - 5. Ces messages sont triés (voir R2)

    @PP @plusieursRegles @prerequisAssuj @controleContribuable
    Scénario: Contrôler une taxation immo PP : prerequis bloquant KO, decla contribuable PP KO  => un seul message
      Etant donné un assujettissement PP de rôle IS dans l'état INFORMATIF depuis le 01.01.2020
      Etant donné le dossier de taxation pour cet assujettissement est à l’état EN_TRAVAIL
      Etant donné le volet immobilier du dossier de taxation pour l'année précédente de cet assujettissement est validé
      Etant donné que les plafonds de contrôle sont paramétrés par défaut à 200
      Etant donné que les tolérances de contrôle sont paramétrées par défaut à 50%
      Etant donné les lignes contribuable PP genevoises suivantes pour le dossier de taxation de cet assuj :
        | Code taxation | Code commune cadastrale | Numéro de parcelle | Etat locatif | Taux abattement | Entretien IFD | Revenu IFD | Entretien ICC | Revenu ICC |
        | 15.10         | 150                     | 22                 | non          |                 | 200           | 500        | 300           | 400        |
      Quand l'utilisateur contrôle la taxation immobilière
      Alors le résultat du contrôle affiche les messages suivants :
        | Cet assujettissement est informatif pour l'année 2020             |
        | Cet assujettissement n'a pas de date de fin pour l'année 2020     |
        | Ce n'est pas un assujettissement IBO PPHC ou PM pour l'année 2020 |

    @PP @plusieursRegles @prerequisArticle14 @prerequisMiseEnAttente @prerequisReservation @prerequisVoletImmoDossierTaxationAnneePrecedente @controleContribuable @prerequisAssujUnique
    Scénario: Contrôler une taxation immo PP : plusieurs prérequis non bloquants KO => plusieurs messages
      Etant donné que le contribuable 87654321 est mis en attente par l'utilisateur BACCI pour le numéro de volume AAA au 31.12.2020
      Etant donné un assujettissement PP de rôle IBO dans l'état A_TAXER du 01.01.2020 au 31.12.2020 avec la référence métier 722.39.2620-2020-IBO-1
      Et que cet assujettissement est imposé d'après la dépense i.e. article 14
      Et que le contribuable 87654321 a aussi les assujettissements 722.39.2620-2020-PPHC-1 à taxer et fermé
      Etant donné que le dossier de taxation pour cet assujettissement est à l’état EN_TRAVAIL
      Etant donné le volet immobilier du dossier de taxation pour l'année précédente de cet assujettissement est validé
      Etant donné que les plafonds de contrôle sont paramétrés par défaut à 200
      Etant donné que les tolérances de contrôle sont paramétrées par défaut à 50%
      Etant donné les lignes contribuable PP genevoises suivantes pour le dossier de taxation de cet assuj :
        | Code taxation | Code commune cadastrale | Numéro de parcelle | Etat locatif | Taux abattement | Entretien IFD | Revenu IFD | Entretien ICC | Revenu ICC |
        | 15.10         | 150                     | 22                 | non          |                 | 200           | 500        | 300           | 400        |
      Etant donné que il n'existe aucune valeur immobilière pour cet assujettissement
      Quand l'utilisateur contrôle la taxation immobilière pour cet assujettissement
      Alors le résultat du contrôle affiche les messages suivants :
        | Attention mises en attente AAA  |
        | RTAX 15.10-150-22-BTR est divergente sur Entretien                                      |
        | RTAX 15.10-150-22-BTR est manquante ou différente dans TaxImmo                          |
        | Cet assujettissement est un article 14                                                  |
        | Plusieurs assujettissements pour 2020 : 722.39.2620-2020-IBO-1, 722.39.2620-2020-PPHC-1 |

    @PP @plusieursRegles @prerequisReservation
    Scénario: Messages de contrôle distincts : un seul message affiché si des messages sont identiques
      Etant donné un assujettissement pour un contribuable PP
      Et que la valeur immobilière pour cet assujettissement contient l'objet cadastral 123-456-789 réservé par l'utilisateur BACCI dans la session 98765
      Et que la valeur immobilière pour cet assujettissement contient l'objet cadastral 123-456-789 réservé par l'utilisateur BACCI dans la session 98765
      Quand l'utilisateur valide le prérequis de réservation pour cet assujettissement
      Alors le résultat affiche les messages de contrôle suivants :
        | Message                                                                  | Sévérité      | Type      |
        | L'objet cadastral 123-456-789 est réservé par BACCI par la session 98765 | AVERTISSEMENT | PREREQUIS |

    @PP @plusieursRegles @prerequisMiseEnAttente
    Scénario: Contrôler une taxation immo PP : prérequis important (à afficher en popup)
      Etant donné que le contribuable 87654321 est mis en attente par l'utilisateur BACCI pour le numéro de volume AAA au 31.12.2020
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable PP ayant comme numeroR 87654321
      Quand l'utilisateur valide le prérequis de mise en attente pour cet assujettissement
      Alors le résultat affiche les messages de contrôle suivants :
        | Message                                | Sévérité      | Type      | Important |
        | Attention mises en attente AAA         | AVERTISSEMENT | PREREQUIS | oui       |

    @PP @plusieursRegles @prerequisArticle14
    Scénario: Contrôler une taxation immo PP : prérequis important (à ne pas afficher en popup)
      Etant donné que le contribuable 87654321 est mis en attente par l'utilisateur BACCI pour le numéro de volume AAA au 31.12.2020
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable PP ayant comme numeroR 87654321
      Et que cet assujettissement est imposé d'après la dépense i.e. article 14
      Quand l'utilisateur valide le prérequis Article 14 pour cet assujettissement
      Alors le résultat affiche les messages de contrôle suivants :
        | Message                                | Sévérité      | Type      | Important |
        | Cet assujettissement est un article 14 | AVERTISSEMENT | PREREQUIS | non       |

    @PP @plusieursRegles @prerequisAssuj @prerequisMiseEnAttente @prerequisDossierTaxation
    Scénario: Contrôler une taxation immo PP : plusieurs prérequis bloquants => plusieurs messages agrégés
      Etant donné que le contribuable 87654321 est mis en attente par l'utilisateur BACCI pour le numéro de volume AAA au 31.12.2020
      Etant donné un assujettissement PP ayant comme numeroR 87654321 de rôle IBO dans l'état INFORMATIF du 01.01.2020 au 31.12.2020
      Etant donné que le dossier de taxation pour cet assujettissement est à l’état NOTIFIE
      Etant donné le volet immobilier du dossier de taxation pour l'année précédente de cet assujettissement est validé
      Quand l'utilisateur contrôle la taxation immobilière pour cet assujettissement
      Alors le résultat du contrôle affiche les messages suivants :
        | Cet assujettissement est informatif pour l'année 2020                                  |
        | Attention mises en attente AAA |
        | Le dossier de taxation de l'année 2020 est notifié                                     |

    @PP @plusieursRegles @prerequis @comparaison @controleContribuable
    Scénario: Contrôler une taxation immo PP : prerequis OK, decla contribuable PP KO, comparaison avec le référentiel KO, comparaison entre contribuable N et N-1 KO => trois messages agrégés
      Etant donné que les plafonds de contrôle sont paramétrés par défaut à 200
      Etant donné que les tolérances de contrôle sont paramétrées par défaut à 50%
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Etant donné le volet immobilier du dossier de taxation pour l'année précédente de cet assujettissement est validé
      Etant donné les lignes contribuable PP genevoises suivantes pour le dossier de taxation de cet assuj :
        | Code taxation | Code commune cadastrale | Numéro de parcelle | Etat locatif | Taux abattement | Entretien IFD | Revenu IFD | Entretien ICC | Revenu ICC |
        | 15.10         | 150                     | 22                 | non          |                 | 200           | 500        | 300           | 400        |
        | 15.20         | 160                     | 23                 | non          |                 |               |            |               |            |
      Etant donné les lignes contribuable PP hors canton suivantes pour le dossier de taxation de cet assuj :
        | Code taxation | Code pays | Code canton | Fortune |
        | 15.20         | CHE       | VD          | 1000    |
        | 15.10         | FRA       |             |         |
      Et les lignes contribuable PP hors canton suivantes pour le dossier de taxation de l'assuj de l'année fiscale précédente :
        | Code taxation | Code pays | Code canton | Fortune |
        | 15.20         | CHE       | VD          | 1300    |
      Etant donné que il n'existe aucune valeur immobilière pour cet assujettissement
      Quand l'utilisateur contrôle la taxation immobilière
      Alors le résultat du contrôle affiche les messages suivants :
        | RTAX 15.10-150-22-BTR est divergente sur Entretien                       |
        | RTAX 15.10-150-22-BTR est manquante ou différente dans TaxImmo           |
        | RTAX 15.20-CH-VD a une différence entre l'année 2020 et 2019 sur Fortune |
        | RTAX 15.20-160-23-BTR est manquante ou différente dans TaxImmo           |
        | RTAX 15.10-FRA manquante dans l'année 2019                               |

  Règle: R2 - Trier les messages avec le tri suivant :
  - par type contrôle dans l'ordre PREREQUIS, CONTROLE_CONTRIBUABLE
  - pour les PREREQUIS, pas de tri spécifique
  - pour les CONTROLE_CONTRIBUABLE, trier par :
  – pour les lignes contribuable lieu fiscal :
  — typeLieuFiscal : COMMUNE_GENEVOISE, CANTON_HORS_GENEVE et PAYS_HORS_SUISSE
  – pour les lignes contribuable et référentiel parcelle :
  – les critères suivants dans l'ordre : code de taxation, code commune, parcelle, type ligne, abattement

    @plusieursRegles @tri @controles
    Scénario: Trier les messages générés :
      Etant donné les messages de controle :
        | Type                  | Type lieu fiscal   | Code taxation | Code commune cadastrale | Numéro de parcelle | Code commune politique | Type ligne parcelle | Taux abattement | Message    |
        | CONTROLE_CONTRIBUABLE | COMMUNE_GENEVOISE  | 15.10         | 12                      | 19                 | 6000                   | L                   |                 | Message 1  |
        | CONTROLE_CONTRIBUABLE | PAYS_HORS_SUISSE   | 15.20         |                         |                    |                        |                     |                 | Message 2  |
        | CONTROLE_CONTRIBUABLE | COMMUNE_GENEVOISE  | 15.10         | 140                     | 21                 | 6001                   | L                   |                 | Message 3  |
        | CONTROLE_CONTRIBUABLE | COMMUNE_GENEVOISE  | 15.10         | 140                     | 21                 | 6002                   | L                   |                 | Message 4  |
        | CONTROLE_CONTRIBUABLE | COMMUNE_GENEVOISE  | 15.10         | 140                     | 21                 | 6002                   | BTR                 | 35              | Message 5  |
        | CONTROLE_CONTRIBUABLE | COMMUNE_GENEVOISE  | 15.10         | 140                     | 21                 | 6002                   | BTR                 | 45              | Message 6  |
        | CONTROLE_CONTRIBUABLE | COMMUNE_GENEVOISE  | 15.10         | 140                     | 21                 | 6002                   | BTR                 | 30              | Message 7  |
        | CONTROLE_CONTRIBUABLE | COMMUNE_GENEVOISE  | 15.10         | 145                     | 20                 | 6000                   | L                   |                 | Message 8  |
        | CONTROLE_CONTRIBUABLE | COMMUNE_GENEVOISE  | 15.10         | 1500                    | 20                 | 6000                   | L                   |                 | Message 9  |
        | CONTROLE_CONTRIBUABLE | COMMUNE_GENEVOISE  | 15.20         | 150                     | 20                 | 6000                   | L                   |                 | Message 10 |
        | CONTROLE_CONTRIBUABLE | COMMUNE_GENEVOISE  | 15.20         | 151                     | 20                 | 6000                   | L                   |                 | Message 11 |
        | CONTROLE_CONTRIBUABLE | PAYS_HORS_SUISSE   | 15.10         |                         |                    |                        |                     |                 | Message 12 |
        | CONTROLE_CONTRIBUABLE | COMMUNE_GENEVOISE  | 15.10         | 140                     | 20                 | 6000                   | L                   |                 | Message 13 |
        | CONTROLE_CONTRIBUABLE | CANTON_HORS_GENEVE | 15.20         |                         |                    |                        |                     |                 | Message 14 |
        | PREREQUIS             |                    |               |                         |                    |                        |                     |                 | Message 15 |
      Quand les messages de controle sont triés
      Alors le résultat du contrôle affiche les messages triés suivants :
        | Message 15 |
        | Message 1  |
        | Message 13 |
        | Message 3  |
        | Message 7  |
        | Message 5  |
        | Message 6  |
        | Message 4  |
        | Message 8  |
        | Message 9  |
        | Message 10 |
        | Message 11 |
        | Message 12 |
        | Message 2  |
        | Message 14 |

