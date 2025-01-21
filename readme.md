## Demo v0.2

Set up:

1. `aws configure`

2. connect to snowflake with `source setup_scripts/snow_connect.sh`. This shell script will ask you about snowflake account, user and password.
    
3. initialize terraform env with `make init`

4. `make dotenv` (creates vars.env file in projects root dir)

5. `export $(cat vars.env | xargs)` (uses vars.env file as env vars)

6. `make sf` (creates a Snowflake infrastructure)

7. `make apply` (creates an aws infrasructure + snowflake sorage integration)

8. `cd astro_airflow`

airflow:

1. `envsubst < airflow_settings_template.yaml > airflow_settings.yaml` (generates airflow_settings.yaml file with confidential values from env vars)
and `envsubst < docker-compose-template.override.yml > docker-compose.override.yml`

2. `astro dev start` (builds a Docker image)

3. `astro dev object import` (imports a Snoflake connection to Airflow)

4. run a dag

