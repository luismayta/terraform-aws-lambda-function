<!--


  ** DO NOT EDIT THIS FILE
  **
  ** 1) Make all changes to `provision/generator/README.yaml`
  ** 2) Run`task readme` to rebuild this file.
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **


  -->

[![Latest Release](https://img.shields.io/github/release/hadenlabs/terraform-aws-lambda-function)](https://github.com/hadenlabs/terraform-aws-lambda-function/releases) [![Lint](https://img.shields.io/github/workflow/status/hadenlabs/terraform-aws-lambda-function/lint-code)](https://github.com/hadenlabs/terraform-aws-lambda-function/actions?workflow=lint-code) [![CI](https://img.shields.io/github/workflow/status/hadenlabs/terraform-aws-lambda-function/ci)](https://github.com/hadenlabs/terraform-aws-lambda-function/actions?workflow=ci) [![Test](https://img.shields.io/github/workflow/status/hadenlabs/terraform-aws-lambda-function/test)](https://github.com/hadenlabs/terraform-aws-lambda-function/actions?workflow=test) [![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit) [![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow)](https://conventionalcommits.org) [![KeepAChangelog](https://img.shields.io/badge/changelog-Keep%20a%20Changelog%20v1.0.0-orange)](https://keepachangelog.com) [![Terraform Version](https://img.shields.io/badge/terraform-1.x%20|%200.15%20|%200.14%20|%200.13%20|%200.12.20+-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases) [![AWS Provider Version](https://img.shields.io/badge/AWS-3%20and%202.0+-F8991D.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-aws/releases)

# terraform-aws-lambda-function

terraform-aws-lambda-function for project

## Requirements

This is a list of plugins that need to be installed previously to enjoy all the goodies of this configuration:

- [gomplate](https://github.com/hairyhenderson/gomplate)
- [terraform](https://github.com/hashicorp/terraform)
- [python](https://www.python.org)
- [taskfile](https://github.com/go-task/task)

## Usage

# How to use this project

```hcl
module "main" {
  source  = "hadenlabs/lambda-function/aws"
  version = "0.0.0"
}
```

Full working examples can be found in [examples](./examples) folder.

## Examples

<!-- Space: Projects -->
<!-- Parent: TerraformAwsLambdaFunction -->
<!-- Title: Examples TerraformAwsLambdaFunction -->
<!-- Label: Examples -->
<!-- Include: ./../disclaimer.md -->
<!-- Include: ac:toc -->

### common

```hcl
module "main" {
  source  = "hadenlabs/lambda-function/aws"
  version = "0.0.0"
}
```

 <!-- markdown-link-check-disable -->
<!-- BEGIN_TF_DOCS -->

## Requirements

| Name      | Version           |
| --------- | ----------------- |
| terraform | >= 0.12.20, < 2.0 |
| aws       | >= 2.51, < 4.0    |
| null      | >=0.1.0           |

## Providers

| Name | Version        |
| ---- | -------------- |
| aws  | >= 2.51, < 4.0 |

## Modules

| Name | Source              | Version |
| ---- | ------------------- | ------- |
| tags | hadenlabs/tags/null | >=0.2   |

## Resources

| Name | Type |
| --- | --- |
| [aws_lambda_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_alias) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| --- | --- | --- | --- | :-: |
| aliases | (Optional) A map of aliases (keyed by the alias name) that will be created for the Lambda function. If 'version' is omitted, the alias will automatically point to '$LATEST'. | `any` | `{}` | no |
| dead_letter_config_target_arn | (Optional) The ARN of an SNS topic or SQS queue to notify when an invocation fails. If this option is used, the function's IAM role must be granted suitable access to write to the target object, which means allowing either the sns:Publish or sqs:SendMessage action on this ARN, depending on which service is targeted. | `string` | `""` | no |
| description | (Optional) A description of what the Lambda function does. | `string` | `null` | no |
| enabled | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| environment_variables | (Optional) A map of environment variables to pass to the Lambda function. AWS will automatically encrypt these with KMS if a key is provided and decrypt them when running the function. | `map(string)` | `{}` | no |
| filename | (Optional) The path to the .zip file that contains the Lambda function source code. | `string` | `null` | no |
| function_name | (Required) A unique name for the Lambda function. | `string` | n/a | yes |
| handler | (Required) The function entrypoint in the code. This is the name of the method in the code which receives the event and context parameter when this Lambda function is triggered. | `string` | n/a | yes |
| kms_key_arn | (Optional) The ARN for the KMS encryption key that is used to encrypt environment variables. If none is provided when environment variables are in use, AWS Lambda uses a default service key. | `string` | `null` | no |
| layer_arns | (Optional) Set of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function. For details see https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html | `set(string)` | `[]` | no |
| memory_size | (Optional) Amount of memory in MB the Lambda function can use at runtime. For details see https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-limits.html | `number` | `128` | no |
| namespace | The namespace of project | `string` | n/a | yes |
| permissions | (Optional) A list of permission objects of external resources (like a CloudWatch Event Rule, SNS, or S3) that should have permission to access the Lambda function. | `any` | `[]` | no |
| publish | (Optional) Whether to publish creation/change as new Lambda function. This allows you to use aliases to refer to execute different versions of the function in different environments. | `bool` | `false` | no |
| reserved_concurrent_executions | (Optional) The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. For details see https://docs.aws.amazon.com/lambda/latest/dg/invocation-scaling.html | `number` | `-1` | no |
| role_arn | (Optional) The ARN of the policy that is used to set the permissions boundary for the IAM role for the Lambda function. | `string` | `null` | no |
| runtime | (Required) The runtime the Lambda function should run in. A list of all available runtimes can be found here: https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html | `string` | n/a | yes |
| s3_bucket | (Optional) The S3 bucket location containing the function's deployment package. Conflicts with 'filename'. This bucket must reside in the same AWS region where you are creating the Lambda function. | `string` | `null` | no |
| s3_key | (Optional) The S3 key of an object containing the function's deployment package. Conflicts with 'filename'. | `string` | `null` | no |
| s3_object_version | (Optional) The object version containing the function's deployment package. Conflicts with 'filename'. | `string` | `null` | no |
| source_code_hash | (Optional) Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. | `string` | `null` | no |
| stage | The name of stage (dev,staging,prod) | `string` | n/a | yes |
| tags | The tags for add resources | `map(any)` | `{}` | no |
| timeout | (Optional) The amount of time the Lambda function has to run in seconds. For details see https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-limits.html | `number` | `3` | no |
| tracing_mode | (Optional) Can be either 'PassThrough' or 'Active'. If set to 'PassThrough', Lambda will only trace the request from an upstream service if it contains a tracing header with 'sampled=1'. If set to 'Active', Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision. | `string` | `null` | no |
| use_fullname | If set to 'true' then the full ID for the IAM user name (e.g. `[var.namespace]-[var.stage]-[var.name]`) will be used. | `bool` | `false` | no |
| vpc_security_group_ids | (Optional) A set of security group IDs associated with the Lambda function. | `set(string)` | `[]` | no |
| vpc_subnet_ids | (Optional) A set of subnet IDs associated with the Lambda function. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
| --- | --- |
| aliases | A map of all created 'aws_lambda_alias' resources keyed by name. |
| enabled | Whether the module is enabled. |
| function | All outputs of the 'aws_lambda_function' resource. |
| function_name | function name of lambda. |
| guessed_function_arn | Guessed function arn in the format: arn:aws:lambda:<region>:<account_id>:function:<function_name> |
| instance | output instance repository |
| invoke_arn | Invoke ARN of function lambda |
| lambda_arn | ARN of function lambda |
| module_inputs | A map of all module arguments. Omitted optional arguments will be represented with their actual defaults. |
| permissions | A map of all created 'aws_lambda_permission' resources keyed by statement_id. |
| tags | The map of tags that will be applied to all created resources that accept tags. |
| use_fullname | fullname module. |

<!-- END_TF_DOCS -->
<!-- markdown-link-check-enable -->

## Help

**Got a question?**

File a GitHub [issue](https://github.com/hadenlabs/terraform-aws-lambda-function/issues).

## Contributing

See [Contributing](./docs/contributing.md).

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)](https://semver.org/).

Using the given version number of `MAJOR.MINOR.PATCH`, we apply the following constructs:

1. Use the `MAJOR` version for incompatible changes.
1. Use the `MINOR` version when adding functionality in a backwards compatible manner.
1. Use the `PATCH` version when introducing backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- In the context of initial development, backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- In the context of pre-release, backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## Copyright

Copyright © 2018-2022 [Hadenlabs](https://hadenlabs.com)

## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## License

The code and styles are licensed under the LGPL-3.0 license [See project license.](LICENSE).

## Don't forget to 🌟 Star 🌟 the repo if you like terraform-aws-lambda-function

[Your feedback is appreciated](https://github.com/hadenlabs/terraform-aws-lambda-function/issues)
