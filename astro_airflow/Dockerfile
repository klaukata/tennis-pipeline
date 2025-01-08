FROM quay.io/astronomer/astro-runtime:12.6.0

# updating out package manager and installing curl
USER root
RUN apt-get update && sudo apt-get install -y curl 

# downloading snowflake cli
ENV SNOW_VERSION=3.2.2
RUN curl -O https://sfc-repo.snowflakecomputing.com/snowflake-cli/linux_x86_64/${SNOW_VERSION}/snowflake-cli-${SNOW_VERSION}.x86_64.deb && \
    sudo dpkg -i snowflake-cli-${SNOW_VERSION}.x86_64.deb

# switching to a non-root user
RUN useradd nonroot && \
    chmod -R 777 ./
USER nonroot

# installing dependencies
COPY requirements.txt .
RUN python -m venv dbt_venv && source dbt_venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt && deactivate    