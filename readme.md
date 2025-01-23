## Tennis pipeline

### Requirements

- [AWS CLI](https://aws.amazon.com/cli/)
- installed packages from /requirments.txt

### Set up:

1. `make aws` (enter your access keys and region name)
    
2. initialize terraform env with `make init`

3. `make dotenv` (creates /vars.env file and configures snowflake connection)

4. `export $(cat vars.env | xargs)` (uses vars.env file as env vars)

5?. `make profile` (adds a dbt profile with our snowflake credentials as env vars)

5. `make sf` (creates a Snowflake infrastructure)

6. `make apply` (creates an aws infrasructure + snowflake sorage integration)

7. `make files` (generates airflow_settings.yaml and docker-compose-template.override.yml with confidential values from env vars)

airflow:

1. `make airflow`

*1. `astro dev object import` (imports a Snoflake connection to Airflow)

2. run a dag

