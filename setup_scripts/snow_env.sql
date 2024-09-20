-- __________ WAREHOUSE __________
create warehouse if not exists WH
    warehouse_size = "x-small";

use warehouse WH;
-- __________ ROLE __________
create role if not exists CUSTOMROLE;

grant role SYSADMIN to role CUSTOMROLE;
grant role CUSTOMROLE to role ACCOUNTADMIN;
grant usage on warehouse WH to role CUSTOMROLE;

use role CUSTOMROLE;

-- __________ DATABASE, SCHEMAS, TABLE, FILE FORMAT __________
create database if not exists DB;
use database DB;
create schema if not exists DB.PREVIOUS;
create schema if not exists DB.RECENT;
create table if not exists RAW_TABLE(
    "raw_object" VARIANT
);
create file format if not exists CSVFORMAT
    type = CSV
    field_delimiter = ",";

use role ACCOUNTADMIN;
grant CREATE STAGE on all schemas in database DB to role CUSTOMROLE;
grant CREATE ROLE on account to role CUSTOMROLE;
grant CREATE INTEGRATION on account to role CUSTOMROLE;