help:
		@echo " infra		Creates an AWS infrastructure"

infra:
		terraform '-chdir=terraform/' init
		chmod +x shell_scripts/obtain_credentials.sh
		./shell_scripts/obtain_credentials.sh
		terraform 'chdir=terraform/' apply