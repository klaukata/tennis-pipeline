help:
		@echo " infra		Creates an AWS infrastructure"
		@echo " test		Tests scraper.py"


infra:
		terraform '-chdir=terraform/' init;
		terraform '-chdir=terraform/' apply; 

test:
		pytest

	