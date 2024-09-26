#language: fr
Fonctionnalité: Création d'une personne dans le référentiel des personnes

  #TODO SHOULD modifier le Quand de ce scénarios (et l'implémentation) de manière à enregister une personne et non plus la LR entière
  Scénario: Création d´une personne dans le référentiel des personnes
    Etant donné que l´utilisateur est un DPI de type SALARIES
    Etant donné l´année en cours 2021
    Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
    Etant donné qu'il existe un salarié "lindien" "Joe"
    Quand l´utilisateur sauvegarde cette LR
    Alors le système DepotLR accepte
    Et la LR est sauvegardée
    Et le salarié "lindien" "Joe" est présent dans la LR sauvegardée

    # TODO SHOULD : R1.4 -  on ne comprend pas ce qu'il se passe dans les 3 scénarios ci-dessous. En lisant le code encore moins... De plus le titre des scénarios ne correspond pas au contenu.
  #TODO SHOULD modifier le Quand de ce scénarios (et l'implémentation) de manière à enregister une personne et non plus la LR entière
  Scénario: Creation d´une personne valide dans le référentiel des personnes sur une LR deja existante
    Etant donné que l´utilisateur est un DPI de type SALARIES
    Etant donné l´année en cours 2021
    Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
    Etant donné qu'il existe un salarié "lindien" "Joe"
    Quand l´utilisateur modifie cette LR
    Alors le système DepotLR accepte

  Scénario: Creation d´une personne invalide dans le référentiel des personnes sur une LR deja existante
    Etant donné que l´utilisateur est un DPI de type SALARIES
    Etant donné l´année en cours 2021
    Etant donné que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
    Etant donné que l´utilisateur saisit un salarié avec une période d'activité invalide
    Quand l'utilisateur ajoute un salarié à cette LR avec une période d'activité du 01.03.2021 au 31.01.2021
    Alors le système DepotLR refuse

  #TODO SHOULD modifier le Quand de ce scénarios (et l'implémentation) de manière à enregister une personne et non plus la LR entière
  Scénario: Création d´un bénéficiaire de rente dans le référentiel des personnes d'une LR
    Etant donné que l´utilisateur est un DPI de type BENEFICIAIRE_RENTE
    Et l´année en cours 2021
    Et que l´utilisateur a créé une nouvelle LR 2021 pour ce DPI
    Et qu'il existe un bénéficiaire "Doe" "John"
    Quand l´utilisateur sauvegarde cette LR
    Alors le système DepotLR accepte
    Et la LR est sauvegardée
    Et le bénéficiaire "Doe" "John" est présent dans la LR sauvegardée
