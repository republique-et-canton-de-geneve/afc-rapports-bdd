#language: fr
Fonctionnalité: F6 - Détermination du libellé en fonction de l'inscription à la e-bill du contribuable

  Règle: R1 - Déterminer le libellé :
  - si l'inscription e-Bill existe, retourner  "Vous êtes inscrit à eBill, vous pouvez payer directement depuis votre espace e-banking"
  - sinon, retourner  "Utilisez eBill pour recevoir et payer vos factures d'impôts directement depuis votre e-banking"

    Plan du Scénario: Vérification de la présence d'une inscription e-Bill. <Test> -> <Observation>
      Etant donné un contribuable <Statut eBill> à e-Bill
      Et que le contribuable possède un compte ICC, avec bordereau Notifié avec montant 100
      Quand le système détermine le libellé eFacture à afficher
      Alors le système renvoie le texte eFacture à afficher : <Libelle>
      Exemples:
        | Test | Statut eBill        | Libelle                                                                                        | Observation         |
        | 1    | Inscrit             | Vous êtes inscrit à eBill, vous pouvez payer directement depuis votre espace e-banking         | Inscrit à eBill     |
        | 2    | Pas inscrit         | Utilisez eBill pour recevoir et payer vos factures d'impôts directement depuis votre e-banking | Non inscrit à eBill |

