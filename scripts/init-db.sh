#!/usr/bin/env bash

set -e

DB_USER="vehicledata"
DB_NAME="vehicledata"

echo "# "
echo "# Setting up databse..."
echo "# "

psql <<-EOSQL
    CREATE DATABASE ${DB_NAME};
EOSQL

if [ "$SEED_DATABASE" = true ]; then
    echo "# "
    echo "Prepare vehicle data"
    echo "# "
    #awk 'BEGIN{FS=OFS="\""} {for (i=1;i<=NF;i+=2) gsub(/,/,"|",$i)}1' /tmp/data.csv > /tmp/data_clean.csv
    iconv -f iso8859-15 -t utf8 /tmp/koodisto.csv > /tmp/koodisto_utf8.csv
    iconv -f iso8859-15 -t utf8 /tmp/data.csv > /tmp/data_utf8.csv

    echo "# "
    echo "# Create tables for vehicle data and codesystem"
    echo "# "
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DATABASE" -c "\i /tmp/koodisto.sql"
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DATABASE" -c "\i /tmp/tekniset_tiedot.sql"

    echo "# "
    echo "# Import codesystem"
    echo "# "
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DATABASE" <<-EOSQL
        COPY koodisto(koodisto, koodintunnus, lyhytselite_fi, pitkaselite_fi, lyhytselite_sv, pitkaselite_sv, lyhytselite_en, pitkaselite_en) FROM '/tmp/koodisto_utf8.csv' CSV HEADER DELIMITER ';';
EOSQL

    echo "# "
    echo "# Import vehicle data"
    echo "# "
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DATABASE" <<-EOSQL
        COPY tekniset_tiedot FROM '/tmp/data_utf8.csv' CSV HEADER DELIMITER ';';
EOSQL

    echo "# "
    echo "# Create indexes for koodisto"
    echo "# "
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DATABASE" <<-EOSQL
        CREATE INDEX koodisto_idx ON koodisto(koodintunnus);
EOSQL

    echo "# "
    echo "# Create view and materialized view of tekniset_tiedot with codesystem"
    echo "# "
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DATABASE" -c "\i /tmp/tekniset_tiedot_view.sql"

    echo "# "
    echo "# Create indexes for tekniset_tiedot_mat_view"
    echo "# "
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DATABASE" <<-EOSQL
        CREATE INDEX merkkiSelvakielinen_idx ON tekniset_tiedot_mat_view(merkkiSelvakielinen);
        CREATE INDEX mallimerkinta_idx ON tekniset_tiedot_mat_view(mallimerkinta);
EOSQL

    echo "# "
    echo "# Add grants to views"
    echo "# "
    psql <<-EOSQL
        GRANT ALL ON tekniset_tiedot_view TO ${DB_USER};
        GRANT ALL ON tekniset_tiedot_mat_view TO ${DB_USER};
EOSQL

    echo "# "
    echo "# Done"
    echo "# "
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DATABASE" <<-EOSQL
        select column_name, data_type, character_maximum_length from INFORMATION_SCHEMA.COLUMNS where table_name = 'tekniset_tiedot_mat_view';
EOSQL
fi
