FROM quay.io/astronomer/astro-runtime:12.6.0

# updating out package manager and installing curl
USER root
RUN apt-get update && sudo apt-get install -y curl 

# downloading snowflake cli
ENV SNOW_VERSION=3.2.2
RUN curl -O https://sfc-repo.snowflakecomputing.com/snowflake-cli/linux_x86_64/${SNOW_VERSION}/snowflake-cli-${SNOW_VERSION}.x86_64.deb && \
    sudo dpkg -i snowflake-cli-${SNOW_VERSION}.x86_64.deb

# switching to a non-root user
RUN groupadd --system nonroot --gid 444 && \
    useradd --uid 444 --system --gid nonroot --home-dir /home/nonroot --create-home --shell /sbin/nologin --comment "Docker image user" nonroot && \
    chown -R nonroot:nonroot /home/nonroot
USER nonroot

WORKDIR /home/nonroot

# installing dependencies
COPY --chown=nonroot:nonroot requirements.txt .
RUN python -m venv dbt_venv && source dbt_venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt && deactivate

# COPY ${HOME}/.snowflake/config.toml /home/astro/.config/snowflake/config.toml