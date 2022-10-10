module "label" {
  source    = "hadenlabs/tags/null"
  version   = ">=0.2"
  namespace = var.namespace
  stage     = var.stage
  name      = var.function_name
  tags      = var.tags
}

locals {
  input = {
    enabled                        = var.enabled
    function_name                  = var.function_name
    namespace                      = var.namespace
    stage                          = var.stage
    use_fullname                   = var.use_fullname
    tags                           = var.tags
    handler                        = var.handler
    runtime                        = var.runtime
    aliases                        = var.aliases
    dead_letter_config_target_arn  = var.dead_letter_config_target_arn
    description                    = var.description
    environment_variables          = var.environment_variables
    filename                       = var.filename
    kms_key_arn                    = var.kms_key_arn
    layer_arns                     = var.layer_arns
    memory_size                    = var.memory_size
    permissions                    = var.permissions
    publish                        = var.publish
    reserved_concurrent_executions = var.reserved_concurrent_executions
    role_arn                       = var.role_arn
    timeout                        = var.timeout
    tracing_mode                   = var.tracing_mode
    vpc_subnet_ids                 = var.vpc_subnet_ids
    vpc_security_group_ids         = var.vpc_security_group_ids
    s3_bucket                      = var.filename != null ? null : var.s3_bucket
    s3_key                         = var.filename != null ? null : var.s3_key
    s3_object_version              = var.filename != null ? null : var.s3_object_version
    source_code_hash               = var.source_code_hash != null ? var.source_code_hash : var.filename != null ? filebase64sha256(var.filename) : null
  }
}

locals {

  generated = {
    enabled                        = local.input.enabled
    function_name                  = local.input.function_name
    namespace                      = local.input.namespace
    stage                          = local.input.stage
    use_fullname                   = local.input.use_fullname
    tags                           = local.input.tags
    handler                        = local.input.handler
    runtime                        = local.input.runtime
    aliases                        = local.input.aliases
    dead_letter_config_target_arn  = local.input.dead_letter_config_target_arn
    description                    = local.input.description
    environment_variables          = local.input.environment_variables
    filename                       = local.input.filename
    kms_key_arn                    = local.input.kms_key_arn
    layer_arns                     = local.input.layer_arns
    memory_size                    = local.input.memory_size
    permissions                    = local.input.permissions
    publish                        = local.input.publish
    reserved_concurrent_executions = local.input.reserved_concurrent_executions
    role_arn                       = local.input.role_arn
    s3_bucket                      = local.input.s3_bucket
    s3_key                         = local.input.s3_key
    source_code_hash               = local.input.source_code_hash
    s3_object_version              = local.input.s3_object_version
    timeout                        = local.input.timeout
    tracing_mode                   = local.input.tracing_mode
    vpc_subnet_ids                 = local.input.vpc_subnet_ids
    vpc_security_group_ids         = local.input.vpc_security_group_ids
  }

}

locals {

  outputs = {
    enabled       = local.generated.enabled
    function_name = local.generated.use_fullname ? module.label.id_full : local.generated.function_name
    namespace     = local.generated.namespace
    stage         = local.generated.stage
    use_fullname  = local.generated.use_fullname
    tags = merge(local.generated.tags, {
      Name = local.generated.function_name
    })
    handler                        = local.generated.handler
    runtime                        = local.generated.runtime
    aliases                        = local.generated.aliases
    dead_letter_config_target_arn  = local.generated.dead_letter_config_target_arn
    description                    = local.generated.description
    environment_variables          = local.generated.environment_variables
    filename                       = local.generated.filename
    kms_key_arn                    = local.generated.kms_key_arn
    layer_arns                     = local.generated.layer_arns
    memory_size                    = local.generated.memory_size
    permissions                    = local.generated.permissions
    publish                        = local.generated.publish
    reserved_concurrent_executions = local.generated.reserved_concurrent_executions
    role_arn                       = local.generated.role_arn
    s3_bucket                      = local.generated.s3_bucket
    s3_key                         = local.generated.s3_key
    source_code_hash               = local.generated.source_code_hash
    s3_object_version              = local.generated.s3_object_version
    timeout                        = local.generated.timeout
    tracing_mode                   = local.generated.tracing_mode
    vpc_subnet_ids                 = local.generated.vpc_subnet_ids
    vpc_security_group_ids         = local.generated.vpc_security_group_ids

  }
}


resource "aws_lambda_function" "this" {
  count            = local.outputs.enabled ? 1 : 0
  function_name    = local.outputs.function_name
  description      = local.outputs.description
  source_code_hash = local.outputs.source_code_hash

  s3_bucket         = local.outputs.s3_bucket
  s3_key            = local.outputs.s3_key
  s3_object_version = local.outputs.s3_object_version

  runtime = local.outputs.runtime
  handler = local.outputs.handler
  layers  = local.outputs.layer_arns
  publish = local.outputs.publish
  role    = local.outputs.role_arn

  memory_size = local.outputs.memory_size
  timeout     = local.outputs.timeout

  reserved_concurrent_executions = local.outputs.reserved_concurrent_executions

  kms_key_arn = local.outputs.kms_key_arn

  dynamic "environment" {
    for_each = length(local.outputs.environment_variables) > 0 ? [true] : []

    content {
      variables = local.outputs.environment_variables
    }
  }

  dynamic "dead_letter_config" {
    for_each = length(local.outputs.dead_letter_config_target_arn) > 0 ? [true] : []

    content {
      target_arn = local.outputs.dead_letter_config_target_arn
    }
  }

  vpc_config {
    security_group_ids = local.outputs.vpc_security_group_ids
    subnet_ids         = local.outputs.vpc_subnet_ids
  }

  dynamic "tracing_config" {
    for_each = local.outputs.tracing_mode != null ? [true] : []

    content {
      mode = local.outputs.tracing_mode
    }
  }

  tags = local.outputs.tags
}

locals {
  aliases = {
    for name, config in local.outputs.aliases : name => {
      description                = try(config.description, ""),
      version                    = try(config.version, "$LATEST")
      additional_version_weights = try(config.additional_version_weights, {})
    }
  }
}

resource "aws_lambda_alias" "this" {

  for_each = local.outputs.enabled ? local.outputs.aliases : {}

  name             = each.key
  description      = each.value.description
  function_name    = aws_lambda_function.this[0].function_name
  function_version = each.value.version

  dynamic "routing_config" {
    for_each = length(each.value.additional_version_weights) > 0 ? [true] : []

    oontent {
      additional_version_weights = each.value.additional_version_weights
    }
  }
}

# ATTACH A MAP OF PERMISSIONS TO THE LAMBDA FUNCTION

locals {
  permissions = {
    for permission in local.outputs.permissions : permission.statement_id => {
      statement_id       = permission.statement_id
      action             = try(permission.action, "lambda:InvokeFunction")
      event_source_token = try(permission.event_source_token, null)
      principal          = permission.principal
      qualifier          = try(permission.qualifier, null)
      source_account     = try(permission.source_account, null)
      source_arn         = permission.source_arn
    }
  }
}

resource "aws_lambda_permission" "this" {
  for_each = local.outputs.enabled ? local.outputs.permissions : {}

  action             = each.value.action
  event_source_token = each.value.event_source_token
  function_name      = aws_lambda_function.this[0].function_name
  principal          = each.value.principal
  qualifier          = each.value.qualifier
  statement_id       = each.key
  source_account     = each.value.source_account
  source_arn         = each.value.source_arn
}
