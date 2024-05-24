output "app_runner_service_name" {
  description = "The name of the AWS App Runner service."
  value       = aws_apprunner_service.app_runner_service.service_name
}

output "app_runner_service_arn" {
  description = "The ARN of the AWS App Runner service."
  value       = aws_apprunner_service.app_runner_service.arn
}

output "app_runner_service_status" {
  description = "The status of the AWS App Runner service."
  value       = aws_apprunner_service.app_runner_service.status
}

output "app_runner_service_url" {
  description = "The default domain URL of the AWS App Runner service."
  value       = aws_apprunner_service.app_runner_service.service_url
}

output "app_runner_service_instance_configuration" {
  description = "The instance configuration of the AWS App Runner service."
  value       = aws_apprunner_service.app_runner_service.instance_configuration
}

output "app_runner_service_network_configuration" {
  description = "The network configuration of the AWS App Runner service."
  value       = aws_apprunner_service.app_runner_service.network_configuration
}

output "app_runner_service_auto_scaling_configuration_arn" {
  description = "The ARN of the auto scaling configuration used by the AWS App Runner service."
  value       = aws_apprunner_service.app_runner_service.auto_scaling_configuration_arn
}

output "app_runner_service_observability_configuration" {
  description = "The observability configuration of the AWS App Runner service."
  value       = aws_apprunner_service.app_runner_service.observability_configuration
}

output "app_runner_service_source_configuration" {
  description = "The source configuration of the AWS App Runner service."
  value       = aws_apprunner_service.app_runner_service.source_configuration
}


# custom domain 
output "app_runner_custom_domain_association_id" {
  description = "The domain name and service ARN separated by a comma."
  value       = aws_apprunner_custom_domain_association.appRunnerDomain.id
}

output "app_runner_custom_domain_certificate_validation_records" {
  description = "A set of certificate CNAME records used for this domain name."
  value       = aws_apprunner_custom_domain_association.appRunnerDomain.certificate_validation_records
}

output "app_runner_custom_domain_dns_target" {
  description = "App Runner subdomain of the App Runner service. The custom domain name is mapped to this target name."
  value       = aws_apprunner_custom_domain_association.appRunnerDomain.dns_target
}