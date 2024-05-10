variable "region" {
  type = string
}

variable "profile" {
  type = string
}

variable "service_name" {

  type = string

}

variable "tags" {

}

#source_configuration
variable "app_port" {

  type = number


}
variable "image_repository_type" {
  type = string

}

variable "image_identifier" {
  type = string

}


variable "auto_deployments_enabled" {

  default = false

}



#instance_configuration
variable "cpu" {

}

#network_configuration
variable "is_publicly_accessible" {
  type    = bool
  default = true
}

variable "egress_type" {
  type    = string
  default = "DEFAULT"
}

#---------------------------------
#aws_apprunner_auto_scaling_configuration_version

variable "auto_scaling_configuration_name" {
  type = string

}

variable "max_concurrency" {
  type = number

}

variable "min_size" {
  type = number

}

variable "max_size" {
  type = number

}