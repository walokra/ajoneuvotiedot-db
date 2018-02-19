# ajoneuvotiedot-db

Database of Finnish TraFi's "vehicle technical information" open data.

## Technology

* PostgreSQL

## Setting up environment

Project has Docker and scripts for setting up things and importing data.

```
$ docker-compose up
```

### Requirements

Required software on macOS.

### Using PostgreSQL on Docker

psql access:
```
$ docker run --name vehicledata-db -e POSTGRES_PASSWORD=vehicledata -e POSTGRES_USER=vehicledata -d postgres

$ docker exec -it vehicledata-db psql
```

#### Importing data

You can also use the following to import the data manually.
Here we are using PostgreSQL where we have done vehicledata database and user.

Tables and views are described in following files:

* sql/tekniset_tiedot.sql
* sql/koodisto.sql
* sql/tekniset_tiedot_view.sql

Create database tables
```
vehicledata=> \i sql/koodisto.sql
vehicledata=> \i sql/tekniset_tiedot.sql
vehicledata=> \i sql/tekniset_tiedot_view.sql
```

##### Vehicles data

1. Convert to UTF-8
```
$ iconv -f iso8859-15 -t utf8 data.csv > data_utf8.csv
```

2. Connect to PostgreSQL and import data
```
vehicledata=# \COPY tekniset_tiedot FROM 'data_utf8.csv' CSV HEADER DELIMITER ';';

or from container cmd line
$ psql -U vehicledata -d vehicledata -c "\COPY tekniset_tiedot FROM 'data_utf8.csv' CSV HEADER DELIMITER ';';"
```

##### Codesystem

TBD: The codesystem data can be imported to the database as is:

1. Save the xlsx-file to CSV

2. Connect to PostgreSQL and import data
```
vehicledata=# \COPY koodisto FROM 'koodisto.csv' CSV HEADER DELIMITER ';';
```

## Running the application

```
$ docker-compose up
```

## TraFi open data

TraFi's open data of vehicle information can be found from http://www.trafi.fi/tietopalvelut/avoin_data

# License

Application: MIT

TraFi's data: CC 4.0 (http://www.trafi.fi/tietopalvelut/avoin_data/avoimen_datan_lisenssi)
