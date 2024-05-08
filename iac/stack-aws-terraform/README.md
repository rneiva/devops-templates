# aws-terraform (IaC)

### Topics

- [Description](#description)
- [Installation](#installation)
- [Running the Project](#running-the-project)
- [Contact](#contact)
- [Disable Sandbox Mode](#manually-switching-to-production-mode)

## Description

Provisioning AWS resources for the project:

- IAM
- ECS
- S3 Bucket (Terraform)
- SE Bucket (Code)
- SNS
- SES
- RDS Postgres
- Cognito

## Architecture

![Architecture](./img)

## Installation

1. Fill in the values in `samples.tfvars` (You can change the name if you wish).
2. Create the S3 Bucket to store the `.tfstate` file;

```bash
terraform plan -target=aws_s3_bucket.project
terraform apply -target=aws_s3_bucket.project
```

3. After creating the Bucket, adjust the values in the `provider.tf` file (Lines 8 to 12).

## Running the Project

* Plan
```bash
terraform plan -var-file=sample.tfvars
```

* Apply
```bash
terraform apply -var-file=sample.tfvars
```

## Manually Switching to Production Mode

* If the environment is production, it will be necessary to deactivate the Sandbox Mode for the following services:

```
SES
SNS
```

# Necessary Settings (Sandbox):

* SNS will only work with [Verified Numbers](https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox-verifying-phone-numbers.html)
* SES Sandbox will only work with [Validated Domains](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html)

## Contact

- Author - [Raul Neiva](https://github.com/rneiva)
- Creation Date: 12/05/2023
```