export SHELL:=/bin/bash
export SHELLOPTS:=$(if $(SHELLOPTS),$(SHELLOPTS):)pipefail:errexit

DBT_VERSION := $(shell cat dbt_project.yml | grep version | grep -o "'.*'" | tr -d "'")

.ONESHELL:


docker_login:
	sudo docker login -u=$(DOCKER_USER) -p=$(DOCKER_PASSWORD)

build_dbt:
	docker build -t "$(DOCKER_USER)/dbt-poc:$(DBT_VERSION)" '.'

run_dbt:
	docker run -e DBT_HOST=$(DBT_HOST) -e DBT_USER=$(DBT_USER) -e DBT_PASSWORD=$(DBT_PASSWORD) -e DBT_DATABASE=$(DBT_DATABASE) -e DBT_TARGET_SCHEMA=$(DBT_TARGET_SCHEMA) "$(DOCKER_USER)/dbt-poc:$(DBT_VERSION)" run

push_dbt:
	docker push "$(DOCKER_USER)/dbt-poc-$(DBT_VERSION)"
