

output "service_name" {
  type        = string
  description = "The name of the AWS App Runner service."
}

output "app_runner_tags" {
  type        = map(string)
  description = "Tags to apply to the AWS App Runner service."
}

output "ecr_arn" {
  type        = list(string)
  description = "The ARN of the Amazon ECR repository."
}

output "app_port" {
  type        = number
  description = "The port on which the application runs."
}

output "image_repository_type" {
  type        = string
  description = "The type of image repository used (e.g., 'ECR')."
}

output "image_identifier" {
  type        = string
  description = "The identifier of the Docker image."
}

output "auto_deployments_enabled" {
  default     = false
  type = bool
  description = "Whether automatic deployments are enabled."
}

output "runtime_environment_variables" {
  description = "Environment variables for the App Runner service."
  type        = map(string)
  default     = {}
}

output "cpu" {
  type     = number
  description = "The amount of CPU allocated to each instance."
}

output "memory" {
  type =       number
  description = "The amount of memory allocated to each instance."
}

output "is_publicly_accessible" {
  type        = bool
  default     = true
  description = "Whether the service is publicly accessible."
}

output "egress_type" {
  type        = string
  default     = "DEFAULT"
  description = "The type of egress traffic (e.g., 'DEFAULT')."
}

output "auto_scaling_configuration_name" {
  type        = string
  description = "The name of the App Runner auto scaling configuration."
}

output "max_concurrency" {
  type        = number
  description = "The maximum concurrency setting."
}

output "min_size" {
  type        = number
  description = "The minimum number of instances."
}

output "max_size" {
  type        = number
  description = "The maximum number of instances."
}

output "auto_scale_tags" {
  type        = map(string)
  description = "Tags to apply to the auto scaling configuration."
}

output "env" {
  type        = string
  description = "The environment (e.g., 'development', 'production')."
}

output "domain_name" {
  type        = string
  description = "The domain name associated with the App Runner service."
}


output "stack_depends_on" {

  type = list(string)
  
  
}

output "codebuild_project_arn" {
  type = string
  
}

output "region" {
  type =string

}
output "profile" {
  type =  string

  
}
output "ecr_repository_name" {
  type = string
}