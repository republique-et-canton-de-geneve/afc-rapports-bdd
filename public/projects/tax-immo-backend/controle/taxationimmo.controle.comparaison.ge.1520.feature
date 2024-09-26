#language: fr

Fonctionnalité: F32 - Comparaison entre taxation immo contribuable PP année N et N-1

  Règle: R1 - Contrôler l'existence des lignes parcelle contribuable 15.20 entre l'année N et N-1
  - Contrôler la liste des lignes parcelle contribuable 15.20 pour l'année N avec l'année N-1 :
  -- Les lignes de l'année N doivent être présentes dans l'année N-1
  -- Sinon la taxation immobilière affichera le message de contrôle suivant "La ligne parcelle contribuable xx-xx-xx (clé) est absente pour l'année 2020"
  -- Les lignes de l'année N-1 doivent être présentes dans l'année N
  -- Sinon la taxation immobilière affichera le message de contrôle suivant "La ligne parcelle contribuable xx-xx-xx (clé) est absente pour l'année 2021"

    @PP @comparaison
    Scénario: Les taxations immobilières contribuable N et N-1 ont des lignes parcelle manquantes chacune et des lignes parcelle identiques
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Etant donné que la taxation immobilière contribuable pour l'année 2020 contient les lignes parcelle suivantes :
         | Code taxation | Code commune | Numéro parcelle | Type ligne parcelle | Taux abattement |
         | 15.10         | 22           | 150             | BTR                 | 10%             |
         | 15.20         | 22           | 150             | BTR                 |                 |
         | 15.20         | 22           | 150             | L                   |                 |
         | 15.20         | 22           | 151             | BTR                 |                 |
      Etant donné que la taxation immobilière contribuable pour l'année 2019 contient les lignes parcelle suivantes :
         | Code taxation | Code commune | Numéro parcelle | Type ligne parcelle | Taux abattement |
         | 15.10         | 23           | 150             | BTR                 | 10%             |
         | 15.20         | 22           | 150             | BTR                 |                 |
         | 15.20         | 22           | 152             | BTR                 |                 |
         | 15.20         | 23           | 150             | BTR                 |                 |
      Quand l'utilisateur compare la taxation immobilière contribuable entre l'année N et N-1
      Alors le résultat de la comparaison affiche les messages suivants :
        | La ligne parcelle 15.20-22-152-BTR est manquante dans l'année 2020 |
        | La ligne parcelle 15.20-23-150-BTR est manquante dans l'année 2020 |

  Règle: R2 - Comparer les revenus (revenu IFD ou revenu ICC) des lignes parcelle contribuable 15.20 entre l'année N et N-1
  - Les montants revenus ne sont comparés que pour les 15.20
  - Deux lignes parcelle avec la même clé sont comparées avec les règles suivantes :
  -- Si le montant des deux lignes est inexistant, alors aucun message de contrôle n'est généré
  -- Si le montant est inexistant pour un seul, alors un message de contrôle est généré
  -- Si les montants existent pour les deux lignes, alors ces montants sont comparés :
  --- par rapport au plafond paramétré en fonction du type de montant, du code de taxation et de l'année fiscale :
  ---- Si ValeurAbsolue (Montant contribuable - Montant référentiel) > Plafond alors un message de contrôle est généré
  --- par rapport à la tolérance paramétrée en fonction du type de montant, du code de taxation et de l'année fiscale :
  ---- Si (ValeurAbsolue (Montant contribuable - Montant référentiel)) / Montant contribuable > Tolérance alors un message de contrôle est généré
  - Si un message de contrôle a été généré, alors il est le suivant :
  -- "RTAX xx.xx-xx-xxx-XXX a une différence entre l'année N-1 et N sur Revenu"
  - Si le plafond ou la toérance ne sont pas paramétrés, la comparaison renvoie une erreur

    @PP @comparaison @revenuIFD @revenuICC
    Scénario: Comparer les revenus des lignes parcelle RTAX entre l’année N et N-1
      Etant donné que les plafonds de contrôle sont paramétrés par défaut à 200
      Etant donné que les tolérances de contrôle sont paramétrées par défaut à 50%
      Etant donné un assujettissement pour l'année fiscale 2020 pour un contribuable seul PP
      Etant donné que la taxation immobilière contribuable pour l'année 2020 contient les lignes parcelle suivantes :
        | Code taxation | Code commune | Numéro parcelle | Type ligne parcelle | Revenu IFD | Revenu ICC |
        | 15.10         | 22           | 150             | BTR                 | 2000       | 1000       |
        | 15.10         | 22           | 151             | BTR                 | 799        | 40         |
        | 15.10         | 22           | 152             | L                   | 799        | 40         |
        | 15.20         | 22           | 152             | BTR                 | 799        | 40         |
      Etant donné que la taxation immobilière contribuable pour l'année 2019 contient les lignes parcelle suivantes :
        | Code taxation | Code commune | Numéro parcelle | Type ligne parcelle | Revenu IFD | Revenu ICC |
        | 15.10         | 22           | 150             | BTR                 | 2000       | 1000       |
        | 15.10         | 22           | 151             | BTR                 | 1000       | 100        |
        | 15.10         | 22           | 152             | L                   | 1000       | 100        |
        | 15.20         | 22           | 152             | BTR                 | 1000       | 100        |
      Quand l'utilisateur compare la taxation immobilière contribuable entre l'année N et N-1
      Alors le résultat de la comparaison affiche les messages suivants :
        | RTAX 15.20-22-152-BTR a une différence entre l'année 2019 et 2020 sur Revenu |
