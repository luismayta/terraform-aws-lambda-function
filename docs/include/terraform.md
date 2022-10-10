<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.20, < 2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.51, < 4.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >=0.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.51, < 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_label"></a> [label](#module\_label) | hadenlabs/tags/null | >=0.2 |

## Resources

| Name | Type |
|------|------|
| [aws_lambda_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_alias) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aliases"></a> [aliases](#input\_aliases) | (Optional) A map of aliases (keyed by the alias name) that will be created for the Lambda function. If 'version' is omitted, the alias will automatically point to '$LATEST'. | `any` | `{}` | no |
| <a name="input_dead_letter_config_target_arn"></a> [dead\_letter\_config\_target\_arn](#input\_dead\_letter\_config\_target\_arn) | (Optional) The ARN of an SNS topic or SQS queue to notify when an invocation fails. If this option is used, the function's IAM role must be granted suitable access to write to the target object, which means allowing either the sns:Publish or sqs:SendMessage action on this ARN, depending on which service is targeted. | `string` | `""` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of what the Lambda function does. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | (Optional) A map of environment variables to pass to the Lambda function. AWS will automatically encrypt these with KMS if a key is provided and decrypt them when running the function. | `map(string)` | `{}` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | (Optional) The path to the .zip file that contains the Lambda function source code. | `string` | `null` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | (Required) A unique name for the Lambda function. | `string` | n/a | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | (Required) The function entrypoint in the code. This is the name of the method in the code which receives the event and context parameter when this Lambda function is triggered. | `string` | n/a | yes |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | (Optional) The ARN for the KMS encryption key that is used to encrypt environment variables. If none is provided when environment variables are in use, AWS Lambda uses a default service key. | `string` | `null` | no |
| <a name="input_layer_arns"></a> [layer\_arns](#input\_layer\_arns) | (Optional) Set of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function. For details see https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html | `set(string)` | `[]` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | (Optional) Amount of memory in MB the Lambda function can use at runtime. For details see https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-limits.html | `number` | `128` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace of project | `string` | n/a | yes |
| <a name="input_permissions"></a> [permissions](#input\_permissions) | (Optional) A list of permission objects of external resources (like a CloudWatch Event Rule, SNS, or S3) that should have permission to access the Lambda function. | `any` | `[]` | no |
| <a name="input_publish"></a> [publish](#input\_publish) | (Optional) Whether to publish creation/change as new Lambda function. This allows you to use aliases to refer to execute different versions of the function in different environments. | `bool` | `false` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | (Optional) The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. For details see https://docs.aws.amazon.com/lambda/latest/dg/invocation-scaling.html | `number` | `-1` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | (Optional) The ARN of the policy that is used to set the permissions boundary for the IAM role for the Lambda function. | `string` | `null` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | (Required) The runtime the Lambda function should run in. A list of all available runtimes can be found here: https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html | `string` | n/a | yes |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | (Optional) The S3 bucket location containing the function's deployment package. Conflicts with 'filename'. This bucket must reside in the same AWS region where you are creating the Lambda function. | `string` | `null` | no |
| <a name="input_s3_key"></a> [s3\_key](#input\_s3\_key) | (Optional) The S3 key of an object containing the function's deployment package. Conflicts with 'filename'. | `string` | `null` | no |
| <a name="input_s3_object_version"></a> [s3\_object\_version](#input\_s3\_object\_version) | (Optional) The object version containing the function's deployment package. Conflicts with 'filename'. | `string` | `null` | no |
| <a name="input_source_code_hash"></a> [source\_code\_hash](#input\_source\_code\_hash) | (Optional) Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3\_key. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | The name of stage (dev,staging,prod) | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags for add resources | `map(any)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | (Optional) The amount of time the Lambda function has to run in seconds. For details see https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-limits.html | `number` | `3` | no |
| <a name="input_tracing_mode"></a> [tracing\_mode](#input\_tracing\_mode) | (Optional) Can be either 'PassThrough' or 'Active'. If set to 'PassThrough', Lambda will only trace the request from an upstream service if it contains a tracing header with 'sampled=1'. If set to 'Active', Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision. | `string` | `null` | no |
| <a name="input_use_fullname"></a> [use\_fullname](#input\_use\_fullname) | If set to 'true' then the full ID for the IAM user name (e.g. `[var.namespace]-[var.stage]-[var.name]`) will be used. | `bool` | `false` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | (Optional) A set of security group IDs associated with the Lambda function. | `set(string)` | `[]` | no |
| <a name="input_vpc_subnet_ids"></a> [vpc\_subnet\_ids](#input\_vpc\_subnet\_ids) | (Optional) A set of subnet IDs associated with the Lambda function. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aliases"></a> [aliases](#output\_aliases) | A map of all created 'aws\_lambda\_alias' resources keyed by name. |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether the module is enabled. |
| <a name="output_function"></a> [function](#output\_function) | All outputs of the 'aws\_lambda\_function' resource. |
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | function name of lambda. |
| <a name="output_guessed_function_arn"></a> [guessed\_function\_arn](#output\_guessed\_function\_arn) | Guessed function arn in the format: arn:aws:lambda:<region>:<account\_id>:function:<function\_name> |
| <a name="output_instance"></a> [instance](#output\_instance) | output instance repository |
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | Invoke ARN of function lambda |
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | ARN of function lambda |
| <a name="output_module_inputs"></a> [module\_inputs](#output\_module\_inputs) | A map of all module arguments. Omitted optional arguments will be represented with their actual defaults. |
| <a name="output_permissions"></a> [permissions](#output\_permissions) | A map of all created 'aws\_lambda\_permission' resources keyed by statement\_id. |
| <a name="output_tags"></a> [tags](#output\_tags) | The map of tags that will be applied to all created resources that accept tags. |
| <a name="output_use_fullname"></a> [use\_fullname](#output\_use\_fullname) | fullname module. |
<!-- END_TF_DOCS -->