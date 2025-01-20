import boto3
import os

def get_env_var(var: str):
    """
    Retrieve the value of an environment variable.
    """
    return os.environ[var]

def upload_to_s3(bucket_name: str, file_name: str, path: str) -> None:
    """
    Upload a file to an S3 bucket.
    """
    s3 = boto3.resource('s3')
    try:
        s3.Bucket(bucket_name).upload_file(path, file_name)
        print(f'Successfully uploaded {file_name} to the S3 bucket "{bucket_name}".')
    except Exception as e:
        print(f'Failed to upload {file_name} to a S3 bucket, because of an error: {e}')

if __name__ == '__main__':
    bucket_name = get_env_var('TF_VAR_bucket_name')
    upload_to_s3(
        bucket_name = bucket_name,
        file_name = 'raw_data.csv',
        path = '/tmp/raw_data.csv'
    )