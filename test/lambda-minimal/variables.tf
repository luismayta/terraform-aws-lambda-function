# ----------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables.
# ----------------------------------------------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

variable "aws_region" {
  description = "The AWS region to deploy the example in."
  type        = string
  default     = "us-east-1"
}

# ----------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables must be set when using this module.
# ----------------------------------------------------------------------------------------------------------------------

variable "function_name" {
  description = "(Required) A unique name for your Lambda function."
  type        = string
  default     = "lambda-test"
}

variable "handler" {
  description = "(Required) The function entrypoint in the code. This is the name of the method in the code which receives the event and context parameter when this Lambda function is triggered."
  type        = string
  default     = "main.lambda_handler"
}

variable "runtime" {
  description = "(Required) The runtime the Lambda function should use. A list of all available runtimes can be found here: https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html"
  type        = string
  default     = "python3.8"
}

# ----------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------
variable "description" {
  type        = string
  description = "(Optional) Description of what the Lambda function does."
  default     = "A test Lambda function."
}

variable "environment_variables" {
  description = "(Optional) A map of environment variables to pass to the Lambda function. AWS will automatically encrypt these with KMS if a key is provided and decrypt them when running the function."
  type        = map(string)
  default     = {}
}

variable "publish" {
  type        = bool
  description = "(Optional) Whether to publish changes as a new Lambda function. This allows you to use aliases to refer to execute different versions of the function in different environments. Note that an alternative way to run Lambda functions in multiple environments is to version your Terraform code."
  default     = false
}

variable "memory_size" {
  description = "(Optional) Amount of memory in MB your Lambda function can use at runtime. For details see https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-limits.html"
  type        = number
  default     = 128
}

variable "filename" {
  description = "(Optional) The path to the .zip file that contains the Lambda function source code."
  type        = string
  default     = "main.py.zip"
}

variable "timeout" {
  description = "(Optional) The amount of time the Lambda function has to run in seconds. For details see https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-limits.html"
  type        = number
  default     = 3
}

variable "namespace" {
  type        = string
  default     = null
  description = "ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique"
}

variable "stage" {
  type        = string
  default     = null
  description = "ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release'"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
  default     = {}
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

variable "use_fullname" {
  type        = bool
  default     = false
  description = <<-EOT
  If set to 'true' then the full ID for the IAM user name (e.g. `[var.namespace]-[var.stage]-[var.name]`) will be used.
  EOT
}
