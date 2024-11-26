#language: fr
Fonctionnalité: F10 - Vérification du tri des comptes

  Règle: R1 - La liste des comptes doivent être triées selon les règles ci-dessous :
  - Chaque compte est associé à un type de prestation (ou impôt) (Ex : ICC, IFD, QDMTT, ...)
  - Chaque type de prestation possède un ordre (AFL_T_TYPE_IMPOT#TPI_N_ORDRE) défini par le métier (Ex: ICC = 1, IFD = 2, ..., QDMTT = 42)
  - Chaque compte possède un 'Increment' ( Ex : ICC / 12345678 /2024 / 1 , ICC / 12345678 / 2024 / 2, ...)
  - Le tri se fait donc d'abord selon l'ordre du type de prestation définie en base ASC (du plus petit au plus grand)
  - Et ensuite le tri doit se faire par 'Increment' ASC (du plus petit au plus grand)

    Scénario: 1 - la liste est déjà dans le bon ordre
      Etant donné que le contribuable possède les comptes suivants :
        | Code prestation | Increment | Ordre |
        | ICC             | 1         | 1     |
        | ICC             | 2         | 1     |
        | ICC             | 3         | 1     |
        | IFD             | 1         | 2     |
        | IFD             | 2         | 2     |
        | ISRSALA         | 1         | 3     |
        | QDMTT           | 1         | 4     |
      Quand le système trie les comptes
      Alors le système renvoie la liste des comptes dans cet ordre
        | Code prestation | Increment | Ordre |
        | ICC             | 1         | 1     |
        | ICC             | 2         | 1     |
        | ICC             | 3         | 1     |
        | IFD             | 1         | 2     |
        | IFD             | 2         | 2     |
        | ISRSALA         | 1         | 3     |
        | QDMTT           | 1         | 4     |

    Scénario: 2 - la liste n'est pas dans le bon ordre
      Etant donné que le contribuable possède les comptes suivants :
        | Code prestation | Increment | Ordre |
        | QDMTT           | 1         | 4     |
        | IFD             | 2         | 2     |
        | IFD             | 1         | 2     |
        | ISRSALA         | 1         | 3     |
        | ICC             | 2         | 1     |
        | ICC             | 1         | 1     |
      Quand le système trie les comptes
      Alors le système renvoie la liste des comptes dans cet ordre
        | Code prestation | Increment | Ordre |
        | ICC             | 1         | 1     |
        | ICC             | 2         | 1     |
        | IFD             | 1         | 2     |
        | IFD             | 2         | 2     |
        | ISRSALA         | 1         | 3     |
        | QDMTT           | 1         | 4     |

    Scénario: 3 - la liste est dans l'ordre inverse
      Etant donné que le contribuable possède les comptes suivants :
        | Code prestation | Increment | Ordre |
        | QDMTT           | 1         | 4     |
        | ISRSALA         | 1         | 3     |
        | IFD             | 2         | 2     |
        | IFD             | 1         | 2     |
        | ICC             | 2         | 1     |
        | ICC             | 1         | 1     |
      Quand le système trie les comptes
      Alors le système renvoie la liste des comptes dans cet ordre
        | Code prestation | Increment | Ordre |
        | ICC             | 1         | 1     |
        | ICC             | 2         | 1     |
        | IFD             | 1         | 2     |
        | IFD             | 2         | 2     |
        | ISRSALA         | 1         | 3     |
        | QDMTT           | 1         | 4     |

    Scénario: 4 - la liste est vide
      Etant donné que le contribuable possède les comptes suivants :
        | Code prestation | Ordre |
      Quand le système trie les comptes
      Alors le système renvoie la liste des comptes dans cet ordre
        | Code prestation | Ordre |
