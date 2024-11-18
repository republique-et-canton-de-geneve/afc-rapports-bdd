#language: fr
Fonctionnalité: F5 - Détermination du libellé en fonction de la présence d'un arrangement

  Règle: R1 - Déterminer le libellé :
  - si un arrangement existe, retourner  "Un arrangement de paiement a été accordé sur ce compte"
  - s'il n'y a pas d'arrangement, retourner  "Vous avez la possibilité de payer en plusieurs fois selon certaines conditions <<lien sur la DDP>>"

    Plan du Scénario: Vérification d'un compte avec un mouvement de type bordereau <Statut Compte>. <Test> -> <Observation>
      Etant donné que le contribuable possède un compte ICC, avec bordereau Notifié avec montant 100
      Et dont le statut est <Statut Compte>
      Quand le système détermine le libellé à afficher
      Alors le système renvoie le texte pour l'arrangement à afficher : <Libelle>
      Exemples:
        | Test | Statut Compte    | Libelle                                                                                            | Observation                     |
        | 1    | Avec arrangement | Un arrangement de paiement a été accordé sur ce compte <<lien sur le courrier d'arrangement>>      | Avec un arrangement de paiement |
        | 2    | Sans arrangement | Vous avez la possibilité de payer en plusieurs fois selon certaines conditions <<lien sur la DDP>> | Sans arrangement de paiement    |
