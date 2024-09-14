## Demo

Set up (so far):

1. obtain credentials, set them using `aws configure`, create terraform/.env file with *BUCKET_NAME=''*
2. `make s3`
3. `make outputs` (4 prefix)
4. `make py` runs .py scripts (saving scraped data do s3 bucket)
5. `make aws` (create a cloudwatch alarm and iam role)
6. add your snowflake credentials to *terraform/secret-variables.tf*
7. `make sf_aws` (creates snowflake integration + description output)
8. `make outputs` (4 integration description)
9. `make json` (creates a *terraform/new_trust_policy.json* file)
10. `make update_policy`