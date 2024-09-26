#language: fr

Fonctionnalité: F15 - Calcul du total IIC des lignes agrégées

  Règle: R1 - Calcul du total IIC pour une taxation immobilière
  le total IIC est égal à la somme des montants IIC de chaque ligne agrégée de la taxation immobilière.

    @totalIIC @PM
    Scénario: Calcul du total IIC pour une taxation immobilière PM à partir des valeurs immobilières
      Etant donné un assujettissement pour un contribuable PM
      Et que le taux IIC par défaut paramétré pour les PM OCCUPE est de 2‰ pour cette année fiscale
      Et que les valeurs immobilières pour cet assujettissement sont :
        | Type     | Id OC    | Usages | Valeur totale |
        | TERRAIN  | 22-150-7 | OCCUPE | 1500000       |
        | BATIMENT | 22-150-7 | OCCUPE | 1200000       |
      Et a une part d'usage 1/1
      Et a comme usage OCCUPE
      Et a une part de responsabilite 1/1
      Et a aussi les taux exo IIC: (50%)
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors le total IIC de cette taxation immobilière est de 1200.00

    @totalIIC @PP
    Scénario: Calcul du total IIC pour une taxation immobilière PP à partir des valeurs immobilières
      Etant donné un assujettissement pour un contribuable PP
      Et que le taux IIC pour les PP est paramétré à 1‰ pour cette année fiscale
      Et que les valeurs immobilières pour cet assujettissement sont :
        | Type     | Id OC    | Usages | Valeur totale |
        | TERRAIN  | 22-150-7 | OCCUPE | 1800000       |
        | BATIMENT | 22-150-7 | OCCUPE | 1700000       |
      Et a une part d'usage 1/1
      Et a une part de responsabilite 1/1
      Et a aussi les taux exo IIC: (50%)
      Quand l'utilisateur demande la taxation immobilière pour cet assujettissement
      Alors le total IIC de cette taxation immobilière est de 850.00

    @totalIIC
    Scénario: Calcul du total IIC à partir des lignes agrégées
      Etant donné les lignes agrégées suivantes :
        | Code taxation | Id OC    | Montant IIC |
        | 15.10         | 22-150-7 | 1000.35     |
        | 15.10         | 22-150-8 | 2520        |
        | 15.20         | 22-150-7 | 300.90      |
        | 15.10         | 22-150-9 | 1300        |
        | 15.40         | 22-150-7 | 0           |
      Quand le système calcule l'IIC à partir des lignes agrégées
      Alors le total IIC est de 5121.25

    @totalIIC
    Scénario: Calcul du total IIC à zéro à partir des lignes agrégées
      Etant donné les lignes agrégées suivantes :
        | Code taxation | Id OC    | Montant IIC |
        | 15.10         | 22-150-7 | 0           |
        | 15.10         | 22-150-8 | 0           |
        | 15.20         | 22-150-7 | 0           |
      Quand le système calcule l'IIC à partir des lignes agrégées
      Alors le total IIC est de 0.00
