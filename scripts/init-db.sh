#!/usr/bin/env bash

psql <<-EOSQL
DROP TABLE IF EXISTS koodisto;

create table koodisto (
    id BIGINT NOT NULL PRIMARY KEY UNIQUE,
    koodistonkuvaus varchar(255),
    koodintunnus varchar(255),
    lyhytselite varchar(255),
    pitkaselite varchar(1000),
    kieli varchar(255)
 );
EOSQL

psql <<-EOSQL
DROP TABLE IF EXISTS tekniset_tiedot;

CREATE TABLE tekniset_tiedot (
  ajoneuvoluokka varchar(255),
  ensirekisterointipvm varchar(255),
  ajoneuvoryhma integer,
  ajoneuvonkaytto varchar(255),
  variantti varchar(255),
  versio varchar(255),
  kayttoonottopvm integer,
  vari varchar(255),
  ovienLukumaara integer,
  korityyppi varchar(255),
  ohjaamotyyppi integer,
  istumapaikkojenLkm integer,
  omamassa integer,
  teknSuurSallKokmassa integer,
  tieliikSuurSallKokmassa integer,
  ajonKokPituus integer,
  ajonLeveys integer,
  ajonKorkeus integer,
  kayttovoima varchar(255),
  iskutilavuus integer,
  suurinNettoteho numeric,
  sylintereidenLkm integer,
  ahdin varchar(255),
  sahkohybridi varchar(255),
  merkkiSelvakielinen varchar(255),
  mallimerkinta varchar(255),
  vaihteisto varchar(255),
  vaihteidenLkm integer,
  kaupallinenNimi varchar(255),
  voimanvalJaTehostamistapa varchar(255),
  tyyppihyvaksyntanro varchar(255),
  yksittaisKayttovoima varchar(255),
  kunta varchar(255),
  co2 integer,
  matkamittarilukema integer,
  alue varchar(255),
  valmistenumero2 varchar(255),
  jarnro BIGINT NOT NULL PRIMARY KEY UNIQUE
);

EOSQL

# Prepare vehicle data
awk 'BEGIN{FS=OFS="\""} {for (i=1;i<=NF;i+=2) gsub(/,/,"|",$i)}1' /tmp/data.csv > /tmp/data_clean.csv
iconv -f iso8859-15 -t utf8 data_clean.csv > data_utf8.csv

# Import vehicle data
psql <<-EOSQL
COPY tekniset_tiedot FROM '/tmp/data_utf8.csv' CSV HEADER DELIMITER '|';
EOSQL

#psql <<-EOSQL
#DROP VIEW IF EXISTS tekniset_tiedot_view;
#create view tekniset_tiedot_view as select jarnro,
#	(select lyhytselite from koodisto where koodintunnus=ajoneuvoluokka and koodistonkuvaus='ajoneuvoluokka' and kieli='fi') as ajoneuvoluokka,
#	ensirekisterointipvm, ajoneuvoryhma, ajoneuvonkaytto, kayttoonottopvm,
#	(select lyhytselite from koodisto where koodintunnus=vari and koodistonkuvaus='Ajoneuvon väri' and kieli='fi') as vari,
#	ovienLukumaara,
#	(select lyhytselite from koodisto where koodintunnus=korityyppi and koodistonkuvaus LIKE 'Korityyppi' and kieli='fi') as korityyppi,
#	(select lyhytselite from koodisto where koodintunnus=ohjaamotyyppi::text and koodistonkuvaus='Ohjaamotyyppi' and kieli='fi') as ohjaamotyyppi,
#	istumapaikkojenLkm, omamassa, teknSuurSallKokmassa, tieliikSuurSallKokmassa, ajonKokPituus, ajonLeveys, ajonKorkeus,
#	(select lyhytselite from koodisto where koodintunnus=kayttovoima and koodistonkuvaus='Polttoaine' and kieli='fi') as kayttovoima,
#	iskutilavuus, suurinNettoteho, sylintereidenLkm, ahdin, merkkiSelvakielinen, mallimerkinta, vaihteisto, vaihteidenLkm, kaupallinenNimi,
#	(select lyhytselite from koodisto where koodintunnus=voimanvalJaTehostamistapa and koodistonkuvaus='Voimanvälitys ja tehostamistapa' and kieli='fi') as voimanvalJaTehostamistapa,
#	tyyppihyvaksyntanro, yksittaisKayttovoima,
#	(select lyhytselite from koodisto where koodintunnus=kunta and koodistonkuvaus='Kuntien numerot ja nimet' and kieli='fi') as kunta,
#	Co2 from tekniset_tiedot;
#
#DROP materialized view IF EXISTS tekniset_tiedot_mat_view;
#create materialized view tekniset_tiedot_mat_view as select jarnro,
#	(select lyhytselite from koodisto where koodintunnus=ajoneuvoluokka and koodistonkuvaus='ajoneuvoluokka' and kieli='fi') as ajoneuvoluokka,
#	ensirekisterointipvm, ajoneuvoryhma, ajoneuvonkaytto, kayttoonottopvm,
#	(select lyhytselite from koodisto where koodintunnus=vari and koodistonkuvaus='Ajoneuvon väri' and kieli='fi') as vari,
#	ovienLukumaara,
#	(select lyhytselite from koodisto where koodintunnus=korityyppi and koodistonkuvaus LIKE 'Korityyppi' and kieli='fi') as korityyppi,
#	(select lyhytselite from koodisto where koodintunnus=ohjaamotyyppi::text and koodistonkuvaus='Ohjaamotyyppi' and kieli='fi') as ohjaamotyyppi,
#	istumapaikkojenLkm, omamassa, teknSuurSallKokmassa, tieliikSuurSallKokmassa, ajonKokPituus, ajonLeveys, ajonKorkeus,
#	(select lyhytselite from koodisto where koodintunnus=kayttovoima and koodistonkuvaus='Polttoaine' and kieli='fi') as kayttovoima,
#	iskutilavuus, suurinNettoteho, sylintereidenLkm, ahdin, merkkiSelvakielinen, mallimerkinta, vaihteisto, vaihteidenLkm, kaupallinenNimi,
#	(select lyhytselite from koodisto where koodintunnus=voimanvalJaTehostamistapa and koodistonkuvaus='Voimanvälitys ja tehostamistapa' and kieli='fi') as voimanvalJaTehostamistapa,
#	tyyppihyvaksyntanro, yksittaisKayttovoima,
#	(select lyhytselite from koodisto where koodintunnus=kunta and koodistonkuvaus='Kuntien numerot ja nimet' and kieli='fi') as kunta,
#	Co2 from tekniset_tiedot;
#
#GRANT ALL ON tekniset_tiedot_view TO vehicledata;
#GRANT ALL ON tekniset_tiedot_mat_view TO vehicledata;
#EOSQL

psql <<-EOSQL
--CREATE INDEX koodisto_idx ON koodisto(koodintunnus);
CREATE INDEX merkkiSelvakielinen_idx ON tekniset_tiedot(merkkiSelvakielinen);
CREATE INDEX mallimerkinta_idx ON tekniset_tiedot(mallimerkinta);

-- select column_name, data_type, character_maximum_length from INFORMATION_SCHEMA.COLUMNS where table_name = 'tekniset_tiedot';
EOSQL
