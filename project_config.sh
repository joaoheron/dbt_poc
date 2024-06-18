source .env

export DBT_PROJECT="dbt_poc"
export DBT_TYPE="snowflake"
export DBT_ACCOUNT="ww91642.sa-east-1.aws"
export DBT_ROLE="dbt_poc_role"
export DBT_WAREHOUSE="dbt_poc_warehouse"
export DBT_DATABASE="dbt_poc"
export DBT_REGISTRY="public.ecr.aws/x7s5w8i1"
export DBT_SCHEMA="dbt_poc_joaoheron"
export DBT_USER=$DBT_USER
export DBT_PASSWORD=$DBT_PASSWORD
export DOCKER_USER=$DOCKER_USER
export DOCKER_PASSWORD=$DOCKER_PASSWORD