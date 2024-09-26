#language: fr
Fonctionnalité: Assujettissement des majeurs en séjour

  Scénario: avec activité dépendente sans demande TOU
    Etant donné que la date du jour est le 01.06.2021
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP étendue ILLIMITEE mode d'imposition IS

  Scénario: avec activité dépendente et demande TOU
    Etant donné que la date du jour est le 01.06.2021
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.2005 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP étendue ILLIMITEE mode d'imposition IS

  Scénario: avec activité dépendente et revenu > 120000
    Etant donné que la date du jour est le 01.06.2021
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 121000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue ILLIMITEE mode d'imposition IS

  Scénario: avec activité dépendente et revenu = 120000
    Etant donné que la date du jour est le 01.06.2021
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 120000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue ILLIMITEE mode d'imposition IS

  Scénario: Sans activité
    Etant donné que la date du jour est le 01.06.2021
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite SANS statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue ILLIMITEE mode d'imposition IO

  Scénario: 16. Séjour et sans activité

    Etant donné que la date du jour est le 01.06.2021
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite SANS statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN
    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue ILLIMITEE mode d'imposition IO

  Scénario: Arrivée d'une personne hors canton qui était propriétaire ou indépendant à Genève qui perd son bien ou son activité indépendante en arrivant

    Etant donné que la date du jour est le 01.06.2021
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type IPP_RO étendue LIMITEE mode d'imposition IO
    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP étendue ILLIMITEE mode d'imposition IS

  Scénario: Arrivée d'une personne hors canton qui était indépendant à Genève qui perd son activité indépendante en arrivant et a une activité salariée à Genève
    Etant donné que la date du jour est le 01.06.2021
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type IPP_RO étendue LIMITEE mode d'imposition IO
    Lorsque le moteur de calcul est lancé pour la date du jour
    Alors l'assuj IPP calculé de la personne principale est type IPP étendue ILLIMITEE mode d'imposition IS
