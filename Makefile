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
	terraform '-chdir=terraform/' apply
	terraform '-chdir=terraform/snowflake' apply


py:
	python3 ./airflow/tasks/scraper.py
	python3 ./airflow/tasks/uploader.py


# terraform debug
plan:
	terraform '-chdir=terraform/' plan

destroy:
	terraform '-chdir=terraform/' destroy




# TODO
help:
		@echo " s3				TF module 1"

# docker commands
base_build:
	docker build -t base-img .

base_run:
	docker run --name base-container base-img

build: 
	docker compose build

up_init:
	docker compose up airflow-init

up:
	docker compose up

profile:
	python3 setup_scripts/dbt_profile.py

test:
	pytest


	