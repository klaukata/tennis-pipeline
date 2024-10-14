help:
		@echo " s3				TF module 1"
		@echo " outputs			Extracts terraform outputs and saves them in /tf-outputs.json"
		@echo " aws				TF module 2"
		@echo " role			Creates and grants privelages to a Snowflake role"
		@echo " sf_aws			TF module 3"
		@echo " json			Creates a terraform/new_trust_policy.json file"
		@echo " update_policy	Updates a trust policy"

# 01
s3:
	terraform '-chdir=terraform/' apply -target=module.m_s3 
	terraform '-chdir=terraform/' apply -refresh-only -auto-approve

outputs:
	chmod +x setup_scripts/outputs.sh
	setup_scripts/outputs.sh

py:
	python3 ./airflow/tasks/scraper.py
	python3 ./airflow/tasks/uploader.py

#02
aws:
	terraform '-chdir=terraform/' apply -target=module.m_aws
	terraform '-chdir=terraform/' apply -refresh-only -auto-approve

#03
sf:
	snow sql -f setup_scripts/snow_env.sql

#04
sf_aws:
	terraform '-chdir=terraform/' apply -target=module.m_sf_aws

json:
	python3 -m setup_scripts.integration_vals

update_policy:
	aws iam update-assume-role-policy --role-name snowflake_uploader --policy-document file://terraform/new_trust_policy.json   

copy:
	snow sql -f setup_scripts/copy_raw.sql

profile:
	python3 setup_scripts/dbt_profile.py
# 4 debugging:
init:
	terraform '-chdir=terraform/' init
app:
	terraform '-chdir=terraform/' apply
prov:
	terraform '-chdir=terraform/' providers

test:
	pytest


	