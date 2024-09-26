#language: fr
Fonctionnalité: F30 - Contrôle du dossier de taxation de l’année N.

  Règle: R1 - Prérequis "Lieu fiscal valide" : Contrôler la validité du lieu fiscal
  - Le lieu fiscal d'un bien immobilier est valide ssi il :
  – Pour les biens hors suisse :
  — Le pays doit obligatoirement être renseigné
  – Pour les biens suisses hors canton :
  — Si le pays correspond à "Suisse"
  — Alors le canton doit obligatoirement être renseigné
  – Pour les biens Genevois :
  — Si le canton correspond à "Genève"
  — Alors la commune doit obligatoirement être renseignée
  - Si invalide, afficher le message suivant "Le lieu fiscal doit être défini"
  - Ce prérequis est bloquant c.a.d les contrôles suivants ne sont pas exécutés si invalide

    @prerequis @LieuFiscal @PP
    Plan du Scénario: Vérifier prérequis "Lieu fiscal valide" du bien immobilier (<Test Id> -> <Observation>)
      Etant donné un assujettissement pour un contribuable PP
      Etant donné une ligne contribuable PP pour le dossier de taxation de cet assuj avec le code taxation <Code taxation>
      Etant donné cette ligne contribuable PP a le code commune <Code commune>
      Etant donné cette ligne contribuable PP a le code canton <Code canton>
      Etant donné cette ligne contribuable PP a le code pays <Code pays>
      Quand l'utilisateur valide le prérequis lieu fiscal
      Alors un message de contrôle BLOQUANT est généré : <résultat>
      Exemples:
        | Code taxation | Code commune      | Code canton   |Code pays     | résultat | Observation                                        |
        | 15.10         | 19                | GE            |  CHE         | non      | Bien genevois avec une commune politique (Corsier) |
        | 15.10         |                   | GE            |  CHE         | oui      | Bien genevois sans commune politique               |
        | 15.20         |                   | VD            |  CHE         | non      | Bien suisse hors genève avec un canton (Vaud)      |
        | 15.20         |                   |               |  CHE         | oui      | Bien suisse hors genève sans canton                |
        | 15.20         |                   |               |  FRA         | non      | Bien hors suisse avec un pays (France)             |
        | 15.20         |                   |               |              | oui      | Bien hors suisse sans pays                         |
