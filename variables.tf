#variable "aws_access_key" {
#    description = "The AWS access key."
#}
#
#variable "aws_secret_key" {
#    description = "The AWS secret key."
#}

variable "region" {
  description = "The AWS region to create resources in."
  default     = "eu-west-3"
}

# TODO: support multiple availability zones, and default to it.
variable "availability_zone" {
  description = "The availability zone"
  default     = "eu-west-3a"
}

variable "ecs_cluster_name" {
  description = "The name of the Amazon ECS cluster."
  default     = "pnrb-draft"
}

variable "amis" {
  description = "Which AMI to spawn. Defaults to the AWS ECS optimized images."

  default = {
    # amzn-ami-2018.03.b-amazon-ecs-optimized
    eu-west-3 = "ami-2187375c"
  }
}

variable "autoscale_min" {
  default     = "1"
  description = "Minimum autoscale (number of EC2)"
}

variable "autoscale_max" {
  default     = "3"
  description = "Maximum autoscale (number of EC2)"
}

variable "autoscale_desired" {
  default     = "1"
  description = "Desired autoscale (number of EC2)"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ssh_pubkey_file" {
  description = "Path to an SSH public key"
  default     = "~/.ssh/id_rsa.pub"
}
