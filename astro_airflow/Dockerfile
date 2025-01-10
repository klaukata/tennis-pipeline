FROM quay.io/astronomer/astro-runtime:12.6.0

LABEL author="klaukata" contact-email="kkborowy@gmail.com"

# updating out package manager and installing curl
USER root
RUN apt-get update && sudo apt-get install -y wget unzip && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt install -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb &&  apt-get clean

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
