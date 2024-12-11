## Demo v0.2

Set up:

1. `aws configure`

2. connect to snowflake with `source setup_scripts/snow_connect.sh`. This shell script will ask you about snowflake account, user and password.
    
3. initialize terraform env with `make init`

4. `make dotenv` (creates vars.env file in projects root dir)

5. `export $(cat vars.env | xargs)` (uses vars.env file as env vars)

6. `make sf` (creates a Snowflake infrastructure)

7. `make apply` (creates an aws infrasructure + snowflake sorage integration)

8. `make py` runs .py scripts (saving scraped data do s3 bucket)

9. `make copy` (move a file from s3 to sf)
___

**old steps from main branch:**

8. `make sf_aws` (creates snowflake integration + description output)
9. `make outputs` (4 integration description)
10. `make json` (creates a *terraform/new_trust_policy.json* file)
11. `make update_policy`
12. 

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