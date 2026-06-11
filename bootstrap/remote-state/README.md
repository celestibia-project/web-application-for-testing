# Remote State Bootstrap

This stack creates the GCS bucket used by Terraform remote state.

Run this stack with local Terraform state first:

```bash
terraform init
terraform plan
terraform apply
```

After the bucket exists, initialize environment stacks such as `environments/dev`.
