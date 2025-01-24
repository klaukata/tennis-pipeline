'''
This script adds a new DBT profile with snowflake as a profile type.
'''

import yaml
import os

dbt_directory_path = os.path.expanduser('~/.dbt')
file_path = os.path.expanduser('~/.dbt/profiles.yml')

if not os.path.exists(dbt_directory_path):
    os.mkdir(dbt_directory_path)

if os.path.exists(file_path):
    with open(file_path, 'r') as f:
        file_txt = yaml.safe_load(f)
else:
    file_txt = {}

new_profile = {
    'outputs': {
        'dev': {
            'account': "{{ env_var('SNOWFLAKE_IDENTIFIER') }}",
            'database': 'DB',
            'password': "{{ env_var('SNOWFLAKE_PASSWORD') }}",
            'role': 'CUSTOMROLE',
            'schema': 'RECENT',
            'threads': 10,
            'type': 'snowflake',
            'user': "{{ env_var('SNOWFLAKE_USER') }}",
            'warehouse': 'WH'
        }
    },
    'target': 'dev'
}

file_txt['transform'] = new_profile

with open(f'{file_path}', 'w') as f:
    yaml.dump(file_txt, f, sort_keys=False)
    print("Profile was saved succesfully")

