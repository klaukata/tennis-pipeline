help:
		@echo " infra		Creates an AWS infrastructure"


infra:
		terraform '-chdir=terraform/' init;
		terraform '-chdir=terraform/' apply; 
	