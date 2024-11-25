from dotenv import set_key
from pathlib import Path
import string
import random

# generate a bucket name
rand_str = ''.join(random.choices(
    population=string.ascii_lowercase + string.digits, 
    k=47)
)
bucket_name = 'tennis-pipeline-' + rand_str

# create and write in .env file
dot_env_path = Path('vars.env')
dot_env_path.touch(mode=0o600, exist_ok=True)
set_key(dotenv_path=dot_env_path, key_to_set='TF_VAR_bucket_name', value_to_set=bucket_name)