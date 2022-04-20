source .env

export DBT_PROJECT="dbt_poc"
export DBT_TYPE="postgres"
export DBT_HOST="0.0.0.0"
export DBT_PORT=5432
export DBT_DATABASE="dbt_poc"
export DBT_TARGET_SCHEMA="dbt_poc_dev"
export DBT_USER=$DBT_USER
export DBT_PASSWORD=$DBT_PASSWORD
export DOCKER_USER=$DOCKER_USER
export DOCKER_PASSWORD=$DOCKER_PASSWORD