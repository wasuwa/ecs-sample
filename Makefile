ENV ?= stg
AWS_PROFILE ?= web-api-$(ENV)
TF_ROOT := terraform
TF_ENV_DIR := $(TF_ROOT)/environments/$(ENV)
TF_VARS_FILE := terraform.tfvars
BACKEND_FILE := backend.hcl

export AWS_PROFILE

.PHONY: login init plan apply validate fmt lint

login:
	aws sso login --profile $(AWS_PROFILE)

init:
	terraform -chdir=$(TF_ENV_DIR) init -backend-config=$(BACKEND_FILE)

plan:
	terraform -chdir=$(TF_ENV_DIR) plan -var-file=$(TF_VARS_FILE)

apply:
	terraform -chdir=$(TF_ENV_DIR) apply -var-file=$(TF_VARS_FILE)

validate:
	terraform -chdir=$(TF_ENV_DIR) validate

fmt:
	terraform fmt -recursive $(TF_ROOT)

lint:
	tflint --recursive --chdir=$(TF_ROOT)
