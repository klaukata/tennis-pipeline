import boto3
import os
from dotenv import load_dotenv

def get_env_var(var: str):
    load_dotenv(dotenv_path='terraform/.env')
    return os.getenv(var)

def upload_to_s3(bucket_name: str, file_name: str, path: str) -> None:
    s3 = boto3.resource('s3')
    try:
        s3.Bucket(bucket_name).upload_file(path, file_name)
    except Exception as e:
        print(f'Failed to upload {file_name} to a S3 bucket, because of an error: {e}')

if __name__ == '__main__':
    bucket_name = get_env_var('BUCKET_NAME')
    upload_to_s3(
        bucket_name = bucket_name,
        file_name = 'raw_data.csv',
        path = '/tmp/raw_data.csv'
    )