import json
from dotenv import load_dotenv, set_key

with open('tf_outputs.json', 'r') as file:
    data = json.load(file)

all_values = data["itegration_description"]["value"]

user_arn_value = all_values[4]["property_value"]
external_id_value = all_values[6]["property_value"]

def save_value_to_dotenv(file_path: str, key: str, value):
    load_dotenv(file_path)
    try: 
        set_key(file_path, key, value)
    except Exception as e:
        print(f"Can't save a given env var because of error: {e}")

save_value_to_dotenv('terraform/.env', "STORAGE_USER_ARN", user_arn_value)
save_value_to_dotenv('terraform/.env', "STORAGE_EXTERNAL_ID", external_id_value)