help:
		@echo " infra		Creates an AWS infrastructure"
		@echo " outputs		Extracts terraform outputs and saves them in /tf-outputs.json"
		@echo " test		Tests scraper.py"


s3:
		terraform '-chdir=terraform/' init
		terraform '-chdir=terraform/' apply -target=aws_s3_bucket.raw_data

outputs:
		chmod +x shell_scripts/outputs.sh
		shell_scripts/outputs.sh

tf:
		terraform '-chdir=terraform/' apply

test:
		pytest

# TODO - rm a /tmp/data.csv

	