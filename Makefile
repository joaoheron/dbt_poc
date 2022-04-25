export SHELL:=/bin/bash
export SHELLOPTS:=$(if $(SHELLOPTS),$(SHELLOPTS):)pipefail:errexit

DBT_VERSION := $(shell cat dbt_project.yml | grep version | grep -o "'.*'" | tr -d "'")

.ONESHELL:

docker_login:
	sudo docker login -u=$(DOCKER_USER) -p=$(DOCKER_PASSWORD)

login_registry:
	aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin "$(DBT_REGISTRY)"

build_dbt:
	docker build -t "$(DBT_REGISTRY)/dbt-poc:$(DBT_VERSION)" '.'

run_dbt:
	docker run -e DBT_HOST=$(DBT_HOST) -e DBT_USER=$(DBT_USER) -e DBT_PASSWORD=$(DBT_PASSWORD) -e DBT_DATABASE=$(DBT_DATABASE) -e DBT_TARGET_SCHEMA=$(DBT_TARGET_SCHEMA) "$(DBT_REGISTRY)/dbt-poc:$(DBT_VERSION)" run

push_dbt:
	docker push "$(DBT_REGISTRY)/dbt-poc:$(DBT_VERSION)" 
