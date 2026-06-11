# automcation-terraform-gcp

Production-ready Terraform starter for Google Cloud Platform.

## Layout

```text
.
├── bootstrap/
│   └── remote-state/        # Creates the GCS bucket used for Terraform state
├── environments/
│   └── dev/                 # Dev environment root module
└── modules/
    ├── project_apis/        # Enables required GCP APIs
    └── service_account/     # Reusable service account module
```

## Remote State

The Dev backend is configured to use this GCS bucket:

```text
celestibia-automation-bucket-remote-state
```

The bucket must exist before running `terraform init` in `environments/dev`.
Create it first from `bootstrap/remote-state`.

## Prerequisites

- Terraform `>= 1.8.0`
- Google Cloud SDK authenticated with `gcloud auth application-default login`
- A GCP project where you have permission to create buckets and manage IAM/APIs

## Bootstrap State Bucket

```bash
cd bootstrap/remote-state
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

Update `terraform.tfvars` before applying.

## Deploy Dev

```bash
cd environments/dev
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

## Notes

- Do not commit `.tfvars` files or Terraform state.
- Keep environment-specific resources under `environments/<env>`.
- Keep reusable resources under `modules/`.
