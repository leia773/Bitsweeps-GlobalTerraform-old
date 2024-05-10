terraform {
  required_providers {
    aws = {

      source  = "hashicorp/aws"
      version = "5.46.0"

    }
  }
}
provider "aws" {

  region  = var.region
  profile = var.profile

}

resource "aws_apprunner_auto_scaling_configuration_version" "app_runner_service_config" {

  auto_scaling_configuration_name = var.auto_scaling_configuration_name
  max_concurrency                 = var.max_concurrency
  max_size                        = var.max_size
  min_size                        = var.min_size
  tags = {

  }

}

resource "aws_apprunner_service" "app_runner_service" {

  service_name = var.service_name


  tags = {
    Name = var.tags
  }
  instance_configuration {
    cpu = var.cpu
  }

  network_configuration {
    ingress_configuration {
      is_publicly_accessible = var.is_publicly_accessible
    }
    egress_configuration {
      egress_type = var.egress_type
    }

  }


  observability_configuration {

    observability_enabled = false
  }
  ## source_configuration with image repo
  source_configuration {
    authentication_configuration {
      connection_arn = "create a ecr access arn "
    }


    image_repository {

      image_configuration {
        port = var.app_port
        runtime_environment_variables = {

        }
      }
      image_identifier      = va.image_identifier
      image_repository_type = va.image_repository_type
    }
    auto_deployments_enabled = var.auto_deployments_enabled

  }




}


