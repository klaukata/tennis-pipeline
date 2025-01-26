help:
	@echo " airflow		Run the Airflow Docker container defined in astro_airflow/Dockerfile."
	@echo " apply		Execute planned actions, create and update AWS infrastructure and Snowflake storage integration. "
	@echo " aws			Configure a connection with AWS and give everyone read and execute permissions on the ~/.aws folder."
	@echo " destroy		Destroy all services built by Terraform."
	@echo " dotenv		Configure a connection with Snowflake, generate a S3 bucket name and store login credentials in the vars.env file."
	@echo " files		Generate airflow_settings.yaml and docker-compose.override.yml based on users environment variables."
	@echo " init		Initialize Terraform working directorties and installs plugins for required providers."
	@echo " kill		Permanently kill all built containers."
	@echo " profile		Add a DBT profile with Snowflake credentials to the ~/.dbt/profiles.yml file."
	@echo " pytest		Test the scraper module."
	@echo " restart		Restart locally running Airflow containers."
	@echo " sf			Build Snowflake infrastructure using Snowflake CLI."


aws:
	aws configure
	chmod -R 755 ~/.aws

# SETUP_SCRIPS FOLDER RELATED
dotenv:
	python3 ./setup_scripts/create_dotenv_file.py

profile:
	python3 setup_scripts/dbt_profile.py

sf:
	snow sql -f setup_scripts/snow_env.sql

# TERRAFORM RELATED
init:
	terraform '-chdir=terraform/' init
	terraform '-chdir=terraform/snowflake' init

apply:
	terraform '-chdir=terraform/' apply -auto-approve
	terraform '-chdir=terraform/snowflake' apply -auto-approve

# AIRFLOW RELATED
files:
	cd astro_airflow; \
	envsubst < airflow_settings_template.yaml > airflow_settings.yaml; \
	envsubst < docker-compose-template.override.yml > docker-compose.override.yml

airflow:
	cd astro_airflow; \
	astro dev start --wait 5m

# DEBUGGING
kill:
	cd astro_airflow; \
	astro d kill

restart:
	cd astro_airflow; \
	astro d restart

destroy:
	terraform '-chdir=terraform/snowflake' destroy -auto-approve
	terraform '-chdir=terraform/' destroy -auto-approve

test:
	pytest


	