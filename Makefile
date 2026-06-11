ENV ?= dev
TF_DIR := environments/$(ENV)

.PHONY: fmt validate init plan apply destroy bootstrap

fmt:
	terraform fmt -recursive

validate:
	cd $(TF_DIR) && terraform validate

init:
	cd $(TF_DIR) && terraform init

plan:
	cd $(TF_DIR) && terraform plan

apply:
	cd $(TF_DIR) && terraform apply

destroy:
	cd $(TF_DIR) && terraform destroy

bootstrap:
	cd bootstrap/remote-state && terraform init && terraform plan
