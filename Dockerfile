FROM python:3.11

LABEL author="klaukata" contact-email="kkborowy@gmail.com"

USER root

# install python packages
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt 

# install system packages
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt install -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb &&  apt-get clean

# dbt profile setup
# RUN mkdir /root/.dbt
# COPY profile.yml /root/.dbt/profiles.yml