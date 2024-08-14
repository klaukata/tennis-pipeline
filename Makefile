help:
		@echo " tf			Execute a tf plan"
		@echo " s3			Creates a bucket"
		@echo " outputs		Extracts terraform outputs and saves them in /tf-outputs.json"
		@echo " test		Tests scraper.py"


s3:
		terraform '-chdir=terraform/' init
		terraform '-chdir=terraform/' apply -target=aws_s3_bucket.raw_data

outputs:
		chmod +x setup_scripts/outputs.sh
		setup_scripts/outputs.sh

tf:
		terraform '-chdir=terraform/' apply
	
test:
		pytest

# creates a json file w a new policy
json:
		python3 -m setup_scripts.integration_vals_to_env

# updates a new policy
update_policy:
		cd terraform
		aws iam update-assume-role-policy --role-name snowflake_uploader --policy-document file://new_trust_policy.json   
		cd ..


	