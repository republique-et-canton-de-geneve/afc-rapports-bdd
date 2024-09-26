#language: fr
Fonctionnalité: Modification etat locatif

  Scénario: cas nominal
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Ham, prenom: Abra }

    mutations:
      - &mut_01_01_2020 { dateValeur: 01.01.2020 }

    parcelles:
      - identifier: 16-40
        mutationDebut: *mut_01_01_2020
        surface: 50
        constructions:
          - &construction1 { identifier: 16-40-cst1,  no: cst1 }
          - &construction2 { identifier: 16-40-cst2,  no: cst2 }
        parts:
          - fraction: 1/3
            personne: *personne_1

            valeurEtatLocatifs:
              - identifier: 16-40-vel1
                montant: 10000
                idAdresse: 1
                anneeVisa: 2020
                construction: *construction1

          - identifier: 16-40-part2
            fraction: 2/3
            personne: *personne_2

            valeurEtatLocatifs:
              # A modifier et doublon avec le suivant
              - identifier: 16-40-vel2
                montant: 12345
                anneeVisa: 2020
                idAdresse: 1
                construction: *construction1

              # A modifier et doublon avec le précédent
              - identifier: 16-40-vel3
                montant: 67890
                anneeVisa: 2020
                idAdresse: 1
                construction: *construction1

              # Autre etat locatif à conserver (addresse differente)
              - identifier: 16-40-vel4
                montant: 10000
                anneeVisa: 2020
                idAdresse: 2
                construction: *construction1

              # Autre etat locatif à conserver (addresse non renseignée)
              - identifier: 16-40-vel5
                anneeVisa: 2020
                montant: 10000
                idAdresse: null
                construction: *construction1


              # Autre etat locatif à conserver (construction differente)
              - identifier: 16-40-vel6
                anneeVisa: 2020
                montant: 10000
                idAdresse: 1
                construction: *construction2

              # Autre etat locatif à conserver (annee visa differente)
              - identifier: 16-40-vel7
                anneeVisa: 2021
                montant: 10000
                idAdresse: 1
                construction: *construction2
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-40 |
    Etant donnée une opération de modification d'état locatif à la date 01.01.2022
    Etant donnée l'opération de modification d'état locatif modifie 16-40-vel1 avec le montant 40 000
    Etant donnée l'opération de modification d'état locatif est prévisualisée
    Etant donnée l'opération de modification d'état locatif est validée

    Alors il n'y a pas d'erreur lors de la publication de la session
    Et la parcelle 16-40 à la date valeur 01.01.2022 est
    """yaml
    identifier: 16-40
    parts:
    - personne: Ham Abra
      valeurEtatLocatifs:
      - {identifier: 16-40-vel3, montant: 26667.0}
      - {identifier: 16-40-vel4, montant: 10000.0}
      - {identifier: 16-40-vel5, montant: 10000.0}
      - {identifier: 16-40-vel6, montant: 10000.0}
      - {identifier: 16-40-vel7, montant: 10000.0}

    - personne: Marie Currie
      valeurEtatLocatifs:
      - {identifier: 16-40-vel1, montant: 13333.0}
    """


  Scénario: répartition du montant total entre les états locatifs concernées
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Ham, prenom: Abra }
      - &personne_3 { id: 3, ref: 100.000.003, nom: Cadabra, prenom: Abra }

    mutations:
      - &mut_01_01_2020 { dateValeur: 01.01.2020 }

    parcelles:
      - identifier: 16-40
        mutationDebut: *mut_01_01_2020
        surface: 50
        constructions:
          - &construction1 { identifier: 16-40-cst1,  no: cst1 }
          - &construction2 { identifier: 16-40-cst2,  no: cst2 }
        parts:
          - fraction: 1/3
            personne: *personne_1

            valeurEtatLocatifs:
              - identifier: 16-40-vel1
                montant: 5000
                idAdresse: 1
                anneeVisa: 2020
                construction: *construction1

          - identifier: 16-40-part2
            fraction: 1/3
            personne: *personne_2

            valeurEtatLocatifs:
              - identifier: 16-40-vel2
                montant: 5000
                anneeVisa: 2020
                idAdresse: 1
                construction: *construction1

          - identifier: 16-40-part3
            fraction: 1/3
            personne: *personne_3

            valeurEtatLocatifs:
              # Autre etat locatif à conserver (annee visa differente).
              - identifier: 16-40-vel3
                montant: 5000
                idAdresse: 1
                anneeVisa: 2021
                construction: *construction1
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-40 |
    Etant donnée une opération de modification d'état locatif à la date 01.01.2022
    Etant donnée l'opération de modification d'état locatif modifie 16-40-vel1 avec le montant 30 000
    Etant donnée l'opération de modification d'état locatif est prévisualisée
    Etant donnée l'opération de modification d'état locatif est validée

    Alors il n'y a pas d'erreur lors de la publication de la session
    Et la parcelle 16-40 à la date valeur 01.01.2022 est
    """yaml
    identifier: 16-40
    parts:
    - personne: Ham Abra
      valeurEtatLocatifs:
      - {identifier: 16-40-vel2, montant: 10000.0}

    - personne: Marie Currie
      valeurEtatLocatifs:
      - {identifier: 16-40-vel1, montant: 10000.0}

    - personne: Cadabra Abra
      valeurEtatLocatifs:
      - {identifier: 16-40-vel3, montant: 5000.0}
    """

  Scénario: Absence de répartition des états locatifs si date de début de validité est différente
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Ham, prenom: Abra }
      - &personne_3 { id: 3, ref: 100.000.003, nom: Cadabra, prenom: Abra }

    mutations:
      - &mut_01_01_2020 { dateValeur: 01.01.2020 }
      - &mut_01_02_2020 { dateValeur: 01.02.2020 }
      - &mut_01_03_2020 { dateValeur: 01.03.2020 }

    parcelles:
      - identifier: 16-40
        mutationDebut: *mut_01_01_2020
        surface: 50
        constructions:
          - &construction1 { identifier: 16-40-cst1,  no: cst1 }
          - &construction2 { identifier: 16-40-cst2,  no: cst2 }
        parts:
          - fraction: 1/3
            personne: *personne_1

            valeurEtatLocatifs:
              - identifier: 16-40-vel1
                montant: 5000
                idAdresse: 1
                anneeVisa: 2020
                construction: *construction1
                mutationDebut: *mut_01_01_2020

          - identifier: 16-40-part2
            fraction: 1/3
            personne: *personne_2

            valeurEtatLocatifs:
              - identifier: 16-40-vel2
                montant: 5000
                anneeVisa: 2020
                idAdresse: 1
                construction: *construction1
                mutationDebut: *mut_01_02_2020

          - identifier: 16-40-part3
            fraction: 1/3
            personne: *personne_3

            valeurEtatLocatifs:
              # Autre etat locatif à conserver (annee visa differente).
              - identifier: 16-40-vel3
                montant: 5000
                idAdresse: 1
                anneeVisa: 2020
                construction: *construction1
                mutationDebut: *mut_01_03_2020
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-40 |
    Etant donnée une opération de modification d'état locatif à la date 01.01.2022
    Etant donnée l'opération de modification d'état locatif modifie 16-40-vel1 avec le montant 30 000
    Etant donnée l'opération de modification d'état locatif est prévisualisée
    Etant donnée l'opération de modification d'état locatif est validée

    Alors il n'y a pas d'erreur lors de la publication de la session
    Et la parcelle 16-40 à la date valeur 01.01.2022 est
    """yaml
    identifier: 16-40
    parts:
    - personne: Marie Currie
      valeurEtatLocatifs:
      - {identifier: 16-40-vel1, montant: 10000.0}

    - personne: Ham Abra
      valeurEtatLocatifs:
      - {identifier: 16-40-vel2, montant: 5000.0}

    - personne: Cadabra Abra
      valeurEtatLocatifs:
      - {identifier: 16-40-vel3, montant: 5000.0}
    """

  Scénario: Répartition des états loctifs si ils sont considérés égaux
    Etant donné le reférentiel
    """yaml
    personnes:
      - &personne_1 { id: 1, ref: 100.000.001, nom: Marie, prenom: Currie }
      - &personne_2 { id: 2, ref: 100.000.002, nom: Ham, prenom: Abra }
      - &personne_3 { id: 3, ref: 100.000.003, nom: Cadabra, prenom: Abra }

    mutations:
      - &mut_01_01_2020 { dateValeur: 01.01.2020 }

    parcelles:
      - identifier: 16-40
        mutationDebut: *mut_01_01_2020
        surface: 50
        constructions:
          - &construction1 { identifier: 16-40-cst1,  no: cst1 }
          - &construction2 { identifier: 16-40-cst2,  no: cst2 }
        parts:
          - fraction: 1/3
            personne: *personne_1

            valeurEtatLocatifs:
              - identifier: 16-40-vel1
                montant: 5000
                idAdresse: 1
                anneeVisa: 2020
                construction: *construction1
                mutationDebut: *mut_01_01_2020

          - identifier: 16-40-part2
            fraction: 1/3
            personne: *personne_2

            valeurEtatLocatifs:
              - identifier: 16-40-vel2
                montant: 5000
                anneeVisa: 2020
                idAdresse: 1
                construction: *construction1
                mutationDebut: *mut_01_01_2020

          - identifier: 16-40-part3
            fraction: 1/3
            personne: *personne_3

            valeurEtatLocatifs:
              - identifier: 16-40-vel3
                montant: 5000
                idAdresse: 1
                anneeVisa: 2020
                construction: *construction1
                mutationDebut: *mut_01_01_2020
    """

    Etant donnée que la session concerne la/les parcelles
      | 16-40 |
    Etant donnée une opération de modification d'état locatif à la date 01.01.2022
    Etant donnée l'opération de modification d'état locatif modifie 16-40-vel1 avec le montant 30 000
    Etant donnée l'opération de modification d'état locatif est prévisualisée
    Etant donnée l'opération de modification d'état locatif est validée

    Alors il n'y a pas d'erreur lors de la publication de la session
    Et la parcelle 16-40 à la date valeur 01.01.2022 est
    """yaml
    identifier: 16-40
    parts:
    - personne: Ham Abra
      valeurEtatLocatifs:
      - {identifier: 16-40-vel2, montant: 10000.0}

    - personne: Marie Currie
      valeurEtatLocatifs:
      - {identifier: 16-40-vel1, montant: 10000.0}

    - personne: Cadabra Abra
      valeurEtatLocatifs:
      - {identifier: 16-40-vel3, montant: 10000.0}
    """