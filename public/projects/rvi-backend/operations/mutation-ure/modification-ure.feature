#language: fr
Fonctionnalité: mutation Usage, Resps et Exos

  Contexte:
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Newton, prenom: Isaac }
      - &personne_3 { id: 3, ref: 100.000.003, nom: Robesse, prenom: Pierre }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        surface: 1000
        constructions:
          - &construction1 { identifier: 16-16-cst1, no: cst1 }
        parts:
          - identifier: 16-16-pp1
            fraction: 1/3
            personne: *personne_1
            valeurTerrains:
              - identifier: 16-16-vt1
                prix: 20000
                usages :
                  - {identifier: 16-16-u, fraction: 1/1, type: loué}
                exonerations :
                  - {identifier: 16-16-exo-1, typeExoneration: 1 }
                  - {identifier: 16-16-exo-2, typeExoneration: 3 }
                responsabilites :
                  - {identifier: 16-16-r, fraction: 1/2, personne: *personne_2,  type: USUFRUIT}
          - identifier: 16-16-pp2
            fraction: 2/3
            personne: *personne_2
            valeurTerrains:
              - identifier: 16-16-vt2
                prix: 10000
    """

  Scénario: cas nominal
    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de mutation URE à la date 01.01.2020
    Etant donné que la valeur 16-16-vt1 est concernée par la mutation URE
    Etant donné que la valeur 16-16-vt2 est concernée par la mutation URE
    Etant donné que les usages sont modifiés par la mutation URE
    Etant donné qu'un usage 3/4 loué est ajouté à la mutation URE
    Etant donné qu'un usage 1/4 professionnel est ajouté à la mutation URE
    Etant donné que les responsabilites sont modifiés par la mutation URE
    Etant donné que l'exonération 3 est supprimée par la mutation URE
    Etant donné qu'une responsabilité 1/2 de type Usufruit pour la personne 100.000.003 est ajouté à la mutation URE
    Etant donné qu'une exonération 2 2000-2022 tx fortune 40% tx IIC 10% tx Revenu 15% est ajouté à la mutation URE

    Alors il y a 0 message d'erreur sur l'opération
    Quand l'opération de mutation URE est previsualisée


    Alors sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      parts:
      - identifier: 16-16-pp2
        valeurTerrains:
        - identifier: 16-16-vt2
          exos:
          - {tauxRevenu: 15.0, tauxIIC: 10.0, tauxFortune: 40.0, typeExoneration: Exo non transmissible 2}
          usages:
          - {fraction: 3/4, type: Loué}
          - {fraction: 1/4, type: Professionnel}
        responsabilites:
        - {fraction: 1/2, personne: Robesse Pierre, type: Usufruit}
      - identifier: 16-16-pp1
        valeurTerrains:
        - identifier: 16-16-vt1
          exos:
          - {tauxRevenu: 50.0, tauxIIC: 25.0, tauxFortune: 75.0, typeExoneration: Exo non transmissible 1}
          - {tauxRevenu: 15.0, tauxIIC: 10.0, tauxFortune: 40.0, typeExoneration: Exo non transmissible 2}
          usages:
          - {fraction: 3/4, type: Loué}
          - {fraction: 1/4, type: Professionnel}
        responsabilites:
        - {fraction: 1/2, personne: Robesse Pierre, type: Usufruit}
    """

    Quand l'opération de mutation URE est validée
    Alors il n'y a pas d'erreur lors de la publication de la session