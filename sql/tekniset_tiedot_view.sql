DROP VIEW IF EXISTS tekniset_tiedot_view;
CREATE VIEW tekniset_tiedot_view AS
  SELECT
    jarnro,
    ajoneuvoluokka,
    COALESCE((SELECT lyhytselite_fi
              FROM koodisto
              WHERE koodisto = 'ajoneuvoluokka' AND koodintunnus = ajoneuvoluokka),
             ajoneuvoluokka)            AS ajoneuvoluokkaselite,
    ensirekisterointipvm,

    ajoneuvoryhma,
    COALESCE((SELECT pitkaselite_fi
              FROM koodisto
              WHERE koodisto = 'ajoneuvoryhma' AND koodintunnus = ajoneuvoryhma :: TEXT),
             ajoneuvoryhma :: TEXT)             AS ajoneuvoryhmaselite,

    ajoneuvonkaytto,
    COALESCE((SELECT lyhytselite_fi
              FROM koodisto
              WHERE koodisto = 'ajoneuvonkaytto' AND koodintunnus = ajoneuvonkaytto),
             ajoneuvonkaytto)           AS ajoneuvonkayttoselite,

    variantti,
    versio,
    kayttoonottopvm,

    vari,
    COALESCE((SELECT lyhytselite_fi
              FROM koodisto
              WHERE koodisto = 'vari' AND koodintunnus = vari),
             vari)                      AS variselite,

    ovienLukumaara,

    korityyppi,
    COALESCE((SELECT pitkaselite_fi
              FROM koodisto
              WHERE koodisto = 'korityyppi' AND koodintunnus = korityyppi),
             korityyppi)                AS korityyppiselite,

    ohjaamotyyppi,
    COALESCE((SELECT lyhytselite_fi
              FROM koodisto
              WHERE koodisto = 'ohjaamotyyppi' AND koodintunnus = ohjaamotyyppi :: TEXT),
             ohjaamotyyppi :: TEXT)             AS ohjaamotyyppiselite,

    istumapaikkojenLkm,
    omamassa,
    teknSuurSallKokmassa,
    tieliikSuurSallKokmassa,
    ajonKokPituus,
    ajonLeveys,
    ajonKorkeus,

    kayttovoima,
    COALESCE((SELECT lyhytselite_fi
              FROM koodisto
              WHERE koodisto = 'kayttovoima' AND koodintunnus = kayttovoima),
             kayttovoima)               AS kayttovoimaselite,

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

    voimanvalJaTehostamistapa,
    COALESCE((SELECT lyhytselite_fi
              FROM koodisto
              WHERE koodisto = 'voimanvalJaTehostamistapa' AND koodintunnus = voimanvalJaTehostamistapa),
             voimanvalJaTehostamistapa) AS voimanvalJaTehostamistapaselite,

    tyyppihyvaksyntanro,
    yksittaisKayttovoima,

    kunta,
    COALESCE((SELECT pitkaselite_fi
              FROM koodisto
              WHERE koodisto = 'kunta' AND koodintunnus = kunta),
             kunta)                     AS kuntaselite,

    Co2,
    matkamittarilukema,
    alue,
    valmistenumero2

  FROM tekniset_tiedot;

DROP MATERIALIZED VIEW IF EXISTS tekniset_tiedot_mat_view;
CREATE MATERIALIZED VIEW tekniset_tiedot_mat_view AS
  SELECT
    jarnro,
    ajoneuvoluokka,
    COALESCE((SELECT lyhytselite_fi
              FROM koodisto
              WHERE koodisto = 'ajoneuvoluokka' AND koodintunnus = ajoneuvoluokka),
             ajoneuvoluokka)            AS ajoneuvoluokkaselite,
    ensirekisterointipvm,

    ajoneuvoryhma,
    COALESCE((SELECT pitkaselite_fi
              FROM koodisto
              WHERE koodisto = 'ajoneuvoryhma' AND koodintunnus = ajoneuvoryhma :: TEXT),
             ajoneuvoryhma :: TEXT)             AS ajoneuvoryhmaselite,

    ajoneuvonkaytto,
    COALESCE((SELECT lyhytselite_fi
              FROM koodisto
              WHERE koodisto = 'ajoneuvonkaytto' AND koodintunnus = ajoneuvonkaytto),
             ajoneuvonkaytto)           AS ajoneuvonkayttoselite,

    variantti,
    versio,
    kayttoonottopvm,

    vari,
    COALESCE((SELECT lyhytselite_fi
              FROM koodisto
              WHERE koodisto = 'vari' AND koodintunnus = vari),
             vari)                      AS variselite,

    ovienLukumaara,

    korityyppi,
    COALESCE((SELECT pitkaselite_fi
              FROM koodisto
              WHERE koodisto = 'korityyppi' AND koodintunnus = korityyppi),
             korityyppi)                AS korityyppiselite,

    ohjaamotyyppi,
    COALESCE((SELECT lyhytselite_fi
              FROM koodisto
              WHERE koodisto = 'ohjaamotyyppi' AND koodintunnus = ohjaamotyyppi :: TEXT),
             ohjaamotyyppi :: TEXT)             AS ohjaamotyyppiselite,

    istumapaikkojenLkm,
    omamassa,
    teknSuurSallKokmassa,
    tieliikSuurSallKokmassa,
    ajonKokPituus,
    ajonLeveys,
    ajonKorkeus,

    kayttovoima,
    COALESCE((SELECT lyhytselite_fi
              FROM koodisto
              WHERE koodisto = 'kayttovoima' AND koodintunnus = kayttovoima),
             kayttovoima)               AS kayttovoimaselite,

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

    voimanvalJaTehostamistapa,
    COALESCE((SELECT lyhytselite_fi
              FROM koodisto
              WHERE koodisto = 'voimanvalJaTehostamistapa' AND koodintunnus = voimanvalJaTehostamistapa),
             voimanvalJaTehostamistapa) AS voimanvalJaTehostamistapaselite,

    tyyppihyvaksyntanro,
    yksittaisKayttovoima,

    kunta,
    COALESCE((SELECT pitkaselite_fi
              FROM koodisto
              WHERE koodisto = 'kunta' AND koodintunnus = kunta),
             kunta)                     AS kuntaselite,

    Co2,
    matkamittarilukema,
    alue,
    valmistenumero2

  FROM tekniset_tiedot;
