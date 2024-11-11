#language: fr

Fonctionnalité: Affichage des informations de l'état civil

  Scénario: afficher le détail de l'état civil
    Etant donné que un contribuable possède les attributs suivants
      | prenomContribuable | nomContribuable | sexe  | etatCivil                     | dateEtatCivil            | prenomConjoint              | nomConjoint            |
      | Karl               | Dubois          | HOMME | MARIE                         | 01.01.2015               | Simone                      | Dubois                 |
      | Simone             | Dubois          | FEMME | MARIE                         | 01.01.2015               | Karl                        | Dubois                 |
      | Karl               | Dubois          | HOMME | PARTENARIAT                   | 01.01.2015               | Simone                      | Dubois                 |
      | Simone             | Dubois          | FEMME | PARTENARIAT                   | 01.01.2015               | Karl                        | Dubois                 |
      | Karl               | Dubois          | HOMME | PARTENARIAT_SEPARE            | 01.01.2015               | Simone                      | Dubois                 |
      | Simone             | Dubois          | FEMME | PARTENARIAT_SEPARE            | 01.01.2015               | Karl                        | Dubois                 |
      | Karl               | Dubois          | HOMME | DIVORCE                       | 01.01.2015               |                             |                        |
      | Simone             | Dubois          | FEMME | DIVORCE                       | 01.01.2015               |                             |                        |
      | Karl               | Dubois          | HOMME | PARTENARIAT_VEUF              | 01.01.2015               |                             |                        |
      | Simone             | Dubois          | FEMME | PARTENARIAT_VEUF              | 01.01.2015               |                             |                        |
      | Karl               | Dubois          | HOMME | PARTENARIAT_DISSOUS           | 01.01.2015               |                             |                        |
      | Simone             | Dubois          | FEMME | PARTENARIAT_DISSOUS           | 01.01.2015               |                             |                        |
      | Karl               | Dubois          | HOMME | SEPARE                        | 01.01.2015               |                             |                        |
      | Simone             | Dubois          | FEMME | SEPARE                        | 01.01.2015               |                             |                        |
      | Karl               | Dubois          | HOMME | VEUF_VEUVE                    | 01.01.2015               |                             |                        |
      | Simone             | Dubois          | FEMME | VEUF_VEUVE                    | 01.01.2015               |                             |                        |
      | Karl               | Dubois          | HOMME | MARIAGE_ANNULE                | 01.01.2015               |                             |                        |
      | Simone             | Dubois          | FEMME | MARIAGE_ANNULE                | 01.01.2015               |                             |                        |
      | Karl               | Dubois          | HOMME | SEPARE_PAR_JUGEMENT           | 01.01.2015               |                             |                        |
      | Simone             | Dubois          | FEMME | SEPARE_PAR_JUGEMENT           | 01.01.2015               |                             |                        |
      | Karl               | Dubois          | HOMME | MARIAGE_DISSOUS               | 01.01.2015               |                             |                        |
      | Simone             | Dubois          | FEMME | MARIAGE_DISSOUS               | 01.01.2015               |                             |                        |
      | Karl               | Dubois          | HOMME | CELIBATAIRE                   |                          |                             |                        |
      | Simone             | Dubois          | FEMME | CELIBATAIRE                   |                          |                             |                        |
      | Karl               | Dubois          | HOMME | INCONNU                       |                          |                             |                        |
      | Simone             | Dubois          | FEMME | INCONNU                       |                          |                             |                        |
      | Simone             | Dubois          | FEMME | MERE_CELIBATAIRE              |                          |                             |                        |
      | Simone             | Dubois          | FEMME | CELIBATAIRE_APPELEE_MADAME    |                          |                             |                        |
    Quand on construit le libellé de l'état civil à afficher dans la section informations générales
    Alors le libellé de l'état civil à afficher est
      | libelleEtatCivil |
      | Marié à Simone Dubois depuis le 01.01.2015 |
      | Mariée à Karl Dubois depuis le 01.01.2015  |
      | Partenariat avec Simone Dubois depuis le 01.01.2015  |
      | Partenariat avec Karl Dubois depuis le 01.01.2015  |
      | Partenariat séparé de Simone Dubois depuis le 01.01.2015  |
      | Partenariat séparé de Karl Dubois depuis le 01.01.2015  |
      | Divorcé depuis le 01.01.2015  |
      | Divorcée depuis le 01.01.2015  |
      | Partenariat veuf depuis le 01.01.2015  |
      | Partenariat veuve depuis le 01.01.2015  |
      | Partenariat dissous depuis le 01.01.2015  |
      | Partenariat dissous depuis le 01.01.2015  |
      | Séparé depuis le 01.01.2015  |
      | Séparée depuis le 01.01.2015  |
      | Veuf depuis le 01.01.2015  |
      | Veuve depuis le 01.01.2015  |
      | Mariage annulé depuis le 01.01.2015  |
      | Mariage annulé depuis le 01.01.2015  |
      | Séparé par jugement depuis le 01.01.2015  |
      | Séparée par jugement depuis le 01.01.2015  |
      | Mariage dissous depuis le 01.01.2015  |
      | Mariage dissous depuis le 01.01.2015  |
      | Célibataire |
      | Célibataire |
      | Inconnu |
      | Inconnu |
      | Mère célibataire |
      | Célibataire appelée Madame |
