FROM postgres:10-alpine

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

ENV POSTGRES_USER vehicledata
ENV POSTGRES_PASSWORD vehicledata
ENV POSTGRES_DB vehicledata

ENV DATA_ZIP 180117_tieliikenne_5_1.zip
ENV DATA_EXTRACTED "tieliikenne 5.1.csv"

WORKDIR /tmp

# Install common tools
RUN set -x \
    && apk update && apk upgrade \
    && apk add --no-cache --update \
    bash \
    unzip \
    gawk \
    sed \
    python \
    py-pip \
    py2-psycopg2

ADD data/${DATA_ZIP} /tmp
RUN unzip ${DATA_ZIP} \
    && mv "${DATA_EXTRACTED}" data.csv \
    && rm -rf ${DATA_ZIP}

COPY scripts/init-db.sh /docker-entrypoint-initdb.d/