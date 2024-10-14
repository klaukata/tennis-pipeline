#!/bin/bash

read "account?Enter a value for SNOWFLAKE_ACCOUNT environment variable: "
export SNOWFLAKE_ACCOUNT="$account"

read "user?Enter a value for SNOWFLAKE_USER environment variable: "
export SNOWFLAKE_USER="$user"

read -s "password?Enter a value for SNOWFLAKE_PASSWORD environment variable: "
export SNOWFLAKE_PASSWORD="$password"

export SNOWFLAKE_ROLE="CUSTOMROLE"

echo "\nEnvionment variables have been set succesfully"

snow connection add -n myconnection -a $SNOWFLAKE_ACCOUNT -u $SNOWFLAKE_USER -p $SNOWFLAKE_PASSWORD -r $SNOWFLAKE_ROLE --default