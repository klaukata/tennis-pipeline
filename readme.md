## Demo

Set up (so far):

1. obtain credentials, set them using `aws configure`, create terraform/.env file with *BUCKET_NAME=''*

    sf credentials with `source setup_scripts/snowflake_env.sh` (in terminal)
    in .toml file include  *[connections.myconnection]*
    
    `snow connection set-default myconnection`
    
    `make init`

2. `make s3`
3. `make outputs` (4 prefix)
4. `make py` runs .py scripts (saving scraped data do s3 bucket)
5. `make aws` (create a cloudwatch alarm and iam role)
7. `make sf`
    **note**: ACCOUNTADMIN -> CUSTOM_ROLE -> SYSADMIN 
8. `make sf_aws` (creates snowflake integration + description output)
9. `make outputs` (4 integration description)
10. `make json` (creates a *terraform/new_trust_policy.json* file)
11. `make update_policy`
12. `make copy` (s3 -> sf)

____
transforming:
1. `make profile`, for adding a dbt profile with our snowflake credentials as env vars
___
Resources:

- ["Loading Data into Snowflake from S3" by Kenny Nagano](https://medium.com/@kenny.nagano/loading-data-into-snowflake-from-s3-c5499ccc179)
- ["How to Work with YAML in Python" by Mercy Bassey](https://earthly.dev/blog/yaml-in-python/)
___
**note**: teraform [xyz] -auto-approve 