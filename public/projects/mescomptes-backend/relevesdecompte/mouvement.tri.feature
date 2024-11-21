#language: fr
Fonctionnalité: F7 - Vérification du tri des mouvements

  Règle: R1 - Une liste de mouvements est correctement triée si :
  - tous les mouvements sont ordonnés par date d'opération, de la plus ancienne à la plus récente

    Scénario: 1 - la liste est déjà dans le bon ordre
      Etant donné que le contribuable sélectionne un compte avec ces mouvements :
        | CodeTypeMouvement | DateOperation |
        | BORD              | 18.11.2024    |
        | BORD              | 18.11.2024    |
        | BORD              | 20.11.2024    |
      Quand le système trie les mouvements
      Alors le système renvoie la liste des mouvements dans cet ordre
        | CodeTypeMouvement | DateOperation |
        | BORD              | 18.11.2024    |
        | BORD              | 18.11.2024    |
        | BORD              | 20.11.2024    |

    Scénario: 2 - la liste n'est pas dans le bon ordre
      Etant donné que le contribuable sélectionne un compte avec ces mouvements :
        | CodeTypeMouvement | DateOperation |
        | BORD              | 18.11.2024    |
        | BORD              | 20.11.2024    |
        | BORD              | 18.11.2024    |
      Quand le système trie les mouvements
      Alors le système renvoie la liste des mouvements dans cet ordre
        | CodeTypeMouvement | DateOperation |
        | BORD              | 18.11.2024    |
        | BORD              | 18.11.2024    |
        | BORD              | 20.11.2024    |

    Scénario: 3 - la liste est dans l'ordre inverse
      Etant donné que le contribuable sélectionne un compte avec ces mouvements :
        | CodeTypeMouvement | DateOperation |
        | BORD              | 20.11.2024    |
        | BORD              | 18.11.2024    |
        | BORD              | 18.11.2024    |
      Quand le système trie les mouvements
      Alors le système renvoie la liste des mouvements dans cet ordre
        | CodeTypeMouvement | DateOperation |
        | BORD              | 18.11.2024    |
        | BORD              | 18.11.2024    |
        | BORD              | 20.11.2024    |

    Scénario: 4 - la liste est vide
      Etant donné que le contribuable sélectionne un compte avec ces mouvements :
        | CodeTypeMouvement | DateOperation |
      Quand le système trie les mouvements
      Alors le système renvoie la liste des mouvements dans cet ordre
        | CodeTypeMouvement | DateOperation |
