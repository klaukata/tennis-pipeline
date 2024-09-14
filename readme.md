## Demo

Set up (so far):

1. obtain credentials, set them using `aws configure`, create terraform/.env file with *BUCKET_NAME=''*
2. `make s3`
3. `make outputs` (4 prefix)
4. `make py` runs .py scripts (saving scraped data do s3 bucket)
5. `make aws` (create a cloudwatch alarm and iam role)
7. add your snowflake credentials to *terraform/secret-variables.tf*
8. `make sf_aws` (creates snowflake integration + description output)
9. `make outputs` (4 integration description)

REDO:

9. `make itegr_val`
10. `make update_policy`