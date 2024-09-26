#language: fr

Fonctionnalité: F44 - Gestion des observations

  Règle: R1 -Les observations doivent être triées par date de création

    @observation @recuperer-observations @tri
    Scénario: Récupération de la liste des observation pour un contribuable
      Etant donné les observations suivantes pour le contribuable
        | Contenu observation                 | Année de début | Année de fin | Date de création |
        | Mon observation du mois de juin     | 2020           | 2020         | 01.06.2020       |
        | Mon observation du mois de novembre | 2020           | 2020         | 01.11.2020       |
        | Mon observation du mois de janvier  | 2020           | 2020         | 01.01.2020       |
      Quand l'utilisateur demande à récupérer les observations
      Alors les observations sont triées dans l'ordre
        | Contenu observation                 | Année de début | Année de fin | Date de création |
        | Mon observation du mois de novembre | 2020           | 2020         | 01.11.2020       |
        | Mon observation du mois de juin     | 2020           | 2020         | 01.06.2020       |
        | Mon observation du mois de janvier  | 2020           | 2020         | 01.01.2020       |

  Règle: R2 - L'enregistrement d'une nouvelle observation apparaît dans la liste

    @observation @ajouter-observation
    Scénario: Ajouter une nouvelle observation, retourne la liste avec la nouvelle observation
      Etant donné les observations suivantes pour le contribuable
        | Contenu observation                 | Année de début | Année de fin | Date de création |
        | Mon observation du mois de juin     | 2020           | 2020         | 01.06.2020       |
        | Mon observation du mois de novembre | 2020           | 2020         | 01.11.2020       |
        | Mon observation du mois de janvier  | 2020           | 2020         | 01.01.2020       |
      Quand l'utilisateur ajoute une observation avec le contenu Ma nouvelle observation avec l'année de debut 2023
      Alors une nouvelle observation à été ajouté à la liste

  Règle: R3 - La modification d'une nouvelle observation, retourne la liste avec l'observation modifiée

    @observation @modifier-observation
    Scénario: Modification d'une observation, retourne la liste avec l'observation modifier
      Etant donné les observations suivantes pour le contribuable
        | Contenu observation                 | Année de début | Année de fin | Date de création |
        | Mon observation du mois de juin     | 2020           | 2020         | 01.06.2020       |
        | Mon observation du mois de novembre | 2020           | 2020         | 01.11.2020       |
        | Mon observation du mois de janvier  | 2020           | 2020         | 01.01.2020       |
      Quand l'utilisateur replace le contenu de l'observation Mon observation du mois de novembre par Mon observation modifiee
      Alors une observation avec le contenu Mon observation modifiee existe dans la liste

    @observation @estFermee
    Scénario: Une observation avec une année de fin strictement inférieure à l'année en cours est considérée comme fermée
      Etant donné les observations suivantes pour le contribuable
        | Contenu observation                                    | Année de début | Année de fin | Date de création |
        | Mon observation ouverte car année fin superieur à 2023 | 2022           | 2024         | 01.06.2020       |
        | Mon observation fermée car année fin inférieur à 2023  | 2020           | 2022         | 01.06.2020       |
        | Mon observation ouverte car année fin égale à 2023     | 2023           | 2023         | 01.06.2020       |
      Quand l'utilisateur demande à récupérer les observations
      Alors les observations avec une année de fin strictement inférieure à l'année 2023 sont fermées

    @observation @ajouter-observation @validation
    Scénario: Ajouter une observation avec une date de debut null
      Etant donné les observations suivantes pour le contribuable
        | Contenu observation                 | Année de début | Année de fin | Date de création |
        | Mon observation du mois de juin     | 2020           | 2020         | 01.06.2020       |
        | Mon observation du mois de novembre | 2020           | 2020         | 01.11.2020       |
        | Mon observation du mois de janvier  | 2020           | 2020         | 01.01.2020       |
      Quand l'utilisateur ajoute une observation avec le contenu une observation sans l'année de debut
      Alors une erreur de validation est générée

    @observation @ajouter-observation @validation
    Scénario: Ajouter une observation avec un contenu null
      Etant donné les observations suivantes pour le contribuable
        | Contenu observation                 | Année de début | Année de fin | Date de création |
        | Mon observation du mois de juin     | 2020           | 2020         | 01.06.2020       |
        | Mon observation du mois de novembre | 2020           | 2020         | 01.11.2020       |
        | Mon observation du mois de janvier  | 2020           | 2020         | 01.01.2020       |
      Quand l'utilisateur ajoute une observation non renseignée avec l'année de debut 2023
      Alors une erreur de validation est générée


    @observation @modifier-observation @validation
    Scénario: Modification d'une observation avec un contenu null
      Etant donné les observations suivantes pour le contribuable
        | Contenu observation                 | Année de début | Année de fin | Date de création |
        | Mon observation du mois de juin     | 2020           | 2020         | 01.06.2020       |
        | Mon observation du mois de novembre | 2020           | 2020         | 01.11.2020       |
        | Mon observation du mois de janvier  | 2020           | 2020         | 01.01.2020       |
      Quand l'utilisateur renseigne une valeur null pour remplacer le contenu de l'observation Mon observation du mois de novembre
      Alors une erreur de validation est générée

    @observation @modifier-observation @validation
    Scénario: Modification d'une observation avec une date de debut null
      Etant donné les observations suivantes pour le contribuable
        | Contenu observation                 | Année de début | Année de fin | Date de création |
        | Mon observation du mois de juin     | 2020           | 2020         | 01.06.2020       |
        | Mon observation du mois de novembre | 2020           | 2020         | 01.11.2020       |
        | Mon observation du mois de janvier  | 2020           | 2020         | 01.01.2020       |
      Quand l'utilisateur replace l'année de début par une année null et remplace le contenu de l'observation Mon observation du mois de novembre par mon observation modifiee
      Alors une erreur de validation est générée

  Règle: R3 - La supression d'une nouvelle observation, retourne la liste avec l'observation modifiée

    @observation @supprimer-observation
    Scénario: Modification d'une observation, retourne la liste avec l'observation modifier
      Etant donné les observations suivantes pour le contribuable
        | Contenu observation                 | Année de début | Année de fin | Date de création |
        | Mon observation du mois de juin     | 2020           | 2020         | 01.06.2020       |
        | Mon observation du mois de novembre | 2020           | 2020         | 01.11.2020       |
        | Mon observation du mois de janvier  | 2020           | 2020         | 01.01.2020       |
      Quand l'utilisateur demande de supprimer une observation ayant une cle un contenu de l'observation Mon observation du mois de novembre
      Alors la liste d'observation contient 2 observation
      Et ces lignes observations sont les suivantes :
        | Contenu observation                 | Année de début | Année de fin | Date de création |
        | Mon observation du mois de juin     | 2020           | 2020        | 01.06.2020       |
        | Mon observation du mois de janvier  | 2020           | 2020        | 01.01.2020       |
