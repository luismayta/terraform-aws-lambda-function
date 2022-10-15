output "enabled" {
  description = "Enabled property of module"
  value       = module.main.enabled
}

output "use_fullname" {
  description = "return if enabled use fullname"
  value       = module.main.use_fullname
}

output "lambda" {
  description = "output instance lambda"
  value       = module.main.lambda
}
