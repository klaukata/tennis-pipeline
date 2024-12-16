from dotenv import set_key
from pathlib import Path
from getpass import getpass
import string
import random
import subprocess

# create .env file
dot_env_path = Path('vars.env')
dot_env_path.touch(mode=0o600, exist_ok=True)

# generate a bucket name
rand_str = ''.join(random.choices(
    population=string.ascii_lowercase + string.digits, 
    k=47)
)
bucket_name = 'tennis-pipeline-' + rand_str
print(f"Generated name for a s3 bucket = {bucket_name}")

# snowflake connection
print("Please input your Snoflake credentials.")

sf_role = "ACCOUNTADMIN"
sf_org = input("Organization: ")
sf_acc = input("Account name: ")
sf_identifier = input("Identifier (https://<this_value>.snowflakecomputing.com) ")
sf_acc_name = sf_org + '-' + sf_acc
sf_user = input("User: ")
sf_pass = getpass("Password: ")

print("Thats it! Please skip succeeding prompts by pressing ENTER button.")

# add a connection to a config.toml file
subprocess.run(['snow', 'connection', 'add', 
                '-n', 'myconnection',
                '-a', sf_acc_name,
                '-u', sf_user,
                '-r', sf_role, 
                '--default' ])

# set env vars in .env file
set_key(dotenv_path=dot_env_path, key_to_set='TF_VAR_bucket_name', value_to_set=bucket_name)
set_key(dotenv_path=dot_env_path, key_to_set='SNOWFLAKE_ACCOUNT_NAME', value_to_set=sf_acc)
set_key(dotenv_path=dot_env_path, key_to_set='SNOWFLAKE_ORGANIZATION_NAME', value_to_set=sf_org)
set_key(dotenv_path=dot_env_path, key_to_set='SNOWFLAKE_IDENTIFIER', value_to_set=sf_identifier)
set_key(dotenv_path=dot_env_path, key_to_set='SNOWFLAKE_USER', value_to_set=sf_user)
set_key(dotenv_path=dot_env_path, key_to_set='SNOWFLAKE_PASSWORD', value_to_set=sf_pass)
set_key(dotenv_path=dot_env_path, key_to_set='SNOWFLAKE_CONNECTIONS_MYCONNECTION_PASSWORD', value_to_set=sf_pass)