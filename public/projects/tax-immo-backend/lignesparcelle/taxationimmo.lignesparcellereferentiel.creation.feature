#language: fr

Fonctionnalité: F17 - Création des lignes parcelle référentiel

  Règle: R1 - Les lignes parcelle référentiel sont agrégées pour les PP selon la clé de regroupement suivante :
  - Le code de taxation
  - L'identifiant unique de la parcelle (code commune cadastral + numéro parcelle)
  - Taux abattement pour les 15.10 et 15.40
  - Type de ligne parcelle : L ou BTR

    @creation-ligne-parcelle-referentiel @PP
    Scénario: Les lignes parcelle référentiel sont regroupées par code de taxation, parcelle et taux d'abattement à partir de lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail suivantes :
        | Code taxation | Id OC    | Type         | Taux abattement |
        | 15.10         | 22-150-7 | BATIMENT     | 10%             |
        | 15.10         | 22-150-7 | TERRAIN      | 20%             |
        | 15.20         | 22-150-7 | BATIMENT     |                 |
        | 15.20         | 22-150-7 | ETAT_LOCATIF |                 |
        | 15.20         | 22-150-7 | ETAT_LOCATIF |                 |
        | 15.20         | 22-150-7 | TERRAIN      |                 |
        | 15.10         | 22-150-8 | BATIMENT     | 10%             |
        | 15.40         | 22-150-7 | BATIMENT     | 10%             |
        | 15.40         | 22-150-7 | TERRAIN      | 20%             |
        | 15.50         | 22-150-7 | BATIMENT     |                 |
        | 15.50         | 22-150-7 | TERRAIN      |                 |
        | 15.30         | 22-150-7 | TERRAIN      |                 |
      Quand l'utilisateur demande de créer les lignes parcelle pour cette taxation immobilière
      Alors cette taxation immobilière contient 8 lignes parcelle
      Et ces lignes parcelle sont les suivantes :
        | Code taxation | Id parcelle | Taux abattement | Type ligne parcelle | Nb lignes détail |
        | 15.10         | 22-150      | 10%             | BTR                 | 2                |
        | 15.10         | 22-150      | 20%             | BTR                 | 1                |
        | 15.20         | 22-150      |                 | BTR                 | 2                |
        | 15.20         | 22-150      |                 | L                   | 2                |
        | 15.40         | 22-150      | 10%             | BTR                 | 1                |
        | 15.40         | 22-150      | 20%             | BTR                 | 1                |
        | 15.50         | 22-150      |                 | BTR                 | 2                |
        | 15.30         | 22-150      |                 | BTR                 | 1                |
