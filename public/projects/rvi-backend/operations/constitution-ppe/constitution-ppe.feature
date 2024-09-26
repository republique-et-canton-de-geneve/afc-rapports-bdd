#language: fr
Fonctionnalité: constitution ppe

  Scénario: constitution sur parcelle
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Currie, prenom: Marie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Newton, prenom: Isaac }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        parts:
          - identifier: 16-16-pp
            fraction: 1/1
            personne: *personne_1
            valeurTerrains:
              - identifier: 16-16-vt
                usages : [{identifier: 16-16-u, fraction: 1/1, type: loué}]
                exonerations : [{identifier: 16-16-exo, typeExoneration: 1 }]
                responsabilites : [{identifier: 16-16-rp, fraction: 1/2, personne: *personne_2,  type: USUFRUIT}]
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de constitution PPE à la date valeur 01.02.2020
    Etant donné l'objet 16-16 est selectionné pour constitution de PPE
    Alors l'opération est en état prévisualisé

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      surface: 1000
      debutValidite: 2010-01-01
      constructions: [ ]
      ppes:
        - identifier: 16-16-1
          millieme: 1000.0
          parts:
            - fraction: 1/1
              personne: Currie Marie
              valeurTerrains:
                - valeurEstimee: 10000.0
                  exos: [ { typeExoneration: Exo non transmissible 1 } ]
                  usages: [ { fraction: 1/1, type: Loué } ]
                  responsabilites: [ { fraction: 1/2, personne: Newton Isaac, type: Usufruit } ]
    """

  Scénario: constitution sur ddp
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Currie, prenom: Marie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Newton, prenom: Isaac }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        ddps:
          - identifier: 16-16-1
            parts:
              - identifier: 16-16-pp
                personne: *personne_1
                valeurTerrains:
                  - identifier: 16-16-vt
                    usages : [{identifier: 16-16-u, fraction: 1/1, type: loué}]
                    exonerations : [{identifier: 16-16-exo, typeExoneration: 1 }]
                    responsabilites : [{identifier: 16-16-rp, fraction: 1/2, personne: *personne_2,  type: USUFRUIT}]
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de constitution PPE à la date valeur 01.02.2020
    Etant donné l'objet 16-16-1 est selectionné pour constitution de PPE
    Alors l'opération est en état prévisualisé

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      ppes: []
      ddps:
      - identifier: 16-16-1
        ppes:
        - identifier: 16-16-1-1
          millieme: 1000.0
          parts:
            - fraction: 1/1
              personne: Currie Marie
              valeurTerrains:
                - valeurEstimee: 10000.0
                  exos: [ { typeExoneration: Exo non transmissible 1 } ]
                  usages: [ { fraction: 1/1, type: Loué } ]
                  responsabilites: [ { fraction: 1/2, personne: Newton Isaac, type: Usufruit } ]
    """

  Scénario: constitution sur btl
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Currie, prenom: Marie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Newton, prenom: Isaac }
    mutations:
      - &mut_01_01_2010 { dateValeur: 01.01.2010 }
    parcelles:
      - identifier: 16-16
        mutationDebut: *mut_01_01_2010
        btls:
          - identifier: 16-16-1
            parts:
              - identifier: 16-16-pp
                personne: *personne_1
                valeurTerrains:
                  - identifier: 16-16-vt
                    usages : [{identifier: 16-16-u, fraction: 1/1, type: loué}]
                    exonerations : [{identifier: 16-16-exo, typeExoneration: 1 }]
                    responsabilites : [{identifier: 16-16-rp, fraction: 1/2, personne: *personne_2,  type: USUFRUIT}]
    """
    Etant donnée que la session concerne la/les parcelles
      | 16-16 |
    Etant donnée une opération de constitution PPE à la date valeur 01.02.2020
    Etant donné l'objet 16-16-1 est selectionné pour constitution de PPE
    Alors l'opération est en état prévisualisé

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      ppes: []
      btls:
      - identifier: 16-16-1
        ppes:
        - identifier: 16-16-1-1
          millieme: 1000.0
          parts:
            - fraction: 1/1
              personne: Currie Marie
              valeurTerrains:
                - valeurEstimee: 10000.0
                  exos: [ { typeExoneration: Exo non transmissible 1 } ]
                  usages: [ { fraction: 1/1, type: Loué } ]
                  responsabilites: [ { fraction: 1/2, personne: Newton Isaac, type: Usufruit } ]
    """


