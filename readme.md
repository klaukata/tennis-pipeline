## Demo v0.2

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
2. `cd` to /transform
3. change a var for your location in *dbt_project.yml* file  
3. `dbt test --select "source:*"`, testing a source
4. `dbt run`
5. `dbt test --exclude "source:*" tst_ratios`, testing everything, except a source and an unit test
___

**note**: teraform [xyz] -auto-approve 