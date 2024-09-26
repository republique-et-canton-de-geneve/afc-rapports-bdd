#language: fr
Fonctionnalité: Transfert de millième sans règle de l'achat - test de la consolidation

  Contexte:

  Scénario: Valeurs terrain consolidées
    Etant donné le reférentiel
    """yaml
    personnes:
    - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
    - &personne_2 { id: 2, ref: 100.000.002, nom: Newton, prenom: Isaac }
    mutations:
    - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
    - identifier: 16-16
      mutationDebut: *mut_01_01_2010
      constructions:
      - &construction1 { identifier: 16-16-construction, no: cst1 }
      ppes:
      - identifier: 16-16-1
        millieme: 1000
        parts:
        - personne: *personne_1
          valeurTerrains:
          - {surface: 300, prix: 20000, dateEstimation: 01.01.2000, unite: ESTIME}
          - {surface: 300, prix: 10000, dateEstimation: 01.01.2000, unite: ESTIME}
          - {surface: 300, prix: 20000, dateEstimation: 01.02.2000, unite: ESTIME}
          - {surface: 400, prix: 20000, dateEstimation: 01.01.2000, unite: ESTIME}
          - {surface: 300, prix: 30, unite: M2}
          - {surface: 300, prix: 30, unite: M2}
          - {surface: 300, prix: 40, unite: M2}
          - {surface: 300, prix: 100, unite: VALEUR_DE_RENDEMENT}
          - {surface: 300, prix: 100, unite: VALEUR_DE_RENDEMENT}
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de millième à la date d'estimation 01.02.2020
    Etant donnée un ppe cédé 16-16-1 sur 250 millième
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1

    Etant donnée il s'agit d'un transfert sans regle de l'achat avec report de montant 2000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée l'opération est consolidée

    Alors l'opération est en état consolidation

    Et sur la consolidation, les objets sont
    """yaml
    valeursTerrains:
    - {surface: 300, prix: 5000.0, unite: estimé}
    - {surface: 600, prix: 7500.0, unite: estimé}
    - {surface: 400, prix: 5000.0, unite: estimé}
    - {surface: 300, prix: 40.0, unite: m2}
    - {surface: 600, prix: 30.0, unite: m2}
    - {surface: 300, prix: 25.0, unite: valeur de rendement}
    - {surface: 300, prix: 25.0, unite: valeur de rendement}
    """

  Scénario: Valeurs batiment consolidées
    Etant donné le reférentiel
    """yaml
    personnes:
    - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
    - &personne_2 { id: 2, ref: 100.000.002, nom: Newton, prenom: Isaac }
    mutations:
    - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
    - identifier: 16-16
      mutationDebut: *mut_01_01_2010
      constructions:
      - &construction1 { identifier: 16-16-construction, no: cst1 }
      ppes:
      - identifier: 16-16-1
        millieme: 1000
        parts:
        - personne: *personne_1
          valeurBatiments:
          - {prix: 10000, dateEstimation: 01.01.2020, unite: ESTIME}
          - {prix: 20000, dateEstimation: 01.01.2020, unite: ESTIME}
          - {prix: 10000, dateEstimation: 01.02.2020, unite: ESTIME}
          - { prix: 100, unite: VALEUR_DE_RENDEMENT}
          - { prix: 200, unite: VALEUR_DE_RENDEMENT}
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de millième à la date d'estimation 01.02.2020
    Etant donnée un ppe cédé 16-16-1 sur 250 millième
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1

    Etant donnée il s'agit d'un transfert sans regle de l'achat avec report de montant 2000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée l'opération est consolidée

    Alors l'opération est en état consolidation

    Et sur la consolidation, les objets sont
    """yaml
    valeursBatiments:
    - { prix: 2500.0, unite: estimé}
    - { prix: 7500.0, unite: estimé}
    - { prix: 25.0, unite: valeur de rendement}
    - { prix: 50.0, unite: valeur de rendement}
    """
