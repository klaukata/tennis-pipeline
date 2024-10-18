import boto3
from dotenv import load_dotenv, set_key

def find_bucket_name() -> str:
    client = boto3.client('s3')
    buckets = client.list_buckets()['Buckets']
    if len(buckets) != 1:
        raise Exception('A number of buckets present != 1') 
    return(buckets[0]['Name'])

def save_value_to_dotenv(file_path: str, key: str, value):
    load_dotenv(file_path)
    try: 
        set_key(file_path, key, value)
        print(f'Variable {key} set succesfully inside {file_path}')
    except Exception as e:
        print(f"Can't save a given env var because of error: {e}")

if __name__ == '__main__':
    bucket_name = find_bucket_name()
    save_value_to_dotenv('terraform/.env', 'BUCKET_NAME', bucket_name)