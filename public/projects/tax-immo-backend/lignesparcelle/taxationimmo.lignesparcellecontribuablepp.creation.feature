#language: fr

Fonctionnalité: F19 - Création des lignes parcelle contribuable PP

  Règle: R1 - Les lignes parcelle contribuables sont agrégées pour les PP selon la clé de regroupement suivante :
  - Le code de taxation
  - L'identifiant unique de la parcelle (code commune cadastral + numéro parcelle)
  - Taux abattement pour les 15.10 et 15.40
  - Type de ligne parcelle : L ou BTR

    @creation-ligne-parcelle-contribuable @PP
    Scénario: Les lignes parcelle contribuable PP sont regroupées par code de taxation, code commune cadastrale, numéro de parcelle,
    d'un état locatif, et taux d'abattement à partir de lignes contribuable PP
      Etant donné un assujettissement pour un contribuable PP
      Etant donné les lignes contribuable PP genevoises suivantes pour le dossier de taxation de cet assuj :
        | Code taxation | Code commune cadastrale | Numéro de parcelle | Etat locatif | Taux abattement |
        | 15.10         | 150                     | 7                  | non          | 10%             |
        | 15.10         | 150                     | 7                  | non          | 10%             |
        | 15.20         | 150                     | 7                  | non          |                 |
        | 15.20         | 150                     | 7                  | oui          |                 |
        | 15.20         | 150                     | 7                  | oui          |                 |
        | 15.20         | 150                     | 7                  | non          |                 |
        | 15.10         | 150                     | 8                  | non          | 10%             |
        | 15.40         | 150                     | 7                  | non          | 10%             |
        | 15.40         | 160                     | 7                  | non          | 10%             |
        | 15.50         | 150                     | 7                  | non          |                 |
        | 15.50         | 150                     | 7                  | non          |                 |
      Quand le système crée les lignes parcelle contribuable PP pour cet assuj
      Alors cette taxation immobilière contribuable PP contient les lignes parcelle genevoises suivantes :
        | Code taxation | Code commune cadastrale | Numéro de parcelle | Taux abattement | Type ligne parcelle |
        | 15.10         | 150                     | 7                  | 10%             | BTR                 |
        | 15.10         | 150                     | 8                  | 10%             | BTR                 |
        | 15.20         | 150                     | 7                  |                 | BTR                 |
        | 15.20         | 150                     | 7                  |                 | L                   |
        | 15.40         | 150                     | 7                  | 10%             | BTR                 |
        | 15.40         | 160                     | 7                  | 10%             | BTR                 |
        | 15.50         | 150                     | 7                  |                 | BTR                 |

  Règle: R2 - Appliquer les règles de comparaison avec le référentiel uniquement sur les biens genevois

    @creation-ligne-parcelle-contribuable-genevois @PP
    Scénario: Appliquer les règles de comparaison entre les lignes parcelle contribuable et référentiel uniquement sur les biens genevois
      Etant donné un assujettissement pour un contribuable PP
      Etant donné les lignes contribuable PP suivantes pour le dossier de taxation de cet assuj :
        | Code taxation | Code commune cadastrale | Code canton | Code pays | Numéro de parcelle | Etat locatif | Taux abattement |
        | 15.10         | 150                     | GE          | CHE       | 7                  | non          | 10%             |
        | 15.20         | 150                     | GE          | CHE       | 7                  | non          |                 |
        | 15.10         |                         | VD          | CHE       | 8                  | non          | 10%             |
        | 15.40         |                         |             | FRA       | 7                  | non          | 10%             |
        | 15.50         |                         | VD          | CHE       | 7                  | non          |                 |

      Quand le système crée les lignes parcelle contribuable PP pour cet assuj
      Alors cette taxation immobilière contribuable PP contient les lignes parcelle genevoises suivantes :
        | Code taxation | Code commune cadastrale | Numéro de parcelle | Taux abattement | Type ligne parcelle |
        | 15.10         | 150                     | 7                  | 10%             | BTR                 |
        | 15.20         | 150                     | 7                  |                 | BTR                 |

