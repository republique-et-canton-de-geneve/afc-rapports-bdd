#language: fr

Fonctionnalité: Authentification - Connexion
  En tant qu'utilisateur
  Je veux me connecter pour accéder aux fonctionnalités protégées

  @demo @auth
  Scénario: Connexion réussie
    Etant donné un utilisateur "alice" avec le mot de passe "secret"
    Quand je saisis ces identifiants sur l'écran de connexion
    Alors je suis connecté et je vois mon tableau de bord
