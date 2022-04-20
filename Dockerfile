FROM python:3.7-slim

COPY . /opt/

COPY profiles.yml /root/.dbt/

COPY requirements.txt /opt/

WORKDIR /opt/

RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -U pip

RUN pip install -r requirements.txt

RUN chmod a+x entrypoint.sh

ENTRYPOINT ["/bin/sh", "entrypoint.sh"]