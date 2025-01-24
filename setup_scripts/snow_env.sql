-- __________ WAREHOUSE __________
create warehouse if not exists WH
    warehouse_size = "x-small";

-- __________ ROLE __________
create role if not exists customrole;
grant role sysadmin to role customrole;
grant role customrole to role accountadmin;
grant create integration on account to role customrole;
grant usage on warehouse wh to role customrole;
-- grant CREATE STAGE on all schemas in database DB to role CUSTOMROLE;

use role customrole;
use warehouse WH;

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