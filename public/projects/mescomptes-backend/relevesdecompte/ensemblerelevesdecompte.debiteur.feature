#language: fr
Fonctionnalité: F1 - Vérification si un contribuable est Débiteur

  Règle: R1 - Un contribuable est considéré comme Débiteur si:
  - Au moins un compte existe pour ce contribuable et
  - Au moins un de ses comptes est Débiteur
  - Un compte est considéré comme Débiteur si son montant est positif

    Scénario: 1 - Vérification d'un contribuable avec 1 compte débiteur
      Etant donné que le contribuable possède les comptes suivants :
        | Référence compte | Montant |
        | Compte A         | 5000    |
      Quand le système vérifie le statut des comptes
      Alors le système renvoie que le contribuable est débiteur

    Scénario: 2 - Vérification d'un contribuable avec 3 comptes dont l'un est débiteur
      Etant donné que le contribuable possède les comptes suivants :
        | Référence compte | Montant |
        | Compte A         | -500    |
        | Compte B         | 3000    |
        | Compte C         | -800    |
      Quand le système vérifie le statut des comptes
      Alors le système renvoie que le contribuable est débiteur

    Scénario: 3 - Vérification d'un contribuable avec 3 comptes créditeurs
      Etant donné que le contribuable possède les comptes suivants :
        | Référence compte | Montant |
        | Compte A         | -1500   |
        | Compte B         | -200    |
        | Compte C         | -800    |
      Quand le système vérifie le statut des comptes
      Alors le système renvoie que le contribuable n'est pas débiteur

    Scénario: 4 - Vérification qu'un contribuable sans compte n'est pas débiteur
      Etant donné que le contribuable ne possède aucun compte
      Quand le système vérifie le statut des comptes
      Alors le système renvoie que le contribuable n'est pas débiteur
