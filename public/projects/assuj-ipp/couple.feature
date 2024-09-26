#language: fr
Fonctionnalité: Assujettissement des couples

  Scénario: IS + IS
    Etant donné que la date du jour est le 01.01.2020
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Etant donné que la personne principale a un conjoint 987654321
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP étendue ILLIMITEE mode d'imposition IS
    Et l'assuj IPP calculé du conjoint est type IPP étendue ILLIMITEE mode d'imposition IS

  Scénario: IS + IS demande TOU
    Etant donné que la date du jour est le 01.01.2020
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Etant donné que la personne principale a un conjoint 987654321
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il existe une demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue ILLIMITEE mode d'imposition IS
    Et l'assuj IPP calculé du conjoint est type IPP_RO étendue ILLIMITEE mode d'imposition IS


  Scénario: IS + IS IP_RO résident (revenu >120 k)
    Etant donné que la date du jour est le 01.01.2020
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Etant donné que la personne principale a un conjoint 987654321
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 130000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue ILLIMITEE mode d'imposition IS
    Et l'assuj IPP calculé du conjoint est type IPP_RO étendue ILLIMITEE mode d'imposition IS


  Scénario: IS + IS_et_IO résidents
    Etant donné que la date du jour est le 01.01.2020
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Etant donné que la personne principale a un conjoint 987654321
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il existe une demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue ILLIMITEE mode d'imposition IS
    Et l'assuj IPP calculé du conjoint est type IPP_RO étendue ILLIMITEE mode d'imposition IS_ET_IO

  Scénario: IS séjour avec activité + un établi
    Etant donné que la date du jour est le 01.01.2020
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Etant donné que la personne principale a un conjoint 987654321
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis ETABLI statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue ILLIMITEE mode d'imposition IO
    Et l'assuj IPP calculé du conjoint est type IPP_RO étendue ILLIMITEE mode d'imposition IO


  Scénario: Séjour sans activité + un établi peu importe activité
    Etant donné que la date du jour est le 01.01.2020
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite SANS statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Etant donné que la personne principale a un conjoint 987654321
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite SANS statut indépendant AUCUN type de permis ETABLI statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue ILLIMITEE mode d'imposition IO
    Et l'assuj IPP calculé du conjoint est type IPP_RO étendue ILLIMITEE mode d'imposition IO

  Scénario: Un séjour avec activité dep + un propriétaire vivant à l'étranger
    Etant donné que la date du jour est le 01.01.2020
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Etant donné que la personne principale a un conjoint 987654321
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence ETRANGER activite SANS statut indépendant AUCUN type de permis AUTRE statut propriétaire PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP étendue ILLIMITEE mode d'imposition IS
    Et l'assuj IPP calculé du conjoint est type IPP_RO étendue LIMITEE mode d'imposition IO

  Scénario: Un séjour avec activité + un étranger avec activité dep + propriétaire
    Etant donné que la date du jour est le 01.06.2021
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Etant donné que la personne principale a un conjoint 987654321
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence ETRANGER activite AVEC statut indépendant AUCUN type de permis AUTRE statut propriétaire PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP étendue ILLIMITEE mode d'imposition IS
    Et l'assuj IPP calculé du conjoint est type IPP_RO étendue LIMITEE mode d'imposition IS_ET_IO

  Scénario: couple IO (sans activite) + IS
    Etant donné que la date du jour est le 01.06.2021
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type IPP étendue ILLIMITEE mode d'imposition IS

    Etant donné que la personne principale a un conjoint 987654321
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite SANS statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type IPP étendue ILLIMITEE mode d'imposition IO

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue ILLIMITEE mode d'imposition IS
    Et l'assuj IPP calculé du conjoint est type IPP_RO étendue ILLIMITEE mode d'imposition IO

  Scénario: couple de 2 personnes en séjour avec activité dont un est propriétaire
    Etant donné que la date du jour est le 01.06.2021
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Etant donné que la personne principale a un conjoint 987654321
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue ILLIMITEE mode d'imposition IS
    Et l'assuj IPP calculé du conjoint est type IPP_RO étendue ILLIMITEE mode d'imposition IS_ET_IO

  Scénario: Un séjour avec activité salariée marié à un propriétaire vivant à l'étranger sans activité
    Etant donné que la date du jour est le 01.06.2021
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire NON_PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Etant donné que la personne principale a un conjoint 987654321
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence ETRANGER activite SANS statut indépendant AUCUN type de permis AUTRE statut propriétaire PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP étendue ILLIMITEE mode d'imposition IS
    Et l'assuj IPP calculé du conjoint est type IPP_RO étendue LIMITEE mode d'imposition IO

  Scénario: Un séjour avec activité salariée propriétaire marié à un propriétaire genevois sans activité
    Etant donné que la date du jour est le 01.06.2021
    Et que le calcul de l'assuj IPP concerne la personne 123456789
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite AVEC statut indépendant AUCUN type de permis SEJOUR statut propriétaire PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Etant donné que la personne principale a un conjoint 987654321
    Et que la personne RF est définie par date de naissance 25.08.1980 état vital VIVANT type de résidence GENEVE activite SANS statut indépendant AUCUN type de permis ETABLI statut propriétaire PROPRIETAIRE
    Et que le revenu est 100000
    Et qu'il n'existe pas de demande TOU
    Et que l'assujIpp intiale est type AUCUN étendue AUCUN mode d'imposition AUCUN

    Lorsque le moteur de calcul est lancé pour la date du jour

    Alors l'assuj IPP calculé de la personne principale est type IPP_RO étendue ILLIMITEE mode d'imposition IO
    Et l'assuj IPP calculé du conjoint est type IPP_RO étendue ILLIMITEE mode d'imposition IO