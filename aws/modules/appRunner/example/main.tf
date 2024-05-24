terraform {
  required_providers {
    aws = {

      source  = "hashicorp/aws"
      version = "5.46.0"

    }
  }
    backend "s3" {
    bucket         = "terraform-state-store-main"
    dynamodb_table = "dynamodb_table"
    encrypt        = true
    key            = "terraform/local-dev-2/apprunner/terraform.tfstate"
    profile        = "worldleaves"
    region         = "us-west-2"
  }
}
provider "aws" {

  region  = var.region
  profile = var.profile

}
# permission plocy
data "aws_iam_policy_document" "app_runner_ecr_permission_policy" {

  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:InitiateLayerUpload",
      "ecr:BatchGetImage",
      "ecr:UploadLayerPart", // Added for uploading layers
      "ecr:CompleteLayerUpload",
      "ecr:PutImage"
    ]
    resources = var.ecr_arn
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

}


# writing a trust   policy 
data "aws_iam_policy_document" "assume_role" {

  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "build.apprunner.amazonaws.com"
      ]

    }

    actions = ["sts:AssumeRole"]
  }

}

#  attaching  trust policy to role
resource "aws_iam_role" "appRunnerRole" {

 
  name = "${var.env}_apprunner_role"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

}

# saving the policy to aws account and generated  the arn will futher  attach in role
resource "aws_iam_policy" "app_runner_permission_policy" {
 name = "${var.env}_app_runner_permission"
  policy = data.aws_iam_policy_document.app_runner_ecr_permission_policy.json
}




# attaching the permission policy to role  
resource "aws_iam_role_policy_attachment" "app_runner_role_policy_attachment" {
  role       = aws_iam_role.appRunnerRole.name
  policy_arn = aws_iam_policy.app_runner_permission_policy.arn
}








resource "aws_apprunner_auto_scaling_configuration_version" "app_runner_service_config" {

  auto_scaling_configuration_name = var.auto_scaling_configuration_name
  max_concurrency                 = var.max_concurrency
  max_size                        = var.max_size
  min_size                        = var.min_size
  tags = var.auto_scale_tags

}







resource "aws_apprunner_service" "app_runner_service" {

  service_name = var.service_name
  

  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.app_runner_service_config.arn
  tags = var.app_runner_tags
  instance_configuration {
    cpu = var.cpu
    memory = var.memory
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

      access_role_arn = aws_iam_role.appRunnerRole.arn
    }


    image_repository {

      image_configuration {
        port = var.app_port
        runtime_environment_variables = var.runtime_environment_variables
      }
      image_identifier      = var.image_identifier
      image_repository_type = var.image_repository_type
    }
    auto_deployments_enabled = var.auto_deployments_enabled

  }




}


resource "aws_apprunner_custom_domain_association" "appRunnerDomain" {
  domain_name = var.domain_name
  service_arn = aws_apprunner_service.app_runner_service.arn
}