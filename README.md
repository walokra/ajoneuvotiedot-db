# ajoneuvotiedot-db

Docker image for importing TraFi's "vehicle technical information" open data to PostgreSQL database and creating some views.

Uses TraFi's "vehicle technical information" open data, version 5.1, which covers details on vehicle registration, 
approval and also on technical data for all vehicles in road traffic, extracted from the Vehicular and Driver Data Register maintained by Trafi.

- Total of 4 997 966 lines
- The data is dated: 1.1.2018
- The date of publication: 18.1.2018
- File format is: ZIP-packed CSV
- File size: 845 MB (241 MB when packed)
- Open data has been licensed under the Creative Commons Nimeä 4.0 International license.

## Technology

* PostgreSQL

## Setting up environment

Project has Docker and scripts for setting up things and importing data. 

Build the docker image with script and then on docker start the data is imported to the database.

```
$ ./build.sh
$ docker-compose up
```

### Requirements

Required software on macOS.

## Using PostgreSQL on Docker

psql access:
```
$ docker run --name vehicledata-db -e POSTGRES_PASSWORD=vehicledata -e POSTGRES_USER=vehicledata -d postgres

$ docker exec -it vehicledata-db psql
```

## Importing data

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

### Vehicles data

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

### Codesystem

The codesystem data can be imported to the database as is:

1. Hassle with the open data and combine all codes to CSV

2. Connect to PostgreSQL and import data
```
vehicledata=# \COPY koodisto FROM 'koodisto.csv' CSV HEADER DELIMITER ';';
```

## Running the database

```
$ docker-compose up
```

## TraFi open data

TraFi's open data of vehicle information can be found from [Open data at Trafi](https://www.trafi.fi/tietopalvelut/avoin_data). 
Link points to Finnish version of the page which has (at the time of writing) newer data.

# License

Application: MIT

TraFi's open data: CC 4.0 (https://www.trafi.fi/en/information_services/open_data/open_data_licence)
