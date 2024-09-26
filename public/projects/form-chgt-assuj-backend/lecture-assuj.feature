#language: fr

Fonctionnalité: Lecture d'un assujettissement

  Règle: Une lecture d'un assujettissement qui existe

    Scénario: Lecture d'un assujettissement existant
      Etant donné un assujettissement pour un contribuable ayant pour ref metier 111.11.1111-1111-XXX-1
      Quand On lit un assujettissement de ref metier: 111.11.1111-1111-XXX-1
      Alors On obtient 1 seul assuj ayant comme ref metier 111.11.1111-1111-XXX-1

  Règle: Une lecture d'un assujettissement qui n'existe pas retourne une erreur

    Scénario: Lecture d'un assujettissement non existant
      Etant donné un assujettissement pour un contribuable ayant pour ref metier 111.11.1111-1111-XXX-1
      Quand On lit un assujettissement de ref metier: 111.11.1111-1111-XXX-2
      Alors On obtient une erreur de validation: Erreur lors de la lecture de l'assujettissement
