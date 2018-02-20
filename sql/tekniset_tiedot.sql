DROP TABLE IF EXISTS tekniset_tiedot;

CREATE TABLE tekniset_tiedot (
  ajoneuvoluokka            VARCHAR(255),
  ensirekisterointipvm      VARCHAR(255),
  ajoneuvoryhma             INTEGER,
  ajoneuvonkaytto           VARCHAR(255),
  variantti                 VARCHAR(255),
  versio                    VARCHAR(255),
  kayttoonottopvm           INTEGER,
  vari                      VARCHAR(255),
  ovienLukumaara            INTEGER,
  korityyppi                VARCHAR(255),
  ohjaamotyyppi             INTEGER,
  istumapaikkojenLkm        INTEGER,
  omamassa                  INTEGER,
  teknSuurSallKokmassa      INTEGER,
  tieliikSuurSallKokmassa   INTEGER,
  ajonKokPituus             INTEGER,
  ajonLeveys                INTEGER,
  ajonKorkeus               INTEGER,
  kayttovoima               VARCHAR(255),
  iskutilavuus              INTEGER,
  suurinNettoteho           NUMERIC,
  sylintereidenLkm          INTEGER,
  ahdin                     VARCHAR(255),
  sahkohybridi              VARCHAR(255),
  merkkiSelvakielinen       VARCHAR(255),
  mallimerkinta             VARCHAR(255),
  vaihteisto                VARCHAR(255),
  vaihteidenLkm             INTEGER,
  kaupallinenNimi           VARCHAR(255),
  voimanvalJaTehostamistapa VARCHAR(255),
  tyyppihyvaksyntanro       VARCHAR(255),
  yksittaisKayttovoima      VARCHAR(255),
  kunta                     VARCHAR(255),
  co2                       INTEGER,
  matkamittarilukema        INTEGER,
  alue                      VARCHAR(255),
  valmistenumero2           VARCHAR(255),
  jarnro                    BIGINT NOT NULL PRIMARY KEY UNIQUE
);

-- CREATE INDEX merkkiSelvakielinen_idx
--   ON tekniset_tiedot (merkkiSelvakielinen);
-- CREATE INDEX mallimerkinta_idx
--   ON tekniset_tiedot (mallimerkinta);

-- select column_name, data_type, character_maximum_length from INFORMATION_SCHEMA.COLUMNS where table_name = 'tekniset_tiedot';
