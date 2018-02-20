DROP VIEW IF EXISTS tekniset_tiedot_view;
CREATE VIEW tekniset_tiedot_view AS
  SELECT
    jarnro,
    (SELECT lyhytselite_fi
     FROM koodisto
     WHERE koodintunnus = ajoneuvoluokka AND koodisto = 'ajoneuvoluokka')            AS ajoneuvoluokka,
    ensirekisterointipvm,
    (SELECT pitkaselite_fi
     FROM koodisto
     WHERE koodintunnus = ajoneuvoryhma :: TEXT AND koodisto = 'ajoneuvoryhma')      AS ajoneuvoryhma,
    (SELECT lyhytselite_fi
     FROM koodisto
     WHERE koodintunnus = ajoneuvonkaytto AND koodisto = 'ajoneuvonkaytto')          AS ajoneuvonkaytto,
    variantti,
    versio,
    kayttoonottopvm,
    (SELECT lyhytselite_fi
     FROM koodisto
     WHERE koodintunnus = vari AND koodisto = 'vari')                                AS vari,
    ovienLukumaara,
    (SELECT pitkaselite_fi
     FROM koodisto
     WHERE koodintunnus = korityyppi AND koodisto = 'korityyppi')                    AS korityyppi,
    (SELECT lyhytselite_fi
     FROM koodisto
     WHERE koodintunnus = ohjaamotyyppi :: TEXT AND koodisto = 'ohjaamotyyppi')      AS ohjaamotyyppi,
    istumapaikkojenLkm,
    omamassa,
    teknSuurSallKokmassa,
    tieliikSuurSallKokmassa,
    ajonKokPituus,
    ajonLeveys,
    ajonKorkeus,
    (SELECT lyhytselite_fi
     FROM koodisto
     WHERE koodintunnus = kayttovoima AND koodisto = 'kayttovoima')                  AS kayttovoima,
    iskutilavuus,
    suurinNettoteho,
    sylintereidenLkm,
    ahdin,
    sahkohybridi,
    merkkiSelvakielinen,
    mallimerkinta,
    vaihteisto,
    vaihteidenLkm,
    kaupallinenNimi,
    (SELECT lyhytselite_fi
     FROM koodisto
     WHERE koodintunnus = voimanvalJaTehostamistapa AND koodisto =
                                                        'voimanvalJaTehostamistapa') AS voimanvalJaTehostamistapa,
    tyyppihyvaksyntanro,
    yksittaisKayttovoima,
    (SELECT pitkaselite_fi
     FROM koodisto
     WHERE koodintunnus = kunta AND koodisto = 'kunta')                              AS kunta,
    Co2,
    matkamittarilukema,
    alue,
    valmistenumero2

  FROM tekniset_tiedot;

DROP MATERIALIZED VIEW IF EXISTS tekniset_tiedot_mat_view;
CREATE MATERIALIZED VIEW tekniset_tiedot_mat_view AS
  SELECT
    jarnro,
    (SELECT lyhytselite_fi
     FROM koodisto
     WHERE koodintunnus = ajoneuvoluokka AND koodisto = 'ajoneuvoluokka')            AS ajoneuvoluokka,
    ensirekisterointipvm,
    (SELECT pitkaselite_fi
     FROM koodisto
     WHERE koodintunnus = ajoneuvoryhma :: TEXT AND koodisto = 'ajoneuvoryhma')      AS ajoneuvoryhma,
    (SELECT lyhytselite_fi
     FROM koodisto
     WHERE koodintunnus = ajoneuvonkaytto AND koodisto = 'ajoneuvonkaytto')          AS ajoneuvonkaytto,
    variantti,
    versio,
    kayttoonottopvm,
    (SELECT lyhytselite_fi
     FROM koodisto
     WHERE koodintunnus = vari AND koodisto = 'vari')                                AS vari,
    ovienLukumaara,
    (SELECT pitkaselite_fi
     FROM koodisto
     WHERE koodintunnus = korityyppi AND koodisto = 'korityyppi')                    AS korityyppi,
    (SELECT lyhytselite_fi
     FROM koodisto
     WHERE koodintunnus = ohjaamotyyppi :: TEXT AND koodisto = 'ohjaamotyyppi')      AS ohjaamotyyppi,
    istumapaikkojenLkm,
    omamassa,
    teknSuurSallKokmassa,
    tieliikSuurSallKokmassa,
    ajonKokPituus,
    ajonLeveys,
    ajonKorkeus,
    (SELECT lyhytselite_fi
     FROM koodisto
     WHERE koodintunnus = kayttovoima AND koodisto = 'kayttovoima')                  AS kayttovoima,
    iskutilavuus,
    suurinNettoteho,
    sylintereidenLkm,
    ahdin,
    sahkohybridi,
    merkkiSelvakielinen,
    mallimerkinta,
    vaihteisto,
    vaihteidenLkm,
    kaupallinenNimi,
    (SELECT lyhytselite_fi
     FROM koodisto
     WHERE koodintunnus = voimanvalJaTehostamistapa AND koodisto =
                                                        'voimanvalJaTehostamistapa') AS voimanvalJaTehostamistapa,
    tyyppihyvaksyntanro,
    yksittaisKayttovoima,
    (SELECT pitkaselite_fi
     FROM koodisto
     WHERE koodintunnus = kunta AND koodisto = 'kunta')                              AS kunta,
    Co2,
    matkamittarilukema,
    alue,
    valmistenumero2

  FROM tekniset_tiedot;
