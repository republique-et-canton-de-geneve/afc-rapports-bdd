#language: fr
Fonctionnalité: Modification numéro oc

  Scénario: Modification numéro ddp
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
    Etant donnée une opération de modification de numero BTL DDP à la date valeur 01.02.2020
    Etant donné l'objet 16-16-1 de type ddp change de numéro. Nouveau numero 2
    Etant donnée l'opération de modification de numéro est prévisualisée
    Alors l'opération est en état prévisualisé

    Et sur la prévisualisation, les objets finaux sont
    """yaml
    - identifier: 16-16
      surface: 1000
      ddps:
      - identifier: 16-16-2
        noRf: "2"
        debutValidite: 2020-02-01
        parts:
        - personne: Currie Marie
          identifierDdp: 16-16-2
          valeurTerrains:
          - surface: 1000
            exos:
            - typeExoneration: Exo non transmissible 1
            usages:
            - type: Loué
            responsabilites:
            - personne: Newton Isaac
        ppes: []
        questionnaires: []
      btls: []
      parts: []
      questionnaires: []
    """
