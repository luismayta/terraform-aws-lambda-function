locals {
  region       = data.aws_region.current.name
  account_id   = data.aws_caller_identity.current.account_id
  function_arn = "arn:aws:lambda:${local.region}:${local.account_id}:function:${local.outputs.function_name}"
}

output "guessed_function_arn" {
  description = "Guessed function arn in the format: arn:aws:lambda:<region>:<account_id>:function:<function_name>"
  value       = local.function_arn
}

# OUTPUT ALL RESOURCES AS FULL OBJECTS

output "instance" {
  description = "output instance repository"
  value       = aws_lambda_function.this
}

output "lambda_arn" {
  description = "ARN of function lambda"
  value       = try(aws_lambda_function.this[0].arn, null)
}

output "invoke_arn" {
  description = "Invoke ARN of function lambda"
  value       = try(aws_lambda_function.this[0].invoke_arn, null)
}

output "function_name" {
  description = "function name of lambda."
  value       = try(aws_lambda_function.this[0].function_name, null)
}

output "function" {
  description = "All outputs of the 'aws_lambda_function' resource."
  value       = try(aws_lambda_function.this[0], null)
}

output "aliases" {
  description = "A map of all created 'aws_lambda_alias' resources keyed by name."
  value       = try(aws_lambda_alias.this, null)
}

output "permissions" {
  description = "A map of all created 'aws_lambda_permission' resources keyed by statement_id."
  value       = try(aws_lambda_permission.this, null)
}

# OUTPUT ALL INPUT VARIABLES

output "module_inputs" {
  description = "A map of all module arguments. Omitted optional arguments will be represented with their actual defaults."
  value = {
    aliases                        = local.aliases
    dead_letter_config_target_arn  = local.outputs.dead_letter_config_target_arn
    description                    = local.outputs.description
    environment_variables          = local.outputs.environment_variables
    filename                       = local.outputs.filename
    tags                           = local.outputs.tags
    function_name                  = local.outputs.function_name
    handler                        = local.outputs.handler
    kms_key_arn                    = local.outputs.kms_key_arn
    layer_arns                     = local.outputs.layer_arns
    memory_size                    = local.outputs.memory_size
    permissions                    = values(local.permissions)
    publish                        = local.outputs.publish
    reserved_concurrent_executions = local.outputs.reserved_concurrent_executions
    runtime                        = local.outputs.runtime
    role_arn                       = local.outputs.role_arn
    s3_bucket                      = local.outputs.s3_bucket
    s3_key                         = local.outputs.s3_key
    s3_object_version              = local.outputs.s3_object_version
    source_code_hash               = local.outputs.source_code_hash
    timeout                        = local.outputs.timeout
    tracing_mode                   = local.outputs.tracing_mode
    vpc_subnet_ids                 = local.outputs.vpc_subnet_ids
    vpc_security_group_ids         = local.outputs.vpc_security_group_ids
  }
}

# OUTPUT MODULE CONFIGURATION
output "use_fullname" {
  description = "fullname module."
  value       = local.outputs.use_fullname
}

output "enabled" {
  description = "Whether the module is enabled."
  value       = local.outputs.enabled
}

output "tags" {
  description = "The map of tags that will be applied to all created resources that accept tags."
  value       = local.outputs.tags
}
