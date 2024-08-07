help:
		@echo " infra		Creates an AWS infrastructure"
		@echo " outputs		Extracts terraform outputs and saves them in /tf-outputs.json"
		@echo " test		Tests scraper.py"


infra:
		terraform '-chdir=terraform/' init
		terraform '-chdir=terraform/' apply 

outputs:
		chmod +x shell_scripts/outputs.sh
		shell_scripts/outputs.sh

test:
		pytest

# TODO - rm a /tmp/data.csv

	