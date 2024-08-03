import boto3

# TODO find a name of our bucket
bucket_name = 'idk'

def upload_to_s3(b_name: str, file_name: str, path: str):
    s3 = boto3.resource('s3')
    try:
        s3.Bucket(b_name).upload_file(path, file_name)
    except Exception as e:
        print(f'Failed to upload {file_name} so S3, because of error: {e}')

if __name__ == '__main__':
    upload_to_s3(
        b_name = bucket_name,
        file_name = 'bronze_data.csv',
        path = '/tmp/bronze_data.csv'
    )