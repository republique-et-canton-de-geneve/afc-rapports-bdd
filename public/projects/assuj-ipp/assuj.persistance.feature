#language: fr
Fonctionnalité: Persister un assuj IPP

  Règle: Persister un Assuj IPP

    Scénario: Persister un Assuj IPP nouveau
      Etant donné les assujettissements IPP persistés sont :
        | Id | NumeroR | Mode Imposition | Type   | Etendue |
        | 1  | 1       | IS              | IPP_RO | LIMITEE |
      Etant donné un assujettissement IPP calculé (IS, IPP_RO, LIMITEE) pour la personne de NumeroR 2
      Quand le système persiste cet assujettissement calculé
      Alors l'assujettisement est persisté
