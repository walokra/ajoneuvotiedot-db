DROP TABLE IF EXISTS koodisto;

CREATE TABLE koodisto (
  id             SERIAL PRIMARY KEY,
  koodisto       VARCHAR(255),
  koodintunnus   VARCHAR(255),
  lyhytselite_fi VARCHAR(255),
  pitkaselite_fi VARCHAR(1000),
  lyhytselite_sv VARCHAR(255),
  pitkaselite_sv VARCHAR(1000),
  lyhytselite_en VARCHAR(255),
  pitkaselite_en VARCHAR(1000)
);

-- CREATE INDEX koodisto_idx
--   ON koodisto (koodintunnus);
