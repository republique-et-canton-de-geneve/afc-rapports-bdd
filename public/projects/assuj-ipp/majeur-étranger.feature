#language: fr
Fonctionnalité: Assujettissement des majeurs à l'étranger avec activité

  Scénario: activité dépendante et demande TOU
    Etant donné que la date du jour est le 01.01.2020
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence ETRANGER activite AVEC statut indépendant AUCUN type de permis AUTRE statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il existe une demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP étendue LIMITEE mode d'imposition IS

  Scénario: activité dépendante et pas de demande TOU
    Etant donné que la date du jour est le 01.01.2020
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence ETRANGER activite AVEC statut indépendant AUCUN type de permis AUTRE statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP étendue LIMITEE mode d'imposition IS

  @WIP
  Scénario: FIXME sans activité dépendante avec activité indépendante
#  FIXME le resultat n'est pas celui attendu
    Etant donné que la date du jour est le 01.01.2020
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence ETRANGER activite SANS statut indépendant INDEPENDANT type de permis AUTRE statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP étendue LIMITEE mode d'imposition AUCUN

  @WIP
  Scénario: FIXME avec activité dépendante, avec activité indépendante et non propriétaire
    #  FIXME le resultat n'est pas celui attendu
    Etant donné que la date du jour est le 01.01.2020
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence ETRANGER activite AVEC statut indépendant INDEPENDANT type de permis AUTRE statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue LIMITEE mode d'imposition IO

  @WIP
  Scénario: FIXME avec activité dépendante, avec activité indépendante et propriétaire
    #  FIXME le resultat n'est pas celui attendu
    Etant donné que la date du jour est le 01.01.2020
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence ETRANGER activite AVEC statut indépendant INDEPENDANT type de permis AUTRE statut propriétaire PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue LIMITEE mode d'imposition IO

  Scénario: Propiétaire sans activité
    Etant donné que la date du jour est le 01.01.2020
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence ETRANGER activite SANS statut indépendant AUCUN type de permis AUTRE statut propriétaire PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il existe une demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue LIMITEE mode d'imposition IO

  Scénario: Propiétaire avec activité
    Etant donné que la date du jour est le 01.01.2020
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence ETRANGER activite AVEC statut indépendant AUCUN type de permis AUTRE statut propriétaire PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue LIMITEE mode d'imposition IS_ET_IO


