#language: fr

Fonctionnalité: Hello world

  Règle: Bonjour Genève

    @Hello @World
    Plan du Scénario: Vendredi c'est vraiment permis
      Etant donné Le <Jour semaine>
      Et que La métro dit : <Météo>
      Quand Je demande que faisons-nous ce soir Minus ?
      Alors Cortex répond : <Réponse>
      Exemples:
        | Jour semaine | Météo  | Réponse                        |
        | Lundi        | Soleil | Pas ce soir Minus              |
        | Vendredi     | Soleil | Comme tous les soirs Minus...a |

  Règle: Happy friday

    @Hello
    Scénario: Vendredi c'est permis
      Etant donné Un jour de semaine
      Quand c'est vendredi
      Alors c'est permis
        | entre   | et      |
        | 14h     | 16h     |
        | 19h     | 22h     |
