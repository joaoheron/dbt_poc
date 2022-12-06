export SHELL:=/bin/bash
export SHELLOPTS:=$(if $(SHELLOPTS),$(SHELLOPTS):)pipefail:errexit

DBT_VERSION := $(shell cat dbt_project.yml | grep version | grep -o "'.*'" | tr -d "'")
DBT_TARGET ?= dev

.ONESHELL:

login_registry:
	aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin "$(DBT_REGISTRY)"

build_dbt:
	docker build -t "$(DBT_REGISTRY)/dbt-poc:$(DBT_VERSION)" '.'

seed_dbt:
	docker run -e DBT_ACCOUNT=$(DBT_ACCOUNT) \
		-e DBT_USER=$(DBT_USER) \
		-e DBT_PASSWORD=$(DBT_PASSWORD) \
		-e DBT_ACCOUNT=$(DBT_ACCOUNT) \
		-e DBT_DATABASE=$(DBT_DATABASE) \
		-e DBT_SCHEMA=$(DBT_SCHEMA) \
		"$(DBT_REGISTRY)/dbt-poc:$(DBT_VERSION)" seed \
			--target $(DBT_TARGET)

run_dbt:
	docker run -e DBT_ACCOUNT=$(DBT_ACCOUNT) \
		-e DBT_USER=$(DBT_USER) \
		-e DBT_PASSWORD=$(DBT_PASSWORD) \
		-e DBT_ACCOUNT=$(DBT_ACCOUNT) \
		-e DBT_DATABASE=$(DBT_DATABASE) \
		-e DBT_SCHEMA=$(DBT_SCHEMA) \
		"$(DBT_REGISTRY)/dbt-poc:$(DBT_VERSION)" run \
			--target $(DBT_TARGET)

push_dbt:
	docker push "$(DBT_REGISTRY)/dbt-poc:$(DBT_VERSION)" 
