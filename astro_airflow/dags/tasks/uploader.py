import boto3
import os

def get_bucket_name() -> str:
    """
    Retrieve the value of a abucket from ....
    """
    client = boto3.client('s3')
    bucket_list = client.list_buckets()["Buckets"]
    if len(bucket_list) != 1:
        raise Exception("More than one bucket is present.")
    else:
        bucket_name = bucket_list[0]['Name']
        return bucket_name

def upload_to_s3(bucket_name: str, file_name: str, path: str) -> None:
    """
    Upload a file to an S3 bucket.
    """
    s3 = boto3.resource('s3')
    try:
        s3.Bucket(bucket_name).upload_file(path, file_name)
        print(f'Successfully uploaded {file_name} to the S3 bucket "{bucket_name}".')
    except Exception as e:
        raise Exception(f'Failed to upload {file_name} to a S3 bucket, because of an error: {e}')

if __name__ == '__main__':
    bucket_name = get_bucket_name()
    upload_to_s3(
        bucket_name = bucket_name,
        file_name = 'raw_data.csv',
        path = '/tmp/raw_data.csv'
    )