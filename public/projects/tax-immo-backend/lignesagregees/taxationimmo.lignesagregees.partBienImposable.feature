#language: fr

Fonctionnalité: F39 - Calcul de la part de bien imposable d'une ligne agrégée

  Règle: R1 - La part du bien imposable de la ligne agrégée et calculer à partir des parts des biens imposables des lignes détail
  -Si la ligne agrégée contient uniquement des lignes R
  --Faire la somme des parts du bien imposable pour les lignes détail de type revenu
  ---Si la somme est strictement inférieure à 1/1, alors la part du bien imposable de la ligne en gras sera égale à cette somme
  ---Sinon la part du bien imposable de la ligne en gras sera égale à 1/1
  -Sinon si la ligne agrégée contient uniquement des lignes L
  --Faire la somme des parts du bien imposable pour les lignes détail de type état locatif
  ---Si la somme est strictement inférieure à 1/1, alors la part du bien imposable de la ligne en gras sera égale à cette somme
  ---Sinon la part du bien imposable de la ligne en gras sera égale à 1/1
  -Sinon si la ligne agrégée contient au moins une ligne détail de type Terrain
  --Faire la somme des parts du bien imposable pour les valeurs immobilières de type Terrain
  ---Si la somme est strictement inférieure à 1/1, alors la part du bien imposable de la ligne en gras sera égale à cette somme
  ---Sinon la part du bien imposable de la ligne en gras sera égale à 1/1
  -Sinon (ligne détail B + R ou uniquement B)
  --Faire la somme des parts du bien imposable pour les valeurs immobilières de type Bâtiment
  ---Si la somme est strictement inférieure à 1/1, alors la part du bien imposable de la ligne en gras sera égale à cette somme
  ---Sinon la part du bien imposable de la ligne en gras sera égale à 1/1

    @PartDuBienImposable @lignesAgregees @PPSeul @PPEnCouple @PM
    Plan du scénario: Calcul de la part du bien imposable pour une ligne agrégée à partir des lignes détail
      Etant donné une taxation immobilière qui contient les lignes détail de type <Types lignes détail> avec les parts <Part du bien imposable lignes détail>
      Quand l'utilisateur demande d'agréger les lignes détail pour cette taxation immobilière
      Alors cette taxation immobilière contient la ligne agrégée avec <Nb lignes détail> lignes détail et la part <Part du bien imposable ligne agrégée>
      Exemples:
        | Types lignes détail | Part du bien imposable lignes détail                                    | Nb lignes détail | Part du bien imposable ligne agrégée |
        | B,B,T,T,R           | 1/1,1/1,1/1,1/1,1/1                                                     | 5                | 1/1                                  |
        | B,B,T,T,R           | 1/1,1/1,1/3,1/3,1/1                                                     | 5                | 2/3                                  |
        | R,R,R               | 1/2,1/2,1/1                                                             | 3                | 1/1                                  |
        | R,R,R               | 1/6,1/6,1/6                                                             | 3                | 1/2                                  |
        | B,R                 | 1/2,1/2                                                                 | 2                | 1/2                                  |
        | B,B,R               | 1/3,1/3,1/2                                                             | 3                | 2/3                                  |
        | B,B,T,T,R           | 9853/999178789,9854/998788569,9852/812265789,9854/91122675,9854/9856644 | 5                | 553175234/1875744435                 |
        | L,L,L               | 1/2,1/2,1/1                                                             | 3                | 1/1                                  |
        | L,L                 | 1/6,1/18                                                                | 2                | 2/9                                  |
 
