## Demo

Set up (so far):

1. obtain credentials, set them using `aws configure`
2. `make s3`
3. `make outputs`
4. run .py scripts (saving scraped data do s3 bucket)
5. `make ft` (create a cloudwatch alarm)
6. execute *terraform/aws_iam.tf* (create iam role)
7. add your snowflake credentials to *terraform/secret-variables.tf*
8. run tf/sf
9. `make itegr_val`
10. `make update_policy`