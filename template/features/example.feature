#language: fr
# Ce fichier illustre le mode "dossier simple": placez vos .feature directement sous 'features'.
# Conseil: si vous créez 'features/projects/...', ce fichier ne sera plus visible dans l'interface
# (les slugs sont pris depuis 'projects/<slug>').

Fonctionnalité: Exemple (mode dossier simple)
  Scénario: Afficher un exemple
    Etant donné une fonctionnalité disponible
    Quand je génère les rapports
    Alors le projet affiche un rapport
