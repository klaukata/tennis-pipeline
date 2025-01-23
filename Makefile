# TODO
help:
		@echo " dotenv"
		@echo " sf"
		@echo " copy"
		@echo " init	Initialize Terraform working directorties and installs plugins for required providers."
		@echo " apply	Execute planned actions, create and update AWS infrastructure and Snowflake storage integration. "
		@echo " files	Generate airflow_settings.yaml and docker-compose.override.yml based on users environment variables."


aws:
	aws configure
	chmod -R 755 ~/.aws

# SETUP_SCRIPS FOLDER RELATED
dotenv:
	python3 ./setup_scripts/create_dotenv_file.py

sf:
	snow sql -f setup_scripts/snow_env.sql

copy:
	snow sql -f setup_scripts/copy_raw.sql

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
	
destroy:
	terraform '-chdir=terraform/snowflake' destroy
	terraform '-chdir=terraform/' destroy




plan:
	terraform '-chdir=terraform/' plan

profile:
	python3 setup_scripts/dbt_profile.py





test:
	pytest


	