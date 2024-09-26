#language: fr
Fonctionnalité: F28 - Contrôle du dossier de taxation de l’année N.

  Règle: R1 - Contrôler le prérequis dossier de taxation pour un assujettissement pour un PP uniquement
  - Si le dossier de l'année de l'assujettissement est absent.
  - Alors afficher le message BLOQUANT "Le dossier de taxation de l'année N n'existe pas".
  - Si le dossier de l'année de l'assujettissement a un statut "Notifié".
  - Alors afficher le message BLOQUANT "Le dossier de taxation de l'année N est notifié".
  - Si le dossier de taxation est de genre Taxation d'Office.
  - Alors afficher le message d'AVERTISSEMENT "Attention N taxation d'office".

    @prerequisDossierTaxation @PP
    Scénario: Un dossier de taxation n'existe pas => prérequis KO
      Etant donné un assujettissement pour toute l'année fiscale 2020 pour un contribuable PP
      Et que le dossier de taxation pour cet assujettissement est inexistant
      Quand l'utilisateur valide le prérequis du dossier de taxation pour cet assujettissement
      Alors le résultat du contrôle affiche les messages suivants :
        | Le dossier de taxation de l'année 2020 n'existe pas |

    @prerequisDossierTaxation @PP
    Plan du scénario: Contrôle de l'état d'un dossier de taxation => prérequis KO si notifié  (<Test> - <Observation>)
      Etant donné un assujettissement pour toute l'année fiscale <année assuj> pour un contribuable PP
      Et que le dossier de taxation pour cet assujettissement est à l’état <etat>
      Quand l'utilisateur valide le prérequis du dossier de taxation pour cet assujettissement
      Alors un message de contrôle BLOQUANT est généré : <ouinon>
      Exemples:
        | Test | etat       | année assuj | ouinon | Observation                        |
        | 1    | NOTIFIE    | 2019        | oui    | Dossier notifié => Prérequis KO    |
        | 2    | EN_TRAVAIL | 2020        | non    | Dossier en travail => Prérequis OK |
        | 3    | A_VISER    | 2021        | non    | Dossier a viser => Prérequis OK    |
        | 4    | A_NOTIFIER | 2021        | non    | Dossier à notifier => Prérequis OK |

    @prerequisDossierTaxation @PP
    Scénario: Le prérequis "Dossier de taxation notifié" génère un message de contrôle bloquant
      Etant donné un assujettissement pour toute l'année fiscale 2020 pour un contribuable PP
      Et que le dossier de taxation pour cet assujettissement est à l’état NOTIFIE
      Quand l'utilisateur valide le prérequis du dossier de taxation pour cet assujettissement
      Alors un message de contrôle de type PREREQUIS et de sévérité BLOQUANT est généré : "Le dossier de taxation de l'année 2020 est notifié"

    @prerequisDossierTaxation @PP
    Plan du scénario: Le prérequis "Dossier de taxation TO" génère un message d'avertissement
      Etant donné un assujettissement pour toute l'année fiscale 2020 pour un contribuable PP
      Et que le dossier de taxation pour cet assujettissement est du genre OFFICE
      Quand l'utilisateur valide le prérequis du dossier de taxation pour cet assujettissement
      Alors un message de contrôle de type <typeControle> et de sévérité <severite> est généré : <message>
      Exemples:
        | typeControle | severite      | message                                                                 |
        | PREREQUIS    | AVERTISSEMENT | "Attention 2020 taxation d'office" |

    @prerequisDossierTaxation @PP @TO
    Plan du scénario: Contrôle du genre d'un dossier de taxation => prérequis KO si Taxation Office
      Etant donné un assujettissement pour toute l'année fiscale 2020 pour un contribuable PP
      Et que le dossier de taxation pour cet assujettissement est du genre <genre taxation>
      Quand l'utilisateur valide le prérequis du dossier de taxation pour cet assujettissement
      Alors un message de contrôle AVERTISSEMENT est généré : <ouinon>
      Exemples:
        | Test | genre taxation | ouinon | Observation                         |
        | 1    | OFFICE         | oui    | Dossier TO => Prérequis KO          |
        | 2    | DEFINITIVE     | non    | Dossier définitif => Prérequis OK   |
        | 3    | PROVISOIRE     | non    | Dossier proivisoire => Prérequis OK |

    @PM @prerequisDossierTaxation
    Scénario: Contrôler une taxation immo PM : prérequis Dossier Taxation KO => pas de message car PM
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable PM
      Etant donné le dossier de taxation pour cet assujettissement est inexistant
      Etant donné que les plafonds de contrôle sont paramétrés par défaut à 200
      Etant donné que les tolérances de contrôle sont paramétrées par défaut à 50%
      Quand l'utilisateur contrôle la taxation immobilière
      Alors aucun message de contrôle n'est généré

    @PP @prerequisDossierTaxation
    Scénario: Contrôler une taxation immo PP : prerequis Dossier Taxation KO, decla contribuable PP KO  => un seul message
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Etant donné le dossier de taxation pour cet assujettissement est à l’état NOTIFIE
      Etant donné le volet immobilier du dossier de taxation pour l'année précédente de cet assujettissement est validé
      Etant donné que les plafonds de contrôle sont paramétrés par défaut à 200
      Etant donné que les tolérances de contrôle sont paramétrées par défaut à 50%
      Etant donné les lignes contribuable PP genevoises suivantes pour le dossier de taxation de cet assuj :
        | Code taxation | Code commune cadastrale | Numéro de parcelle | Etat locatif | Taux abattement | Entretien IFD | Revenu IFD | Entretien ICC | Revenu ICC |
        | 15.10         | 150                     | 22                 | non          |                 | 200           | 500        | 300           | 400        |
      Quand l'utilisateur contrôle la taxation immobilière
      Alors le résultat du contrôle affiche les messages suivants :
        | Le dossier de taxation de l'année 2020 est notifié |
