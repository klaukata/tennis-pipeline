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

create or replace table RAW_TABLE(
    "Index" varchar,
    "Rank" varchar,
    "Name" varchar,
    "Pts" varchar,
    "Tourn P" varchar,
    "Rank P" varchar,
    "Ach P" varchar,
    "GS" varchar,
    "TF" varchar,
    "AF" varchar,
    "M" varchar,
    "O" varchar,
    "BT" varchar,
    "T" varchar,
    "W@1" varchar,
    "W%" varchar,
    "Elo" varchar
);

create file format if not exists DB.RECENT.CSVFORMAT
    type = CSV
    field_delimiter = ","
    skip_header = 1;

use role ACCOUNTADMIN;
grant CREATE STAGE on all schemas in database DB to role CUSTOMROLE;
grant CREATE ROLE on account to role CUSTOMROLE;
grant CREATE INTEGRATION on account to role CUSTOMROLE;