variable "region" {
  description = "The AWS region to deploy in"
  default     = "eu-north-1"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t3.micro"
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-08eb150f611ca277f"
}
