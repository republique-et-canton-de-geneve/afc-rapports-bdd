#language: fr
Fonctionnalité: F31 - Création des lignes lieu fiscal hors canton.

  Règle: R12 - Créer une ligne lieu fiscal qui regroupe une ou plusieurs lignes HC selon les paramètres d'agrégation suivants :
  - Le code de taxation
  - Le numero OFS du canton (Pour le cas des biens suisses hors canton de Genève)
  - Le numero OFS du pays (Pour le cas des biens hors suisse)

    @creation-ligne-lieufiscal-horscanton-contribuable @PP
    Scénario: Les lignes lieu fiscal HC contribuable PP sont regroupées par code de taxation, code canton, code pays
      Etant donné un assujettissement pour un contribuable PP
      Etant donné les lignes contribuable PP suivantes pour le dossier de taxation de cet assuj :
        | Code taxation | Code canton | Code pays | Code commune cadastrale | Fortune | IIC net | Revenu IFD | Entretien IFD | Revenu ICC | Entretien ICC |
        | 15.10         | GE          | CHE       | 150                     | 1001    | 1101    | 1201       | 1301          | 1401       | 1501          |
        | 15.10         | VD          | CHE       |                         | 2002    | 2102    | 2202       | 2302          | 2402       | 2502          |
        | 15.10         | VD          | CHE       |                         | 3003    | 3103    | 3203       | 3303          | 3403       | 3503          |
        | 15.20         | VD          | CHE       |                         | 4004    | 4104    | 4204       | 4304          | 4404       | 4504          |
        | 15.20         | VD          | CHE       |                         | 5005    | 5105    | 5205       | 5305          | 5405       | 5505          |
        | 15.10         |             | FRA       |                         | 8008    | 8108    | 8208       | 8308          | 8408       | 8508          |
        | 15.20         |             | FRA       |                         | 6006    | 6106    | 6206       | 6306          | 6406       | 6506          |
        | 15.20         |             | FRA       |                         | 7007    | 7107    | 7207       | 7307          | 7407       | 7507          |
      Quand le système créé les lignes lieu fiscal hors canton contribuable PP pour cet assuj
      Alors les lignes lieu fiscal hors canton contribuable PP suivantes sont regroupées :
        | Code taxation | Code canton | Code pays | Fortune | IIC net | Revenu IFD | Entretien IFD | Revenu ICC | Entretien ICC |
        | 15.10         | VD          | CHE       | 5005    | 5205    | 5405       | 5605          | 5805       | 6005          |
        | 15.20         | VD          | CHE       | 9009    | 9209    | 9409       | 9609          | 9809       | 10009         |
        | 15.10         |             | FRA       | 8008    | 8108    | 8208       | 8308          | 8408       | 8508          |
        | 15.20         |             | FRA       | 13013   | 13213   | 13413      | 13613         | 13813      | 14013         |
