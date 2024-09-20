#!/bin/bash

read "account?Enter a value for SNOWFLAKE_ACCOUNT environment variable: "
export SNOWFLAKE_ACCOUNT="$account"

read "user?Enter a value for SNOWFLAKE_USER environment variable: "
export SNOWFLAKE_USER="$user"

read "password?Enter a value for SNOWFLAKE_PASSWORD environment variable: "
export SNOWFLAKE_PASSWORD="$password"

export SNOWFLAKE_ROLE="ACCOUNTADMIN"

echo "Envionment variables have been set succesfully"