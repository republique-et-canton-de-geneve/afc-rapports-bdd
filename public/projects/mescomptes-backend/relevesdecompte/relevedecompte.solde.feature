#language: fr
Fonctionnalité: F5 - Calcul du solde du compte à partir de la liste des mouvements

  Règle: R1 - Le solde du compte est égal à la somme des mouvements du compte

    Scénario: 1 - Calcul du solde d'un compte avec plusieurs mouvements
      Etant donné que le contribuable sélectionne un compte avec ces mouvements :
        | Montants mouvements |
        | +5000               |
        | -1000               |
        | +500                |
      Quand le système calcule le solde du compte du contribuable
      Alors le solde affiché sur le détail des comptes par année fiscale est 4500

    Scénario: 2 - Calcul du solde d'un compte sans mouvements
      Etant donné que le contribuable sélectionne un compte avec ces mouvements :
        | Montants mouvements |
      Quand le système calcule le solde du compte du contribuable
      Alors le solde affiché sur le détail des comptes par année fiscale est 0

    Scénario: 3 - Calcul du solde d'un compte avec plusieurs mouvements (avec centimes)
      Etant donné que le contribuable sélectionne un compte avec ces mouvements :
        | Montants mouvements |
        | +5000.24            |
        | -1000.36            |
        | +500                |
      Quand le système calcule le solde du compte du contribuable
      Alors le solde affiché sur le détail des comptes par année fiscale est 4499.88
