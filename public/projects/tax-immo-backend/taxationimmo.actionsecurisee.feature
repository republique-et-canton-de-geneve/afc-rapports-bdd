#language: fr

Fonctionnalité: F37 - Sécurisation des actions de l'application

  Règle: Un rôle utilisateur donne accès à des actions sécurisées selon le paramétrage des actions sécurisées

    Contexte:
      Etant donné que le rôle AFC.TAXIMMO.GA-IMMO-TAXATEUR-PP donne accès aux actions sécurisées suivantes : Toutes
      Etant donné que le rôle AFC.TAXIMMO.GA-IMMO-TAXATEUR-PM donne accès aux actions sécurisées suivantes : Toutes
      Etant donné que le rôle AFC.TAXIMMO.GA-IMMO-CHEF-GROUPE donne accès aux actions sécurisées suivantes : Toutes
      Etant donné que le rôle AFC.TAXIMMO.GA-IMMO-ADJOINT-CHEF-SERVICE donne accès aux actions sécurisées suivantes : Toutes
      Etant donné que le rôle AFC.TAXIMMO.GA-IMMO-CHEF-SERVICE donne accès aux actions sécurisées suivantes : Toutes
      Etant donné que le rôle AFC.TAXIMMO.GA-LECTURE-PARAM donne accès aux actions sécurisées suivantes : LECTURE_PARAM
      Etant donné que le rôle AFC.TAXIMMO.GA-ADMIN-PARAM donne accès aux actions sécurisées suivantes : ADMIN_PARAM

    Plan du scénario:
      Etant donné que l'utilisateur courant a le rôle <Rôle>
      Quand l'utilisateur demande ses actions sécurisées
      Alors le système indique qu'il dispose des actions sécurisées suivantes : <Actions sécurisées>
      Exemples:
        | Test | Rôle                                     | Actions sécurisées |
        | 1    | AFC.TAXIMMO.GA-IMMO-TAXATEUR-PP          | Toutes             |
        | 2    | AFC.TAXIMMO.GA-IMMO-TAXATEUR-PM          | Toutes             |
        | 3    | AFC.TAXIMMO.GA-IMMO-CHEF-GROUPE          | Toutes             |
        | 4    | AFC.TAXIMMO.GA-IMMO-ADJOINT-CHEF-SERVICE | Toutes             |
        | 5    | AFC.TAXIMMO.GA-IMMO-CHEF-SERVICE         | Toutes             |
        | 6    | AFC.TAXIMMO.GA-LECTURE-PARAM             | LECTURE_PARAM      |
        | 7    | AFC.TAXIMMO.GA-ADMIN-PARAM               | ADMIN_PARAM        |
        | 8    | AFC.TAXIMMO.UTILISATEUR                  |                    |
