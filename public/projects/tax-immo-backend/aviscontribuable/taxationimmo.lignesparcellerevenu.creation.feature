#language: fr
Fonctionnalité: F31 - Création des lignes parcelle revenu

  Règle: R1 - Les lignes parcelle revenu sont créées à partir des lignes détail avec les critères suivantes :
      - Le code de taxation : 15.10
      - Type de ligne parcelle : R
    et regroupées avec les éléments suivantes :
      - L'identifiant unique de la parcelle (code commune cadastral + numéro parcelle)
      - Taux abattement

    @creation-ligne-parcelle-revenu @PP
    Scénario: Les lignes parcelle revenu sont filtrées par code de taxation et type de ligne et regroupées avec objet cadastral et taux d'abattement
      Etant donné une taxation immobilière référentiel qui contient les lignes détail suivantes :
        | Code taxation | Id OC    | Type               | Taux abattement |
        | 15.10         | 22-150-7 | BATIMENT           | 10%             |
        | 15.10         | 22-150-7 | REVENU_OCCUPE      | 20%             |
        | 15.10         | 22-150-7 | REVENU_OCCUPE      | 20%             |
        | 15.10         | 22-150-7 | REVENU_OCCUPE      | 4%              |
        | 15.20         | 22-150-7 | TERRAIN            |                 |
        | 15.10         | 22-150-8 | REVENU_OCCUPE      | 20%             |
        | 15.10         | 22-150-8 | REVENU_OCCUPE      | 40%             |
      Quand l'utilisateur demande de créer les lignes parcelle revenu pour cet avis au contribuable
      Alors cet avis au contribuable contient les lignes parcelle revenu suivantes :
        | Code taxation | Id parcelle | Taux abattement |
        | 15.10         | 22-150      | 20%             |
        | 15.10         | 22-150      | 4%              |
        | 15.10         | 22-150      | 40%             |
