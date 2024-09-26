#language: fr

Fonctionnalité: F32 - Avis au contribuable global

  Règle: R1 -  Avis au contribuable immo avec les étapes suivantes :
  - 1. Avis au contribuable en passant par toutes les couches

    @PP @plusieursRegles @creation-ligne-parcelle-revenu
    Scénario: Avis au contribuable en passant par toutes les couches
      Etant donné un assujettissement PP de rôle IBO dans l'état INFORMATIF du 01.01.2020 au 31.12.2020 avec la référence métier 676.59.2890-2020-IBO-1
      Et que la valeur immobilière pour cet assujettissement est de type QVL
      Et a comme usage OCCUPE
      Et a les taux exo REVENU: (10%)
      Et a l'objet cadastral 123-456-789
      Et que le plafond d'abattement est paramétré à 40%
      Et que le taux d'abattement annuel paramétré pour les PP est de 4% pour cette année fiscale
      Quand l'utilisateur demande de créer les lignes parcelle revenu pour cet avis au contribuable et cet assuj
      Alors cet avis au contribuable contient les lignes parcelle revenu suivantes pour cet assuj :
        | Code taxation | Id parcelle | Taux abattement |
        | 15.10         | 123-789     |  0%             |


