#language: fr

Fonctionnalité: Tri des documents d'un courrier

  Scénario: trier les documents d'un courrier
    Etant donné que Un courrier avec des documents non triés
      | codeDocument | identifiant              | titre                       |
      | doc1         | 01-lettre-1              | Lettre 1                    |
      | doc2         | 02-lettre-accompagnement | Lettre d'accompagnement 01  |
      | doc3         | 02-lettre-accompagnement | Lettre d'accompagnement 00  |
      | doc4         | 03-porte-adresse         | Porte-adresse               |
    Quand On trie les documents du courrier
    Alors les documents du courrier sont triés de tel sorte à ce que les documents Porte-adresse et Lettre d'accompagnement soit affiché en premier
      | codeDocument | identifiant              | titre                       |
      | doc4         | 03-porte-adresse         | Porte-adresse               |
      | doc3         | 02-lettre-accompagnement | Lettre d'accompagnement 00  |
      | doc2         | 02-lettre-accompagnement | Lettre d'accompagnement 01  |
      | doc1         | 01-lettre-1              | Lettre 1                    |
