#language: fr
Fonctionnalité: Règles métier concernant les lieux de travail

  Règle: Le nom du lieu de travail doit être unique vis à vis des autres lieux dans le référentiel des lieux de travail

    Contexte:
      Etant donné qu'un DPI SALARIES est sélectionné
      Etant donné l´année en cours 2021
      Etant donné qu'il existe une LR Brouillon complète en 2021 pour ce DPI
      Etant donné que l´utilisateur a saisi un lieu de travail dans le référentiel des lieux de travail
      Et que ce lieu de travail a le Nom Lieu "NOM LIEU"

    Scénario: Validation Lieu de travail - Le nom du lieu est unique
      Etant donné que l´utilisateur a saisi un lieu de travail dans le référentiel des lieux de travail
      Et que ce lieu de travail a le Mode Libre
      Et que ce lieu de travail a le Code Pays "CH"
      Et que ce lieu de travail a la Rue "rue"
      Et que ce lieu de travail a la Code Commune "6621"
      Et que ce lieu de travail a le NPA "1000"
      Et que ce lieu de travail a la Localite ""
      Et que ce lieu de travail a le Code Canton "GE"
      Et que ce lieu de travail a le Nom Lieu "NOM LIEU 1"
      Et que ce lieu de travail a l'adresse WS "ADRESSE WS"
      Et que ce lieu de travail a le IdPadr "123456789"
      Quand l´utilisateur valide son lieu de travail
      Alors le lieu de travail est valide

    Scénario: Validation Lieu de travail - Le nom du lieu n'est pas unique
      Etant donné que l´utilisateur a saisi un lieu de travail dans le référentiel des lieux de travail
      Et que ce lieu de travail a le Mode Libre
      Et que ce lieu de travail a le Code Pays "CH"
      Et que ce lieu de travail a la Rue "rue"
      Et que ce lieu de travail a la Code Commune "6621"
      Et que ce lieu de travail a le NPA "1000"
      Et que ce lieu de travail a la Localite ""
      Et que ce lieu de travail a le Code Canton "GE"
      Et que ce lieu de travail a le Nom Lieu "NOM LIEU"
      Et que ce lieu de travail a l'adresse WS "ADRESSE WS"
      Et que ce lieu de travail a le IdPadr "123456789"
      Quand l´utilisateur valide son lieu de travail
      Alors le lieu de travail est invalide car le nom n'est pas unique
