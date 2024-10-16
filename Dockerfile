FROM apache/airflow:2.10.2

LABEL author="klaukata" contact-email="kkborowy@gmail.com"

ENV POSTGRES_DATABASE=airflow
ENV POSTGRES_HOST=host.docker.internal
ENV POSTGRES_PASSWORD=airflow
ENV POSTGRES_PORT=5432
ENV POSTGRES_SCHEMA=public
ENV POSTGRES_USER=airflow

# # install python packages
# COPY requirements.txt ./
# RUN pip install --no-cache-dir -r requirements.txt 

# # install system packages
# RUN apt-get update && apt-get install -y wget unzip && \
#     wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
#     apt install -y ./google-chrome-stable_current_amd64.deb && \
#     rm google-chrome-stable_current_amd64.deb &&  apt-get clean

# dbt profile setup
# RUN mkdir /root/.dbt
# COPY profile.yml /root/.dbt/profiles.yml