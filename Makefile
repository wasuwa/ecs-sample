ENV ?= stg
AWS_PROFILE ?= web-api-$(ENV)
AWS_REGION ?= ap-northeast-1
AWS_ACCOUNT_ID ?= $(shell aws sts get-caller-identity --query Account --output text --profile $(AWS_PROFILE))
ECR_REPOSITORY ?= web-api-$(ENV)-backend
ECR_REGISTRY ?= $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com
IMAGE_TAG ?= $(shell git rev-parse --short HEAD)
IMAGE_URI ?= $(ECR_REGISTRY)/$(ECR_REPOSITORY):$(IMAGE_TAG)
TF_ROOT := terraform
TF_MODULES_DIR := $(TF_ROOT)/modules
TF_ENV_DIR := $(TF_ROOT)/environments/$(ENV)
TF_VARS_FILE := terraform.tfvars
BACKEND_FILE := backend.hcl

export AWS_PROFILE

.PHONY: login init plan apply validate fmt lint docs check ecr-login image-build image-push

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

docs:
	find $(TF_MODULES_DIR) -type f -name '*.tf' -exec dirname {} \; | sort -u | while read -r module; do \
		terraform-docs markdown table --output-file README.md --output-mode replace "$$module"; \
	done

check: fmt lint validate

ecr-login:
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(ECR_REGISTRY)

image-build:
	docker buildx build -t $(IMAGE_URI) .

image-push: ecr-login image-build
	docker image push $(IMAGE_URI)
	@echo $(IMAGE_URI)
