import boto3

def find_bucket_names(prefix: str) -> list:
    client = boto3.client('s3')
    response = client.list_buckets()
    bucket_names = [bucket['Name'] for bucket in response['Buckets']]
    matching = [name for name in bucket_names if name.startswith(prefix)]
    return(matching)

def upload_to_s3(bucket_name: str, file_name: str, path: str) -> None:
    s3 = boto3.resource('s3')
    try:
        s3.Bucket(bucket_name).upload_file(path, file_name)
    except Exception as e:
        print(f'Failed to upload {file_name} so S3, because of an error: {e}')

if __name__ == '__main__':
    prefix = 'pipeline-bucket-'  #TODO - get from a tf output
    bucket_name = find_bucket_names(prefix)[0]
    upload_to_s3(
        bucket_name = bucket_name,
        file_name = 'bronze_data.csv',
        path = '/tmp/bronze_data.csv'
    )