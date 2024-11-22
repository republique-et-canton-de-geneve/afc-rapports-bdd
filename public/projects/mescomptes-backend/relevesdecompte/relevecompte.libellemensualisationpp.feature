#language: fr
Fonctionnalité: F8 - Détermination du libellé pour un compte éligible à la mensu PP

  Règle: R1 - Le libellé est :
  - si le compte est éligible à la mensu PP :  "Voir les courriers relatifs à votre mensualisation <<Accès aux docs liés à la MENSU et Modification d'acomptes>>"
  - si le compte n'est pas éligible : Ne rien afficher

    Scénario: 1 - Compte éligible
      Etant donné que le contribuable sélectionne un compte éligible à la mensualisation PP
      Quand le système détermine le libellé de mensualisation PP à afficher
      Alors le système renvoie le libellé de mensualisation PP Voir les courriers relatifs à votre mensualisation

    Scénario: 2 - Compte non éligible
      Etant donné que le contribuable sélectionne un compte non éligible à la mensualisation PP
      Quand le système détermine le libellé de mensualisation PP à afficher
      Alors le système renvoie un libellé de mensualisation PP vide
