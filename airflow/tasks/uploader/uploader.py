import boto3
import json
from dotenv import load_dotenv, set_key

def get_prefix(json_file: str) -> str:
    try:
        with open(json_file, 'r') as file:
            json_data = json.load(file)
            return json_data['s3_bucket_prefix']['value']
    except Exception as e:
        print(f'File called {json_file} was not found in a project root directory.')

def find_bucket_names(prefix: str) -> list:
    client = boto3.client('s3')
    response = client.list_buckets()
    bucket_names = [bucket['Name'] for bucket in response['Buckets']]
    matching = [name for name in bucket_names if name.startswith(prefix)]
    return(matching)

def save_value_to_dotenv(file_path: str, key: str, value):
    load_dotenv(file_path)
    try: 
        set_key(file_path, key, value)
    except Exception as e:
        print(f"Can't save a given env var because of error: {e}")

def upload_to_s3(bucket_name: str, file_name: str, path: str) -> None:
    s3 = boto3.resource('s3')
    try:
        s3.Bucket(bucket_name).upload_file(path, file_name)
    except Exception as e:
        print(f'Failed to upload {file_name} so S3, because of an error: {e}')

if __name__ == '__main__':
    prefix = get_prefix('tf-outputs.json')
    bucket_name = find_bucket_names(prefix)[0]
    save_value_to_dotenv('terraform/.env', 'BUCKET_NAME', bucket_name)
    upload_to_s3(
        bucket_name = bucket_name,
        file_name = 'bronze_data.csv',
        path = '/tmp/bronze_data.csv'
    )