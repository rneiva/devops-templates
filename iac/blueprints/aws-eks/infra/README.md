<!-- BEGIN_TF_DOCS -->
# AWS EKS Blueprints

## Providers

No providers.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 4.47.0 |
| helm | >= 2.9 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_profile | value of AWS Profile | `string` | n/a | yes |
| aws\_region | value of AWS Region | `string` | n/a | yes |
| cluster\_name | value of EKS cluster version | `string` | n/a | yes |
| cluster\_version | value of EKS cluster version | `string` | n/a | yes |
| iam\_developer\_arn | value of IAM developer arn | `string` | n/a | yes |
| managed\_node\_groups | value of EKS managed node groups | `any` | n/a | yes |
| private\_subnets | value of private subnets | `list(string)` | n/a | yes |
| public\_subnets | value of public subnets | `list(string)` | n/a | yes |
| vpc\_cidr | value of vpc cidr | `list(string)` | n/a | yes |
| vpc\_name | value of vpc name | `string` | n/a | yes |

## Modules

| Name | Source | Version |
|------|--------|---------|
| efs | ../modules/efs | n/a |
| eks\_blueprints | github.com/aws-ia/terraform-aws-eks-blueprints | v4.32.0 |
| iam | ../modules/iam | n/a |
| karpenter | terraform-aws-modules/eks/aws//modules/karpenter | 19.10.0 |
| kubernetes\_addons | github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons | v4.32.0 |
| vpc | ../modules/vpc | n/a |

## Resources

No resources.

## Outputs

| Name | Description |
|------|-------------|
| cluster\_primary\_security\_group\_id | n/a |
<!-- END_TF_DOCS -->