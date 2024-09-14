help:
		@echo " s3			TF module 1"
		@echo " outputs		Extracts terraform outputs and saves them in /tf-outputs.json"
		@echo " aws			TF module 2"
		@echo " test		Tests scraper.py"

# 01
s3:
	terraform '-chdir=terraform/' init
	terraform '-chdir=terraform/' apply -target=module.m_01_s3 
	terraform '-chdir=terraform/' apply -refresh-only -auto-approve

outputs:
	chmod +x setup_scripts/outputs.sh
	setup_scripts/outputs.sh

py:
	/bin/python3 /home/klakli/test_tennis_pipeline/tennis-pipeline/airflow/tasks/scraper/scraper.py
	/bin/python3 /home/klakli/test_tennis_pipeline/tennis-pipeline/airflow/tasks/uploader.py

#02
aws:
	terraform '-chdir=terraform/' apply -target=module.m_02_aws
	terraform '-chdir=terraform/' apply -refresh-only -auto-approve

#03
sf_aws:
	terraform '-chdir=terraform/' init -target=module.m_03_sf_aws
	terraform '-chdir=terraform/' apply -target=module.m_03_sf_aws
	




init:
	terraform '-chdir=terraform/' init
app:
	terraform '-chdir=terraform/' apply
	
test:
		pytest

# creates a json file w a new policy
json:
		python3 -m setup_scripts.integration_vals

# updates a new policy
update_policy:
		aws iam update-assume-role-policy --role-name snowflake_uploader --policy-document file://terraform/new_trust_policy.json   


	