FROM quay.io/astronomer/astro-runtime:12.6.0

LABEL author="klaukata" contact-email="kkborowy@gmail.com"

ENV AWS_CONFIG_FILE=/home/astro/.aws/config
ENV AWS_SHARED_CREDENTIALS_FILE=/home/astro/.aws/credentials

# updating out package manager and installing curl
USER root
RUN apt-get update && sudo apt-get install -y wget unzip && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt install -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb &&  apt-get clean

# switching to a non-root user
RUN chown -R astro:astro ${AIRFLOW_HOME}
USER astro

# installing dependencies
COPY requirements.txt .
RUN python -m venv dbt_venv && source dbt_venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt && deactivate
