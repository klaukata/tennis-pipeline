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
	terraform '-chdir=terraform/' init
	terraform '-chdir=terraform/' apply -target=module.m_01_s3 
	terraform '-chdir=terraform/' apply -refresh-only -auto-approve

outputs:
	chmod +x setup_scripts/outputs.sh
	setup_scripts/outputs.sh

py:
	/bin/python3 ./airflow/tasks/scraper/scraper.py
	/bin/python3 ./airflow/tasks/uploader.py

#02
aws:
	terraform '-chdir=terraform/' apply -target=module.m_02_aws
	terraform '-chdir=terraform/' apply -refresh-only -auto-approve

role:
	terraform '-chdir=terraform/' apply -target=resource.snowflake_account_role.role -auto-approve
	terraform '-chdir=terraform/' apply -target=resource.snowflake_grant_account_role.sysadmin_grant -auto-approve
	terraform '-chdir=terraform/' apply -target=resource.snowflake_grant_privileges_to_account_role.schema_grant -auto-approve
	terraform '-chdir=terraform/' apply -target=resource.snowflake_grant_privileges_to_account_role.account_grant -auto-approve
	terraform '-chdir=terraform/' apply -target=resource.snowflake_grant_account_role.user_grant -auto-approve

#03
sf_aws:
	terraform '-chdir=terraform/' init -target=module.m_03_sf_aws
	terraform '-chdir=terraform/' apply -target=module.m_03_sf_aws

json:
	python3 -m setup_scripts.integration_vals

update_policy:
	aws iam update-assume-role-policy --role-name snowflake_uploader --policy-document file://terraform/new_trust_policy.json   


# 4 debugging:
init:
	terraform '-chdir=terraform/' init
app:
	terraform '-chdir=terraform/' apply
	
test:
	pytest


	