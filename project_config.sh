source .env

export DBT_PROJECT="dbt_poc"
export DBT_TYPE="postgres"
export DBT_HOST="dbt-poc-instance.cfvlqpuctxuv.us-east-1.rds.amazonaws.com"
export DBT_PORT=5432
export DBT_DATABASE="dbt_poc"
export DBT_REGISTRY="public.ecr.aws/x7s5w8i1"
export DBT_SCHEMA="dbt_poc_schema"
export DBT_USER=$DBT_USER
export DBT_PASSWORD=$DBT_PASSWORD
export DOCKER_USER=$DOCKER_USER
export DOCKER_PASSWORD=$DOCKER_PASSWORD