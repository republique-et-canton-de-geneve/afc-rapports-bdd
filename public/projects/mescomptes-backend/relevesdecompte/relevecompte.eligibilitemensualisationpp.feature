#language: fr
Fonctionnalité: F6 - Détermination de l'éligibilité d'un compte à la mensualisation PP

  Règle: R1 - Un compte est éligible à la mensualisation  PP :
  - si le compte appartient à une PP
  - si la prestation du compte est ICC
  - si l'état du compte est non notifié sur l'année en cours

    Plan du scénario: Détermination  l'éligibilité en fonction de l'année courante <AnneeCivile>, du type de personne <TypePersonne>, du type de bordereau <TypeBordereau> et de l'année du compte <AnneeFiscaleCompte>, <Test> -> <Observation>
      Etant donné que  l'année courante est <AnneeCivile>
      Et que le contribuable de type <TypePersonne> sélectionne un des comptes suivants avec code prestation <CodePrestation>, bordereau <TypeBordereau> de l'année <AnneeFiscaleCompte>
      Quand le système vérifie l'éligibilité à la mensu PP
      Alors le système renvoie que l'éligibilité à la mensu PP est <EligibleMensuPP>
      Exemples:
        | Test | AnneeCivile | TypePersonne | CodePrestation | TypeBordereau | AnneeFiscaleCompte | EligibleMensuPP | Observation                                                               |
        | 1    | 2023        | PP           | ICC            | Notifié       | 2020               | false           | false car compte sur une année fiscale différente de l'année civile       |
        | 2    | 2023        | PP           | IFD            | Non notifié   | 2023               | false           | false car compte IFD (et non ICC)                                         |
        | 3    | 2024        | PP           | ICC            | Notifié       | 2024               | false           | false car compte sur une PP de type ICC mais notifié sur l'année en cours |
        | 4    | 2024        | PP           | ICC            | Non notifié   | 2024               | true            | true car compte sur une PP de type ICC non notifié sur l'année en cours   |
        | 5    | 2024        | PM           | ICC            | Non notifié   | 2024               | false           | false car compte sur une PM                                               |
