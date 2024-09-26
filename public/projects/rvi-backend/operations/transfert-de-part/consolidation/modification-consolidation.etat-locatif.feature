#language: fr
Fonctionnalité: Modification de la consolidation pour la partie valeur etat locatif

  Contexte:
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Carpentier, prenom: Emmanuelle }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        surface: 3000
        constructions:
        - &construction1 { identifier: 16-16-construction, no: cst1 }
        parts:
        - identifier: 16-16-pp
          personne: *personne_1
          valeurEtatLocatifs: [ { identifier: 16-16-vel, montant: 20000, codeAffectation: 1, annee: 2010, construction: *construction1 } ]
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de type transfert de part à la date d'estimation 01.02.2020
    Etant donnée une part cédée 16-16-pp à hauteur de 1/1
    Etant donnée une part acquise par la personne 2 à hauteur de 1/1
    Etant donnée il s'agit d'un achat avec report de montant 2000 usage reporté responsabilite reporté QVL reporté éxoneration reporté
    Etant donnée l'opération est consolidée

  Scénario: Ajout d'une valeur etat locatif

    Etant donné l'ajout, en consolidation, d'une valeur etat locatif sur l'objet cadastral 16-16 avec affectation preponderante 1 pour l'annee 2021 et de type construction cat box prix achat 10 000

    Alors sur la consolidation, les objets sont
    """yaml
    - valeursEtatLocatifs:
      - montant: 20000.0
      - montant: 10000.0
    """

  Scénario: Modification d'une valeur etat locatif

    Etant donné la modification, en consolidation, de la valeur etat locative 16-16-valeurEtatLocatif-1 pour le montant 15 000 affectation 1 annee 2022 nature construction

    Alors sur la consolidation, les objets sont
    """yaml
    - valeursEtatLocatifs:
      - montant: 15000.0
    """

  Scénario: Suppression d'une valeur etat locatif

    Etant donné la supression, en consolidation, d'une valeur etat locative 16-16-valeurEtatLocatif-1

    Alors sur la consolidation, les objets sont
    """yaml
    - valeursEtatLocatifs: []
    """
